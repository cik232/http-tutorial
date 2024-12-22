import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/company.dart';

class CompanyService {
  String baseUrl = "https://retoolapi.dev/nW9QyT/";

  getAllCompany() async {
    try {
      List<Company> allCompanies = [];
      var response = await http.get(Uri.parse(baseUrl + 'company'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        print(jsonData);

        for (var company in jsonData) {
          Company newCompany = Company.fromJson(company);
          allCompanies.add(newCompany);
        }
        return allCompanies;
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured ${e}");
    }
  }

  createCompany(Company company) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + "company"),
          body: company.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "The company is suceesfully reated with the following details: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured ${e}");
    }
  }

  updateCompanyPartially(Map<String, dynamic> updatedData, int id) async{
  try {
  var response = await http.patch(Uri.parse(baseUrl + "company" + '/$id'), body: updatedData);

  log("the response status code os ${response.statusCode}");

  if (response.statusCode == 200 || response.statusCode == 201) {
  print(
  "The company is suceesfully deleted with the following details: ${response.body}");
  } else {
  throw Exception(
  "Error occured with status code ${response.statusCode} and the message is ${response.body}");
  }
  } catch (e) {
  print("Error occured ${e}");
  }
  }

  updateCompany(Company company, int id) async {
    try {
      var response = await http.put(Uri.parse(baseUrl + "company" + '/$id'), body: company.toJson());

      log("the response status code os ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "The company is suceesfully deleted with the following details: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured ${e}");
    }
  }

  deleteCompany(int id) async {
    try {
      var response = await http.delete(Uri.parse(baseUrl + "company" + '/$id'));

      if (response.statusCode == 200 || response.statusCode == 204) {
        print(
            "The company is suceesfully deleted with the following details: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured ${e}");
    }
  }
}
