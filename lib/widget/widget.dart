import 'package:flutter/material.dart';
import "package:cached_network_image/cached_network_image.dart";
import "package:wallpaperapp/model/photosdata.dart";
import "package:wallpaperapp/screen/image_view.dart";

Widget Wallpaper(List< photomodel> photos,BuildContext context ){
  return  Container(
     padding: EdgeInsets.symmetric(horizontal: 24),
     child: GridView.count(
        crossAxisCount: 2,
       mainAxisSpacing: 6.0,
       crossAxisSpacing: 6.0,
       childAspectRatio: 0.6,
       physics: ClampingScrollPhysics(), 
       shrinkWrap: true,
       children: photos.map((photomodel Photomodel){
          return GridTile(
             child:GestureDetector(
               onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Imageview(imageurl: Photomodel.src.potrait)));
               },
               child: Hero( tag: Photomodel.src.potrait, child: ClipRRect( borderRadius: BorderRadius.circular(16.0),child: CachedNetworkImage (imageUrl: Photomodel.src.potrait,fit: BoxFit.cover,))),
             ) ,
             
          );
       }).toList()





     ),
  );
}