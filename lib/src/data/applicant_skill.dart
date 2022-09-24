import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicantSkill {
    int? id;
    int? applicant_id;
    int? job_skill_id;
    int? evaluator_id;
    int? rating;
    String? description;
    String? last_updated;
  
    ApplicantSkill({
        this.id,
        this.applicant_id,
        this.job_skill_id,
        this.evaluator_id,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory ApplicantSkill.fromJson(Map<String, dynamic> json) {
        return ApplicantSkill(
                id: json['id'],
                applicant_id: json['applicant_id'],
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
           if(applicant_id != null) 'applicant_id': applicant_id,
           if(job_skill_id != null) 'job_skill_id': job_skill_id,
           if(evaluator_id != null) 'evaluator_id': evaluator_id,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<ApplicantSkill>> fetchApplicantSkills() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_skills'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<ApplicantSkill> applicantSkills = await resultsJson
            .map<ApplicantSkill>((json) => ApplicantSkill.fromJson(json))
            .toList();
        return applicantSkills;
    } else {
        throw Exception('Failed to load ApplicantSkill');
    }
}

Future<ApplicantSkill> fetchApplicantSkill(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_skills/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        ApplicantSkill applicantSkill = await resultsJson
            .map<ApplicantSkill>((json) => ApplicantSkill.fromJson(json));
        return applicantSkill;
    } else {
        throw Exception('Failed to load ApplicantSkill');
    }
}

Future<http.Response> createApplicantSkill(ApplicantSkill applicantSkill) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create ApplicantSkill.');
    }
}

Future<http.Response> updateApplicantSkill(ApplicantSkill applicantSkill) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update ApplicantSkill.');
    }
}

Future<http.Response> deleteApplicantSkill(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_skills/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete ApplicantSkill.');
    }
}