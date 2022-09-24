import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EvaluationCycle {
    int? id;
    String? name;
    String? description;
    String? start_date;
    String? end_date;
    String? last_updated;
    String? notes;
  
    EvaluationCycle({
        this.id,
        this.name,
        this.description,
        this.start_date,
        this.end_date,
        this.last_updated,
        this.notes,
    });

    factory EvaluationCycle.fromJson(Map<String, dynamic> json) {
        return EvaluationCycle(
                id: json['id'],
                name: json['name'],
                description: json['description'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
                notes: json['notes'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
           if(notes != null) 'notes': notes,
    }; 
}

Future<List<EvaluationCycle>> fetchEvaluationCycles() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_cycles'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EvaluationCycle> evaluationCycles = await resultsJson
            .map<EvaluationCycle>((json) => EvaluationCycle.fromJson(json))
            .toList();
        return evaluationCycles;
    } else {
        throw Exception('Failed to load EvaluationCycle');
    }
}

Future<EvaluationCycle> fetchEvaluationCycle(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_cycles/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EvaluationCycle evaluationCycle = await resultsJson
            .map<EvaluationCycle>((json) => EvaluationCycle.fromJson(json));
        return evaluationCycle;
    } else {
        throw Exception('Failed to load EvaluationCycle');
    }
}

Future<http.Response> createEvaluationCycle(EvaluationCycle evaluationCycle) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_cycles'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(evaluationCycle.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EvaluationCycle.');
    }
}

Future<http.Response> updateEvaluationCycle(EvaluationCycle evaluationCycle) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_cycles'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(evaluationCycle.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EvaluationCycle.');
    }
}

Future<http.Response> deleteEvaluationCycle(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/evaluation_cycles/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EvaluationCycle.');
    }
}