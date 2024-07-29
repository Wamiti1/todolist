import 'package:flutter/material.dart';
import 'package:todolist/auth/authentication.dart';
import 'package:todolist/screens/alltasks.dart';
import 'package:todolist/screens/important.dart';
import '../customwidgets/homelayout.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
String? username;
Future fetchusername()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    username = prefs.getString('username')!;
  });
  
  
}

String gettime(){
  var currenttime = DateTime.now().hour;

  if(currenttime >= 6 && currenttime < 12){
    return 'Good morning';
  }
  else if(currenttime >= 12 && currenttime < 16 ){
    return 'Good afternoon';
  }
  else if(currenttime >= 16 && currenttime < 21){
    return 'Good evening';
  }
  else{
    return 'Good night';
  }
}






 String? email;
Future fetchemail()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    email =  prefs.getString('email')!;
  });
  
} 
@override
  void initState() {
    super.initState();
    fetchemail();
    fetchusername();
    
  }
  
Future eraseuser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
  prefs.remove('username');
}

  var scrollKey = ScrollController();
 
  
  List home = ['All tasks', 'Important', 'Completed'];
  late List <IconButton> widgets = [
    IconButton(
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> const Alltasks()));},
      icon: const Icon(Icons.looks_sharp, color: Colors.tealAccent,)), 
      IconButton(onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> const Important()));
      },icon: const Icon(Icons.star_border_outlined, color: Colors.pink,)), 
      IconButton(onPressed:(){},icon: const Icon(Icons.check_box_rounded, color: Colors.amber,))];
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading :  FutureBuilder(
          
          future: fetchusername(),
          builder: (context, snapshot) {
            
            var data = snapshot.data;
            
            return data == null ? const CircleAvatar(
              radius: 3.0,
               backgroundColor: Colors.blueAccent,
              child: Text('', style:  TextStyle(color: Colors.white),),
             
              ) : CircleAvatar(
              radius: 3.0,
               backgroundColor: Colors.blueAccent,
              child: Text(data.toString(), style: const TextStyle(color: Colors.white),),
             
              ) ;
          }
        ),
          title:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(gettime()),
              Text(email ?? '', style: const TextStyle(fontSize: 12),)
            ],),
        actions: [
          IconButton(
            onPressed: () {
              eraseuser();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Authentication()));

            },
            icon: const Icon(Icons.person),
          )
        ],


          
      ),
      body:  Column(
            children: [
              row(widgets[0], Text(home[0]) ),
              row(widgets[1], Text(home[1]) ),
              row(widgets[2], Text(home[2]) )

            ],
          )

      
    );
  }
}

