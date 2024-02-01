import 'package:continents_app/screens/uihelper/cards.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Asian extends StatefulWidget {
  final List<dynamic> countries;
  final continentData;

  const Asian({
    Key? key,
    required this.countries,
    this.continentData,
  }) : super(key: key);

  @override
  State<Asian> createState() => _AsianState();
}

class _AsianState extends State<Asian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.continentData['coname'],
          style: TextStyle(fontSize: 28, color: Colors.white60),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.countries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.1),
        itemBuilder: (BuildContext context, int index) {
          var country = widget.countries[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Con(
                        continentData: widget.continentData,
                        selectedCountry: country,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 185,
                      width: 300,
                      color: const Color.fromARGB(255, 109, 106, 101),
                      child: Image.network(
                        country['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 26,
                      color: const Color.fromARGB(255, 167, 161, 142),
                      child: Center(
                          child: Text(
                        country['Country'],
                        style: const TextStyle(fontSize: 24),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Con extends StatefulWidget {
  const Con({
    Key? key,
    required this.selectedCountry,
    required this.continentData,
  }) : super(key: key);

  final dynamic selectedCountry;
  final Map<String, dynamic> continentData;

  @override
  State<Con> createState() => _ConState();
}

class _ConState extends State<Con> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            child: Container(
              height: 430,
              width: 500,
              color: Colors.amber,
              child: Image.network(
                widget.selectedCountry['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  widget.selectedCountry['Country'],
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 550,
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Cards(
                    text1: "Prime Minister",
                    text2: widget.selectedCountry["Prime Minister"],
                  ),
                  const SizedBox(height: 10),
                  Cards(
                    text1: "States",
                    text2: widget.selectedCountry["States"].toString(),
                  ),
                  const SizedBox(height: 10),
                  Cards(
                    text1: "Population",
                    text2: widget.selectedCountry["Population"],
                  ),
                  const SizedBox(height: 10),
                  Cards(
                    text1: "Area",
                    text2: widget.selectedCountry["Area"],
                  ),
                  const SizedBox(height: 10),
                  Cards(
                    text1: "Sports",
                    text2: widget.selectedCountry["Sports"],
                  ),
                  Cardwithpictxt(
                    image: widget.selectedCountry["Flower"],
                    txt1: widget.selectedCountry["National Flower"],
                  ),
                  Cardwithpictxt(
                    image: widget.selectedCountry["Animal"],
                    txt1: widget.selectedCountry["National Animal"],
                  ),
                  Cardwithpictxt(
                    image: widget.selectedCountry["Bird"],
                    txt1: widget.selectedCountry["National Bird"],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Uri _url = Uri.parse(widget.selectedCountry["url"]);
                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch ${_url}');
                        }
                      },
                      child: const Text("URL"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
