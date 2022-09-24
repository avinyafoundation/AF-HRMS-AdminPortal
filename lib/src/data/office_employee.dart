import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class OfficeEmployee {
    int? id;
    int? office_id;
    int? job_id;
    int? employee_id;
    String? start_date;
    String? end_date;
    String? last_updated;
    String? title;
    String? notes;
  
    OfficeEmployee({
        this.id,
        this.office_id,
        this.job_id,
        this.employee_id,
        this.start_date,
        this.end_date,
        this.last_updated,
        this.title,
        this.notes,
    });

    factory OfficeEmployee.fromJson(Map<String, dynamic> json) {
        return OfficeEmployee(
                id: json['id'],
                office_id: json['office_id'],
                job_id: json['job_id'],
                employee_id: json['employee_id'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
                title: json['title'],
                notes: json['notes'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(office_id != null) 'office_id': office_id,
           if(job_id != null) 'job_id': job_id,
           if(employee_id != null) 'employee_id': employee_id,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
           if(title != null) 'title': title,
           if(notes != null) 'notes': notes,
    }; 
}

Future<List<OfficeEmployee>> fetchOfficeEmployees() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/office_employees'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<OfficeEmployee> officeEmployees = await resultsJson
            .map<OfficeEmployee>((json) => OfficeEmployee.fromJson(json))
            .toList();
        return officeEmployees;
    } else {
        throw Exception('Failed to load OfficeEmployee');
    }
}

Future<OfficeEmployee> fetchOfficeEmployee(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/office_employees/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        OfficeEmployee officeEmployee = await resultsJson
            .map<OfficeEmployee>((json) => OfficeEmployee.fromJson(json));
        return officeEmployee;
    } else {
        throw Exception('Failed to load OfficeEmployee');
    }
}

Future<http.Response> createOfficeEmployee(OfficeEmployee officeEmployee) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/office_employees'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(officeEmployee.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create OfficeEmployee.');
    }
}

Future<http.Response> updateOfficeEmployee(OfficeEmployee officeEmployee) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/office_employees'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(officeEmployee.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update OfficeEmployee.');
    }
}

Future<http.Response> deleteOfficeEmployee(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/office_employees/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete OfficeEmployee.');
    }
}