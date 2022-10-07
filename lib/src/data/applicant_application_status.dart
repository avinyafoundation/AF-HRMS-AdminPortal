import 'package:ShoolManagementSystem/src/data/applicant.dart';
import 'package:ShoolManagementSystem/src/data/application_status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicantApplicationStatus {
  int? id;
  int? applicant_id;
  Applicant? applicant;
  int? application_status_id;
  ApplicationStatus? applicationStatus;
  String? start_date;
  String? end_date;
  String? last_updated;
  String? notes;

  ApplicantApplicationStatus({
    this.id,
    this.applicant_id,
    this.applicant,
    this.application_status_id,
    this.applicationStatus,
    this.start_date,
    this.end_date,
    this.last_updated,
    this.notes,
  });

  factory ApplicantApplicationStatus.fromJson(Map<String, dynamic> json) {
    return ApplicantApplicationStatus(
      id: json['id'],
      applicant_id: json['applicant_id'],
      application_status_id: json['application_status_id'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      last_updated: json['last_updated'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (applicant_id != null) 'applicant_id': applicant_id,
        if (application_status_id != null)
          'application_status_id': application_status_id,
        if (start_date != null) 'start_date': start_date,
        if (end_date != null) 'end_date': end_date,
        if (last_updated != null) 'last_updated': last_updated,
        if (notes != null) 'notes': notes,
      };
}

Future<List<ApplicantApplicationStatus>>
    fetchApplicantApplicationStatuss() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_application_statuss'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ApplicantApplicationStatus> applicantApplicationStatuss =
        await resultsJson
            .map<ApplicantApplicationStatus>(
                (json) => ApplicantApplicationStatus.fromJson(json))
            .toList();
    return applicantApplicationStatuss;
  } else {
    throw Exception('Failed to load ApplicantApplicationStatus');
  }
}

Future<ApplicantApplicationStatus> fetchApplicantApplicationStatus(
    String id) async {
  final response = await http.get(
    Uri.parse(
        AppConfig.hrmApiUrl + '/sms/hrm/applicant_application_statuss/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    ApplicantApplicationStatus applicantApplicationStatus =
        await resultsJson.map<ApplicantApplicationStatus>(
            (json) => ApplicantApplicationStatus.fromJson(json));
    return applicantApplicationStatus;
  } else {
    throw Exception('Failed to load ApplicantApplicationStatus');
  }
}

Future<http.Response> createApplicantApplicationStatus(
    ApplicantApplicationStatus applicantApplicationStatus) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_application_statuss'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(applicantApplicationStatus.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create ApplicantApplicationStatus.');
  }
}

Future<http.Response> updateApplicantApplicationStatus(
    ApplicantApplicationStatus applicantApplicationStatus) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicant_application_statuss'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(applicantApplicationStatus.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update ApplicantApplicationStatus.');
  }
}

Future<http.Response> deleteApplicantApplicationStatus(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(
        AppConfig.hrmApiUrl + '/sms/hrm/applicant_application_statuss/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete ApplicantApplicationStatus.');
  }
}
