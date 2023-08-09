import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/widgets/card_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int questionIndex = 0;
  bool showResultsMessage = false;
  int totalScore = 0;
  int? yourChoiceIndex;

  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'Who is making the Web standards?',
      'answers':[
        {'text': 'The World Wide Web Consortium','score': 1,'icon':'assets/images/w3c.png'},
        {'text': 'Mozilla','score': 0,'icon':'assets/images/mozilla.png'},
        {'text': 'Microsoft','score': 0,'icon':'assets/images/microsoft.png'},
        {'text': 'Google','score': 0,'icon':'assets/images/google.png'},
        ],
    },
    {
      'question': 'What is actually electricity?',
      'answers':[
        {'text': 'A flow of water','score': 0,'icon':'assets/images/water.jpg'},
        {'text': 'A flow of air','score': 0,'icon':'assets/images/air.jpg'},
        {'text': 'A flow of electrons','score': 1,'icon':'assets/images/electrons.png'},
        {'text': 'A flow of atoms','score': 0,'icon':'assets/images/atoms.png'},
        ],
    },
    {
      'question': 'Which of the following animals can run the fastest?',
      'answers':[
        {'text': 'Camel','score': 0,'icon':'assets/images/camel.png'},
        {'text': 'Cheetah','score': 1,'icon':'assets/images/cheetah.png'},
        {'text': 'Horse','score': 0,'icon':'assets/images/horse.jpg'},
        {'text': 'Lion','score': 0,'icon':'assets/images/lion.jpg'},
        ],
    },
    {
      'question': 'What is the largest continent in size?',
      'answers':[
        {'text': 'Asia','score': 1,'icon':'assets/images/asia.jpg'},
        {'text': 'Africa','score': 0,'icon':'assets/images/africa.png'},
        {'text': 'Europe','score': 0,'icon':'assets/images/europe.jpg'},
        {'text': 'North America','score': 0,'icon':'assets/images/northAmerica.jpg'},
        ],
    },
    {
      'question': 'We often use sodium bicarbonate in the kitchen. What is its other name?',
      'answers':[
        {'text': 'Vinegar','score': 0,'icon':'assets/images/vinegar.jpg'},
        {'text': 'Sugar','score': 0,'icon':'assets/images/sugar.jpg'},
        {'text': 'Salt','score': 0,'icon':'assets/images/salt.png'},
        {'text': 'Baking soda','score': 1,'icon':'assets/images/bakingSoda.png'},
        ],
    },
    {
      'question': '‘Free throw’ is associated with ?',
      'answers':[
        {'text': 'Basketball','score': 1,'icon':'assets/images/Basketball.png'},
        {'text': 'Hockey','score': 0,'icon':'assets/images/hockey.png'},
        {'text': 'Volleyball','score': 0,'icon':'assets/images/volleyball.png'},
        {'text': 'Football','score': 0,'icon':'assets/images/football.png'},
        ],
    },
  ];

  void resetQuiz(){
    setState(() {
      questionIndex = 0;
      showResultsMessage = false;
      totalScore = 0;
      yourChoiceIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    final questionWithAnswer = questionsWithAnswers[questionIndex] ;
    //double widthOfTheDevice = MediaQuery.of(context).size.width;
    final sizeOfTheDevice = MediaQuery.of(context).size;

    final answerTexts = (questionWithAnswer['answers'] as List<Map<String,Object>>).map(
                                (answer){
                                return answer['text'] as String;
                              }).toList(); 

    final answerScores = (questionWithAnswer['answers'] as List<Map<String,Object>>).map(
                                (answer){
                                return answer['score'] as int;
                              }).toList();
    
    final answerIcons = (questionWithAnswer['answers'] as List<Map<String,Object>>).map(
                                (answer){
                                return answer['icon'] as String;
                              }).toList();

    return Scaffold(
        body: SafeArea(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: showResultsMessage == false? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(showResultsMessage == false)...[
                  SizedBox(height: sizeOfTheDevice.height * 0.1),
                  Text(
                    questionWithAnswer['question'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Answer and get points',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: sizeOfTheDevice.height * 0.06),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Step ${questionIndex+1}',
                             style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.w500,
                              fontSize:16.0,
                            ),
                          ),
                          Text(
                            ' of ${questionsWithAnswers.length}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize:16.0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 9.0),
                      StepProgressIndicator(
                        size:2,
                        currentStep: questionIndex+1,
                        totalSteps: questionsWithAnswers.length,
                        selectedColor: Colors.orangeAccent,
                        unselectedColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0), 
                  for(int i = 0; i< questionWithAnswer['answers'].length; i++)
                  Padding(
                    padding: const EdgeInsets.only( bottom: 16.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          yourChoiceIndex = i;
                        });
                      },
                      child: Container(
                        width: double.infinity ,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: i != yourChoiceIndex? Colors.white : Colors.orangeAccent,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              CardWidgets(cardImage: answerIcons[i]),
                              // Icon(
                              //   Icons.add,
                              //   color: i == yourChoiceIndex? Colors.white : Colors.black,
                              // ),
                              const SizedBox(width: 16.0),
                              Text(
                                answerTexts[i],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: i == yourChoiceIndex ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          if(yourChoiceIndex != null ){
                            if(questionIndex < questionsWithAnswers.length-1 && yourChoiceIndex != null ){
                                questionIndex++;                                 
                              }else{
                                showResultsMessage = true;
                              }
                              totalScore+=answerScores[yourChoiceIndex!];
                              yourChoiceIndex = null; 
                          } else{
                              final snackbar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title:'Warning!',
                                  message:' Please, Choose the anwer!',
                                  contentType: ContentType.warning,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }   
                        });
                      }, 
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                 const SizedBox(height: 10.0),
                ],
              ],
          ) : Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                     margin: const EdgeInsets.all(16.0),
                     height: MediaQuery.of(context).size.height * 0.4,
                     width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            totalScore >= 3 ?'Congratulations!' : 'Hard Luck!',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: totalScore >= 3 ? Colors.orangeAccent : Colors.red,
                              ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                        'Your Score :',
                         style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                         ),
                        ),
                      const SizedBox(height: 20.0),
                        Text(
                        '$totalScore / ${questionsWithAnswers.length}',
                         style: const TextStyle(
                            fontSize:  30.0,
                            fontWeight: FontWeight.w500,
                         ),
                        ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: resetQuiz,
                      child: const Text(
                        'Reset Quiz',
                        style:  TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.orangeAccent,
                       ),
                      )
                    ),
                   const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const HomePage()));
                      },
                      child: const Text(
                        'Home Page',
                        style:  TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.orangeAccent,
                       ),
                      )
                    ),
                ],
            ),
          ),
        ),
      ) 
    );
  }
}