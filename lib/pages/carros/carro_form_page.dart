import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carros_curso/pages/api_response.dart';
import 'package:flutter_carros_curso/pages/carros/carro.dart';
import 'package:flutter_carros_curso/pages/carros/carros_api.dart';
import 'package:flutter_carros_curso/utils/alert.dart';
import 'package:flutter_carros_curso/utils/nav.dart';
import 'package:flutter_carros_curso/widgets/app_button.dart';
import 'package:flutter_carros_curso/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  CarroFormPage({this.carro});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  Carro get carro => widget.carro;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro.nome;
      tDesc.text = carro.descricao;
      _radioIndex = getTipoInt(carro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro.nome : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppText(
            "Nome",
            "",
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppText(
            "Descrição",
            "",
            controller: tDesc,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          AppButton(
            "Salvar",
            onPressed: _onClickSalvar,
            showProgress: _showProgress,
          )
        ],
      ),
    );
  }

  _headerFoto() {
    return carro != null
        ? CachedNetworkImage(
            imageUrl: carro.urlFoto,
            height: 150,
          )
        : Image.asset(
            "assets/images/camera.png",
            height: 150,
          );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Carro();
    c.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    ApiResponse<bool> response = await CarrosApi.save(c);

    if (response.ok) {
      alert(context, "Carro salvo com sucesso", callback: () {
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
}
