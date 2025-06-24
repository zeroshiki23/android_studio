import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_lab/bloc/table_resto/get_table_resto_bloc.dart';
import 'package:latihan_lab/ui/add_table_resto.dart';
import 'package:latihan_lab/models/table_resto_model.dart';

class TableRestoPage extends StatelessWidget {
  const TableRestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Table Resto'),
      ),
      body: BlocBuilder<GetTableRestoBloc, GetTableRestoState>(
        builder: (context, state) {
          return switch (state) {
            GetTableRestoInitial() || GetTableRestoLoading() =>
            const Center(child: CircularProgressIndicator()),
            GetTableRestoLoaded(listTableResto: var data)
            when data.isNotEmpty =>
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text(item.name ?? 'Tidak ada nama'),
                      subtitle: Text('Kapasitas: ${item.capacity}'),
                      trailing: Text(item.table_status ?? ''),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddTableResto(existingData: item),
                            ),
                          );
                          context.read<GetTableRestoBloc>().add(TableRestoFetched());
                        },
                    );
                  },
                ),
            GetTableRestoLoaded() => const Center(child: Text('Tidak ada data')),
            GetTableRestoError() => Center(child: Text(state.message)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTableResto(), // tanpa parameter
            ),
          );
          context.read<GetTableRestoBloc>().add(TableRestoFetched());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
