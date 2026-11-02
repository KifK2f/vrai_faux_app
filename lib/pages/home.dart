import 'package:flutter/material.dart';


//Ce fichier contient un Sacffold donce sera une page ==> va dans le dossier pages
class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Flutter"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: Center(
        child:  Card(
          color: Theme.of(context).colorScheme.inversePrimary,
          clipBehavior: Clip.antiAlias, //Pour que l'image ne dépasse pas la carde et épouse la bordure
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
            width: 300 ,
            height: 306,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cover.jpg",
                  // "assets/images/${_carSelected.urlString}.jpg",
                  //   _carSelected.urlString
                  // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                ),
                SizedBox(height: 10,),
                Text(
                  "Quand un philosophe me réponds, je ne comprends plus ma question",
                  textAlign: TextAlign.center,
                  // _message,
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                    onPressed: (){
                  
                }, child: const Text("Commencer le QUIZZ")),
              ],
            ),
          ),
        ),
      ),
    );
  }

}