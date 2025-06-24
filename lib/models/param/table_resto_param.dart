class TableRestoParam {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String? tableStatus;
  final String? status;

  TableRestoParam({
    this.id,
    this.code,
    this.name,
    this.capacity,
    this.tableStatus,
    this.status,
  });

  Map<String, dynamic> toJson({bool includeId = false}) {
    final data = {
      'code': code,
      'name': name,
      'capacity': capacity,
      'table_status': tableStatus,
      'status': status,
    };
    if (includeId && id != null) {
      data['id'] = id;
    }
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'capacity': capacity,
      'table_status': tableStatus,
      'status': status,
    };
  }
}
