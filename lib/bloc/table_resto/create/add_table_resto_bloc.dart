import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:latihan_lab/models/param/table_resto_param.dart';
import 'package:latihan_lab/repo/table_resto_repository.dart';
import 'package:latihan_lab/response/table_resto_create_response.dart';
import 'package:meta/meta.dart';

part 'add_table_resto_event.dart';

part 'add_table_resto_state.dart';

class AddTableRestoBloc extends Bloc<AddTableRestoEvent, AddTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  AddTableRestoBloc() : super(AddTableRestoInitial()) {
    on<AddTableRestoPressed>(_onAddTableRestoPressed);
    on<UpdateTableRestoPressed>(_onUpdateTableRestoPressed);
  }

  FutureOr<void> _onAddTableRestoPressed(
    AddTableRestoPressed event,
    Emitter<AddTableRestoState> emit,
  ) async {
    final params = TableRestoParam(
      code: event.tableRestoParam.code,
      name: event.tableRestoParam.name,
      capacity: event.tableRestoParam.capacity,
    );

    try {
      emit(AddTableRestoLoading());
      TableRestoCreateResponse response = await tableRestoRepository
          .addTableResto(params);
      emit(AddTableRestoSuccess(tabelRestoCreateResponse: response));
    } catch (e) {
      emit(AddTableRestoError(message: e.toString()));
    }
  }

  FutureOr<void> _onUpdateTableRestoPressed(
    UpdateTableRestoPressed event,
    Emitter<AddTableRestoState> emit,
  ) async {
    final params = TableRestoParam(
      id: event.tableRestoParam.id,
      code: event.tableRestoParam.code,
      name: event.tableRestoParam.name,
      capacity: event.tableRestoParam.capacity,
      tableStatus: event.tableRestoParam.tableStatus,
      status: event.tableRestoParam.status,
    );

    try {
      emit(AddTableRestoLoading());
      TableRestoCreateResponse response = await tableRestoRepository
          .updateTableResto(params);
      emit(AddTableRestoSuccess(tabelRestoCreateResponse: response));
    } catch (e) {
      emit(AddTableRestoError(message: e.toString()));
    }
  }
}
