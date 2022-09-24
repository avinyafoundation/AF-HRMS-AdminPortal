import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobEvaluationCriteria {
    int? id;
    int? job_id;
    int? evaluation_criteria_category_id;
    int? sequence_no;
    String? description;
  
    JobEvaluationCriteria({
        this.id,
        this.job_id,
        this.evaluation_criteria_category_id,
        this.sequence_no,
        this.description,
    });

    factory JobEvaluationCriteria.fromJson(Map<String, dynamic> json) {
        return JobEvaluationCriteria(
                id: json['id'],
                job_id: json['job_id'],
                evaluation_criteria_category_id: json['evaluation_criteria_category_id'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(job_id != null) 'job_id': job_id,
           if(evaluation_criteria_category_id != null) 'evaluation_criteria_category_id': evaluation_criteria_category_id,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<JobEvaluationCriteria>> fetchJobEvaluationCriterias() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_evaluation_criterias'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobEvaluationCriteria> jobEvaluationCriterias = await resultsJson
            .map<JobEvaluationCriteria>((json) => JobEvaluationCriteria.fromJson(json))
            .toList();
        return jobEvaluationCriterias;
    } else {
        throw Exception('Failed to load JobEvaluationCriteria');
    }
}

Future<JobEvaluationCriteria> fetchJobEvaluationCriteria(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_evaluation_criterias/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobEvaluationCriteria jobEvaluationCriteria = await resultsJson
            .map<JobEvaluationCriteria>((json) => JobEvaluationCriteria.fromJson(json));
        return jobEvaluationCriteria;
    } else {
        throw Exception('Failed to load JobEvaluationCriteria');
    }
}

Future<http.Response> createJobEvaluationCriteria(JobEvaluationCriteria jobEvaluationCriteria) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_evaluation_criterias'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobEvaluationCriteria.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobEvaluationCriteria.');
    }
}

Future<http.Response> updateJobEvaluationCriteria(JobEvaluationCriteria jobEvaluationCriteria) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_evaluation_criterias'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobEvaluationCriteria.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobEvaluationCriteria.');
    }
}

Future<http.Response> deleteJobEvaluationCriteria(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_evaluation_criterias/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobEvaluationCriteria.');
    }
}