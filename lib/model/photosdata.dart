class  photomodel{
  final String url;
  final String photographerId;
  srcmodel src;

  photomodel({required this.url,  required this.photographerId, required this.src});
  factory photomodel.fromMap(Map<String, dynamic> jsonparsed){
     return photomodel(url: jsonparsed["url"], photographerId: jsonparsed["photographer"], src: srcmodel.fromMap(jsonparsed["src"]));
  }
}

class srcmodel{
 final String potrait;

  srcmodel({required this.potrait});
  factory srcmodel.fromMap(Map<String, dynamic> srcparsed){
     return srcmodel(potrait: srcparsed["portrait"]);
  }
}