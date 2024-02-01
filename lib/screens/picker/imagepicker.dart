import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({Key? key}) : super(key: key);

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final ImagePicker _picker = ImagePicker();

  File? doc;
  String docUrl = "";
  File? imageFile;
  String imageUrl = "";
  Future getImageCamera() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.camera).then((xFile) async {
      if (xFile != null) {
        print(
            "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${xFile.path}");
        imageFile = File(xFile.path);
        var ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child("${imageFile}.jpg");

        var uploadTask = await ref.putFile(imageFile!);
        imageUrl = await uploadTask.ref.getDownloadURL();
        print(
            "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$imageUrl");
        setState(() {});
      }
    });
  }

  String aadhar = "";
  File? imageAadhar;

  Future pickAadharImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return; // User canceled picking image
      final imageTemp = File(pickedFile.path);
      print("Picked Image: ${imageTemp.path}");
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("AdminAadharImage/$fileName");
      await imageRef.putFile(imageTemp);
      final imageUrl = await imageRef.getDownloadURL();
      print("Download URL: $imageUrl");
      setState(() {
        imageAadhar = imageTemp;
        aadhar = imageUrl;
      });
    } catch (e) {
      print('Error picking/uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Set Your Profile Picture",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
      )),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            if (imageUrl.isEmpty)
              const CircularProgressIndicator()
            else
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            FilledButton(
              onPressed: getImageCamera,
              child: const Text("Open Camera"),
            ),
            const SizedBox(
              height: 50,
            ),
            if (imageUrl.isEmpty)
              const CircularProgressIndicator()
            else
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.network(
                    aadhar,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            FilledButton(
              onPressed: pickAadharImage,
              child: const Text("Open Gallary"),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:path/path.dart';

// class FirebaseUpload extends StatefulWidget {
//   const FirebaseUpload({Key? key}) : super(key: key);

//   @override
//   State<FirebaseUpload> createState() => _FirebaseUploadState();
// }

// class _FirebaseUploadState extends State<FirebaseUpload> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase Upload"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FilledButton(
//                 onPressed: getImageCamera, child: Text("Camera Image Upload")),
//             imageUrl.isEmpty
//                 ? SizedBox()
//                 : Image.network(
//                     imageUrl,
//                     height: 100,
//                     width: 100,
//                   ),
//             FilledButton(
//                 onPressed: pickAadharImage, child: Text("Galary Image Upload")),
//             aadhar.isEmpty
//                 ? SizedBox()
//                 : Image.network(
//                     aadhar,
//                     height: 100,
//                     width: 100,
//                   ),
//             // FilledButton(
//             //     onPressed: () async {
//             //       FilePickerResult? result =
//             //       await FilePicker.platform.pickFiles();
//             //       if (result != null) {
//             //         PlatformFile file = result.files.first;
//             //         doc = File(file.path!);
//             //         print(file.name);
//             //         print(file.bytes);
//             //         print(file.size);
//             //         print(file.extension);
//             //         print(file.path);
//             //         var ref = FirebaseStorage.instance
//             //             .ref()
//             //             .child('images')
//             //             .child("document/${file.name}");
//             //
//             //         var uploadTask = await ref.putFile(doc!);
//             //         docUrl = await uploadTask.ref.getDownloadURL();
//             //         print(docUrl);
//             //       } else {
//             //         // User canceled the picker
//             //       }
//             //     },
//             //     child: Text("Doc Uplad")),
//             // FilledButton(
//             //     onPressed: () {
//             //       Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //               builder: (builder) => PdfViews(url: docUrl)));
//             //     },
//             //     child: Text("PdfView")),
//           ],
//         ),
//       ),
//     );
//   }

//   File? doc;
//   String docUrl = "";
//   File? imageFile;
//   String imageUrl = "";
//   Future getImageCamera() async {
//     ImagePicker _picker = ImagePicker();
//     await _picker.pickImage(source: ImageSource.camera).then((xFile) async {
//       if (xFile != null) {
//         print(
//             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${xFile.path}");
//         imageFile = File(xFile.path);
//         var ref = FirebaseStorage.instance
//             .ref()
//             .child('images')
//             .child("${imageFile}.jpg");
//         // .child("${xFile.name}.jpg");

//         var uploadTask = await ref.putFile(imageFile!);
//         imageUrl = await uploadTask.ref.getDownloadURL();
//         print(imageUrl);
//         setState(() {});
//       }
//     });
//   }

//   String aadharFilePath = "";
//   File? imageAadhar;
//   String aadhar = "";
//   Future pickAadharImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       final imageTemp = File(image.path);
//       print(
//           "imageTemp ======================================================================? ${imageTemp}");
//       aadharFilePath = basename(imageTemp.path);
//       print(
//           "aadharFilePath ================================================================? ${aadharFilePath}");
//       setState(() => this.imageAadhar = imageTemp);
//       // Create a storage reference from our app
//       final storageRef = FirebaseStorage.instance.ref();
//       // Create a reference to "mountains.jpg"
//       final mountainImagesRef =
//           storageRef.child("AdminAadharImage/$aadharFilePath");
//       await mountainImagesRef.putFile(imageTemp);
//       String aadharurl = await mountainImagesRef.getDownloadURL();
//       print(aadharurl);
//       setState(() {
//         aadhar = aadharurl;
//       });
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
// }
