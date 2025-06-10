import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_lab/bloc/table_resto/get_table_resto_bloc.dart';
class TableRestoPage extends StatefulWidget {
  const TableRestoPage({super.key});

  @override
  State<TableRestoPage> createState() => _tableRestoPageState();
}

class _tableRestoPageState extends State<TableRestoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table Resto')),
      body: BlocBuilder<GetTableRestoBloc, GetTableRestoState>(
        builder: (context, state) {
          return switch(state) {
            // TODO: Handle this case.
            GetTableRestoInitial() => throw UnimplementedError(),
            // TODO: Handle this case.
            GetTableRestoLoading() => throw UnimplementedError(),
            // TODO: Handle this case.
            GetTableRestoLoaded() => throw UnimplementedError(),
            // TODO: Handle this case.
            GetTableRestoError() => throw UnimplementedError(),
          };
        },
      ),
    );
  }
}
