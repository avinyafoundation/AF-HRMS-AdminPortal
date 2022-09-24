import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class TeamLead {
    int? id;
    int? team_id;
    int? employee_id;
    int? lead_order;
    String? title;
    String? start_date;
    String? end_date;
    String? last_updated;
    String? description;
  
    TeamLead({
        this.id,
        this.team_id,
        this.employee_id,
        this.lead_order,
        this.title,
        this.start_date,
        this.end_date,
        this.last_updated,
        this.description,
    });

    factory TeamLead.fromJson(Map<String, dynamic> json) {
        return TeamLead(
                id: json['id'],
                team_id: json['team_id'],
                employee_id: json['employee_id'],
                lead_order: json['lead_order'],
                title: json['title'],
                start_date: json['start_date'],
                end_date: json['end_date'],
                last_updated: json['last_updated'],
                description: json['description'],
        );
    }

    Map<String, dynamic> toJson() =>
    {
            if(id != null) 'id': id,
           if(team_id != null) 'team_id': team_id,
           if(employee_id != null) 'employee_id': employee_id,
           if(lead_order != null) 'lead_order': lead_order,
           if(title != null) 'title': title,
           if(start_date != null) 'start_date': start_date,
           if(end_date != null) 'end_date': end_date,
           if(last_updated != null) 'last_updated': last_updated,
           if(description != null) 'description': description,
    }; 
}

Future<List<TeamLead>> fetchTeamLeads() async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/team_leads'),
        headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        List<TeamLead> teamLeads = await resultsJson
            .map<TeamLead>((json) => TeamLead.fromJson(json))
            .toList();
        return teamLeads;
    } else {
        throw Exception('Failed to load TeamLead');
    }
}

Future<TeamLead> fetchTeamLead(String id) async {
    final response =
        await http.get(Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/team_leads/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'API-Key': AppConfig.hrmApiKey,
        },);

    if (response.statusCode == 200) {
        var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
        TeamLead teamLead = await resultsJson
            .map<TeamLead>((json) => TeamLead.fromJson(json));
        return teamLead;
    } else {
        throw Exception('Failed to load TeamLead');
    }
}

Future<http.Response> createTeamLead(TeamLead teamLead) async {
    final response = await http.post(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/team_leads'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(teamLead.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to create TeamLead.');
    }
}

Future<http.Response> updateTeamLead(TeamLead teamLead) async {
    final response = await http.put(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/team_leads'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
        body: jsonEncode(teamLead.toJson()),
        );
    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to update TeamLead.');
    }
}

Future<http.Response> deleteTeamLead(String id) async {
    final http.Response response = await http.delete(
        Uri.parse(AppConfig.hrmApiUrl + '/sms/hrm/team_leads/$id'),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'API-Key': AppConfig.hrmApiKey,
        },
    );

    if (response.statusCode == 200) {
        return response;
    } else {
        throw Exception('Failed to delete TeamLead.');
    }
}