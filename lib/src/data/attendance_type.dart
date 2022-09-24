import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class AttendanceType {
    int? id;
    int? employment_type_id;
    String? name;
    String? description;
  
    AttendanceType({
        this.id,
        this.employment_type_id,
        this.name,
        this.description,
    });

    factory AttendanceType.fromJson(Map<String, dynamic> json) {
        return AttendanceType(
                id: json['id'],
                employment_type_id: json['employment_type_id'],
                name: json['name'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(employment_type_id != null) 'employment_type_id': employment_type_id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
    }; 
}

Future<List<AttendanceType>> fetchAttendanceTypes() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/attendance_types'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<AttendanceType> attendanceTypes = await resultsJson
            .map<AttendanceType>((json) => AttendanceType.fromJson(json))
            .toList();
        return attendanceTypes;
    } else {
        throw Exception('Failed to load AttendanceType');
    }
}

Future<AttendanceType> fetchAttendanceType(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/attendance_types/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        AttendanceType attendanceType = await resultsJson
            .map<AttendanceType>((json) => AttendanceType.fromJson(json));
        return attendanceType;
    } else {
        throw Exception('Failed to load AttendanceType');
    }
}

Future<http.Response> createAttendanceType(AttendanceType attendanceType) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/attendance_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(attendanceType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create AttendanceType.');
    }
}

Future<http.Response> updateAttendanceType(AttendanceType attendanceType) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/attendance_types'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(attendanceType.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update AttendanceType.');
    }
}

Future<http.Response> deleteAttendanceType(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/attendance_types/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete AttendanceType.');
    }
}