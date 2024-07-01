import 'package:buss/Database%20Repo/Crud.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:flutter/material.dart';

class BusCompanies extends StatefulWidget {
  const BusCompanies({super.key});

  @override
  State<BusCompanies> createState() => _BusCompaniesState();
}

class _BusCompaniesState extends State<BusCompanies> {
  Crud crud = Crud();

  Future<List<dynamic>> getCompanies() async {
    await Future.delayed(const Duration(seconds: 2));
    var response = await crud.getRequest(linkCompaniesName);
    if (response['status'] == "success") {
      return response['data'] as List<dynamic>;
    } else {
      throw Exception('API call failed'); // Or a more specific exception type
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Associated Companies'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 20,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final companyName = snapshot.data?[index]['name'];
                final companyLogo = snapshot.data?[index]
                    ['logo_url']; // Use null-conditional operator

                if (companyName != null) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(companyName),
                        leading: Image.network("$linkImageRoot/$companyLogo"),
                        subtitle: Text(
                          snapshot.data?[index]['contact_info'],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                      'No name available'); // Handle missing data (optional)
                }
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
          return const Center(
            child: Text('loading for now'),
          );
        },
      ),
    );
  }
}
