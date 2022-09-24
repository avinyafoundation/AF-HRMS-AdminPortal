import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Address {
    int? id;
    String? line1;
    String? line2;
    String? line3;
    int? city_id;
    int? address_type_id;
    String? notes;
  
    Address({
        this.id,
        this.line1,
        this.line2,
        this.line3,
        this.city_id,
        this.address_type_id,
        this.notes,
    });

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
                id: json['id'],
                line1: json['line1'],
                line2: json['line2'],
                line3: json['line3'],
                city_id: json['city_id'],
                address_type_id: json['address_type_id'],
                notes: json['notes'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(line1 != null) 'line1': line1,
           if(line2 != null) 'line2': line2,
           if(line3 != null) 'line3': line3,
           if(city_id != null) 'city_id': city_id,
           if(address_type_id != null) 'address_type_id': address_type_id,
           if(notes != null) 'notes': notes,
    }; 
}

Future<List<Address>> fetchAddresss() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/util/addresss'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Address> addresss = await resultsJson
            .map<Address>((json) => Address.fromJson(json))
            .toList();
        return addresss;
    } else {
        throw Exception('Failed to load Address');
    }
}

Future<Address> fetchAddress(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/util/addresss/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        Address address = await resultsJson
            .map<Address>((json) => Address.fromJson(json));
        return address;
    } else {
        throw Exception('Failed to load Address');
    }
}

Future<http.Response> createAddress(Address address) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/util/addresss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(address.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create Address.');
    }
}

Future<http.Response> updateAddress(Address address) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/util/addresss'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(address.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update Address.');
    }
}

Future<http.Response> deleteAddress(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/util/addresss/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete Address.');
    }
}