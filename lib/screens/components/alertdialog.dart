import 'dart:convert';
import 'dart:ui';
import '../alltasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/futures/tasks/tasks.dart';




class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  var formKey = GlobalKey<FormState>();
  var taskname = TextEditingController();
  var taskdescription = TextEditingController();
  String? urgent;
  DateTime datetime = DateTime.now();
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


  String? email;
  @override
  void initState() {
    
    super.initState();
    getemail();
    Alltasks;

  }




  void _showDatePicker(){
    showDatePicker(
    initialDate: DateTime.now(),
    context: context, 
    firstDate: DateTime(1900), 
    lastDate: DateTime(2025) 
    ).then((value){
      setState((){
        datetime = value!;
      });
    });
  }
  @override

  Widget build(BuildContext context) {
    
    return  BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          scrollable: true,

          
          content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                        const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child:  Text('Add a New Task'),
                        ),
        
        
                     Padding(
                  
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                        controller: taskname,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: 'Task Name',
                        ),
                        validator: (value){
                              if(value!.isEmpty){
                                  return 'Task name cannot be empty';
                              }
                              else{
                                return null;
                              }
                        },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                        controller: taskdescription,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Task Description',
                        ),
                         validator: (value){
                              if(value!.isEmpty){
                                  return 'Task name cannot be empty';
                              }
                              else{
                                return null;
                              }
                        },
                       ),
                     ),
                     const Padding(
                       padding:  EdgeInsets.all(8.0),
                       child:  Text('Select urgency'),
                     ),
                     Row(
                      children: [
                        Radio(
                          value: 'Yes', 
                          groupValue: urgent, 
                          onChanged: (value){
                            
                            
                            setState(() {
                              urgent = (value!).toString();
                            });
                          }),
                          const Text('Yes'),
          
                          Radio(
                          value: 'No', 
                          groupValue: urgent, 
                          onChanged: (value){
                            setState(() {
                              urgent = (value!).toString();
                            });
                          }),
                          const Text('No'),
                        
          
                      ],),
          
                      Card(
                        elevation: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                             
                            _showDatePicker();
                            
                                          
                          },
                          child:  const Text('Pick your due date'),),
                        ),
                      ),
                      
                      
                      Text(DateFormat().format(datetime).substring(0,13))
          
          
                     
          
          
                    ],
                  ),
                ),
              ),
        
              actions: [IconButton(onPressed: (){
                var isValid = formKey.currentState!.validate();
                if(isValid){
                  postTask(email ?? 'email', taskname.text, taskdescription.text, urgent ?? 'No', datetime.toString()).then((v){
                    if(v == "Task has been added successfully."){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(v.toString()))));
                      
                      
                      
                      Navigator.pop(context);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                     
                      Navigator.pop(context);
                    }
                  });
                }
              }, icon: const Icon(Icons.upload, color: Colors.redAccent,))],
        ),
      ),
    );
  }
}