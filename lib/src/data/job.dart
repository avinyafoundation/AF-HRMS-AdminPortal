import 'package:ShoolManagementSystem/src/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Job {
  int? id;
  String? name;
  String? description;
  int? team_id;
  Team? team;
  int? job_band_id;
  JobBand? jobBand;
  int? hc_plan;
  List<Employee>? employees = [];
  List<PositionsVacant>? positionsVacant = [];

  Job(
      {this.id,
      this.name,
      this.description,
      this.team_id,
      this.team,
      this.job_band_id,
      this.jobBand,
      this.hc_plan,
      List<Employee>? employees,
      List<PositionsVacant>? positionsVacant})
      : this.employees = employees ?? [],
        this.positionsVacant = positionsVacant ?? [];

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      team_id: json['team_id'],
      job_band_id: json['job_band_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (team_id != null) 'team_id': team_id,
        if (job_band_id != null) 'job_band_id': job_band_id,
      };
}

Future<List<Job>> fetchJobs() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/jobs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Job> jobs =
        await resultsJson.map<Job>((json) => Job.fromJson(json)).toList();
    return jobs;
  } else {
    throw Exception('Failed to load Job');
  }
}

Future<Job> fetchJob(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/jobs/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Job job = await resultsJson.map<Job>((json) => Job.fromJson(json));
    return job;
  } else {
    throw Exception('Failed to load Job');
  }
}

Future<http.Response> createJob(Job job) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/jobs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(job.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Job.');
  }
}

Future<http.Response> updateJob(Job job) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/jobs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(job.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update Job.');
  }
}

Future<http.Response> deleteJob(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/jobs/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete Job.');
  }
}
