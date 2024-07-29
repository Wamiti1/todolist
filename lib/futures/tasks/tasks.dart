import 'dart:convert';
import 'package:http/http.dart' as http;


//Future for posting a task
Future postTask(
  String emailaddress, 
  String taskname, 
  String taskdescription,
  String urgent,
  var doneBy
  ) async{
 try{
  var url = Uri.parse("http://192.168.100.147:5000/tasks");
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({
    'email_address': emailaddress,
    'task_name': taskname,
    'task_description': taskdescription,
    'urgent': urgent,
    'doneBy': doneBy
  });

  http.Response response = await http.post(url,headers: headers,body: body);
  if(response.statusCode == 200 ){
   return response.body; 
  }
  else{
    return response.body; 
  }
 }
 catch(e){
  return e.toString();
 }


}

//Deleting tasks
Future deletetask(int taskid) async{
 
 try{
  var url = Uri.parse("http://192.168.100.147:5000/tasks");
  var headers = {
    "Content-type":"application/json"
  };
  var body = jsonEncode({
    'task_id': taskid
  });
  http.Response response = await http.delete(url, headers: headers, body: body);

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }
  else{
    throw Exception('Failed to delete task: ${response.statusCode} - ${response.body}');
  }

 } 
 catch(e){
  throw Exception('Failed to delete task : ${e.toString()}');
 }
}

//Fetching tasks
Stream gettasks(
  String emailaddress,
) async*{
  try{
    var url = Uri.parse("http://192.168.100.147:5000/tasks/all");
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email_address': emailaddress});
    var response = await http.post(url, headers: headers, body: body);
    if(response.statusCode == 200){
      yield jsonDecode(response.body);
    }
    else{
      yield jsonDecode(response.body);
    }

  }
  catch(e){
    throw Exception('Failed to fetch tasks: ${e.toString()}');
  }
}

Future importanttasks(String email) async{
  try{
    var url = Uri.parse("http://192.168.100.147:5000/tasks/important");
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email_address': email});
    var response = await http.post(url, headers: headers, body: body);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      return jsonDecode(response.body);
    }
  }

  catch(e){
    throw Exception('Failed to fetch important tasks: ${e.toString()}');
  }

}

Future updatetasks(String urgent, int taskid) async{
  try{
    var url = Uri.parse("http://192.168.100.147:5000/tasks/urgent");
    var headers = {"Content-Type":"application/json"};
    var body = jsonEncode({"urgent": urgent, "task_id": taskid});
    var response = await http.put(url, headers: headers, body: body);
    if(response.statusCode == 200 ){
      return jsonDecode(response.body);
    }
    else{
      return jsonDecode(response.body);
    }
  }
  catch(e){
    return null;
  }

}