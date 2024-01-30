import 'package:continents_app/screens/LoginScreens/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoncontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 550,
              width: 500,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(350, 250),
                  bottomRight: Radius.elliptical(350, 250),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "L O G I N ",
                  style: TextStyle(color: Colors.grey, fontSize: 48),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: TextField(
                controller: phoncontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      height: 413,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      height: 413,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber,
                      ),
                      height: 50,
                      width: 300,
                      child: GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            verificationCompleted:
                                (PhoneAuthCredential Cred) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verifyid, int? resendopt) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    verificationId: verifyid,
                                  ),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                            phoneNumber: phoncontroller.text.toString(),
                          );
                        },
                        child: const Text(
                          textAlign: TextAlign.center,
                          "SignIn ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
