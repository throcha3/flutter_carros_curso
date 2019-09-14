import 'package:flutter_carros_curso/pages/carro/carro.dart';
import 'package:flutter_carros_curso/pages/login/usuario.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum TipoCarro{
  classicos,
  esportivos,
  luxo
}

class CarrosApi{

  static Future<List<Carro>> getCarros(TipoCarro tipo) async{

    Usuario user = await Usuario.get();

    Map<String,String> headers = {
      "Content-Type": "application/json",
      "Authorization" : "Bearer ${user.token}"
    };

    String s = tipo.toString().replaceAll("TipoCarro.", "");

    var url = "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$s";

    print(headers);

    var response = await http.get(url, headers: headers);

    String json = response.body;

    print(response.body);

    List list = convert.json.decode(json);

    return list.map<Carro>((map) => Carro.fromJson(map)).toList();
  }

}