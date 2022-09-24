import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeSkill {
    int? id;
    int? employee_id;
    int? job_skill_id;
    int? evaluator_id;
    int? rating;
    String? description;
    String? last_updated;
  
    EmployeeSkill({
        this.id,
        this.employee_id,
        this.job_skill_id,
        this.evaluator_id,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory EmployeeSkill.fromJson(Map<String, dynamic> json) {
        return EmployeeSkill(
                id: json['id'],
                employee_id: json['employee_id'],
                job_skill_id: json['job_skill_id'],
                evaluator_id: json['evaluator_id'],
                rating: json['rating'],
                description: json['description'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(job_skill_id != null) 'job_skill_id': job_skill_id,
           if(evaluator_id != null) 'evaluator_id': evaluator_id,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeSkill>> fetchEmployeeSkills() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_skills'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeSkill> employeeSkills = await resultsJson
            .map<EmployeeSkill>((json) => EmployeeSkill.fromJson(json))
            .toList();
        return employeeSkills;
    } else {
        throw Exception('Failed to load EmployeeSkill');
    }
}

Future<EmployeeSkill> fetchEmployeeSkill(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_skills/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeSkill employeeSkill = await resultsJson
            .map<EmployeeSkill>((json) => EmployeeSkill.fromJson(json));
        return employeeSkill;
    } else {
        throw Exception('Failed to load EmployeeSkill');
    }
}

Future<http.Response> createEmployeeSkill(EmployeeSkill employeeSkill) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeSkill.');
    }
}

Future<http.Response> updateEmployeeSkill(EmployeeSkill employeeSkill) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeSkill.');
    }
}

Future<http.Response> deleteEmployeeSkill(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_skills/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeSkill.');
    }
}