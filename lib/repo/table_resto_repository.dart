import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_lab/core/api_client.dart';
import 'package:latihan_lab/models/param/table_resto_param.dart';
import 'package:latihan_lab/models/table_resto_model.dart';
import 'package:latihan_lab/response/table_resto_create_response.dart';

class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('api/table_resto');
      debugPrint('Table Resto GET ALL: ${response.data}');
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
      var response = await dio.post(
        'api/table_resto',
        data: tableRestoParam.toJson(),
      );
      debugPrint('Table Resto POST: ${response.data}');
      return TableRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<TableRestoCreateResponse> updateTableResto(
      TableRestoParam tableRestoParam,
      ) async {
    try {
      debugPrint('UPDATE ID: ${tableRestoParam.id}');
      var response = await dio.put(
        'api/table_resto/${tableRestoParam.id}',
        data: tableRestoParam.toJsonUpdate(),
      );
      debugPrint('Table Resto Update: ${response.data}');
      return TableRestoCreateResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('UPDATE ERROR: $e');
      throw Exception(e);
    }
  }
}
