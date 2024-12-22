import 'package:flutter/material.dart';

import '../model/company.dart';
import '../services/company_service.dart';

class CreateCompany extends StatefulWidget {
  final Company? company;

  const CreateCompany({super.key, this.company});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    if (widget.company != null) {
      _nameController.text = widget.company!.companyName!;
      _addressController.text = widget.company!.companyAddress!;
      _phoneController.text = widget.company!.companyNumber!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.company == null? "Create Company" : "Update Company",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Please enter company name";
                      }
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        helperText: "Your name here",
                        hintText: "Enter the company name",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        labelText: "Address",
                        helperText: "Your address here",
                        hintText: "Enter the company address",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        labelText: "Phone number",
                        helperText: "Your company phone number here",
                        hintText: "Enter the company phone number",
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          Company newCompany = Company(
                            companyName: _nameController.text,
                            companyAddress: _addressController.text,
                            companyNumber: _phoneController.text,
                            companyLogo: "https://logo.clearbit.com/europa.eu");

                          if(widget.company != null){
                            await CompanyService().updateCompany(newCompany, widget.company!.id!);
                          }else{
                            await CompanyService().createCompany(newCompany);
                          }


                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Company added successfully")));

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.company == null? "Create Company" : "Update Company",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Radiusni o'zgartirish
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
