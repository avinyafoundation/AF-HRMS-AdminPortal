import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicantEvaluation {
    int? id;
    int? applicant_id;
    int? job_evaluation_criteria_id;
    int? interviewer_id;
    int? rating;
    String? description;
    String? last_updated;
  
    ApplicantEvaluation({
        this.id,
        this.applicant_id,
        this.job_evaluation_criteria_id,
        this.interviewer_id,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory ApplicantEvaluation.fromJson(Map<String, dynamic> json) {
        return ApplicantEvaluation(
                id: json['id'],
                applicant_id: json['applicant_id'],
                job_evaluation_criteria_id: json['job_evaluation_criteria_id'],
                interviewer_id: json['interviewer_id'],
                rating: json['rating'],
                description: json['description'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(applicant_id != null) 'applicant_id': applicant_id,
           if(job_evaluation_criteria_id != null) 'job_evaluation_criteria_id': job_evaluation_criteria_id,
           if(interviewer_id != null) 'interviewer_id': interviewer_id,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<ApplicantEvaluation>> fetchApplicantEvaluations() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_evaluations'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<ApplicantEvaluation> applicantEvaluations = await resultsJson
            .map<ApplicantEvaluation>((json) => ApplicantEvaluation.fromJson(json))
            .toList();
        return applicantEvaluations;
    } else {
        throw Exception('Failed to load ApplicantEvaluation');
    }
}

Future<ApplicantEvaluation> fetchApplicantEvaluation(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_evaluations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        ApplicantEvaluation applicantEvaluation = await resultsJson
            .map<ApplicantEvaluation>((json) => ApplicantEvaluation.fromJson(json));
        return applicantEvaluation;
    } else {
        throw Exception('Failed to load ApplicantEvaluation');
    }
}

Future<http.Response> createApplicantEvaluation(ApplicantEvaluation applicantEvaluation) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_evaluations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantEvaluation.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create ApplicantEvaluation.');
    }
}

Future<http.Response> updateApplicantEvaluation(ApplicantEvaluation applicantEvaluation) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_evaluations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantEvaluation.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update ApplicantEvaluation.');
    }
}

Future<http.Response> deleteApplicantEvaluation(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_evaluations/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete ApplicantEvaluation.');
    }
}