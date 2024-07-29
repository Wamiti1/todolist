import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/futures/tasks/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/screens/components/alertdialog.dart';


class Alltasks extends StatefulWidget {
  const Alltasks({super.key});

  @override
  State<Alltasks> createState() => _AlltasksState();
}




class _AlltasksState extends State<Alltasks> {
 




  var taskname = TextEditingController();
  var taskdescription = TextEditingController();
  var formKey = GlobalKey<FormState>();
 



  @override
  void initState() {
    super.initState();
    getemail();
    gettasks(email?? '');
    
    
  
  }





String? email;
Future getemail() async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email')?? 'Guest';
  setState(() {
    email = email;
  });

  }
  catch(error){
    return Text('Error getting email: ${error.toString()}');
  }
  
  
}








  





  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
      title: const Text('All'),
      ),
      body: StreamBuilder(
        stream: gettasks(email ?? 'email'), 
        builder: (context, snapshot){
          try{
            if(snapshot.hasData ){
              if(snapshot.connectionState == ConnectionState.active){
                 return const Text('Wait a little bit') ;
              }
            else{
             
            var data = snapshot.data;
            
            if(data == null){
              return const Text('No tasks found');
            }
            else{
              try{
                return ListView.builder(
                itemCount: data['body'].length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 3,
                    child: data == "No tasks found for this user. Create new tasks." ?  const Text("No tasks found for this user. Create new tasks.")
                       
                     : Dismissible(
                      key: ValueKey(data['body'][index]['task_id']),
                       onDismissed: (DismissDirection direction){
                        if(direction == DismissDirection.startToEnd){
                          if(data['body'][index]['urgent'] == 'Yes'){
                            var urgent1 = 'No';
                            updatetasks(urgent1,data['body'][index]['task_id']).then((v){
                              if(v == 'Task not found and thus not updated.'){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                              }
                            });
                          }
                          else{
                            var urgent2 = 'Yes';
                             
                            updatetasks( urgent2, data['body'][index]['task_id']).then((v){
                              if(v == 'Task not found and thus not updated.'){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                              }
                            });
                          }
                        }
                        else{
                          () =>  null;
                        }
                       },
                       child: ListTile(
                        key: const ValueKey(123),
                        leading: Icon(data['body'][index]['urgent'] == 'Yes' ? Icons.star : Icons.star_outline),
                        title: Text(data['body'][index]['task_name'] ),
                         subtitle:  Text(data['body'][index]['task_description']),
                        trailing: IconButton(
                          onPressed: (){
                            deletetask(data['body'][index]['task_id']);
                            
                       
                          },
                          icon: const Icon(Icons.delete),),
                                           ),
                     ),
                  );
                });
       
                  

              }
              catch(error){
                return Text('Error: ${error.toString()}');
              }
              
            }
            }

          }
          else if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          else if(snapshot.connectionState ==  ConnectionState.waiting){
              return const CircularProgressIndicator();
          }
          else{
            return const Text('No tasks found');
          }
          }
          catch(e){
            return Text('Error: ${e.toString()}');
          }



        }),


        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          
          onPressed:  (){
            showCupertinoModalPopup(context: context, builder: (context) => const Alert());
          },
      
      
      
    ));
  }
}