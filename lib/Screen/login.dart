import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/user_model.dart';
import 'package:academia_admin_panel/Screen/Home/home_page.dart';
import 'package:academia_admin_panel/Screen/signup.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:html' show window;
import 'dart:convert' show json, base64, ascii;

import 'AcademicYear/academic_year_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool exit = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
    String email;
    String password;
    TextEditingController _emailTextController = TextEditingController();
    TextEditingController _passwordTextController = TextEditingController();
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

            Text("Admin Login",
              style: TextStyle(
                  fontFamily: 'ProductSans',
                color: AppColors.textColorBlackBlue,
                fontSize:MediaQuery.of(context).size.width * .025,
                fontWeight: FontWeight.bold
            ),
            ),

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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          AnchorText(),

                          SizedBox(height:MediaQuery.of(context).size.height * .05 ,),

                          TextFormField(
                            onChanged: (value){
                              email = value;
                            },
                            controller: _emailTextController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: AppColors.gray400)
                                ),
                                hintText: "Email Id"
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email id';
                              }

                              else if(value.isNotEmpty){
                                return emailValidator(value);
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15,),

                          TextFormField(
                            onChanged: (value){
                              password = value;
                            },
                            controller: _passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: AppColors.gray400)
                              ),

                              hintText: "Password",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 15,),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("Forgot password ?",style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.normal
                            ),),
                          ),
                          SizedBox(height: 15,),

                          InkWell(
                           onTap: () async{
                                try{
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_formKey.currentState.validate()) {
                                    var jwt = await attemptLogin(
                                        email: email, password: password);
                                    print("token");
                                    print(jwt);
                                    if (jwt.isNotEmpty) {

                                      window.localStorage["token"] = jwt;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AcademicYearPage(window.localStorage["userId"])
                                          )
                                      );
                                      _emailTextController.clear();
                                      _passwordTextController.clear();
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                       const SnackBar(
                                         content: Text('An Error Occurred,No account was found matching that username and password'),
                                       ),
                                     );
                                    }
                                }
                                }
                                catch(error){
                                  showToast(context, "Something went wrong");
                                }
                                finally{
                                    setState(() {
                                    isLoading = false;
                                  });
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
                              child: !isLoading ? Text("Login",style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: AppColors.white,
                                  fontSize: MediaQuery.of(context).size.width * .015,
                                  fontWeight: FontWeight.bold
                              )):CircularProgressIndicator(backgroundColor: AppColors.green600,),
                            ),
                          ),

                        ],
                      ),
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
Widget boxContainer({@required Widget child,double rightRadius, double leftRadius,BuildContext context,double height,double width}){
  rightRadius = rightRadius == null? 0 : rightRadius;
  leftRadius = leftRadius  == null? 0 : leftRadius;
  height = height  == null?  MediaQuery.of(context).size.height * .5 : height;
  width = width  == null?  MediaQuery.of(context).size.width * .4 : width;
  return Container(
    width: width,
    height: height,
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
      TextSpan(text:"Don't have an account? ",style: TextStyle(
        fontFamily: 'ProductSans',
        fontSize: 20,
        color: Colors.black,),
          children: <TextSpan>[
            TextSpan(text: ' Sign up', style: TextStyle(fontFamily: 'ProductSans',color: Colors.blueAccent,
              decoration: !exit ? TextDecoration.underline:TextDecoration.none,
              fontSize: !exit ? 20:19,
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

