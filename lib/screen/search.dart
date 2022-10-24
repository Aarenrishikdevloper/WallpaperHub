import 'dart:io';
import 'dart:convert';

import "package:flutter/material.dart" ;
import "package:wallpaperapp/model/photosdata.dart";
import "package:http/http.dart" as http;
import "package:wallpaperapp/secret.dart";
import "package:wallpaperapp/widget/widget.dart";
import "package:google_fonts/google_fonts.dart";
class Search extends StatefulWidget {
     final String search;

  const Search({super.key, required this.search});




  @override
  State<Search> createState() => _SearchState();

}

class _SearchState extends State<Search> {
 bool loading = false;
  List< photomodel> photos = [];
  TextEditingController controll= TextEditingController();


  int no = 40;
  getsearch(String query)async {
    setState(() {
      loading = true;
    });
    try{
      Uri uri = Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=$no&page=1");
      var response = await http.get(
          uri, headers: {HttpHeaders.authorizationHeader: api_key});
      Map<String, dynamic> jsondata = jsonDecode(response.body);
      jsondata[ "photos"].forEach((element) {
        print(element);
        photomodel Photomodel = photomodel.fromMap(element);

        photos.add(Photomodel);
        print(photos);

      });
    }  catch(e){
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Error !", style: GoogleFonts.fuzzyBubbles(),),
            content: Text("Something Went wrong Please Check your internet Connection and Referesh", style: GoogleFonts.fuzzyBubbles(),),
            actions: [
              TextButton(
                onPressed: (){
                  getsearch(widget.search);
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

    }
    setState(() {
      loading = false;
    });


  }


  @override
  void initState() {






    // TODO: implement initState
    super.initState();
    getsearch(widget.search);
    controll.text = widget.search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wallpaper ", style: GoogleFonts.fuzzyBubbles(color: Colors.black87)),
            Text("Hub", style: GoogleFonts.fuzzyBubbles(color: Colors.blue)),


          ],

        ),
        actions: [
          Opacity(opacity: 0,

          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.abc),
          )
        ],
        leading: IconButton(

          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        elevation: 0.0,


      ),
      body:loading ?Container(
        child: Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      ):SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30),

              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
         child:Row(
        children: [
          Expanded(
            child: TextField(
              controller: controll,
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
              String query =widget.search;
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Search(search: controll.text) ));


            },
          )

        ],
       ),
      ),
            SizedBox(height: 30,),
            Wallpaper(photos, context),
            SizedBox(height: 16,),
            SizedBox(height: 16,),

          ],
        ),
      ),

    );


  }
}

