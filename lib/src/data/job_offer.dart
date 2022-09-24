import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class JobOffer {
    int? id;
    int? applicant_id;
    String? offer_status;
    int? approved_by;
    String? start_date;
    String? end_date;
    String? last_updated;
    double? salary;
    String? description;
    String? notes;
  
    JobOffer({
        this.id,
        this.applicant_id,
        this.offer_status,
        this.approved_by,
        this.start_date,
        this.end_date,
        this.last_updated,
        this.salary,
        this.description,
        this.notes,
    });

    factory JobOffer.fromJson(Map<String, dynamic> json) {
        return JobOffer(
                id: json['id'],
                applicant_id: json['applicant_id'],
                offer_status: json['offer_status'],
                approved_by: json['approved_by'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
                salary: json['salary'],
                description: json['description'],
                notes: json['notes'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(applicant_id != null) 'applicant_id': applicant_id,
           if(offer_status != null) 'offer_status': offer_status,
           if(approved_by != null) 'approved_by': approved_by,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
           if(salary != null) 'salary': salary,
           if(description != null) 'description': description,
           if(notes != null) 'notes': notes,
    }; 
}

Future<List<JobOffer>> fetchJobOffers() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_offers'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<JobOffer> jobOffers = await resultsJson
            .map<JobOffer>((json) => JobOffer.fromJson(json))
            .toList();
        return jobOffers;
    } else {
        throw Exception('Failed to load JobOffer');
    }
}

Future<JobOffer> fetchJobOffer(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_offers/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        JobOffer jobOffer = await resultsJson
            .map<JobOffer>((json) => JobOffer.fromJson(json));
        return jobOffer;
    } else {
        throw Exception('Failed to load JobOffer');
    }
}

Future<http.Response> createJobOffer(JobOffer jobOffer) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_offers'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobOffer.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create JobOffer.');
    }
}

Future<http.Response> updateJobOffer(JobOffer jobOffer) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_offers'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(jobOffer.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update JobOffer.');
    }
}

Future<http.Response> deleteJobOffer(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/job_offers/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete JobOffer.');
    }
}