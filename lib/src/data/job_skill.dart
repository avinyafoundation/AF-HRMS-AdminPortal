import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobSkill {
    int? id;
    int? job_id;
    int? skill_category_id;
    int? sequence_no;
    String? description;
  
    JobSkill({
        this.id,
        this.job_id,
        this.skill_category_id,
        this.sequence_no,
        this.description,
    });

    factory JobSkill.fromJson(Map<String, dynamic> json) {
        return JobSkill(
                id: json['id'],
                job_id: json['job_id'],
                skill_category_id: json['skill_category_id'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(job_id != null) 'job_id': job_id,
           if(skill_category_id != null) 'skill_category_id': skill_category_id,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<JobSkill>> fetchJobSkills() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_skills'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobSkill> jobSkills = await resultsJson
            .map<JobSkill>((json) => JobSkill.fromJson(json))
            .toList();
        return jobSkills;
    } else {
        throw Exception('Failed to load JobSkill');
    }
}

Future<JobSkill> fetchJobSkill(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_skills/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobSkill jobSkill = await resultsJson
            .map<JobSkill>((json) => JobSkill.fromJson(json));
        return jobSkill;
    } else {
        throw Exception('Failed to load JobSkill');
    }
}

Future<http.Response> createJobSkill(JobSkill jobSkill) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobSkill.');
    }
}

Future<http.Response> updateJobSkill(JobSkill jobSkill) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_skills'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobSkill.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobSkill.');
    }
}

Future<http.Response> deleteJobSkill(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_skills/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobSkill.');
    }
}