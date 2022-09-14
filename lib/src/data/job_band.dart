import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobBand {
  int? id;
  String? name;
  String? description;
  int? level;
  double? min_salary;
  double? max_salary;

  JobBand({
    this.id,
    this.name,
    this.description,
    this.level,
    this.min_salary,
    this.max_salary,
  });

  factory JobBand.fromJson(Map<String, dynamic> json) {
    return JobBand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      level: json['level'],
      min_salary: json['min_salary'],
      max_salary: json['max_salary'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (level != null) 'level': level,
        if (min_salary != null) 'min_salary': min_salary,
        if (max_salary != null) 'max_salary': max_salary,
      };
}

Future<List<JobBand>> fetchJobBands() async {
  final response = await http.get(
    Uri.parse(
      AppConfig.hrmApiUrl + '/sms/hrm/job_bands',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<JobBand> jobBands = await resultsJson
        .map<JobBand>((json) => JobBand.fromJson(json))
        .toList();
    return jobBands;
  } else {
    throw Exception('Failed to load JobBand');
  }
}

Future<JobBand> fetchJobBand(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_bands/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    JobBand jobBand =
        await resultsJson.map<JobBand>((json) => JobBand.fromJson(json));
    return jobBand;
  } else {
    throw Exception('Failed to load JobBand');
  }
}

Future<http.Response> createJobBand(JobBand jobBand) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_bands'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(jobBand.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create JobBand.');
  }
}

Future<http.Response> updateJobBand(JobBand jobBand) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_bands'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(jobBand.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update JobBand.');
  }
}

Future<http.Response> deleteJobBand(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_bands/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete JobBand.');
  }
}
