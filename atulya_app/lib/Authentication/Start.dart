import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final signupPurpleGradient = LinearGradient(colors: <Color>[
  Color.fromRGBO(44, 67, 140, 1),
  Color.fromRGBO(116, 174, 222, 1),
]);
final signupDarkPurple = Color.fromRGBO(44, 67, 154, 1);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          
          Color.fromRGBO(116, 174, 222, 1),
          Color.fromRGBO(44, 67, 140, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: topPadding),
                SizedBox(height: 10),
                AnimatedImage(),
                
              ],
            ),
          ),
        //  Positioned(
        //         left: 130,
        //         bottom: 2,
        //         child: ClipRRect(
        //         child: ImageFiltered(
        //           imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        //           child: Container(
        //             width: 100,
        //             height: 100,
        //             child: Image.asset('assets/images/logo.png')),
        //         ),
        //                   ),
        //       ),

          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 4.5,
            child: Card(
              elevation: 10,
            shadowColor: Colors.black,
              color: Colors.white.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                
                width: MediaQuery.of(context).size.width-150,
                height: MediaQuery.of(context).size.height*0.2-20, 
                decoration: BoxDecoration(
                  //color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(225, 255, 255, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10)
                                        )],
                  borderRadius: BorderRadius.circular(15),
                ),
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(1, 8, 1, 1),
                     child: Column(
                       children: <Widget>[
                         GestureDetector(
                            onTap: (){
                              },
                            child: Container(
                              height: 35,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                gradient: signupPurpleGradient,
                                borderRadius: BorderRadius.circular(50),
                                //color: Colors.orange[900]
                              ),
                              child: Center(
                                child: Text("Login",style:GoogleFonts.lato(
                                        fontSize: 17,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                          
                                      ),),
                              ),
                              
                            ),),
                          SizedBox(height: 10,),
                         GestureDetector(
                            onTap: (){
                              },
                            child: Container(
                              height: 35,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                gradient: signupPurpleGradient,
                                borderRadius: BorderRadius.circular(50),
                                //color: Colors.orange[900]
                              ),
                              child: Center(
                                child: Text("SignUp",style:GoogleFonts.lato(
                                        fontSize: 17,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                          
                                      ),),
                              ),
                              
                            ),),
                       ],
                     ),
                   ),
                      ),
            ),
          )
          ]
        ),

      ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0, 0.08),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  late final Animation<Offset> _animation1 = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0, 0.15),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 60,
          width:80,
          child: Image.asset('assets/images/clouds.png'),
        ),
        Positioned(
          right: 25,
          top: 10,
          child: SizedBox(
            height: 60,
            width:100,
            child: Image.asset('assets/images/clouds.png'),
          ),
        ),
        Positioned(
          right: 10,
          top: 80,
          child: SizedBox(
            height: 60,
            width:50,
            child: Image.asset('assets/images/clouds.png'),
          ),
        ),
        SlideTransition(
          position: _animation1,
          child: SizedBox(
            width: 300,
            height:250,
            child: Image.asset('assets/images/par_1.png'),
          ),
        ),
        SlideTransition(
          position: _animation,
          child: SizedBox(
            width: 250,
            height:250,
            child: Image.asset('assets/images/par.png')),
        ),
        Positioned(
          left: 10,
          top: 80,
          child: SizedBox(
            height: 60,
            width:80,
            child: Image.asset('assets/images/clouds.png'),
          ),
        ),
        

      ],
    );
  }
}
