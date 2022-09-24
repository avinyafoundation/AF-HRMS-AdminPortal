import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class RoleResponsibilityCategory {
    int? id;
    String? name;
    String? description;
  
    RoleResponsibilityCategory({
        this.id,
        this.name,
        this.description,
    });

    factory RoleResponsibilityCategory.fromJson(Map<String, dynamic> json) {
        return RoleResponsibilityCategory(
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

Future<List<RoleResponsibilityCategory>> fetchRoleResponsibilityCategorys() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/role_responsibility_categorys'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<RoleResponsibilityCategory> roleResponsibilityCategorys = await resultsJson
            .map<RoleResponsibilityCategory>((json) => RoleResponsibilityCategory.fromJson(json))
            .toList();
        return roleResponsibilityCategorys;
    } else {
        throw Exception('Failed to load RoleResponsibilityCategory');
    }
}

Future<RoleResponsibilityCategory> fetchRoleResponsibilityCategory(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/role_responsibility_categorys/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        RoleResponsibilityCategory roleResponsibilityCategory = await resultsJson
            .map<RoleResponsibilityCategory>((json) => RoleResponsibilityCategory.fromJson(json));
        return roleResponsibilityCategory;
    } else {
        throw Exception('Failed to load RoleResponsibilityCategory');
    }
}

Future<http.Response> createRoleResponsibilityCategory(RoleResponsibilityCategory roleResponsibilityCategory) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/role_responsibility_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(roleResponsibilityCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create RoleResponsibilityCategory.');
    }
}

Future<http.Response> updateRoleResponsibilityCategory(RoleResponsibilityCategory roleResponsibilityCategory) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/role_responsibility_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(roleResponsibilityCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update RoleResponsibilityCategory.');
    }
}

Future<http.Response> deleteRoleResponsibilityCategory(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/role_responsibility_categorys/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete RoleResponsibilityCategory.');
    }
}