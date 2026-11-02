import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }

}

class _BodyState extends State<Body> {

  IconData _iconData =  Icons.person;
  Color _color = Colors.white;
  int _count = 0;

  void _showSnackBar(){
    SnackBar snackBar = SnackBar( //SnackBar permet de dire par exemple à l'utilisateur qu'il est connecté ou déconnecrté
      content: const Text("Nous avons montré une SnackBar"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 5,
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating, //On mets ceci pour permttre le margin
      showCloseIcon: true, //Avoir l'icon e de la croix pour fermer la snackbar
      duration: const Duration(seconds: 8), //Duré de l'afichage du SnackBar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _simpleDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) { //Builder va être une fonction qui va nous ramener un buil context
          return SimpleDialog(
            title: const Text("Change l'icone"),
            children: [
              _dialogButton(text: "Home", iconData: Icons.house),
              _dialogButton(text: "Personne", iconData: Icons.person)
            ],
          );
        }
    );
  }

  void _alertDialog(){
    showDialog(context: context,
        barrierDismissible: false, //Pour ne pas fermer le diaog lors d'un appui hors du cadre du dialog
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Incrémentation"),
            content: const Text("Etes vous sûr de vouloir incrémenter"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Annuler")),
              TextButton(onPressed: (){
                setState(() {
                  _count++;
                });
                Navigator.pop(context);
              }, child: const Text("Ok")),

            ],
          );
        }
    );
  }


  TextButton _dialogButton({required String text, required IconData iconData }){
    return TextButton(
        onPressed: (){
          setState(() {
            _iconData = iconData;
            Navigator.pop(context);// Fermer la SimpleDialog juste après appui sur Home ou Personne
          });
        },
        child: Row(
          children: [
            Icon(iconData),
            Text(text),
          ],
        )
    );
  }

  TextButton bottomSheetButton({required String colorString, required Color color}){
    return TextButton(onPressed: (){
      setState(() {
        Navigator.pop(context);
        _color = color;
      });
    }, child: Text(colorString));
  }

  Column bottom(){
    return Column(
      children: [
        const Text("Changer la couleur du bouton"),
        const Divider(),
        bottomSheetButton(colorString: "Rouge", color: Colors.red),
        bottomSheetButton(colorString: "Vert", color: Colors.green),
        bottomSheetButton(colorString: "Blanc", color: Colors.white)
      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: _showSnackBar, child: const Text("Montre moi un Snackbar")),
          ElevatedButton(onPressed: _simpleDialog, child: const Text("Simple Dialog")),
          Icon(_iconData, color: Theme.of(context).colorScheme.primary,),
          ElevatedButton(onPressed: _alertDialog, child: Text("J'ai confirmé $_count fois")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _color
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
              }, child: const Text("Bottom Sheet Modale")),

          ElevatedButton(onPressed: (){
            Scaffold.of(context).showBottomSheet((BuildContext context){
              return bottom();
            });
          }, child: const Text("Persistante"))
        ],
      ),
    );
  }
}