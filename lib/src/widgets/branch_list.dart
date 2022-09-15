import 'package:flutter/material.dart';

import '../data.dart';

class BranchList extends StatefulWidget {
  const BranchList({super.key, this.onTap});
  final ValueChanged<Branch>? onTap;

  @override
  // ignore: no_logic_in_create_state
  BranchListState createState() => BranchListState(onTap);
}

class BranchListState extends State<BranchList> {
  late Future<List<Branch>> futureBranchs;
  final ValueChanged<Branch>? onTap;

  BranchListState(this.onTap);

  @override
  void initState() {
    super.initState();
    futureBranchs = fetchBranchs();
  }

  Future<List<Branch>> refreshBranchState() async {
    futureBranchs = fetchBranchs();
    return futureBranchs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Branch>>(
      future: refreshBranchState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          hrSystemInstance.setBranches(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                snapshot.data![index].name!,
              ),
              subtitle: Text(
                ' ' +
                    snapshot.data![index].organization_id!.toString() +
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
                                builder: (context) => EditBranchPage(
                                    branch: snapshot.data![index]),
                              ),
                            )
                            .then((value) => setState(() {}));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _deleteBranch(snapshot.data![index]);
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

  Future<void> _deleteBranch(Branch branch) async {
    try {
      await deleteBranch(branch.id!.toString());
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to delete the Branch'),
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

class AddBranchPage extends StatefulWidget {
  static const String route = '/branch/add';
  const AddBranchPage({super.key});
  @override
  _AddBranchPageState createState() => _AddBranchPageState();
}

class _AddBranchPageState extends State<AddBranchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _organization_id_Controller;
  late FocusNode _organization_id_FocusNode;
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
    _organization_id_Controller = TextEditingController();
    _organization_id_FocusNode = FocusNode();
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
    _organization_id_Controller.dispose();
    _organization_id_FocusNode.dispose();
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
        title: const Text('Branch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Branch you want to add'),
              TextFormField(
                controller: _organization_id_Controller,
                decoration: const InputDecoration(labelText: 'organization_id'),
                onFieldSubmitted: (_) {
                  _organization_id_FocusNode.requestFocus();
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
          await _addBranch(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _addBranch(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Branch branch = Branch(
          organization_id: int.parse(_organization_id_Controller.text),
          name: _name_Controller.text,
          description: _description_Controller.text,
          phone_number1: _phone_number1_Controller.text,
          phone_number2: _phone_number2_Controller.text,
        );
        await createBranch(branch);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to add Branch'),
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

class EditBranchPage extends StatefulWidget {
  static const String route = 'branch/edit';
  final Branch branch;
  const EditBranchPage({super.key, required this.branch});
  @override
  _EditBranchPageState createState() => _EditBranchPageState();
}

class _EditBranchPageState extends State<EditBranchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _organization_id_Controller;
  late FocusNode _organization_id_FocusNode;
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
    final Branch branch = widget.branch;
    _organization_id_Controller =
        TextEditingController(text: branch.organization_id.toString());
    _organization_id_FocusNode = FocusNode();
    _name_Controller = TextEditingController(text: branch.name);
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController(text: branch.description);
    _description_FocusNode = FocusNode();
    _phone_number1_Controller =
        TextEditingController(text: branch.phone_number1);
    _phone_number1_FocusNode = FocusNode();
    _phone_number2_Controller =
        TextEditingController(text: branch.phone_number2);
    _phone_number2_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _organization_id_Controller.dispose();
    _organization_id_FocusNode.dispose();
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
        title: const Text('Branch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Branch you want to edit'),
              TextFormField(
                controller: _organization_id_Controller,
                decoration: const InputDecoration(labelText: 'organization_id'),
                onFieldSubmitted: (_) {
                  _organization_id_FocusNode.requestFocus();
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
          await _editBranch(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _editBranch(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Branch branch = Branch(
          id: widget.branch.id,
          organization_id: int.parse(_organization_id_Controller.text),
          name: _name_Controller.text,
          description: _description_Controller.text,
          phone_number1: _phone_number1_Controller.text,
          phone_number2: _phone_number2_Controller.text,
        );
        await updateBranch(branch);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to edit the Branch'),
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
