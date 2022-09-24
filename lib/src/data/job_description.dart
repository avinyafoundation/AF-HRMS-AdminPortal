import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobDescription {
    int? id;
    int? job_id;
    int? sequence_no;
    String? description;
  
    JobDescription({
        this.id,
        this.job_id,
        this.sequence_no,
        this.description,
    });

    factory JobDescription.fromJson(Map<String, dynamic> json) {
        return JobDescription(
                id: json['id'],
                job_id: json['job_id'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(job_id != null) 'job_id': job_id,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<JobDescription>> fetchJobDescriptions() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_descriptions'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobDescription> jobDescriptions = await resultsJson
            .map<JobDescription>((json) => JobDescription.fromJson(json))
            .toList();
        return jobDescriptions;
    } else {
        throw Exception('Failed to load JobDescription');
    }
}

Future<JobDescription> fetchJobDescription(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_descriptions/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobDescription jobDescription = await resultsJson
            .map<JobDescription>((json) => JobDescription.fromJson(json));
        return jobDescription;
    } else {
        throw Exception('Failed to load JobDescription');
    }
}

Future<http.Response> createJobDescription(JobDescription jobDescription) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_descriptions'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobDescription.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobDescription.');
    }
}

Future<http.Response> updateJobDescription(JobDescription jobDescription) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_descriptions'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobDescription.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobDescription.');
    }
}

Future<http.Response> deleteJobDescription(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_descriptions/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobDescription.');
    }
}