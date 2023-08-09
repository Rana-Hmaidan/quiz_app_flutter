import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz_page.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children:[
           const  Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: 12.0),
                        Text(
                          'Welcome',
                          style: TextStyle(
                           fontSize: 35.0,
                           fontWeight: FontWeight.bold,
                           color: Colors.orangeAccent
                          ),
                      ),
                        SizedBox(height: 5.0,),
                        Padding(
                          padding: EdgeInsets.only(right:160),
                          child: Center(
                            child: Text(
                                   'to Quiz App !',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            ),
                          ),
                        ), 
                    ],
                ),
            ), 
            Container(
            margin: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), 
                image: const DecorationImage(
                  image: AssetImage('assets/images/testKnowledge.png'),
                  fit: BoxFit.cover, //change image fill type
                ),
              ),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizPage()));
        } ,
        tooltip: 'Quiz Page',
        backgroundColor: Colors.orangeAccent,
        label: const Text(
          'Let\'s Go?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        ),
    );
  }
}