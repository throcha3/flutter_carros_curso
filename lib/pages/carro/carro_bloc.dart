import 'dart:async';

import 'package:flutter_carros_curso/pages/carro/carro.dart';
import 'package:flutter_carros_curso/pages/carro/carro_api.dart';

class CarrosBloc {

  final _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  fetch(TipoCarro tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      _streamController.add(carros);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}