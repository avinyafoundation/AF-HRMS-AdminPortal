import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeQualification {
    int? id;
    int? employee_id;
    int? job_qualification_id;
    int? verified_by;
    int? rating;
    String? description;
    String? last_updated;
  
    EmployeeQualification({
        this.id,
        this.employee_id,
        this.job_qualification_id,
        this.verified_by,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory EmployeeQualification.fromJson(Map<String, dynamic> json) {
        return EmployeeQualification(
                id: json['id'],
                employee_id: json['employee_id'],
                job_qualification_id: json['job_qualification_id'],
                verified_by: json['verified_by'],
                rating: json['rating'],
                description: json['description'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(job_qualification_id != null) 'job_qualification_id': job_qualification_id,
           if(verified_by != null) 'verified_by': verified_by,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeQualification>> fetchEmployeeQualifications() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_qualifications'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeQualification> employeeQualifications = await resultsJson
            .map<EmployeeQualification>((json) => EmployeeQualification.fromJson(json))
            .toList();
        return employeeQualifications;
    } else {
        throw Exception('Failed to load EmployeeQualification');
    }
}

Future<EmployeeQualification> fetchEmployeeQualification(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_qualifications/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeQualification employeeQualification = await resultsJson
            .map<EmployeeQualification>((json) => EmployeeQualification.fromJson(json));
        return employeeQualification;
    } else {
        throw Exception('Failed to load EmployeeQualification');
    }
}

Future<http.Response> createEmployeeQualification(EmployeeQualification employeeQualification) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeQualification.');
    }
}

Future<http.Response> updateEmployeeQualification(EmployeeQualification employeeQualification) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeQualification.');
    }
}

Future<http.Response> deleteEmployeeQualification(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_qualifications/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeQualification.');
    }
}