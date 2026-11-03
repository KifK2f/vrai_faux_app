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
  int _index = 1;

  @override
  void initState() {
    super.initState();
    _questionSelected = _questions[0];
  }

  TextButton bottomSheetButton({required String colorString, bool? reponseSelected, required Icon icon}){
    return TextButton(onPressed: (){
      setState(() {
        Navigator.pop(context);
        // _color = color;
        if (!reponseSelected!){
        _score++;
        _questionSelected = _questions[_score];
        }
        if(reponseSelected = _questionSelected!.reponse){
            Text("Tu a raison");
        }
      });
    }, child: Row(
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
            Text("Question numéro : $_index/${_questions.length}",
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