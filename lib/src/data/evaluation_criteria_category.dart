import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EvaluationCriteriaCategory {
    int? id;
    String? name;
    String? description;
  
    EvaluationCriteriaCategory({
        this.id,
        this.name,
        this.description,
    });

    factory EvaluationCriteriaCategory.fromJson(Map<String, dynamic> json) {
        return EvaluationCriteriaCategory(
                id: json['id'],
                name: json['name'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
    }; 
}

Future<List<EvaluationCriteriaCategory>> fetchEvaluationCriteriaCategorys() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_criteria_categorys'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EvaluationCriteriaCategory> evaluationCriteriaCategorys = await resultsJson
            .map<EvaluationCriteriaCategory>((json) => EvaluationCriteriaCategory.fromJson(json))
            .toList();
        return evaluationCriteriaCategorys;
    } else {
        throw Exception('Failed to load EvaluationCriteriaCategory');
    }
}

Future<EvaluationCriteriaCategory> fetchEvaluationCriteriaCategory(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_criteria_categorys/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EvaluationCriteriaCategory evaluationCriteriaCategory = await resultsJson
            .map<EvaluationCriteriaCategory>((json) => EvaluationCriteriaCategory.fromJson(json));
        return evaluationCriteriaCategory;
    } else {
        throw Exception('Failed to load EvaluationCriteriaCategory');
    }
}

Future<http.Response> createEvaluationCriteriaCategory(EvaluationCriteriaCategory evaluationCriteriaCategory) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_criteria_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(evaluationCriteriaCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EvaluationCriteriaCategory.');
    }
}

Future<http.Response> updateEvaluationCriteriaCategory(EvaluationCriteriaCategory evaluationCriteriaCategory) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_criteria_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(evaluationCriteriaCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EvaluationCriteriaCategory.');
    }
}

Future<http.Response> deleteEvaluationCriteriaCategory(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_criteria_categorys/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EvaluationCriteriaCategory.');
    }
}