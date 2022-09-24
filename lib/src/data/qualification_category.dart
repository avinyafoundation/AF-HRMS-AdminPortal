import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class QualificationCategory {
    int? id;
    String? name;
    String? description;
  
    QualificationCategory({
        this.id,
        this.name,
        this.description,
    });

    factory QualificationCategory.fromJson(Map<String, dynamic> json) {
        return QualificationCategory(
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

Future<List<QualificationCategory>> fetchQualificationCategorys() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/qualification_categorys'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<QualificationCategory> qualificationCategorys = await resultsJson
            .map<QualificationCategory>((json) => QualificationCategory.fromJson(json))
            .toList();
        return qualificationCategorys;
    } else {
        throw Exception('Failed to load QualificationCategory');
    }
}

Future<QualificationCategory> fetchQualificationCategory(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/qualification_categorys/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        QualificationCategory qualificationCategory = await resultsJson
            .map<QualificationCategory>((json) => QualificationCategory.fromJson(json));
        return qualificationCategory;
    } else {
        throw Exception('Failed to load QualificationCategory');
    }
}

Future<http.Response> createQualificationCategory(QualificationCategory qualificationCategory) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/qualification_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(qualificationCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create QualificationCategory.');
    }
}

Future<http.Response> updateQualificationCategory(QualificationCategory qualificationCategory) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/qualification_categorys'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(qualificationCategory.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update QualificationCategory.');
    }
}

Future<http.Response> deleteQualificationCategory(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/qualification_categorys/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete QualificationCategory.');
    }
}