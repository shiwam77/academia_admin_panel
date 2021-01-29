import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/user_model.dart';
import 'package:academia_admin_panel/Screen/Home/home_page.dart';
import 'package:academia_admin_panel/Screen/sinup.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:html' show window;
import 'dart:convert' show json, base64, ascii;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool exit = true;

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    TextEditingController _emailTextController = TextEditingController();
    TextEditingController _passwordTextController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xffF0F2F5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Admin Login",style: TextStyle(
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
                  child: Hero(
                      tag: "appLogo",
                      child: Image.asset('Assets/images/visionLogo.png')),
                  context: context
                ),

                SizedBox(width: 2,),

                boxContainer(
                  rightRadius: 30,
                  context: context,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        AnchorText(),

                        SizedBox(height:MediaQuery.of(context).size.height * .05 ,),

                        TextField(
                          onChanged: (value){
                            email = value;
                          },
                          controller: _emailTextController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(20.0))
                              ),
                              hintText: "Email Id"
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextField(
                          onChanged: (value){
                            password = value;
                          },
                          controller: _passwordTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            hintText: "Password",
                          ),
                        ),

                        SizedBox(height: 15,),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Forgot password ?",style: TextStyle(
                              color: AppColors.blue,
                              fontSize: MediaQuery.of(context).size.width * .010,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                        SizedBox(height: 15,),

                        InkWell(
                         onTap: () async{
                           try {
                             email.trim();
                             if(email.isNotEmpty && password.isNotEmpty && password.length >= 8){
                               var jwt = await attemptLogin(email: email,password: password);
                               print("token = $jwt");
                               if(jwt != null) {
                                 window.localStorage["token"] = jwt;
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => HomePage()
                                     )
                                 );
                               } else {
                                 //  displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                               }
                               _emailTextController.clear();
                               _passwordTextController.clear();

                             }

                           } catch (error, stacktrace) {
                             print("Exception occured: $error stackTrace: $stacktrace");

                           }
                         },
                          child: Container(
                            height: 60,
                            //width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.blue,
                            ),
                            child: Text("Sign in",style: TextStyle(
                                color: AppColors.white,
                                fontSize: MediaQuery.of(context).size.width * .01,
                                fontWeight: FontWeight.bold
                            )),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget boxContainer({@required Widget child,double rightRadius, double leftRadius,BuildContext context}){
  rightRadius = rightRadius == null? 0 : rightRadius;
  leftRadius = leftRadius  == null? 0 : leftRadius;
  return Container(
    width: MediaQuery.of(context).size.width * .4,
    height: MediaQuery.of(context).size.height * .5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(rightRadius),left: Radius.circular(leftRadius),),
      color: AppColors.white,
    ),
    child:  child,
  );
}




class AnchorText extends StatefulWidget {
  @override
  _AnchorTextState createState() => _AnchorTextState();
}

class _AnchorTextState extends State<AnchorText> {
  bool exit = true;
  @override
  Widget build(BuildContext context) {
    return   MouseRegion(
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
      child: RichText(text:
      TextSpan(text:"Don't have an account? ",style: TextStyle(color: Colors.black,),
          children: <TextSpan>[
            TextSpan(text: ' Sign up', style: TextStyle(color: Colors.blueAccent,
              decoration: !exit ? TextDecoration.underline:TextDecoration.none,
              fontSize: !exit ? 15:14,
            ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUP()),
                    );
                  }
            )
          ]),),
    );
  }
}

Future<dynamic> checkHttp () async {
  try {
    var dio = Dio();
    Response response = await dio.get('https://dog.ceo/api/breeds/image/random');
    return response.data;
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return error;
  }

}

