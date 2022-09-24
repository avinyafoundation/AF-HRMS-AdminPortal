import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmploymentType {
    int? id;
    String? name;
    String? description;
  
    EmploymentType({
        this.id,
        this.name,
        this.description,
    });

    factory EmploymentType.fromJson(Map<String, dynamic> json) {
        return EmploymentType(
                id: json['id'],
                name: json['name'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
    }; 
}

Future<List<EmploymentType>> fetchEmploymentTypes() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_types'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmploymentType> employmentTypes = await resultsJson
            .map<EmploymentType>((json) => EmploymentType.fromJson(json))
            .toList();
        return employmentTypes;
    } else {
        throw Exception('Failed to load EmploymentType');
    }
}

Future<EmploymentType> fetchEmploymentType(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_types/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmploymentType employmentType = await resultsJson
            .map<EmploymentType>((json) => EmploymentType.fromJson(json));
        return employmentType;
    } else {
        throw Exception('Failed to load EmploymentType');
    }
}

Future<http.Response> createEmploymentType(EmploymentType employmentType) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employmentType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmploymentType.');
    }
}

Future<http.Response> updateEmploymentType(EmploymentType employmentType) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employmentType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmploymentType.');
    }
}

Future<http.Response> deleteEmploymentType(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employment_types/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmploymentType.');
    }
}