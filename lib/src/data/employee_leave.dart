import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeLeave {
    int? id;
    int? employee_id;
    int? leave_type_id;
    String? applied_on;
    String? start_date;
    String? end_date;
    int? approved_by;
    String? last_updated;
  
    EmployeeLeave({
        this.id,
        this.employee_id,
        this.leave_type_id,
        this.applied_on,
        this.start_date,
        this.end_date,
        this.approved_by,
        this.last_updated,
    });

    factory EmployeeLeave.fromJson(Map<String, dynamic> json) {
        return EmployeeLeave(
                id: json['id'],
                employee_id: json['employee_id'],
                leave_type_id: json['leave_type_id'],
                applied_on: json['applied_on'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                approved_by: json['approved_by'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(leave_type_id != null) 'leave_type_id': leave_type_id,
           if(applied_on != null) 'applied_on': applied_on,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(approved_by != null) 'approved_by': approved_by,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeLeave>> fetchEmployeeLeaves() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_leaves'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeLeave> employeeLeaves = await resultsJson
            .map<EmployeeLeave>((json) => EmployeeLeave.fromJson(json))
            .toList();
        return employeeLeaves;
    } else {
        throw Exception('Failed to load EmployeeLeave');
    }
}

Future<EmployeeLeave> fetchEmployeeLeave(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_leaves/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeLeave employeeLeave = await resultsJson
            .map<EmployeeLeave>((json) => EmployeeLeave.fromJson(json));
        return employeeLeave;
    } else {
        throw Exception('Failed to load EmployeeLeave');
    }
}

Future<http.Response> createEmployeeLeave(EmployeeLeave employeeLeave) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_leaves'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeLeave.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeLeave.');
    }
}

Future<http.Response> updateEmployeeLeave(EmployeeLeave employeeLeave) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_leaves'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeLeave.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeLeave.');
    }
}

Future<http.Response> deleteEmployeeLeave(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_leaves/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeLeave.');
    }
}