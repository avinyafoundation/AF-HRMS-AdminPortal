import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class EmployeeAddress {
    int? employee_id;
    int? address_id;
  
    EmployeeAddress({
        this.employee_id,
        this.address_id,
    });

    factory EmployeeAddress.fromJson(Map<String, dynamic> json) {
        return EmployeeAddress(
                employee_id: json['employee_id'],
                address_id: json['address_id'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(employee_id != null) 'employee_id': employee_id,
            if(address_id != null) 'address_id': address_id,
    }; 
}

Future<List<EmployeeAddress>> fetchEmployeeAddresss() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_addresss'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<EmployeeAddress> employeeAddresss = await resultsJson
            .map<EmployeeAddress>((json) => EmployeeAddress.fromJson(json))
            .toList();
        return employeeAddresss;
    } else {
        throw Exception('Failed to load EmployeeAddress');
    }
}

Future<EmployeeAddress> fetchEmployeeAddress(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_addresss/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        EmployeeAddress employeeAddress = await resultsJson
            .map<EmployeeAddress>((json) => EmployeeAddress.fromJson(json));
        return employeeAddress;
    } else {
        throw Exception('Failed to load EmployeeAddress');
    }
}

Future<http.Response> createEmployeeAddress(EmployeeAddress employeeAddress) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_addresss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeAddress.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create EmployeeAddress.');
    }
}

Future<http.Response> updateEmployeeAddress(EmployeeAddress employeeAddress) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_addresss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(employeeAddress.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update EmployeeAddress.');
    }
}

Future<http.Response> deleteEmployeeAddress(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/employee_addresss/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete EmployeeAddress.');
    }
}