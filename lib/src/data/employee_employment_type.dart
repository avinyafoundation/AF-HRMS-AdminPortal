import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeEmploymentType {
    int? id;
    int? employee_id;
    int? employment_type_id;
    String? start_date;
    String? end_date;
    String? last_updated;
  
    EmployeeEmploymentType({
        this.id,
        this.employee_id,
        this.employment_type_id,
        this.start_date,
        this.end_date,
        this.last_updated,
    });

    factory EmployeeEmploymentType.fromJson(Map<String, dynamic> json) {
        return EmployeeEmploymentType(
                id: json['id'],
                employee_id: json['employee_id'],
                employment_type_id: json['employment_type_id'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(employment_type_id != null) 'employment_type_id': employment_type_id,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeEmploymentType>> fetchEmployeeEmploymentTypes() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_types'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeEmploymentType> employeeEmploymentTypes = await resultsJson
            .map<EmployeeEmploymentType>((json) => EmployeeEmploymentType.fromJson(json))
            .toList();
        return employeeEmploymentTypes;
    } else {
        throw Exception('Failed to load EmployeeEmploymentType');
    }
}

Future<EmployeeEmploymentType> fetchEmployeeEmploymentType(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_types/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeEmploymentType employeeEmploymentType = await resultsJson
            .map<EmployeeEmploymentType>((json) => EmployeeEmploymentType.fromJson(json));
        return employeeEmploymentType;
    } else {
        throw Exception('Failed to load EmployeeEmploymentType');
    }
}

Future<http.Response> createEmployeeEmploymentType(EmployeeEmploymentType employeeEmploymentType) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEmploymentType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeEmploymentType.');
    }
}

Future<http.Response> updateEmployeeEmploymentType(EmployeeEmploymentType employeeEmploymentType) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEmploymentType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeEmploymentType.');
    }
}

Future<http.Response> deleteEmployeeEmploymentType(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_employment_types/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeEmploymentType.');
    }
}