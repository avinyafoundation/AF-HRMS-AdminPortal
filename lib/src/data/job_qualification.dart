import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobQualification {
    int? id;
    int? job_id;
    int? qualification_category_id;
    int? sequence_no;
    String? description;
  
    JobQualification({
        this.id,
        this.job_id,
        this.qualification_category_id,
        this.sequence_no,
        this.description,
    });

    factory JobQualification.fromJson(Map<String, dynamic> json) {
        return JobQualification(
                id: json['id'],
                job_id: json['job_id'],
                qualification_category_id: json['qualification_category_id'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(job_id != null) 'job_id': job_id,
           if(qualification_category_id != null) 'qualification_category_id': qualification_category_id,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<JobQualification>> fetchJobQualifications() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_qualifications'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobQualification> jobQualifications = await resultsJson
            .map<JobQualification>((json) => JobQualification.fromJson(json))
            .toList();
        return jobQualifications;
    } else {
        throw Exception('Failed to load JobQualification');
    }
}

Future<JobQualification> fetchJobQualification(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_qualifications/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobQualification jobQualification = await resultsJson
            .map<JobQualification>((json) => JobQualification.fromJson(json));
        return jobQualification;
    } else {
        throw Exception('Failed to load JobQualification');
    }
}

Future<http.Response> createJobQualification(JobQualification jobQualification) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobQualification.');
    }
}

Future<http.Response> updateJobQualification(JobQualification jobQualification) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_qualifications'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobQualification.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobQualification.');
    }
}

Future<http.Response> deleteJobQualification(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_qualifications/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobQualification.');
    }
}