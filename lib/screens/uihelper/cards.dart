import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({super.key, this.text1, this.text2});

  final text1;

  final text2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              text1,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Text(
              ":",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class Cardwithpictxt extends StatelessWidget {
  const Cardwithpictxt({super.key, this.image, this.txt1});
  final image;
  final txt1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.2)
                ]),
            height: 100,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  image,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            txt1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
