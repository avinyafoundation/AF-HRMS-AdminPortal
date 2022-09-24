import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmploymentStatus {
    int? id;
    String? name;
    int? sequence_no;
    String? description;
  
    EmploymentStatus({
        this.id,
        this.name,
        this.sequence_no,
        this.description,
    });

    factory EmploymentStatus.fromJson(Map<String, dynamic> json) {
        return EmploymentStatus(
                id: json['id'],
                name: json['name'],
                sequence_no: json['sequence_no'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(name != null) 'name': name,
           if(sequence_no != null) 'sequence_no': sequence_no,
           if(description != null) 'description': description,
    }; 
}

Future<List<EmploymentStatus>> fetchEmploymentStatuss() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_statuss'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmploymentStatus> employmentStatuss = await resultsJson
            .map<EmploymentStatus>((json) => EmploymentStatus.fromJson(json))
            .toList();
        return employmentStatuss;
    } else {
        throw Exception('Failed to load EmploymentStatus');
    }
}

Future<EmploymentStatus> fetchEmploymentStatus(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_statuss/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmploymentStatus employmentStatus = await resultsJson
            .map<EmploymentStatus>((json) => EmploymentStatus.fromJson(json));
        return employmentStatus;
    } else {
        throw Exception('Failed to load EmploymentStatus');
    }
}

Future<http.Response> createEmploymentStatus(EmploymentStatus employmentStatus) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employmentStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmploymentStatus.');
    }
}

Future<http.Response> updateEmploymentStatus(EmploymentStatus employmentStatus) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employmentStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmploymentStatus.');
    }
}

Future<http.Response> deleteEmploymentStatus(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_statuss/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmploymentStatus.');
    }
}