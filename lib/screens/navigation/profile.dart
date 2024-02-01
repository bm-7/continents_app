import 'package:continents_app/screens/navigation/Bottomnav.dart';
import 'package:continents_app/screens/picker/imagepicker.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(Icons.close, size: 26),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigation(),
                    ));
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyImagePicker(),
                  )),
              child: const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                    // child: Image.network(
                    //   imageUrl,
                    //   fit: BoxFit.cover,
                    //   width: 200,
                    //   height: 200,
                    // ),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
