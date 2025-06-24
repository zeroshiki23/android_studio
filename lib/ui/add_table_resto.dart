import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_lab/bloc/table_resto/create/add_table_resto_bloc.dart';
import 'package:latihan_lab/models/param/table_resto_param.dart';
import 'package:latihan_lab/bloc/table_resto/get_table_resto_bloc.dart';
import 'package:latihan_lab/models/table_resto_model.dart';

class AddTableResto extends StatelessWidget {
  final TableRestoModel? existingData;

  const AddTableResto({super.key, this.existingData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTableRestoBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(existingData == null ? 'Tambah Meja' : 'Edit Meja'),
        ),
        body: AddTableRestoForm(
          tableRestoModel: existingData,
        ),
      ),
    );
  }
}

class AddTableRestoForm extends StatefulWidget {
  final TableRestoModel? tableRestoModel;

  const AddTableRestoForm({super.key, this.tableRestoModel});

  @override
  State<AddTableRestoForm> createState() => _AddTableRestoFormState();
}

class _AddTableRestoFormState extends State<AddTableRestoForm> {
  final _formKey = GlobalKey<FormState>();
  final _tecCode = TextEditingController();
  final _tecName = TextEditingController();
  final _tecCapacity = TextEditingController();

  String? selectedTableStatus;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.tableRestoModel != null) {
      _tecCode.text = widget.tableRestoModel!.code ?? '';
      _tecName.text = widget.tableRestoModel!.name ?? '';
      _tecCapacity.text = widget.tableRestoModel!.capacity?.toString() ?? '';
      selectedTableStatus = widget.tableRestoModel!.table_status;
      selectedStatus = widget.tableRestoModel!.status;
    }
  }

  @override
  void dispose() {
    _tecCode.dispose();
    _tecName.dispose();
    _tecCapacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTableRestoBloc, AddTableRestoState>(
      listener: (context, state) {
        if (state is AddTableRestoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (state is AddTableRestoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil disimpan')),
          );
          context.read<GetTableRestoBloc>().add(TableRestoFetched());
          Navigator.pop(context);
        }

        if (state is AddTableRestoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${state.message}')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tecCode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kode Meja',
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Kode tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tecName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Meja',
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tecCapacity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kapasitas Meja',
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Kapasitas tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedTableStatus,
                items: ['Kosong', 'Terisi']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status Meja',
                ),
                onChanged: (value) {
                  setState(() {
                    selectedTableStatus = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: ['Aktif', 'Tidak Aktif']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status',
                ),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final param = TableRestoParam(
                      id: widget.tableRestoModel?.id,
                      code: _tecCode.text.trim(),
                      name: _tecName.text.trim(),
                      capacity: int.tryParse(_tecCapacity.text) ?? 0,
                      tableStatus: selectedTableStatus,
                      status: selectedStatus,
                    );

                    final isEdit = widget.tableRestoModel != null;
                    if (isEdit) {
                      context.read<AddTableRestoBloc>().add(
                        UpdateTableRestoPressed(tableRestoParam: param),
                      );
                    } else {
                      context.read<AddTableRestoBloc>().add(
                        AddTableRestoPressed(tableRestoParam: param),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
