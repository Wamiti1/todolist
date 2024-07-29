import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/futures/users/users.dart';
import 'package:todolist/screens/home.dart';



class Login extends StatefulWidget {
  final VoidCallback onClicked;
  const Login({super.key,  required this.onClicked});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {



Future setemail() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('email', email.text);
}

Future setusername(String firstname) async{
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('username', firstname);
}




  final formKey = GlobalKey<FormState>();
 
  var email = TextEditingController();
  var password = TextEditingController();
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Log In')),
        automaticallyImplyLeading: false,
        
      ),
      
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon:  Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      // validator: (value){
                      //     var validator = EmailValidator.validate(value!);
                      //     if(!validator){
                      //       return null;
                      //     }else{
                      //       return 'Invalid Email';
                      //     }
                          
                        
        
                      //   },
                      
                  ),
                ),

                
               
                
                

                


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon:  Icon(Icons.password),
                      ),
                      keyboardType: TextInputType.text,
                      
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter a password';
                        }
                        
                        else{
                          return null;
                        }
                        
                      

                      },
                  ),
                ),

                 


              ],
            )),

        ElevatedButton(
          onPressed: (){
            var isValid =formKey.currentState!.validate();
            if(isValid){
              
              try{
                login(email.text, password.text).then((v){
                  if(v == "Invalid credentials. Check your email address or your password and try again" || v == 'An unexpected error occurred'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v.toString())));
                  }
                  else{
                   
                    setusername(v['body'][0]['first_name'].toString());
                    setemail();
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(v['message'].toString())));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Home()));

                  }
                  
               
              });
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
              
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your credentials and try again')));
            }
              
          }, child: const Text('Log In')),

       RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: "Dont have an account?"),
                TextSpan(text:' Sign Up', style: const TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = widget.onClicked),

          
                
              ],
            ))


           
        ],),


        
      
      
      
      );
  }
}