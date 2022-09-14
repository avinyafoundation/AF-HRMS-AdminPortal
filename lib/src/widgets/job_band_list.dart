import 'package:flutter/material.dart';

import '../data.dart';

class JobBandList extends StatefulWidget {
  const JobBandList({super.key, this.onTap});
  final ValueChanged<JobBand>? onTap;

  @override
  // ignore: no_logic_in_create_state
  JobBandListState createState() => JobBandListState(onTap);
}

class JobBandListState extends State<JobBandList> {
  late Future<List<JobBand>> futureJobBands;
  final ValueChanged<JobBand>? onTap;

  JobBandListState(this.onTap);

  @override
  void initState() {
    super.initState();
    futureJobBands = fetchJobBands();
  }

  Future<List<JobBand>> refreshJobBandState() async {
    futureJobBands = fetchJobBands();
    return futureJobBands;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobBand>>(
      future: refreshJobBandState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          hrSystemInstance.setJobBands(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                snapshot.data![index].name!,
              ),
              subtitle: Text(
                ' ' +
                    snapshot.data![index].name! +
                    ' ' +
                    snapshot.data![index].description! +
                    ' ' +
                    snapshot.data![index].level!.toString() +
                    ' ' +
                    snapshot.data![index].min_salary!.toString() +
                    ' ' +
                    snapshot.data![index].max_salary!.toString() +
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
                                builder: (context) => EditJobBandPage(
                                    jobBand: snapshot.data![index]),
                              ),
                            )
                            .then((value) => setState(() {}));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _deleteJobBand(snapshot.data![index]);
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

  Future<void> _deleteJobBand(JobBand jobBand) async {
    try {
      await deleteJobBand(jobBand.id!.toString());
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to delete the JobBand'),
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

class AddJobBandPage extends StatefulWidget {
  static const String route = '/job_band/add';
  const AddJobBandPage({super.key});
  @override
  _AddJobBandPageState createState() => _AddJobBandPageState();
}

class _AddJobBandPageState extends State<AddJobBandPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _level_Controller;
  late FocusNode _level_FocusNode;
  late TextEditingController _min_salary_Controller;
  late FocusNode _min_salary_FocusNode;
  late TextEditingController _max_salary_Controller;
  late FocusNode _max_salary_FocusNode;

  @override
  void initState() {
    super.initState();
    _name_Controller = TextEditingController();
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController();
    _description_FocusNode = FocusNode();
    _level_Controller = TextEditingController();
    _level_FocusNode = FocusNode();
    _min_salary_Controller = TextEditingController();
    _min_salary_FocusNode = FocusNode();
    _max_salary_Controller = TextEditingController();
    _max_salary_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _level_Controller.dispose();
    _level_FocusNode.dispose();
    _min_salary_Controller.dispose();
    _min_salary_FocusNode.dispose();
    _max_salary_Controller.dispose();
    _max_salary_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobBand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the JobBand you want to add'),
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
                controller: _level_Controller,
                decoration: const InputDecoration(labelText: 'level'),
                onFieldSubmitted: (_) {
                  _level_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _min_salary_Controller,
                decoration: const InputDecoration(labelText: 'min_salary'),
                onFieldSubmitted: (_) {
                  _min_salary_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _max_salary_Controller,
                decoration: const InputDecoration(labelText: 'max_salary'),
                onFieldSubmitted: (_) {
                  _max_salary_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addJobBand(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _addJobBand(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final JobBand jobBand = JobBand(
          name: _name_Controller.text,
          description: _description_Controller.text,
          level: int.parse(_level_Controller.text),
          min_salary: double.parse(_min_salary_Controller.text),
          max_salary: double.parse(_max_salary_Controller.text),
        );
        await createJobBand(jobBand);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to add JobBand'),
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

class EditJobBandPage extends StatefulWidget {
  static const String route = 'job_band/edit';
  final JobBand jobBand;
  const EditJobBandPage({super.key, required this.jobBand});
  @override
  _EditJobBandPageState createState() => _EditJobBandPageState();
}

class _EditJobBandPageState extends State<EditJobBandPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _level_Controller;
  late FocusNode _level_FocusNode;
  late TextEditingController _min_salary_Controller;
  late FocusNode _min_salary_FocusNode;
  late TextEditingController _max_salary_Controller;
  late FocusNode _max_salary_FocusNode;
  @override
  void initState() {
    super.initState();
    final JobBand jobBand = widget.jobBand;
    _name_Controller = TextEditingController(text: jobBand.name);
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController(text: jobBand.description);
    _description_FocusNode = FocusNode();
    _level_Controller = TextEditingController(text: jobBand.level.toString());
    _level_FocusNode = FocusNode();
    _min_salary_Controller =
        TextEditingController(text: jobBand.min_salary.toString());
    _min_salary_FocusNode = FocusNode();
    _max_salary_Controller =
        TextEditingController(text: jobBand.max_salary.toString());
    _max_salary_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _level_Controller.dispose();
    _level_FocusNode.dispose();
    _min_salary_Controller.dispose();
    _min_salary_FocusNode.dispose();
    _max_salary_Controller.dispose();
    _max_salary_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobBand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the JobBand you want to edit'),
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
                controller: _level_Controller,
                decoration: const InputDecoration(labelText: 'level'),
                onFieldSubmitted: (_) {
                  _level_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _min_salary_Controller,
                decoration: const InputDecoration(labelText: 'min_salary'),
                onFieldSubmitted: (_) {
                  _min_salary_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _max_salary_Controller,
                decoration: const InputDecoration(labelText: 'max_salary'),
                onFieldSubmitted: (_) {
                  _max_salary_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _editJobBand(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _editJobBand(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final JobBand jobBand = JobBand(
          id: widget.jobBand.id,
          name: _name_Controller.text,
          description: _description_Controller.text,
          level: int.parse(_level_Controller.text),
          min_salary: double.parse(_min_salary_Controller.text),
          max_salary: double.parse(_max_salary_Controller.text),
        );
        await updateJobBand(jobBand);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to edit the JobBand'),
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
