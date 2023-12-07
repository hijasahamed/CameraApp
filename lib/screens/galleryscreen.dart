import 'dart:io';
import 'package:camera_app/db/functions/db_functions.dart';
import 'package:camera_app/db/model/db_model.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getImage(); 
    return Scaffold(
      appBar: AppBar(
        title: Text('PHOTOS',style: TextStyle(fontWeight: FontWeight.w900),),        
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: imageNotifier, 
          builder: (BuildContext ctx,List<Imagemodel>imageList,Widget?child){
            return Padding(
              padding:  EdgeInsets.only(top: 2,bottom: 2,left: 2 ),
              child: GridView.builder( 
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (ctx,index){
                  final data=imageList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right:2),
                    child: InkWell(
                      highlightColor:Colors.white70,
                      splashColor: Colors.transparent,
                      onLongPress: () {
                        onLongPressImage(context,data.id);     
                      },
                      onTap: () {
                        onTapPhoto(context,data,index); 
                      },  
                      child: Ink.image(image: FileImage(File(data.image)),fit: BoxFit.cover,),
                    ),
                  );
                },
                itemCount: imageList.length,
              ),
            );
          }
        ),
      ),
    );
  }


  onLongPressImage(context,id){
    showDialog(
      context: context, 
      builder: (ctx){
        return AlertDialog(
          content: Text('Do You Want To Delete Photo'),
          actions: [
            TextButton(
              onPressed: (){
                deletePhoto(id);
                 Navigator.of(context).pop();
                 onYesButtonClick(ctx);
              }, 
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('No'),
            ),
          ],
        );
      }
    );
  } 

  onYesButtonClick(ctx){
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text('Photo Deleted'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black,
      )
    );
  }


  onTapPhoto(context,data,int index){
    showGeneralDialog(
      context: context, 
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      pageBuilder: (BuildContext context ,Animation first,Animation second){
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.arrow_back,color: Colors.white,),
          ), 
            title: Text('image ${index+1}',style: TextStyle(color: Colors.white),),
          ),
          body: Center(  
            child: Container(
              height: 500 ,
              width: double.infinity,
              child: Image(image: FileImage(File(data.image)),fit: BoxFit.cover,)             
            ),
          ),
        ); 
      },
    );
  }


}
