import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Branch {
  int? id;
  int? organization_id;
  String? name;
  String? description;
  String? phone_number1;
  String? phone_number2;

  Branch({
    this.id,
    this.organization_id,
    this.name,
    this.description,
    this.phone_number1,
    this.phone_number2,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      organization_id: json['organization_id'],
      name: json['name'],
      description: json['description'],
      phone_number1: json['phone_number1'],
      phone_number2: json['phone_number2'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (organization_id != null) 'organization_id': organization_id,
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (phone_number1 != null) 'phone_number1': phone_number1,
        if (phone_number2 != null) 'phone_number2': phone_number2,
      };
}

Future<List<Branch>> fetchBranchs() async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/branches'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Branch> branches =
        await resultsJson.map<Branch>((json) => Branch.fromJson(json)).toList();
    return branches;
  } else {
    throw Exception('Failed to load Branch');
  }
}

Future<Branch> fetchBranch(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/branches/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Branch branch =
        await resultsJson.map<Branch>((json) => Branch.fromJson(json));
    return branch;
  } else {
    throw Exception('Failed to load Branch');
  }
}

Future<http.Response> createBranch(Branch branch) async {
  final response = await http.post(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/branches'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(branch.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Branch.');
  }
}

Future<http.Response> updateBranch(Branch branch) async {
  final response = await http.put(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/branches'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
    body: jsonEncode(branch.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update Branch.');
  }
}

Future<http.Response> deleteBranch(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/branches/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.hrmApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete Branch.');
  }
}
