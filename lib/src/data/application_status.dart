import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class ApplicationStatus {
    int? id;
    String? name;
    int? sequence_no;
    String? description;
  
    ApplicationStatus({
        this.id,
        this.name,
        this.sequence_no,
        this.description,
    });

    factory ApplicationStatus.fromJson(Map<String, dynamic> json) {
        return ApplicationStatus(
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

Future<List<ApplicationStatus>> fetchApplicationStatuss() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/application_statuss'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<ApplicationStatus> applicationStatuss = await resultsJson
            .map<ApplicationStatus>((json) => ApplicationStatus.fromJson(json))
            .toList();
        return applicationStatuss;
    } else {
        throw Exception('Failed to load ApplicationStatus');
    }
}

Future<ApplicationStatus> fetchApplicationStatus(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/application_statuss/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        ApplicationStatus applicationStatus = await resultsJson
            .map<ApplicationStatus>((json) => ApplicationStatus.fromJson(json));
        return applicationStatus;
    } else {
        throw Exception('Failed to load ApplicationStatus');
    }
}

Future<http.Response> createApplicationStatus(ApplicationStatus applicationStatus) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/application_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicationStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create ApplicationStatus.');
    }
}

Future<http.Response> updateApplicationStatus(ApplicationStatus applicationStatus) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/application_statuss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(applicationStatus.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update ApplicationStatus.');
    }
}

Future<http.Response> deleteApplicationStatus(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/application_statuss/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete ApplicationStatus.');
    }
}