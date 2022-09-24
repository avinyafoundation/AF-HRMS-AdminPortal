import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeEmploymentStatus {
    int? id;
    int? employee_id;
    int? employment_status_id;
    String? start_date;
    String? end_date;
    String? last_updated;
  
    EmployeeEmploymentStatus({
        this.id,
        this.employee_id,
        this.employment_status_id,
        this.start_date,
        this.end_date,
        this.last_updated,
    });

    factory EmployeeEmploymentStatus.fromJson(Map<String, dynamic> json) {
        return EmployeeEmploymentStatus(
                id: json['id'],
                employee_id: json['employee_id'],
                employment_status_id: json['employment_status_id'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(employment_status_id != null) 'employment_status_id': employment_status_id,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeEmploymentStatus>> fetchEmployeeEmploymentStatuss() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_statuss'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeEmploymentStatus> employeeEmploymentStatuss = await resultsJson
            .map<EmployeeEmploymentStatus>((json) => EmployeeEmploymentStatus.fromJson(json))
            .toList();
        return employeeEmploymentStatuss;
    } else {
        throw Exception('Failed to load EmployeeEmploymentStatus');
    }
}

Future<EmployeeEmploymentStatus> fetchEmployeeEmploymentStatus(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_statuss/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeEmploymentStatus employeeEmploymentStatus = await resultsJson
            .map<EmployeeEmploymentStatus>((json) => EmployeeEmploymentStatus.fromJson(json));
        return employeeEmploymentStatus;
    } else {
        throw Exception('Failed to load EmployeeEmploymentStatus');
    }
}

Future<http.Response> createEmployeeEmploymentStatus(EmployeeEmploymentStatus employeeEmploymentStatus) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEmploymentStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeEmploymentStatus.');
    }
}

Future<http.Response> updateEmployeeEmploymentStatus(EmployeeEmploymentStatus employeeEmploymentStatus) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEmploymentStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeEmploymentStatus.');
    }
}

Future<http.Response> deleteEmployeeEmploymentStatus(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_statuss/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeEmploymentStatus.');
    }
}