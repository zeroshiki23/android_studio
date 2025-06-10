import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_lab/core/api_client.dart';
import 'package:latihan_lab/models/models.dart';

class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('table-resto-list');
      // Pastikan data dalam bentuk List dan mapping ke model
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => TableRestoModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load table resto data');
      }
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception('Error fetching table resto: ${e.message}');
    }
  }
}
