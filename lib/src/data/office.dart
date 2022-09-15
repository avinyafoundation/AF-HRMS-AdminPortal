import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Office {
    int? id;
    int? branch_id;
    String? name;
    String? description;
    String? phone_number1;
    String? phone_number2;
  
    Office({
        this.id,
        this.branch_id,
        this.name,
        this.description,
        this.phone_number1,
        this.phone_number2,
    });

    factory Office.fromJson(Map<String, dynamic> json) {
        return Office(
                id: json['id'],
                branch_id: json['branch_id'],
                name: json['name'],
                description: json['description'],
                phone_number1: json['phone_number1'],
                phone_number2: json['phone_number2'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(branch_id != null) 'branch_id': branch_id,
           if(name != null) 'name': name,
           if(description != null) 'description': description,
           if(phone_number1 != null) 'phone_number1': phone_number1,
           if(phone_number2 != null) 'phone_number2': phone_number2,
    }; 
}

Future<List<Office>> fetchOffices() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/offices'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Office> offices = await resultsJson
            .map<Office>((json) => Office.fromJson(json))
            .toList();
        return offices;
    } else {
        throw Exception('Failed to load Office');
    }
}

Future<Office> fetchOffice(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/offices/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        Office office = await resultsJson
            .map<Office>((json) => Office.fromJson(json));
        return office;
    } else {
        throw Exception('Failed to load Office');
    }
}

Future<http.Response> createOffice(Office office) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/offices'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(office.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create Office.');
    }
}

Future<http.Response> updateOffice(Office office) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/offices'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(office.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update Office.');
    }
}

Future<http.Response> deleteOffice(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/offices/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete Office.');
    }
}