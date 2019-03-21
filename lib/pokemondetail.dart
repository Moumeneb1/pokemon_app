import 'package:flutter/material.dart';
import 'package:pokemon_app/pokemon.dart';

class PokeDeatil extends StatelessWidget {
  final Pokemon pokemon;

  const PokeDeatil({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => new Stack(
        children: <Widget>[
          Positioned(
            height : MediaQuery.of(context).size.height/1.5,
            width : MediaQuery.of(context).size.width-20,
            left: 10.0,
            top: MediaQuery.of(context).size.height*0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(pokemon.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("Height : ${pokemon.height}"),
                  Text("Weight : ${pokemon.weight}"),
                  Text("Types"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) =>
                            FilterChip(
                                label: Text(t,style: TextStyle(color: Colors.white),),
                                onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Weaknesses"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) =>
                            FilterChip(
                                backgroundColor: Colors.orange,
                                label: Text(t,style: TextStyle(color: Colors.white),),
                                onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Evolution"),
                  pokemon.nextEvolution==null ? Text("No evolution"):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution
                        .map((n) =>
                            FilterChip(
                                backgroundColor: Colors.deepOrange,
                                label: Text(n.name,style: TextStyle(color: Colors.white)),
                                onSelected: (b) {}))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(tag: pokemon.img,
                child:Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                        image: NetworkImage(pokemon.img),
                      fit: BoxFit.cover
                    )
                  ),
                )),
          ),
        ],
      );
}
