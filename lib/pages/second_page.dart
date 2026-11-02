import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }


}

class SecondPageState extends State<SecondPage> {

  TextButton bottomSheetButton({required String colorString, required Color color, required Icon icon}){
    return TextButton(onPressed: (){
      setState(() {
        Navigator.pop(context);
        // _color = color;
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
        bottomSheetButton(colorString: "C'est vrai", color: Colors.red, icon: Icon(Icons.check_circle, color: Colors.green,)),
        bottomSheetButton(colorString: "C'est faux", color: Colors.green, icon: Icon(Icons.cancel, color: Colors.red,)),
        bottomSheetButton(colorString: "Je ne sais pas", color: Colors.white, icon: Icon(Icons.question_mark))
      ],
    );
  }

@override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Score : 0"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Question numéro : 1/10",
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
                      "assets/images/belgique.jpg",
                      // "assets/images/${_carSelected.urlString}.jpg",
                      //   _carSelected.urlString
                      // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        "La devise de la Belgique est l'union fait la force",
                        textAlign: TextAlign.center,
                        // _message,
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
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