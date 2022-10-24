import 'dart:convert';
import "package:cached_network_image/cached_network_image.dart";

import 'dart:io';
import 'package:wallpaperapp/screen/category.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:wallpaperapp/data/data.dart";
import "package:wallpaperapp/model/categorymodel.dart";
import "package:wallpaperapp/model/photosdata.dart";
import "package:http/http.dart" as http;
import 'package:wallpaperapp/screen/search.dart';
import "secret.dart";
import "package:wallpaperapp/widget/widget.dart";
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  List<Categorymodel> categories = [];
  List< photomodel> photos = [];
 int no = 40;
 bool loading = false;

getimages() async{
  setState(() {
     loading = true;
  });
  try{
    Uri uri = Uri.parse("https://api.pexels.com/v1/curated?per_page=$no&page=1");
    var response = await http.get(uri, headers: {HttpHeaders.authorizationHeader: api_key});
    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata[ "photos"].forEach((element){
      print(element);
      photomodel Photomodel =photomodel.fromMap(element);

      photos.add(Photomodel);
      print(photos);

    });
} on Exception catch (e) {

    showDialog(
       context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error !", style: GoogleFonts.fuzzyBubbles(),),
        content: Text("Something Went wrong Please Check your internet Connection and Referesh", style: GoogleFonts.fuzzyBubbles(),),
        actions: [
          TextButton(
            onPressed: (){
              getimages();
              Navigator.of(ctx).pop();
            },
            child: Container(

              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text("Refresh", style: GoogleFonts.fuzzyBubbles( color: Colors.white70)),
            ),
          )
        ],
      )
    );


  // TODO
}
setState(() {
  loading = false;
});





  
}
  @override
  void initState() {
    // TODO: implement initState
    getimages();
    super.initState();
    categories = getcategory(); 

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wallpaper ", style: GoogleFonts.fuzzyBubbles(color: Colors.black87)),
            Text("Hub", style: GoogleFonts.fuzzyBubbles(color: Colors.blue)),


          ],

        ),
        elevation: 0.0,
      ),
      body: loading? Container(
         child: Center(
            child: CircularProgressIndicator(color: Colors.orange),
         ),
      ): SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),

                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: search,
                        style: GoogleFonts.fuzzyBubbles(),
                        decoration: InputDecoration(
                          hintText: "Search Wallpaper",
                          hintStyle: GoogleFonts.fuzzyBubbles(),
                          border: InputBorder.none,
                        ),
                      ),

                    ),
                    GestureDetector(
                      child: Icon(Icons.search), 
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute( builder: (context) => Search(search: search.text,)));
                      },
                    )

                  ],
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                     "Made By ",
                    style: GoogleFonts.fuzzyBubbles(fontSize: 12, color: Colors.black),

                  ),
                  Container(
                    child: Text(
                       "Rishik Kashyap",
                      style: GoogleFonts.fuzzyBubbles(fontSize: 12, color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16,),
              Container(
                height: 80,

                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return categorycard(
                      image: categories[index].Image,
                      name: categories[index].Name,

                    );
                  },

                ),
              ),
              SizedBox(height: 16,),
              Wallpaper(photos, context),
              SizedBox(height: 16,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Photos provided by  ",
                    style: GoogleFonts.fuzzyBubbles(color: Colors.black54, fontSize: 12),
                  ),
                  Container(
                    child: Text(
                       "Pexels.com" ,
                      style: GoogleFonts.fuzzyBubbles(fontSize: 12, color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16,)
            ],

          ),
        ),
      )
    );
  }
}
class categorycard extends StatelessWidget {
  final String name, image;
  const categorycard({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => category(Category: name.toLowerCase())));
      },
      child:Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(imageUrl:image,  height: 50, width: 100, fit: BoxFit.cover,),

            ),
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),

              ),

              child: Text(name, style: GoogleFonts.fuzzyBubbles(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
            )
          ],
        ),
      ) ,
    );
  }

}


