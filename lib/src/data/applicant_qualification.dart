import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicantQualification {
    int? id;
    int? applicant_id;
    int? job_qualification_id;
    int? rating;
    String? description;
    String? last_updated;
  
    ApplicantQualification({
        this.id,
        this.applicant_id,
        this.job_qualification_id,
        this.rating,
        this.description,
        this.last_updated,
    });

    factory ApplicantQualification.fromJson(Map<String, dynamic> json) {
        return ApplicantQualification(
                id: json['id'],
                applicant_id: json['applicant_id'],
                job_qualification_id: json['job_qualification_id'],
                rating: json['rating'],
                description: json['description'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(applicant_id != null) 'applicant_id': applicant_id,
           if(job_qualification_id != null) 'job_qualification_id': job_qualification_id,
           if(rating != null) 'rating': rating,
           if(description != null) 'description': description,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<ApplicantQualification>> fetchApplicantQualifications() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_qualifications'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<ApplicantQualification> applicantQualifications = await resultsJson
            .map<ApplicantQualification>((json) => ApplicantQualification.fromJson(json))
            .toList();
        return applicantQualifications;
    } else {
        throw Exception('Failed to load ApplicantQualification');
    }
}

Future<ApplicantQualification> fetchApplicantQualification(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_qualifications/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        ApplicantQualification applicantQualification = await resultsJson
            .map<ApplicantQualification>((json) => ApplicantQualification.fromJson(json));
        return applicantQualification;
    } else {
        throw Exception('Failed to load ApplicantQualification');
    }
}

Future<http.Response> createApplicantQualification(ApplicantQualification applicantQualification) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create ApplicantQualification.');
    }
}

Future<http.Response> updateApplicantQualification(ApplicantQualification applicantQualification) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update ApplicantQualification.');
    }
}

Future<http.Response> deleteApplicantQualification(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_qualifications/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete ApplicantQualification.');
    }
}