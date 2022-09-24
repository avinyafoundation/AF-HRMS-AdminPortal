import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Employee {
  int? id;
  String? employee_id;
  String? first_name;
  String? last_name;
  String? name_with_initials;
  String? full_name;
  String? gender;
  String? hire_date;
  String? id_number;
  String? phone_number1;
  String? phone_number2;
  String? email;
  String? cv_location;
  String? last_updated;
  String? display_name;

  Employee(
      {this.id,
      this.employee_id,
      this.first_name,
      this.last_name,
      this.name_with_initials,
      this.full_name,
      this.gender,
      this.hire_date,
      this.id_number,
      this.phone_number1,
      this.phone_number2,
      this.email,
      this.cv_location,
      this.last_updated,
      this.display_name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employee_id: json['employee_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      name_with_initials: json['name_with_initials'],
      full_name: json['full_name'],
      gender: json['gender'],
      hire_date: json['hire_date'],
      id_number: json['id_number'],
      phone_number1: json['phone_number1'],
      phone_number2: json['phone_number2'],
      email: json['email'],
      cv_location: json['cv_location'],
      last_updated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (employee_id != null) 'employee_id': employee_id,
        if (first_name != null) 'first_name': first_name,
        if (last_name != null) 'last_name': last_name,
        if (name_with_initials != null)
          'name_with_initials': name_with_initials,
        if (full_name != null) 'full_name': full_name,
        if (gender != null) 'gender': gender,
        if (hire_date != null) 'hire_date': hire_date,
        if (id_number != null) 'id_number': id_number,
        if (phone_number1 != null) 'phone_number1': phone_number1,
        if (phone_number2 != null) 'phone_number2': phone_number2,
        if (email != null) 'email': email,
        if (cv_location != null) 'cv_location': cv_location,
        if (last_updated != null) 'last_updated': last_updated,
      };
}

Future<List<Employee>> fetchEmployees() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employees'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Employee> employees = await resultsJson
        .map<Employee>((json) => Employee.fromJson(json))
        .toList();
    return employees;
  } else {
    throw Exception('Failed to load Employee');
  }
}

Future<Employee> fetchEmployee(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employees/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Employee employee =
        await resultsJson.map<Employee>((json) => Employee.fromJson(json));
    return employee;
  } else {
    throw Exception('Failed to load Employee');
  }
}

Future<http.Response> createEmployee(Employee employee) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employees'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(employee.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Employee.');
  }
}

Future<http.Response> updateEmployee(Employee employee) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employees'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(employee.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update Employee.');
  }
}

Future<http.Response> deleteEmployee(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employees/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete Employee.');
  }
}
