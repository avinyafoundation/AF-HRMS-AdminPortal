import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeAttendance {
    int? id;
    int? employee_id;
    int? attendance_type_id;
    String? time_stamp;
    String? last_updated;
  
    EmployeeAttendance({
        this.id,
        this.employee_id,
        this.attendance_type_id,
        this.time_stamp,
        this.last_updated,
    });

    factory EmployeeAttendance.fromJson(Map<String, dynamic> json) {
        return EmployeeAttendance(
                id: json['id'],
                employee_id: json['employee_id'],
                attendance_type_id: json['attendance_type_id'],
                time_stamp: json['time_stamp'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(attendance_type_id != null) 'attendance_type_id': attendance_type_id,
           if(time_stamp != null) 'time_stamp': time_stamp,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeAttendance>> fetchEmployeeAttendances() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_attendances'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeAttendance> employeeAttendances = await resultsJson
            .map<EmployeeAttendance>((json) => EmployeeAttendance.fromJson(json))
            .toList();
        return employeeAttendances;
    } else {
        throw Exception('Failed to load EmployeeAttendance');
    }
}

Future<EmployeeAttendance> fetchEmployeeAttendance(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_attendances/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeAttendance employeeAttendance = await resultsJson
            .map<EmployeeAttendance>((json) => EmployeeAttendance.fromJson(json));
        return employeeAttendance;
    } else {
        throw Exception('Failed to load EmployeeAttendance');
    }
}

Future<http.Response> createEmployeeAttendance(EmployeeAttendance employeeAttendance) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_attendances'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeAttendance.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeAttendance.');
    }
}

Future<http.Response> updateEmployeeAttendance(EmployeeAttendance employeeAttendance) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_attendances'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeAttendance.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeAttendance.');
    }
}

Future<http.Response> deleteEmployeeAttendance(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_attendances/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeAttendance.');
    }
}