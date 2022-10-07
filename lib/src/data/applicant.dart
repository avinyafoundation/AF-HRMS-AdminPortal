import 'package:ShoolManagementSystem/src/data/applicant_application_status.dart';
import 'package:ShoolManagementSystem/src/data/positions_vacant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Applicant {
  int? id;
  String? positions_vacant_id;
  PositionsVacant? positionsVacant;
  String? first_name;
  String? last_name;
  String? name_with_initials;
  String? full_name;
  String? gender;
  String? applied_date;
  String? id_number;
  String? phone_number1;
  String? phone_number2;
  String? email;
  String? cv_location;
  String? last_updated;
  ApplicantApplicationStatus? applicantApplicationStatus;

  Applicant({
    this.id,
    this.positions_vacant_id,
    this.positionsVacant,
    this.first_name,
    this.last_name,
    this.name_with_initials,
    this.full_name,
    this.gender,
    this.applied_date,
    this.id_number,
    this.phone_number1,
    this.phone_number2,
    this.email,
    this.cv_location,
    this.last_updated,
    this.applicantApplicationStatus,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['id'],
      positions_vacant_id: json['positions_vacant_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      name_with_initials: json['name_with_initials'],
      full_name: json['full_name'],
      gender: json['gender'],
      applied_date: json['applied_date'],
      id_number: json['id_number'],
      phone_number1: json['phone_number1'],
      phone_number2: json['phone_number2'],
      email: json['email'],
      cv_location: json['cv_location'],
      last_updated: json['last_updated'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (positions_vacant_id != null)
          'positions_vacant_id': positions_vacant_id,
        if (first_name != null) 'first_name': first_name,
        if (last_name != null) 'last_name': last_name,
        if (name_with_initials != null)
          'name_with_initials': name_with_initials,
        if (full_name != null) 'full_name': full_name,
        if (gender != null) 'gender': gender,
        if (applied_date != null) 'applied_date': applied_date,
        if (id_number != null) 'id_number': id_number,
        if (phone_number1 != null) 'phone_number1': phone_number1,
        if (phone_number2 != null) 'phone_number2': phone_number2,
        if (email != null) 'email': email,
        if (cv_location != null) 'cv_location': cv_location,
        if (last_updated != null) 'last_updated': last_updated,
      };
}

Future<List<Applicant>> fetchApplicants() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Applicant> applicants = await resultsJson
        .map<Applicant>((json) => Applicant.fromJson(json))
        .toList();
    return applicants;
  } else {
    throw Exception('Failed to load Applicant');
  }
}

Future<Applicant> fetchApplicant(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicants/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Applicant applicant =
        await resultsJson.map<Applicant>((json) => Applicant.fromJson(json));
    return applicant;
  } else {
    throw Exception('Failed to load Applicant');
  }
}

Future<http.Response> createApplicant(Applicant applicant) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(applicant.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Applicant.');
  }
}

Future<http.Response> updateApplicant(Applicant applicant) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(applicant.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update Applicant.');
  }
}

Future<http.Response> deleteApplicant(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/applicants/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete Applicant.');
  }
}
