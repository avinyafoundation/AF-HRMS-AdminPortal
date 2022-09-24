import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobRoleResponsibility {
    int? id;
    int? job_id;
    int? role_responsibility_category_id;
    int? sequence_no;
    String? description;
  
    JobRoleResponsibility({
        this.id,
        this.job_id,
        this.role_responsibility_category_id,
        this.sequence_no,
        this.description,
    });

    factory JobRoleResponsibility.fromJson(Map<String, dynamic> json) {
        return JobRoleResponsibility(
                id: json['id'],
                job_id: json['job_id'],
                role_responsibility_category_id: json['role_responsibility_category_id'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(job_id != null) 'job_id': job_id,
           if(role_responsibility_category_id != null) 'role_responsibility_category_id': role_responsibility_category_id,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<JobRoleResponsibility>> fetchJobRoleResponsibilitys() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_role_responsibilitys'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobRoleResponsibility> jobRoleResponsibilitys = await resultsJson
            .map<JobRoleResponsibility>((json) => JobRoleResponsibility.fromJson(json))
            .toList();
        return jobRoleResponsibilitys;
    } else {
        throw Exception('Failed to load JobRoleResponsibility');
    }
}

Future<JobRoleResponsibility> fetchJobRoleResponsibility(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_role_responsibilitys/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobRoleResponsibility jobRoleResponsibility = await resultsJson
            .map<JobRoleResponsibility>((json) => JobRoleResponsibility.fromJson(json));
        return jobRoleResponsibility;
    } else {
        throw Exception('Failed to load JobRoleResponsibility');
    }
}

Future<http.Response> createJobRoleResponsibility(JobRoleResponsibility jobRoleResponsibility) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_role_responsibilitys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobRoleResponsibility.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobRoleResponsibility.');
    }
}

Future<http.Response> updateJobRoleResponsibility(JobRoleResponsibility jobRoleResponsibility) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_role_responsibilitys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobRoleResponsibility.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobRoleResponsibility.');
    }
}

Future<http.Response> deleteJobRoleResponsibility(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_role_responsibilitys/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobRoleResponsibility.');
    }
}