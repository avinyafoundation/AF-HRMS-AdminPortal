import 'package:flutter/material.dart';

// import '../data/hr_system.dart';
// import '../routing.dart';

class InterviewsScreen extends StatefulWidget {
  const InterviewsScreen({super.key});

  @override
  InterviewsScreenState createState() => InterviewsScreenState();
}

class InterviewsScreenState extends State<InterviewsScreen> {
  final String title = 'Interviews';
  bool checkbox1 = true;
  bool checkbox2 = false;
  String gender = 'male';
  String dropdownValue = 'A';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                Text('TextFormField'),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'write something',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 32.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (value) {
                    //Do something with this value
                  },
                ),
                SizedBox(height: 10.0),
                Text('Password Field'),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'password here',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 32.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (value) {
                    //Do something with this value
                  },
                ),
                SizedBox(height: 10.0),
                Text('Checkbox'),
                SizedBox(height: 10.0),
                Row(children: [
                  SizedBox(
                    width: 10,
                    child: Checkbox(
                      value: checkbox1,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        //value may be true or false
                        //setState(() {
                        checkbox1 = !checkbox1;
                        //});
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('This is Checkbox 1')
                ]),
                Row(children: [
                  SizedBox(
                    width: 10,
                    child: Checkbox(
                      value: checkbox2,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        //value may be true or false
                        //setState(() {
                        checkbox2 = !checkbox2;
                        //});
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('This is Checkbox 2')
                ]),
                SizedBox(height: 10.0),
                Text('Radio Button'),
                SizedBox(height: 10.0),
                Row(children: [
                  SizedBox(
                    width: 10,
                    child: Radio(
                      value: 'male',
                      groupValue: gender,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        //value may be true or false
                        //setState(() {
                        gender = value.toString();
                        //});
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('Male')
                ]),
                Row(children: [
                  SizedBox(
                    width: 10,
                    child: Radio(
                      value: 'female',
                      groupValue: gender,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        //value may be true or false
                        //setState(() {
                        gender = value.toString();
                        //});
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('Female')
                ]),
                SizedBox(height: 10.0),
                Text('DropDown Button'),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3.0)),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, size: 22),
                    underline: SizedBox(),
                    items: <String>['A', 'B', 'C', 'D'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //Do something with this value
                      //setState(() {
                      dropdownValue = value.toString();
                      //});
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Date Picker'),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1994),
                      lastDate: DateTime(2101),
                      // builder: (BuildContext context, Widget child) {
                      //   return Theme(
                      //     data: ThemeData.dark(),
                      //     child: child,
                      //   );
                      // },
                    );
                    if (picked != null && picked != date)
                      //setState(() {
                      date = picked;
                    //});
                  },
                  child: Text('$date Click to open date picker'),
                ),
                SizedBox(height: 10.0),
                Text('Time Picker'),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: time,
                      // builder: (BuildContext context, Widget child) {
                      //   return Theme(
                      //     data: ThemeData.dark(),
                      //     child: child,
                      //   );
                      // },
                    );
                    if (picked != null && picked != time)
                      //setState(() {
                      time = picked;
                    //});
                  },
                  child: Text('$time Click to open time picker'),
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
}
