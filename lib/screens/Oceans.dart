import 'dart:convert';
import 'package:continents_app/screens/uihelper/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Ocean extends StatefulWidget {
  const Ocean({Key? key}) : super(key: key);

  @override
  State<Ocean> createState() => _OceanState();
}

class _OceanState extends State<Ocean> {
  late List<dynamic> oceans = [];

  Future<void> readJson() async {
    try {
      final String res = await rootBundle.loadString("Json/ocean.json");
      final data = json.decode(res);
      setState(() {
        oceans = data["Oceans"];
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: oceans.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: oceans.length,
              itemBuilder: (context, index) {
                return OceanTile(
                  oceanData: oceans[index],
                );
              },
            ),
    );
  }
}

class OceanTile extends StatelessWidget {
  final Map<String, dynamic> oceanData;

  const OceanTile({Key? key, required this.oceanData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsOfOcean(oceandata: oceanData),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250,
          width: 490,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
              boxShadow: [
                const BoxShadow(
                  spreadRadius: 0.1,
                  blurRadius: 0.1,
                )
              ]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  width: 490,
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage(oceanData["image"].toString()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        oceanData["Ocean"].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsOfOcean extends StatelessWidget {
  final Map<String, dynamic>? oceandata;

  const DetailsOfOcean({Key? key, required this.oceandata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (oceandata == null ||
        oceandata!['Countries'] == null ||
        !(oceandata!['Countries'] is List<dynamic>)) {
      return const Scaffold(
        body: Center(
          child: Text('No country data available'),
        ),
      );
    }

    final List<dynamic> countries = oceandata!['Countries'];

    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              height: 430,
              width: 500,
              color: Colors.orange[100],
              child: Image.network(
                oceandata?["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    oceandata?["Ocean"],
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 594,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.orange[100],
                height: 600,
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      countries != null && countries is List<dynamic>
                          ? SizedBox(
                              height: 270,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const Text(
                                    "Countries:",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    width: 150,
                                    height: 100,
                                  ),
                                  Container(
                                    height: 350,
                                    width: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: countries.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          '- ${countries[index]}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text('No country data available')),
                      const SizedBox(
                        height: 10,
                      ),
                      Cards(
                        text1: "Deepest Point",
                        text2: oceandata?["Deepest Point"],
                      ),
                      Cards(
                        text1: "Salinity",
                        text2: oceandata?["Salinity"],
                      ),
                      Cards(
                        text1: "Surface Area",
                        text2: oceandata?["Surface Area"],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            Uri url = Uri.parse(oceandata?["url"] ?? '');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: const Text("URL"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
