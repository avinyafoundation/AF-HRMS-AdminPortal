import 'package:flutter/material.dart';

import '../data.dart';
// import '../routing.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  TeamsScreenState createState() => TeamsScreenState();
}

class TeamsScreenState extends State<TeamsScreen> {
  final String title = 'Teams';

  List<Organization>? organizations = [];
  Organization? selectedOrganization = null;

  TeamsScreenState() {
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
                                label: Text('Employee',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400)),
                              ),
                              DataColumn(
                                label: Text('Employee No',
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
        DataCell(SizedBox.shrink())
      ]));
      team.jobs!.forEach((job) {
        dataRows.add(DataRow(cells: [
          DataCell(SizedBox.shrink()),
          DataCell(Text(job.name!,
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))),
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink())
        ]));
        job.employees!.forEach((employee) {
          dataRows.add(DataRow(cells: [
            DataCell(SizedBox.shrink()),
            DataCell(SizedBox.shrink()),
            DataCell(Text(employee.display_name!)),
            DataCell(Text(employee.employee_id!))
          ]));
        });
      });
    });
    return dataRows;
  }
}
