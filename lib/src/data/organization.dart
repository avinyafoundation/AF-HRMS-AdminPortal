import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Organization {
    int? id;
    String? name;
    String? description;
    String? phone_number1;
    String? phone_number2;
  
    Organization({
        this.id,
        this.name,
        this.description,
        this.phone_number1,
        this.phone_number2,
    });

    factory Organization.fromJson(Map<String, dynamic> json) {
        return Organization(
                id: json['id'],
                name: json['name'],
                description: json['description'],
                phone_number1: json['phone_number1'],
                phone_number2: json['phone_number2'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
           if(phone_number1 != null) 'phone_number1': phone_number1,
           if(phone_number2 != null) 'phone_number2': phone_number2,
    }; 
}

Future<List<Organization>> fetchOrganizations() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/organizations'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Organization> organizations = await resultsJson
            .map<Organization>((json) => Organization.fromJson(json))
            .toList();
        return organizations;
    } else {
        throw Exception('Failed to load Organization');
    }
}

Future<Organization> fetchOrganization(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/organizations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        Organization organization = await resultsJson
            .map<Organization>((json) => Organization.fromJson(json));
        return organization;
    } else {
        throw Exception('Failed to load Organization');
    }
}

Future<http.Response> createOrganization(Organization organization) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/organizations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(organization.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create Organization.');
    }
}

Future<http.Response> updateOrganization(Organization organization) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/organizations'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(organization.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update Organization.');
    }
}

Future<http.Response> deleteOrganization(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/organizations/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete Organization.');
    }
}