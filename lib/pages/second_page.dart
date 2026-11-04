import 'package:flutter/material.dart';
import 'package:vrai_faux_app/model/question.dart';
import 'package:vrai_faux_app/model/datas.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }


}

class SecondPageState extends State<SecondPage> {

  final List<Question> _questions = AppDatas().listeQuestions;
  late Question? _questionSelected;
  int _score = 0;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _questionSelected = _questions[0];
  }

  TextButton bottomSheetButton({required String colorString, bool? reponseSelected, required Icon icon}){
    return TextButton(onPressed: (){
      setState(() {
        Navigator.pop(context); // Ferme la bottom sheet
        _alertDialog(reponseSelected);
      });}
      // return TextButton(onPressed: (){
      // setState(() {
      //   Navigator.pop(context); // Ferme la bottom sheet
      //   if (reponseSelected != null){
      //   _index++;
      //   }
      //   _questionSelected = _questions[_index];
      //   if (reponseSelected != _questionSelected!.reponse){
      //       _score++;
      //   }
      // });}
    , child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 20,),
        Text(colorString, style: TextStyle(color: Colors.black),)
      ],
    ));
  }

  Column bottom(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Ma réponse est : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        bottomSheetButton(colorString: "C'est vrai", reponseSelected: true, icon: Icon(Icons.check_circle, color: Colors.green,)),
        bottomSheetButton(colorString: "C'est faux",reponseSelected: false, icon: Icon(Icons.cancel, color: Colors.red,)),
        bottomSheetButton(colorString: "Je ne sais pas", icon: Icon(Icons.question_mark,))
      ],
    );
  }

  // void _alertDialog(){
  //   showDialog(context: context,
  //       barrierDismissible: false, //Pour ne pas fermer le diaog lors d'un appui hors du cadre du dialog
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           title: const Text("Raté!"),
  //           // content: const Text("Etes vous sûr de vouloir incrémenter"),
  //           content:                     Column(
  //             children: [
  //               Image.asset(
  //                 "assets/images/faux.jpg",
  //                 //   _questionSelected!.getImage()
  //               ),
  //             // Text(_questionSelected!.explication, style: TextStyle(color: Colors.green),),
  //               Text("Raté!"),
  //             ],
  //           ),
  //
  //           actions: [
  //
  //             TextButton(onPressed: (){
  //               setState(() {
  //                 _score++;
  //               });
  //               Navigator.pop(context);
  //             }, child: const Text("Ok")),
  //
  //           ],
  //         );
  //       }
  //   );
  // }


  void _alertDialog(bool? responseSelected){
    // Compare la réponse sélectionnée à la réponse correcte puis stocke le résultat (true ou false) dans 'correct'
    final bool correct = responseSelected == _questionSelected!.reponse; //Une réponse correcte à une question est uen réponse qui est identique à la réponse attendue

    // if (responseSelected == null){
    //   correct == null;
    // }

    showDialog(context: context,
        barrierDismissible: false, //Pour ne pas fermer le diaog lors d'un appui hors du cadre du dialog
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(correct ? "C'est gagné !" : "Raté !"),
            content: Column(
              mainAxisSize: MainAxisSize.min, //Pour que la colum n ne prenne pas beaucop de place
              children: [
                Image.asset("assets/images/" + (correct ? "vrai.jpg" : "faux.jpg")  ) ,// On mets correct entre parenthèse car on ne peut pas concaté,ner un e chaine et un booléen,

                //Opératuer ternaire
                _questionSelected!.explication.isNotEmpty
                  ? Text(_questionSelected!.explication) //Afficher l'explication si pas vide c'est à dire différent de ''
                  : const SizedBox(), // Rien à afficher si l'explication est vide
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    _nextQuestion(correct);
              },
                  child: const Text("Ok"))
            ],
          );
        }
    );

  }

  void _nextQuestion(bool correct){
    if (_index < _questions.length - 1){ // Vérifier que la question actuelle (index) n'est pas la dernière
      setState(() {
        if (correct) {_score++;} //Si la réponse est correcrte incrémenter le score
        _index++;
        _questionSelected = _questions[_index];
      });
    } else { //Si non ==> si c'est la dernière questin augmenter juste le score si réponse correcte
      setState(() {
        if (correct) _score++;
      });
      _finalDialog();
    }

  }

  void _finalDialog() {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Quiz terminé"),
            content: Text("Ton score : $_score / ${_questions.length}"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                setState(() {
                  _score = 0;
                  _index = 0;
                  _questionSelected = _questions[0];
                });
              }, child: const Text("Rejouer"))
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Score : $_score"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Question numéro : ${_index+1}/${_questions.length}",
              style: TextStyle(fontSize: 18,),
            ),
            SizedBox(height: 10,),
            Card(
              color: Colors.white,
              clipBehavior: Clip.antiAlias, //Pour que l'image ne dépasse pas la carde et épouse la bordure
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                width: 330 ,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      // "assets/images/belgique.jpg",
                        _questionSelected!.getImage()
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        _questionSelected!.question,
                        textAlign: TextAlign.center,
                        // _message,
                        style: TextStyle(fontSize: 13.7, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),


            //Bouton "Je réponds"
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                onPressed: (){
                  showModalBottomSheet(context: context,
                      builder: (BuildContext context){
                        return Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: bottom(),
                        );
                      }
                  );
                }, child: const Text("Je réponds")),
          ],
        )
      )
    );
  }

}