import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class LeaveType {
    int? id;
    int? employment_type_id;
    String? name;
    int? allocation;
    String? description;
  
    LeaveType({
        this.id,
        this.employment_type_id,
        this.name,
        this.allocation,
        this.description,
    });

    factory LeaveType.fromJson(Map<String, dynamic> json) {
        return LeaveType(
                id: json['id'],
                employment_type_id: json['employment_type_id'],
                name: json['name'],
                allocation: json['allocation'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employment_type_id != null) 'employment_type_id': employment_type_id,
           if(name != null) 'name': name,
           if(allocation != null) 'allocation': allocation,
           if(description != null) 'description': description,
    }; 
}

Future<List<LeaveType>> fetchLeaveTypes() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/leave_types'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<LeaveType> leaveTypes = await resultsJson
            .map<LeaveType>((json) => LeaveType.fromJson(json))
            .toList();
        return leaveTypes;
    } else {
        throw Exception('Failed to load LeaveType');
    }
}

Future<LeaveType> fetchLeaveType(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/leave_types/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        LeaveType leaveType = await resultsJson
            .map<LeaveType>((json) => LeaveType.fromJson(json));
        return leaveType;
    } else {
        throw Exception('Failed to load LeaveType');
    }
}

Future<http.Response> createLeaveType(LeaveType leaveType) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/leave_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(leaveType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create LeaveType.');
    }
}

Future<http.Response> updateLeaveType(LeaveType leaveType) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/leave_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(leaveType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update LeaveType.');
    }
}

Future<http.Response> deleteLeaveType(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/leave_types/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete LeaveType.');
    }
}