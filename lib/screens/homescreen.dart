import 'dart:io';
import 'package:camera_app/db/functions/db_functions.dart';
import 'package:camera_app/db/model/db_model.dart';
import 'package:camera_app/screens/galleryscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? image1;
String? image;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CAMERA APP',style: TextStyle(fontWeight: FontWeight.w900 ),),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top:7),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){return GalleryScreen();})); 
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Card(
                              elevation: 10,
                              color: Colors.amber[200],                                                           
                                child:const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder,size: 110,color: Colors.blue,),
                                    Text('PHOTOS',style: TextStyle(fontWeight: FontWeight.w900 ),),
                                  ],
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 25,),
                        const Text('CAMERA',style: TextStyle(fontWeight: FontWeight.w900 ),),
                        ElevatedButton(
                          onPressed: (){
                            fromCamera();
                          }, 
                          child: const Icon(Icons.camera_alt,size: 75,)
                        ),
                      ],
                    )
                  ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fromCamera() async {
    final img1 = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img1 != null) {
      setState(() {
        image1 = File(img1.path);
        image = image1!.path;
      
      });
    }
    final _imagevalues= await  Imagemodel(image: image!);
    addImage(_imagevalues); 
  }
}
