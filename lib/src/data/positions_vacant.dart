import 'package:ShoolManagementSystem/src/data/job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class PositionsVacant {
  int? id;
  int? office_id;
  int? job_id;
  Job? job;
  int? amount;
  String? start_date;
  DateTime? dt_start_date;
  String? end_date;
  DateTime? dt_end_date;
  String? last_updated;
  String? notes;

  PositionsVacant({
    this.id,
    this.office_id,
    this.job_id,
    this.job,
    this.amount,
    this.start_date,
    this.dt_start_date,
    this.end_date,
    this.dt_end_date,
    this.last_updated,
    this.notes,
  });

  factory PositionsVacant.fromJson(Map<String, dynamic> json) {
    return PositionsVacant(
      id: json['id'],
      office_id: json['office_id'],
      job_id: json['job_id'],
      amount: json['amount'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      last_updated: json['last_updated'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (office_id != null) 'office_id': office_id,
        if (job_id != null) 'job_id': job_id,
        if (amount != null) 'amount': amount,
        if (start_date != null) 'start_date': start_date,
        if (end_date != null) 'end_date': end_date,
        if (last_updated != null) 'last_updated': last_updated,
        if (notes != null) 'notes': notes,
      };
}

Future<List<PositionsVacant>> fetchPositionsVacants() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/positions_vacants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<PositionsVacant> positionsVacants = await resultsJson
        .map<PositionsVacant>((json) => PositionsVacant.fromJson(json))
        .toList();
    return positionsVacants;
  } else {
    throw Exception('Failed to load PositionsVacant');
  }
}

Future<PositionsVacant> fetchPositionsVacant(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/positions_vacants/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    PositionsVacant positionsVacant = await resultsJson
        .map<PositionsVacant>((json) => PositionsVacant.fromJson(json));
    return positionsVacant;
  } else {
    throw Exception('Failed to load PositionsVacant');
  }
}

Future<http.Response> createPositionsVacant(
    PositionsVacant positionsVacant) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/positions_vacants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(positionsVacant.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create PositionsVacant.');
  }
}

Future<http.Response> updatePositionsVacant(
    PositionsVacant positionsVacant) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/positions_vacants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(positionsVacant.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update PositionsVacant.');
  }
}

Future<http.Response> deletePositionsVacant(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/positions_vacants/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete PositionsVacant.');
  }
}
