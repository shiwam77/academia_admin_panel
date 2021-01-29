import 'dart:html';

import 'package:academia_admin_panel/Color.dart';
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
      backgroundColor: Color(0xffF0F2F5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Create Account",style: TextStyle(
                color: AppColors.textColorBlackBlue,
                fontSize: MediaQuery.of(context).size.width * .025,
                fontWeight: FontWeight.bold
            ),),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                boxContainer(
                  leftRadius: 30,
                  context: context,
                  child: Hero(
                    tag: "appLogo",
                      child: Image.asset('Assets/images/visionLogo.png')),
                ),

                SizedBox(width: 2,),

                boxContainer(
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
        Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: _nameTextController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(20.0))
                  ),
                  hintText: "Full Name"
              ),
            ),

            SizedBox(height: 20,),
            TextField(
              controller: _emailTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: "Email Id",
              ),
            ),

            SizedBox(height: 20,),
            TextField(
              controller: _passwordTextController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: "Password",
              ),
            ),

            SizedBox(height: 20,),
            TextField(
              controller: _conformPasswordTextController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                ),
                hintText: "Confirm Password",
              ),
            ),
            SizedBox(height: 20,),
            Text("Sign up with"),
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

            AnchorTextSignIn()

          ],
        ),

        Positioned(
          bottom: 50,
          right: 0,
          child: InkWell(
            onTap: () async{
              if(_passwordTextController.text == _conformPasswordTextController.text && _emailTextController.text != "" && _emailTextController.text.isNotEmpty
              && _passwordTextController.text.length >= 8 && _nameTextController.text != "" && _nameTextController.text.isNotEmpty){
                var token = await attemptSignUp(email: _emailTextController.text,password: _passwordTextController.text,passwordConfirm: _conformPasswordTextController.text,
                    name: _nameTextController.text);
                if(token != null) {
                  print(token);
                  window.localStorage["token"] = token;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()
                      )
                  );
                } else {
                  //  displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
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

        print(exit);
      },
      onExit: (value){
        setState(() {
          exit = true;
        });

      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: RichText(text:
        TextSpan(text:"Already have an account?",style: TextStyle(color: Colors.black,),
            children: <TextSpan>[
              TextSpan(text: ' Sign in', style: TextStyle(color: Colors.blueAccent,
                decoration: !exit ? TextDecoration.underline:TextDecoration.none,fontSize: !exit ? 15:14,),
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

