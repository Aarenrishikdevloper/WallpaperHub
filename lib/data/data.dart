import "package:wallpaperapp/model/categorymodel.dart";
List<Categorymodel> getcategory(){
  List<Categorymodel> categories = [];
  Categorymodel categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.pexels.com/photos/1154198/pexels-photo-1154198.jpeg?auto=compress&cs=tinysrgb&w=600" ;
  categorymodel.Name = "Street Art";
  categories.add(categorymodel);
   categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.pexels.com/photos/803844/pexels-photo-803844.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" ;
  categorymodel.Name = "Wild Life";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2l0eXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60" ;
  categorymodel.Name = "City";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJhbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60" ;
  categorymodel.Name = "Nature";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.pexels.com/photos/2531608/pexels-photo-2531608.jpeg?auto=compress&cs=tinysrgb&w=600" ;
  categorymodel.Name = "Abstract";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.pexels.com/photos/3935702/pexels-photo-3935702.jpeg?auto=compress&cs=tinysrgb&w=600" ;
  categorymodel.Name = "Travel";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();
  categorymodel.Image = "https://images.pexels.com/photos/1566909/pexels-photo-1566909.jpeg?auto=compress&cs=tinysrgb&w=600" ;
  categorymodel.Name = "Colorful";
  categories.add(categorymodel);
  categorymodel = new Categorymodel();







  return categories;
}
