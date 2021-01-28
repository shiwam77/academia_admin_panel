import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/sinup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool exit = true;
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

            Text("Admin Login",style: TextStyle(
                color: AppColors.textColorBlackBlue,
                fontSize: MediaQuery.of(context).size.width * .025,
                fontWeight: FontWeight.bold
            ),),

            SizedBox(height: 10,),
            Row(
              children: [
                Spacer(),

                boxContainer(
                  leftRadius: 30,
                  child: SizedBox(),
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

                        MouseRegion(
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
                        ),

                        SizedBox(height:MediaQuery.of(context).size.height * .05 ,),

                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(20.0))
                              ),
                              labelText: "Email Id"
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            labelText: "Password",
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
                         onTap: ()=> print("clicked"),
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
                Spacer(),
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