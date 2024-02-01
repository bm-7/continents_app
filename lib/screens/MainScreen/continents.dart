import 'dart:convert';

import 'package:continents_app/screens/countries/asia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Continents extends StatefulWidget {
  const Continents({Key? key}) : super(key: key);

  @override
  State<Continents> createState() => _ContinentsState();
}

class _ContinentsState extends State<Continents> {
  late List<dynamic> contss = [];

  Future<void> readJson() async {
    final String res = await rootBundle.loadString("Json/ex.json");
    final data = await json.decode(res);
    ;
    setState(() {
      contss = data["continents"];
      print("print data :$contss");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    print("Contents: $contss");
    return Scaffold(
        backgroundColor: Colors.white,
        body: contss != null && contss.isNotEmpty
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: contss.length,
                itemBuilder: (context, index) {
                  if (contss[index] != null) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 300,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 170,
                                    maxWidth: 450,
                                    minHeight: 170,
                                    minWidth: 340),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(contss[index]["link"]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      contss[index]["coname"],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Asian(
                                            countries: contss[index]
                                                ["Countries"],
                                            continentData: {
                                              'coname': contss[index]["coname"],
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
