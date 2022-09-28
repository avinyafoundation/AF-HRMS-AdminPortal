import 'package:flutter/material.dart';

import '../data.dart';

class PositionsVacantList extends StatefulWidget {
  final List<PositionsVacant> positionsVacantList;
  const PositionsVacantList(
      {super.key, this.onTap, required this.positionsVacantList});
  final ValueChanged<PositionsVacant>? onTap;

  @override
  // ignore: no_logic_in_create_state
  PositionsVacantListState createState() => PositionsVacantListState(onTap);
}

class PositionsVacantListState extends State<PositionsVacantList> {
  //late Future<List<PositionsVacant>> futurePositionsVacants;
  final ValueChanged<PositionsVacant>? onTap;

  PositionsVacantListState(this.onTap);

  @override
  void initState() {
    super.initState();
    //futurePositionsVacants = fetchPositionsVacants();
  }

  // Future<List<PositionsVacant>> refreshPositionsVacantState() async {
  //   futurePositionsVacants = fetchPositionsVacants();
  //   return futurePositionsVacants;
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<List<PositionsVacant>>(
    //   future: refreshPositionsVacantState(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       hrSystemInstance.setPositionsVacants(snapshot.data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Positions Vacant'),
        ),
        body: ListView.builder(
          itemCount: widget.positionsVacantList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              widget.positionsVacantList[index].job!.name!,
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text('Count: ' +
                        widget.positionsVacantList[index].amount!.toString())
                  ],
                ),
                Row(
                  children: [
                    Text('Start Date: ' +
                        widget.positionsVacantList[index].start_date!)
                  ],
                ),
                Row(
                  children: [
                    Text('End Date: ' +
                        widget.positionsVacantList[index].end_date!)
                  ],
                ),
                Row(
                  children: [
                    Text('Status: ' + widget.positionsVacantList[index].status!)
                  ],
                ),
                Row(
                  children: [Text(widget.positionsVacantList[index].notes!)],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .push<void>(
                            MaterialPageRoute<void>(
                              builder: (context) => EditPositionsVacantPage(
                                  positionsVacant:
                                      widget.positionsVacantList[index]),
                            ),
                          )
                          .then((value) => setState(() {}));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await _deletePositionsVacant(
                          widget.positionsVacantList[index]);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            onTap: onTap != null
                ? () => onTap!(widget.positionsVacantList[index])
                : null,
          ),
        ));
    // } else if (snapshot.hasError) {
    //   return Text('${snapshot.error}');
    // }

    // By default, show a loading spinner.
    //return const CircularProgressIndicator();
  }

  Future<void> _deletePositionsVacant(PositionsVacant positionsVacant) async {
    try {
      await deletePositionsVacant(positionsVacant.id!.toString());
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to delete the PositionsVacant'),
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

class AddPositionsVacantPage extends StatefulWidget {
  static const String route = '/positions_vacant/add';
  const AddPositionsVacantPage({super.key});
  @override
  _AddPositionsVacantPageState createState() => _AddPositionsVacantPageState();
}

class _AddPositionsVacantPageState extends State<AddPositionsVacantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _office_id_Controller;
  late FocusNode _office_id_FocusNode;
  late TextEditingController _job_id_Controller;
  late FocusNode _job_id_FocusNode;
  late TextEditingController _amount_Controller;
  late FocusNode _amount_FocusNode;
  late TextEditingController _start_date_Controller;
  late FocusNode _start_date_FocusNode;
  late TextEditingController _end_date_Controller;
  late FocusNode _end_date_FocusNode;
  late TextEditingController _last_updated_Controller;
  late FocusNode _last_updated_FocusNode;
  late TextEditingController _notes_Controller;
  late FocusNode _notes_FocusNode;

  @override
  void initState() {
    super.initState();
    _office_id_Controller = TextEditingController();
    _office_id_FocusNode = FocusNode();
    _job_id_Controller = TextEditingController();
    _job_id_FocusNode = FocusNode();
    _amount_Controller = TextEditingController();
    _amount_FocusNode = FocusNode();
    _start_date_Controller = TextEditingController();
    _start_date_FocusNode = FocusNode();
    _end_date_Controller = TextEditingController();
    _end_date_FocusNode = FocusNode();
    _last_updated_Controller = TextEditingController();
    _last_updated_FocusNode = FocusNode();
    _notes_Controller = TextEditingController();
    _notes_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _office_id_Controller.dispose();
    _office_id_FocusNode.dispose();
    _job_id_Controller.dispose();
    _job_id_FocusNode.dispose();
    _amount_Controller.dispose();
    _amount_FocusNode.dispose();
    _start_date_Controller.dispose();
    _start_date_FocusNode.dispose();
    _end_date_Controller.dispose();
    _end_date_FocusNode.dispose();
    _last_updated_Controller.dispose();
    _last_updated_FocusNode.dispose();
    _notes_Controller.dispose();
    _notes_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PositionsVacant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text(
                  'Fill in the details of the PositionsVacant you want to add'),
              TextFormField(
                controller: _office_id_Controller,
                decoration: const InputDecoration(labelText: 'office_id'),
                onFieldSubmitted: (_) {
                  _office_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _job_id_Controller,
                decoration: const InputDecoration(labelText: 'job_id'),
                onFieldSubmitted: (_) {
                  _job_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _amount_Controller,
                decoration: const InputDecoration(labelText: 'amount'),
                onFieldSubmitted: (_) {
                  _amount_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _start_date_Controller,
                decoration: const InputDecoration(labelText: 'start_date'),
                onFieldSubmitted: (_) {
                  _start_date_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _end_date_Controller,
                decoration: const InputDecoration(labelText: 'end_date'),
                onFieldSubmitted: (_) {
                  _end_date_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _last_updated_Controller,
                decoration: const InputDecoration(labelText: 'last_updated'),
                onFieldSubmitted: (_) {
                  _last_updated_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _notes_Controller,
                decoration: const InputDecoration(labelText: 'notes'),
                onFieldSubmitted: (_) {
                  _notes_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addPositionsVacant(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _addPositionsVacant(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final PositionsVacant positionsVacant = PositionsVacant(
          office_id: int.parse(_office_id_Controller.text),
          job_id: int.parse(_job_id_Controller.text),
          amount: int.parse(_amount_Controller.text),
          start_date: _start_date_Controller.text,
          end_date: _end_date_Controller.text,
          last_updated: _last_updated_Controller.text,
          notes: _notes_Controller.text,
        );
        await createPositionsVacant(positionsVacant);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to add PositionsVacant'),
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

class EditPositionsVacantPage extends StatefulWidget {
  //static const String route = 'positions_vacant/edit';
  final PositionsVacant positionsVacant;
  const EditPositionsVacantPage({super.key, required this.positionsVacant});
  @override
  _EditPositionsVacantPageState createState() =>
      _EditPositionsVacantPageState();
}

class _EditPositionsVacantPageState extends State<EditPositionsVacantPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _office_id_Controller;
  late FocusNode _office_id_FocusNode;
  late TextEditingController _job_id_Controller;
  late FocusNode _job_id_FocusNode;
  late TextEditingController _amount_Controller;
  late FocusNode _amount_FocusNode;
  late TextEditingController _start_date_Controller;
  late FocusNode _start_date_FocusNode;
  late TextEditingController _end_date_Controller;
  late FocusNode _end_date_FocusNode;
  late TextEditingController _last_updated_Controller;
  late FocusNode _last_updated_FocusNode;
  late TextEditingController _notes_Controller;
  late FocusNode _notes_FocusNode;
  @override
  void initState() {
    super.initState();
    final PositionsVacant positionsVacant = widget.positionsVacant;
    _office_id_Controller =
        TextEditingController(text: positionsVacant.office_id!.toString());
    _office_id_FocusNode = FocusNode();
    _job_id_Controller =
        TextEditingController(text: positionsVacant.job_id!.toString());
    _job_id_FocusNode = FocusNode();
    _amount_Controller =
        TextEditingController(text: positionsVacant.amount!.toString());
    _amount_FocusNode = FocusNode();
    _start_date_Controller =
        TextEditingController(text: positionsVacant.start_date!);
    _start_date_FocusNode = FocusNode();
    _end_date_Controller =
        TextEditingController(text: positionsVacant.end_date!);
    _end_date_FocusNode = FocusNode();

    _last_updated_Controller =
        TextEditingController(text: positionsVacant.last_updated ?? '');
    _last_updated_FocusNode = FocusNode();
    _notes_Controller = TextEditingController(text: positionsVacant.notes!);
    _notes_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _office_id_Controller.dispose();
    _office_id_FocusNode.dispose();
    _job_id_Controller.dispose();
    _job_id_FocusNode.dispose();
    _amount_Controller.dispose();
    _amount_FocusNode.dispose();
    _start_date_Controller.dispose();
    _start_date_FocusNode.dispose();
    _end_date_Controller.dispose();
    _end_date_FocusNode.dispose();
    _last_updated_Controller.dispose();
    _last_updated_FocusNode.dispose();
    _notes_Controller.dispose();
    _notes_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions Vacant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text(
                  'Fill in the details of the PositionsVacant you want to edit'),
              TextFormField(
                controller: _office_id_Controller,
                decoration: const InputDecoration(labelText: 'office_id'),
                onFieldSubmitted: (_) {
                  _office_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _job_id_Controller,
                decoration: const InputDecoration(labelText: 'job_id'),
                onFieldSubmitted: (_) {
                  _job_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _amount_Controller,
                decoration: const InputDecoration(labelText: 'amount'),
                onFieldSubmitted: (_) {
                  _amount_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _start_date_Controller,
                decoration: const InputDecoration(labelText: 'start_date'),
                onFieldSubmitted: (_) {
                  _start_date_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _end_date_Controller,
                decoration: const InputDecoration(labelText: 'end_date'),
                onFieldSubmitted: (_) {
                  _end_date_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _last_updated_Controller,
                decoration: const InputDecoration(labelText: 'last_updated'),
                onFieldSubmitted: (_) {
                  _last_updated_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _notes_Controller,
                decoration: const InputDecoration(labelText: 'notes'),
                onFieldSubmitted: (_) {
                  _notes_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _editPositionsVacant(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _editPositionsVacant(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final PositionsVacant positionsVacant = PositionsVacant(
          id: widget.positionsVacant.id,
          office_id: int.parse(_office_id_Controller.text),
          job_id: int.parse(_job_id_Controller.text),
          amount: int.parse(_amount_Controller.text),
          start_date: _start_date_Controller.text,
          end_date: _end_date_Controller.text,
          last_updated: _last_updated_Controller.text,
          notes: _notes_Controller.text,
        );
        //await updatePositionsVacant(positionsVacant);
        positionsVacant;
        Navigator.of(context).pop(positionsVacant);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to edit the PositionsVacant'),
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
