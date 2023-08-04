import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/card-widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int questionIndex = 0;
  bool showResultsMessage = false;
  int totalScore = 0;
  int? yourChoiceIndex;

  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What is your favorite Sport?',
      'answers':[
        {'text': 'Football','score': 0,'icon':'assets/images/football.png'},
        {'text': 'Tennis','score': 0,'icon':'assets/images/tennis.png'},
        {'text': 'Basketball','score': 1,'icon':'assets/images/basketball.png'},
        {'text': 'Volleyball','score': 0,'icon':'assets/images/volleyball.png'},
        ],
    },
    {
      'question': 'What is your favorite Shape?',
      'answers':[
        {'text': 'Circle','score': 0,'icon':'assets/images/circle.png'},
        {'text': 'Rectangle','score': 0,'icon':'assets/images/rectangle.png'},
        {'text': 'Square','score': 1,'icon':'assets/images/square.png'},
        {'text': 'Triangle','score': 0,'icon':'assets/images/triangle.png'},
        ],
    },
    {
       
      'question': 'What is your favorite Animal?',
      'answers':[
        {'text': 'Camel','score': 0,'icon':'assets/images/camel.png'},
        {'text': 'Horse','score': 1,'icon':'assets/images/horse.png'},
        {'text': 'Dog','score': 0,'icon':'assets/images/dog.png'},
        {'text': 'Cat','score': 0,'icon':'assets/images/cat.png'},
        ],
    },
    {
      'question': 'What is your favorite Color?',
      'answers':[
        {'text': 'Red','score': 1,'icon':'assets/images/red_color.png'},
        {'text': 'White','score': 0,'icon':'assets/images/white_color.png'},
        {'text': 'Blue','score': 0,'icon':'assets/images/blue_color.png'},
        {'text': 'Green','score': 0,'icon':'assets/images/green_color.png'},
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
                  SizedBox(height: sizeOfTheDevice.height * 0.1),
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
                      const SizedBox(height: 8.0),
                      StepProgressIndicator(
                        size:2,
                        currentStep: questionIndex+1,
                        totalSteps: questionsWithAnswers.length,
                        selectedColor: Colors.orangeAccent,
                        unselectedColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), 
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
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
                                  message:'Please, Choose one anwer to start a quiz!',
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
                ],
              ],
          ) : Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text(
                      'Congratulations!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Your Score is : $totalScore / ${questionsWithAnswers.length}',
                       style: const TextStyle(
                          fontSize: 20,
                       ),
                      ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: resetQuiz,
                      child: const Text(
                        'Reset Quiz',
                        style:  TextStyle(
                          fontSize: 18,
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