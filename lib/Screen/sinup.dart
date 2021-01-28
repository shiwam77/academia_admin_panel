import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool exit = true;
  bool isSignUpBtnHover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              children: [
                Spacer(),

                boxContainer(
                  leftRadius: 30,
                  context: context,
                  child: SizedBox(),
                ),

                SizedBox(width: 2,),

                boxContainer(
                  rightRadius: 30,
                  context: context,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07,vertical: 20),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20,),
                            TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                  ),
                                  hintText: "Full Name"
                              ),
                            ),

                            SizedBox(height: 20,),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                ),
                                hintText: "Email Id",
                              ),
                            ),

                            SizedBox(height: 20,),
                            TextField(
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
                            MouseRegion(
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
                            ),


                          ],
                        ),

                        Positioned(
                          bottom: 50,
                          right: 0,
                          child: InkWell(
                            onTap: ()=> print("clicked"),
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
