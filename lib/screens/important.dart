import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/futures/tasks/tasks.dart';

class Important extends StatefulWidget {
  const Important({super.key});

  @override
  State<Important> createState() => _ImportantState();
}

class _ImportantState extends State<Important> {
@override
  void initState() {
    super.initState();
    getemail(); 
    
  }

String? email;
  Future getemail() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        email = prefs.getString('email');
      });
      
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Important'),
      ),
      body: FutureBuilder(
        future: importanttasks(email ?? 'email' ), 
        builder:(context, snapshot) {
          try{
              if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
          }
          
          else if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          else {
            var data = snapshot.data;
            if (data == null){
              return const Text('No tasks found');
            }
            
            else if(snapshot.hasData){
              try{
                return ListView.builder(
                itemCount: data['body'].length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 3.0,
                      child: ListTile(
                        title: Text(data['body'][index]['task_name'], style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic), ),
                        subtitle: Text(data['body'][index]['task_description']),
                      ),
                    ),
                  );
                  
                });
              }
              catch(e){
                return Text('Error: ${e.toString()}');
              }
              
            }
            else{
              return const Text('Nothing was found');
            }
          }
          }
          catch(e){
            return Text('Error: ${e.toString()}');
          }
          

        }
        
        ),



    );
  }
}