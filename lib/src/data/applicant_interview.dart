import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicantInterview {
    int? id;
    int? applicant_id;
    int? interviewer_id;
    String? date_time;
    String? description;
    String? current_status;
    String? outcome;
    int? rating;
    String? comments;
    String? notes;
    String? last_updated;
  
    ApplicantInterview({
        this.id,
        this.applicant_id,
        this.interviewer_id,
        this.date_time,
        this.description,
        this.current_status,
        this.outcome,
        this.rating,
        this.comments,
        this.notes,
        this.last_updated,
    });

    factory ApplicantInterview.fromJson(Map<String, dynamic> json) {
        return ApplicantInterview(
                id: json['id'],
                applicant_id: json['applicant_id'],
                interviewer_id: json['interviewer_id'],
                date_time: json['date_time'],
                description: json['description'],
                current_status: json['current_status'],
                outcome: json['outcome'],
                rating: json['rating'],
                comments: json['comments'],
                notes: json['notes'],
                last_updated: json['last_updated'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(applicant_id != null) 'applicant_id': applicant_id,
           if(interviewer_id != null) 'interviewer_id': interviewer_id,
           if(date_time != null) 'date_time': date_time,
           if(description != null) 'description': description,
           if(current_status != null) 'current_status': current_status,
           if(outcome != null) 'outcome': outcome,
           if(rating != null) 'rating': rating,
           if(comments != null) 'comments': comments,
           if(notes != null) 'notes': notes,
           if(last_updated != null) 'last_updated': last_updated,
    }; 
}

Future<List<ApplicantInterview>> fetchApplicantInterviews() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_interviews'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<ApplicantInterview> applicantInterviews = await resultsJson
            .map<ApplicantInterview>((json) => ApplicantInterview.fromJson(json))
            .toList();
        return applicantInterviews;
    } else {
        throw Exception('Failed to load ApplicantInterview');
    }
}

Future<ApplicantInterview> fetchApplicantInterview(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_interviews/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        ApplicantInterview applicantInterview = await resultsJson
            .map<ApplicantInterview>((json) => ApplicantInterview.fromJson(json));
        return applicantInterview;
    } else {
        throw Exception('Failed to load ApplicantInterview');
    }
}

Future<http.Response> createApplicantInterview(ApplicantInterview applicantInterview) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_interviews'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantInterview.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create ApplicantInterview.');
    }
}

Future<http.Response> updateApplicantInterview(ApplicantInterview applicantInterview) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_interviews'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicantInterview.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update ApplicantInterview.');
    }
}

Future<http.Response> deleteApplicantInterview(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_interviews/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete ApplicantInterview.');
    }
}