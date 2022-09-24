import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class SkillCategory {
    int? id;
    String? name;
    String? description;
  
    SkillCategory({
        this.id,
        this.name,
        this.description,
    });

    factory SkillCategory.fromJson(Map<String, dynamic> json) {
        return SkillCategory(
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

Future<List<SkillCategory>> fetchSkillCategorys() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/skill_categorys'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<SkillCategory> skillCategorys = await resultsJson
            .map<SkillCategory>((json) => SkillCategory.fromJson(json))
            .toList();
        return skillCategorys;
    } else {
        throw Exception('Failed to load SkillCategory');
    }
}

Future<SkillCategory> fetchSkillCategory(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/skill_categorys/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        SkillCategory skillCategory = await resultsJson
            .map<SkillCategory>((json) => SkillCategory.fromJson(json));
        return skillCategory;
    } else {
        throw Exception('Failed to load SkillCategory');
    }
}

Future<http.Response> createSkillCategory(SkillCategory skillCategory) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/skill_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(skillCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create SkillCategory.');
    }
}

Future<http.Response> updateSkillCategory(SkillCategory skillCategory) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/skill_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(skillCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update SkillCategory.');
    }
}

Future<http.Response> deleteSkillCategory(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/skill_categorys/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete SkillCategory.');
    }
}