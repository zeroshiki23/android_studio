import 'package:bloc/bloc.dart';
import 'package:latihan_lab/models/models.dart';
import 'package:latihan_lab/repo/table_resto_repository.dart';
import 'package:meta/meta.dart';

part 'get_table_resto_event.dart';
part 'get_table_resto_state.dart';

class GetTableRestoBloc extends Bloc<GetTableRestoEvent, GetTableRestoState> {
  final TableRestoRepository _tableRestoRepository = TableRestoRepository();

  GetTableRestoBloc() : super(GetTableRestoInitial()) {
    on<TableRestoFetched>(_onTableRestoFetched);
  }

  Future<void> _onTableRestoFetched(
      TableRestoFetched event,
      Emitter<GetTableRestoState> emit,
      ) async {
    emit(GetTableRestoLoading());
    try {
      List<TableRestoModel> list = await _tableRestoRepository.getTableRestos();
      emit(GetTableRestoLoaded(listTableResto: list));
    } catch (e) {
      emit(GetTableRestoError(message: e.toString()));
    }
  }
}
