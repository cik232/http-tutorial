import 'package:flutter/material.dart';

import '../model/company.dart';
import '../services/company_service.dart';
import 'create_company.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Company",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100), // Radiusni sozlash
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateCompany(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: CompanyService().getAllCompany(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error receiving data from server"),
            );
          }

          if (snapshot.hasData) {
            var data = snapshot.data as List<Company>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          // Soyaning rangi va shaffofligi
                          spreadRadius: 5,
                          // Soyaning kengayish radiusi
                          blurRadius: 7,
                          // Soyaning xiralashish darajasi
                          offset: Offset(
                              0, 3), // Soyaning siljishi (gorizontal, vertikal)
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Material(
                              shape: CircleBorder(),
                              elevation: 4, // Soyaning balandligi
                              shadowColor: Colors.grey, // Soyaning rangi
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    data[index].companyLogo ??
                                        "https://logo.clearbit.com/google.ru"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  data[index].companyName ??
                                      "Company Name Unavailable",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  data[index].companyNumber ?? "No Number",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  data[index].companyAddress ?? "No Address",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateCompany(
                                            company: data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      size: 20,
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: (context),
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Are you sure want to deleted Company?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    await CompanyService()
                                                        .deleteCompany(
                                                            data[index].id!);

                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No")),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      size: 20,
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      await CompanyService()
                                          .updateCompanyPartially({
                                        'name': 'Azamjon',
                                        'address': 'Uzbekistan, Andijan, Qayirma 16',
                                        'phone': '93 694 96 66'
                                      }, data[index].id!);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      size: 20,
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
