import 'package:http/http.dart' as http;
import 'dart:convert';




//For logging in members
Future login(String emailaddress, String password)async{
  try{
    var url = Uri.parse('http://192.168.100.147:5000/users/all');
    var body = jsonEncode({
      'email_address': emailaddress,
      'password': password
    });
    var headers = {"Content-type":"application/json"};
    var response = await http.post(url, body:body, headers:headers);
    if(response.statusCode == 200){ 
    
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
      
    }
    else{
     return jsonDecode(response.body);
    }
  }
  catch(e){
    return null;
  }
}

//For signing up new members
Future signup(
  String emailaddress, 
  String firstname, 
  String lastname, 
  String password) async{
    try{
      var url = Uri.parse("http://192.168.100.147:5000/users");
      var body = jsonEncode({
        'email_address': emailaddress,
        'first_name': firstname,
        'last_name': lastname,
        'password': password
      });
      var headers ={
        "Content-type":"application/json"
      };
      var response = await http.post(url, body:body, headers:headers);
      if(response.statusCode == 200){
        
        return  jsonDecode(response.body);
      }
      else{
        throw Exception('Failed to post task: ${response.statusCode} - ${response.body}');
      }

    }
    catch(e){
     throw Exception('Failed to sign up user: ${e.toString()}');
    }
}


//Deleting members 
Future deleteUsers()async{
    try{
    var url = Uri.parse("http://192.168.100.147:5000/users");
    var headers = {
      "Content-type":"application/json"
    };
    var response = await http.delete(url, headers: headers);

    if(response.statusCode == 200){
      var body = response.body;
      return jsonDecode(body);
    }
    else{
     throw Exception('Failed to post task: ${response.statusCode} - ${response.body}');
    }
    }
    catch(e){
      throw Exception('Failed to sign up user: ${e.toString()}');
    }
}




