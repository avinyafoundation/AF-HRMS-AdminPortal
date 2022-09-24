import 'package:flutter/material.dart';

import '../data.dart';
// import '../routing.dart';

class HRPlanScreen extends StatefulWidget {
  const HRPlanScreen({super.key});

  @override
  HRPlanScreenState createState() => HRPlanScreenState();
}

class HRPlanScreenState extends State<HRPlanScreen> {
  final String title = 'HR Plan';

  List<Organization>? organizations = [];
  Organization? selectedOrganization = null;

  HRPlanScreenState() {
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
                        children: [
                          Column(
                              children: selectedOrganization!.teams!
                                  .map((team) => Column(children: [
                                        Row(
                                          children: [
                                            Text(team.name!,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(team.description!,
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic)),
                                          ],
                                        ),
                                        Row(children: [
                                          DataTable(
                                              columns: [
                                                DataColumn(
                                                    label: SizedBox(
                                                  width: 120,
                                                  child: Text('Role',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )),
                                                DataColumn(
                                                  label: Text('Plan HC',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                                DataColumn(
                                                  label: Text('Current HC',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                                DataColumn(
                                                  label: Text('Vacant HC',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              ],
                                              rows: team.jobs!
                                                  .map((job) => DataRow(cells: [
                                                        DataCell(SizedBox(
                                                            width: 120,
                                                            child: Text(
                                                                job.name!,
                                                                style: TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic)))),
                                                        DataCell(Text(
                                                            job.hc_plan
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))),
                                                        DataCell(Text(
                                                            job.employees!
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))),
                                                        DataCell(Text(
                                                            (job.hc_plan! -
                                                                    job.employees!
                                                                        .length)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))),
                                                      ]))
                                                  .toList()),
                                        ])
                                      ]))
                                  .toList())
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
}
