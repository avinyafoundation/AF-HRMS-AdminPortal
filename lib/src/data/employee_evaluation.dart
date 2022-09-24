import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeEvaluation {
    int? id;
    int? employee_id;
    int? job_evaluation_criteria_id;
    int? evaluator_id;
    int? evaluation_cycle_id;
    int? rating;
    String? description;
    String? last_updated;
  
    EmployeeEvaluation({
        this.id,
        this.employee_id,
        this.job_evaluation_criteria_id,
        this.evaluator_id,
        this.evaluation_cycle_id,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory EmployeeEvaluation.fromJson(Map<String, dynamic> json) {
        return EmployeeEvaluation(
                id: json['id'],
                employee_id: json['employee_id'],
                job_evaluation_criteria_id: json['job_evaluation_criteria_id'],
                evaluator_id: json['evaluator_id'],
                evaluation_cycle_id: json['evaluation_cycle_id'],
                rating: json['rating'],
                description: json['description'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employee_id != null) 'employee_id': employee_id,
           if(job_evaluation_criteria_id != null) 'job_evaluation_criteria_id': job_evaluation_criteria_id,
           if(evaluator_id != null) 'evaluator_id': evaluator_id,
           if(evaluation_cycle_id != null) 'evaluation_cycle_id': evaluation_cycle_id,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<EmployeeEvaluation>> fetchEmployeeEvaluations() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_evaluations'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeEvaluation> employeeEvaluations = await resultsJson
            .map<EmployeeEvaluation>((json) => EmployeeEvaluation.fromJson(json))
            .toList();
        return employeeEvaluations;
    } else {
        throw Exception('Failed to load EmployeeEvaluation');
    }
}

Future<EmployeeEvaluation> fetchEmployeeEvaluation(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_evaluations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeEvaluation employeeEvaluation = await resultsJson
            .map<EmployeeEvaluation>((json) => EmployeeEvaluation.fromJson(json));
        return employeeEvaluation;
    } else {
        throw Exception('Failed to load EmployeeEvaluation');
    }
}

Future<http.Response> createEmployeeEvaluation(EmployeeEvaluation employeeEvaluation) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_evaluations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEvaluation.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeEvaluation.');
    }
}

Future<http.Response> updateEmployeeEvaluation(EmployeeEvaluation employeeEvaluation) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_evaluations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeEvaluation.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeEvaluation.');
    }
}

Future<http.Response> deleteEmployeeEvaluation(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_evaluations/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeEvaluation.');
    }
}