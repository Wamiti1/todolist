import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/futures/users/users.dart';
import 'package:todolist/screens/home.dart';

      
class Register extends StatefulWidget {
  final VoidCallback  onClickedSignup;
  const Register({super.key, required this.onClickedSignup});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
 Future saveemail() async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('email', email.text);

                  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Register')),
        automaticallyImplyLeading: false,
       
      ),
      
      body: ListView(
        children:[ Column(
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
                        hintText: 'davinchii@gmail.com',
                        border: OutlineInputBorder(),
                        prefixIcon:  Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          var validator = EmailValidator.validate(value!);
                          if(!validator){
                             return 'Invalid Email';
                          }else{
                           return null;
                          }
                          
                        
        
                        },
                    ),
                  ),
        
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: firstname,
                      decoration: const InputDecoration(
                        labelText: 'Your first name',
                        border: OutlineInputBorder(),
                        prefixIcon:  Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty || double.tryParse(value) != null){
                            return 'Enter a valid name';
                          }
                          else{
                            return null;
                          }
                        
        
                        },
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: lastname,
                      decoration: const InputDecoration(
                        labelText: 'Your last name',
                        border: OutlineInputBorder(),
                        prefixIcon:  Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.text,
                       
                        validator: (value){
                            if(value!.isEmpty || double.tryParse(value) != null){
                            return 'Enter a valid name';
                          }
                          else{
                            return null;
                          }
                          
                        
        
                        },
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
                            return 'Enter a valid username';
                          }
                          else if(value.length < 6){
                            return 'Password should be at least 6 characters long';
                            
                          }
                          else{
                            return null;
                          }
                          
                        
        
                        },
                    ),
                  ),
        
                   Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: confirmpassword,
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        border: OutlineInputBorder(),
                        prefixIcon:  Icon(Icons.password),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter a password';
                          }
                          else if(value.length < 6){
                            return 'Password should be at least 6 characters long';
                            
                          }
                          else if(value!= password.text){
                            return 'Passwords do not match';
                            
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
                var isValid = formKey.currentState!.validate();
                if (isValid) {
                  
                  try{
                     signup(email.text, firstname.text, lastname.text, password.text).then((v){
                    
                  
                    
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text(v.toString())));
                      saveemail();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Home()));

                    
                    // else{
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error registering user')));
                      
                    // }
                  });
                 
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Error: ${e.toString()}')));
                  }
                  
                 
                  
                }
                else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check your credentials again')));

                }
                 
            }, child: const Text('Register')),

           RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: 'Already have an account?'),
                TextSpan(text:' Sign In', style: const TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignup),

          
                
              ],
            ))
          ],),
      ]),
      
      
      
      );
  }
}