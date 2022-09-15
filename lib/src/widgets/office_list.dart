import 'package:flutter/material.dart';

import '../data.dart';

class OfficeList extends StatefulWidget {
  const OfficeList({super.key, this.onTap});
  final ValueChanged<Office>? onTap;

  @override
  // ignore: no_logic_in_create_state
  OfficeListState createState() => OfficeListState(onTap);
}

class OfficeListState extends State<OfficeList> {
  late Future<List<Office>> futureOffices;
  final ValueChanged<Office>? onTap;

  OfficeListState(this.onTap);

  @override
  void initState() {
    super.initState();
    futureOffices = fetchOffices();
  }

  Future<List<Office>> refreshOfficeState() async {
    futureOffices = fetchOffices();
    return futureOffices;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Office>>(
      future: refreshOfficeState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          hrSystemInstance.setOffices(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                snapshot.data![index].name!,
              ),
              subtitle: Text(
                ' ' +
                    snapshot.data![index].branch_id!.toString() +
                    ' ' +
                    snapshot.data![index].name! +
                    ' ' +
                    snapshot.data![index].description! +
                    ' ' +
                    snapshot.data![index].phone_number1! +
                    ' ' +
                    snapshot.data![index].phone_number2! +
                    ' ',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .push<void>(
                              MaterialPageRoute<void>(
                                builder: (context) => EditOfficePage(
                                    office: snapshot.data![index]),
                              ),
                            )
                            .then((value) => setState(() {}));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _deleteOffice(snapshot.data![index]);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
              onTap: onTap != null ? () => onTap!(snapshot.data![index]) : null,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Future<void> _deleteOffice(Office office) async {
    try {
      await deleteOffice(office.id!.toString());
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to delete the Office'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

class AddOfficePage extends StatefulWidget {
  static const String route = '/office/add';
  const AddOfficePage({super.key});
  @override
  _AddOfficePageState createState() => _AddOfficePageState();
}

class _AddOfficePageState extends State<AddOfficePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _branch_id_Controller;
  late FocusNode _branch_id_FocusNode;
  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _phone_number1_Controller;
  late FocusNode _phone_number1_FocusNode;
  late TextEditingController _phone_number2_Controller;
  late FocusNode _phone_number2_FocusNode;

  @override
  void initState() {
    super.initState();
    _branch_id_Controller = TextEditingController();
    _branch_id_FocusNode = FocusNode();
    _name_Controller = TextEditingController();
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController();
    _description_FocusNode = FocusNode();
    _phone_number1_Controller = TextEditingController();
    _phone_number1_FocusNode = FocusNode();
    _phone_number2_Controller = TextEditingController();
    _phone_number2_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _branch_id_Controller.dispose();
    _branch_id_FocusNode.dispose();
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _phone_number1_Controller.dispose();
    _phone_number1_FocusNode.dispose();
    _phone_number2_Controller.dispose();
    _phone_number2_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Office you want to add'),
              TextFormField(
                controller: _branch_id_Controller,
                decoration: const InputDecoration(labelText: 'branch_id'),
                onFieldSubmitted: (_) {
                  _branch_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _name_Controller,
                decoration: const InputDecoration(labelText: 'name'),
                onFieldSubmitted: (_) {
                  _name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _description_Controller,
                decoration: const InputDecoration(labelText: 'description'),
                onFieldSubmitted: (_) {
                  _description_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _phone_number1_Controller,
                decoration: const InputDecoration(labelText: 'phone_number1'),
                onFieldSubmitted: (_) {
                  _phone_number1_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _phone_number2_Controller,
                decoration: const InputDecoration(labelText: 'phone_number2'),
                onFieldSubmitted: (_) {
                  _phone_number2_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addOffice(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _addOffice(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Office office = Office(
          branch_id: int.parse(_branch_id_Controller.text),
          name: _name_Controller.text,
          description: _description_Controller.text,
          phone_number1: _phone_number1_Controller.text,
          phone_number2: _phone_number2_Controller.text,
        );
        await createOffice(office);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to add Office'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

class EditOfficePage extends StatefulWidget {
  static const String route = 'office/edit';
  final Office office;
  const EditOfficePage({super.key, required this.office});
  @override
  _EditOfficePageState createState() => _EditOfficePageState();
}

class _EditOfficePageState extends State<EditOfficePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _branch_id_Controller;
  late FocusNode _branch_id_FocusNode;
  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _phone_number1_Controller;
  late FocusNode _phone_number1_FocusNode;
  late TextEditingController _phone_number2_Controller;
  late FocusNode _phone_number2_FocusNode;
  @override
  void initState() {
    super.initState();
    final Office office = widget.office;
    _branch_id_Controller =
        TextEditingController(text: office.branch_id.toString());
    _branch_id_FocusNode = FocusNode();
    _name_Controller = TextEditingController(text: office.name);
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController(text: office.description);
    _description_FocusNode = FocusNode();
    _phone_number1_Controller =
        TextEditingController(text: office.phone_number1);
    _phone_number1_FocusNode = FocusNode();
    _phone_number2_Controller =
        TextEditingController(text: office.phone_number2);
    _phone_number2_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _branch_id_Controller.dispose();
    _branch_id_FocusNode.dispose();
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _phone_number1_Controller.dispose();
    _phone_number1_FocusNode.dispose();
    _phone_number2_Controller.dispose();
    _phone_number2_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Office you want to edit'),
              TextFormField(
                controller: _branch_id_Controller,
                decoration: const InputDecoration(labelText: 'branch_id'),
                onFieldSubmitted: (_) {
                  _branch_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _name_Controller,
                decoration: const InputDecoration(labelText: 'name'),
                onFieldSubmitted: (_) {
                  _name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _description_Controller,
                decoration: const InputDecoration(labelText: 'description'),
                onFieldSubmitted: (_) {
                  _description_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _phone_number1_Controller,
                decoration: const InputDecoration(labelText: 'phone_number1'),
                onFieldSubmitted: (_) {
                  _phone_number1_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _phone_number2_Controller,
                decoration: const InputDecoration(labelText: 'phone_number2'),
                onFieldSubmitted: (_) {
                  _phone_number2_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _editOffice(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _editOffice(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Office office = Office(
          id: widget.office.id,
          branch_id: int.parse(_branch_id_Controller.text),
          name: _name_Controller.text,
          description: _description_Controller.text,
          phone_number1: _phone_number1_Controller.text,
          phone_number2: _phone_number2_Controller.text,
        );
        await updateOffice(office);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to edit the Office'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
