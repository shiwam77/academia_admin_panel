import 'dart:html';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/DashBoard/dashboard.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Home/home_page.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool exit = true;
  bool isSignUpBtnHover = false;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conformPassword;
  String name;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _conformPasswordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Create Account",style: TextStyle(
                fontFamily: 'ProductSans',
                color: AppColors.textColorBlackBlue,
                fontSize: MediaQuery.of(context).size.width * .025,
                fontWeight: FontWeight.bold
            ),),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                boxContainer(
                  height: MediaQuery.of(context).size.height * .6 ,
                  leftRadius: 30,
                  context: context,
                  child: Hero(
                    tag: "appLogo",
                      child: Image.asset('Assets/images/visionLogo.png')),
                ),

                SizedBox(width: 2,),

                boxContainer(
                  height: MediaQuery.of(context).size.height * .6 ,
                  rightRadius: 30,
                  context: context,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07,vertical: 20),
                    child: loginField(),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget loginField(){
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: _nameTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                    ),
                    hintText: "Organization name"
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Organization name field can not be empty';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  hintText: "Email Id",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Email address field can not be empty';
                  }
                  else if(value.isNotEmpty){
                    return emailValidator(value);
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password field can not be empty';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller: _conformPasswordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  hintText: "Confirm Password",
                ),
                validator: (value) {
                 return confirmPasswordValidation(password: _passwordTextController.text,confirmPassword: value);
                },
              ),
              SizedBox(height: 20,),
              Text("Sign up with",style: TextStyle(fontFamily: 'ProductSans',fontSize: 20),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.home,size: 35,),
                      Text('Google')
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Icon(Icons.home,size: 35,),
                      Text('Facebook')
                    ],
                  )
                ],
              ),

              SizedBox(height: 20,),

              Align(
                alignment: Alignment.bottomLeft,
                  child: AnchorTextSignIn())

            ],
          ),
        ),

        Positioned(
          bottom: 50,
          right: 0,
          child: InkWell(
            onTap: () async{
              if(_formKey.currentState.validate()){
                var token = await attemptSignUp(email: _emailTextController.text,password: _passwordTextController.text,passwordConfirm: _conformPasswordTextController.text,
                    name: _nameTextController.text);
                if(token != "") {
                  print(token);
                  window.localStorage["token"] = token;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoardPage()
                      )
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('An Error Occurred,'),
                    ),
                  );
                }
              }
            },
            child: MouseRegion(
              onEnter: (value){
                setState(() {
                  isSignUpBtnHover = true;
                });

                print(exit);
              },
              onExit: (value){
                setState(() {
                  isSignUpBtnHover = false;
                });

              },
              child: Container(
                height: isSignUpBtnHover ?  51: 50,
                width:isSignUpBtnHover ?  101: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.blue,
                ),
                child: Icon(Icons.all_inbox_outlined,size: isSignUpBtnHover ?  36: 35,color: AppColors.white,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget textField({String hintText,Function onChanged,TextEditingController textEditingController}){
  return TextField(
    controller: textEditingController,
    onChanged: onChanged,
    obscureText: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      hintText: "Confirm Password",
    ),
  );
}

class AnchorTextSignIn extends StatefulWidget {
  @override
  _AnchorTextSignInState createState() => _AnchorTextSignInState();
}

class _AnchorTextSignInState extends State<AnchorTextSignIn> {
  bool exit = true;
  @override
  Widget build(BuildContext context) {
    return  MouseRegion(
      onEnter: (value){
        setState(() {
          exit = false;
        });
      },
      onExit: (value){
        setState(() {
          exit = true;
        });

      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: RichText(text:
        TextSpan(text:"Already have an account?",style: TextStyle(
          fontFamily: 'ProductSans',color: Colors.black,fontSize: 20),
            children: <TextSpan>[
              TextSpan(text: ' Sign in', style: TextStyle(
                fontFamily: 'ProductSans',
                color: Colors.blueAccent,
                decoration: !exit ? TextDecoration.underline:TextDecoration.none,fontSize: !exit ? 20:19,),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    }
              )
            ]),),
      ),
    );
  }
}


String confirmPasswordValidation({String password,String confirmPassword}){
  if (confirmPassword.isEmpty) {
    return 'Confirm password field can not be empty';
  }
  else if(confirmPassword.isNotEmpty){
    if(confirmPassword != password){
      return "Passwords are not the same!";
    }
    return null;
  }
  return null;
}