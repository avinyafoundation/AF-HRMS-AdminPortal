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
                                                  label: Text('Role',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
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
                                                        DataCell(Text(job.name!,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))),
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
                      // child: DataTable(
                      //   columns: [
                      //     DataColumn(
                      //       label: Text('Name',
                      //           style: TextStyle(
                      //               fontStyle: FontStyle.italic,
                      //               fontWeight: FontWeight.bold)),
                      //     ),
                      //     DataColumn(
                      //       label: Text('Description',
                      //           style: TextStyle(
                      //               fontStyle: FontStyle.italic,
                      //               fontWeight: FontWeight.bold)),
                      //     ),
                      //   ],
                      //   rows: selectedOrganization!.teams!
                      // .map((team) => DataRow(cells: [
                      //       DataCell(Text(team.name!,
                      //           style: TextStyle(
                      //               fontStyle: FontStyle.italic))),
                      //       DataCell(Text(team.description!,
                      //           style: TextStyle(
                      //               fontStyle: FontStyle.italic))),
                      //             // DataCell(ListView(
                      //             //   children: team.jobs!
                      //             //       .map((job) => Text(job.name!))
                      //             //       .toList(),
                      //             // ))
                      //           ]))
                      //       .toList(),
                      // ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Buttons'),
                    SizedBox(height: 10.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            //color: Colors.green,
                            child: Text('Click',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              //Do Something
                            },
                          ),
                          MaterialButton(
                            color: Colors.orange,
                            child: Text('Click',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              //Do Something
                            },
                          ),
                          Container(
                            color: Colors.lightBlue,
                            child: RawMaterialButton(
                              child: Text('Click',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                //Do Something
                              },
                            ),
                          )
                        ])
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
