
import 'package:flutter_carros_curso/pages/favoritos/favorito.dart';
import 'package:flutter_carros_curso/utils/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {

  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}