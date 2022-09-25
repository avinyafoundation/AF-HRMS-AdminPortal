import 'package:flutter/material.dart';

import '../data.dart';
// import '../routing.dart';

class RecruitmentsScreen extends StatefulWidget {
  const RecruitmentsScreen({super.key});

  @override
  RecruitmentsScreenState createState() => RecruitmentsScreenState();
}

class RecruitmentsScreenState extends State<RecruitmentsScreen> {
  final String title = 'HR Plan';

  List<Organization>? organizations = [];
  Organization? selectedOrganization = null;

  RecruitmentsScreenState() {
    organizations = hrSystemInstance.organizations;
    if (organizations != null) selectedOrganization = organizations!.first;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text('Organization',
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3.0)),
                      child: DropdownButton<Organization>(
                        hint: new Text("Select an organization"),
                        value: selectedOrganization,
                        // isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down, size: 22),
                        underline: SizedBox(),
                        items: organizations!.map((Organization value) {
                          return new DropdownMenuItem<Organization>(
                            value: value,
                            child: new Text(value.name!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          //Do something with this value
                          setState(() {
                            selectedOrganization = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataTable(
                            columns: [
                              DataColumn(
                                label: Text('Team',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                              DataColumn(
                                label: Text('Job',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                              DataColumn(
                                label: Text('Plan HC',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                              DataColumn(
                                label: Text('Vacant HC',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                              DataColumn(
                                label: Text('Actions',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                            rows: getOraganizationTeamStructure(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ])),
        ),
      );

  List<String> getOrganizationNameList() {
    List<String> names = [];
    if (organizations == null)
      names.add('None');
    else
      organizations!.forEach((organization) => names.add(organization.name!));
    return names;
  }

  List<DataRow> getOraganizationTeamStructure() {
    List<DataRow> dataRows = [];
    selectedOrganization!.teams!.forEach((team) {
      dataRows.add(DataRow(cells: [
        DataCell(Text(team.name!,
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w800))),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink()),
        DataCell(SizedBox.shrink())
      ]));
      team.jobs!.forEach((job) {
        dataRows.add(DataRow(cells: [
          DataCell(SizedBox.shrink()),
          DataCell(Text(job.name!,
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))),
          DataCell(Text(job.hc_plan.toString())),
          DataCell(Text((job.hc_plan! - job.employees!.length).toString())),
          DataCell(
            Container(
                child: Row(
                    children: ((job.hc_plan! - job.employees!.length) > 0)
                        ? [
                            Text('Add vacancy'),
                            IconButton(
                              icon: new Icon(Icons.add),
                              onPressed: () {/* Your code */},
                            )
                          ]
                        : [Text('No vacancy')])),
          )
        ]));
      });
    });
    return dataRows;
  }
}
