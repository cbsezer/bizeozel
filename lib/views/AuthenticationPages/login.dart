
import 'package:bizeozel/view-model/Global_variables.dart';
import 'package:bizeozel/views/AuthenticationPages/pageview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeS extends StatelessWidget {
  final FirebaseAuth _user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body:  Center(
  child:   InkWell(
  
                  onTap: () async {
  
                    userID = '';
  
                    await _user.signOut();
  
                    await Navigator.pushAndRemoveUntil(
  
                        context,
  
                        MaterialPageRoute(builder: (context) => MyPageView()),
  
                        (route) => false);
  
                  },
  
                  child: Container(
  
                      alignment: Alignment.center,
  
                      height: MediaQuery.of(context).size.height * 0.07,
  
                      width: MediaQuery.of(context).size.width * 0.5,
  
                      decoration: BoxDecoration(
  
                        borderRadius: BorderRadius.circular(15),
  
                        color: Color(0xffcd0a0a),
  
                      ),
  
                      child: Text(
  
                        'Çıkış Yap',
  
                        style: TextStyle(
  
                            color: Colors.white,
  
                           
  
                            fontWeight: FontWeight.bold),
  
                      )),
  
                ),
),
    );

    
  }
}
