import 'dart:typed_data';

import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';


class Imageview extends StatefulWidget {
  final String imageurl;
  const Imageview({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<Imageview> createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Stack(
           children: [
             Hero(
               tag:widget.imageurl,
               child: Container(
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 child: CachedNetworkImage(
                    imageUrl: widget.imageurl,
                   fit: BoxFit.cover,
                 ),
               ),
             ),
             Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               alignment: Alignment.bottomCenter,
               child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   GestureDetector(
                     onTap:(){
                       save();


                    },
                     child: Container(
                       height: 50,
                       width: MediaQuery.of(context).size.width/2,
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.white24),
                         borderRadius: BorderRadius.circular(40),
                         color: Color(0xff1c1b1b).withOpacity(0.5),

                       ),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                            Text("Download", style: GoogleFonts.fuzzyBubbles(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500),),
                           SizedBox(height: 1,), 
                           Text("Image will be save to gallery", style: GoogleFonts.fuzzyBubbles(fontSize: 8, color: Colors.white70),)
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 16,),
                   GestureDetector(
                     onTap:(){
                        Navigator.of(context).pop();
                     },
                     child: Text("Cancel", style: GoogleFonts.fuzzyBubbles(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),),
                   ),
                   SizedBox(height: 24,),

                 ],
               ),
             )
           ],
         )
    );
  }
  askpermission () async{
    PermissionStatus result = await  Permission.storage.request();




  }
  save() async{
    askpermission();
    var response = await Dio().get(widget.imageurl, options: Options(responseType: ResponseType.bytes));
    final saver = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(saver);
    Navigator.pop(context);
  }
}
