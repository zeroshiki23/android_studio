import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_lab/core/api_client.dart';
import 'package:latihan_lab/models/param/table_resto_param.dart';
import 'package:latihan_lab/models/table_resto_model.dart';
import 'package:latihan_lab/response/table_resto_create_response.dart';

class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('table_resto_list');
      debugPrint('Table Resto GET ALL:${response.data}');
      debugPrint(response.data.runtimeType.toString());
      List list = response.data;
      List<TableRestoModel> listTableResto =
      list.map((element) => TableRestoModel.fromJson(element)).toList();
      return listTableResto;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<TableRestoCreateResponse> addTableResto(
      TableRestoParam tableRestoParam,
      ) async {
    try {
      var response = await dio.post("path", data: tableRestoParam.toJson());
      debugPrint('TabelResto POST: ${response.data}');
      return TableRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
