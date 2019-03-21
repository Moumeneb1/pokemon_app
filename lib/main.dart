import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/pokemondetail.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Poke APP',
    home: new HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url="https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub ;  
  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub==null
          ? Center(
        child: CircularProgressIndicator(),
      ): GridView.count(
          crossAxisCount: 2,
          children: pokeHub.pokemon.map((poke)=>Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDeatil(
                  pokemon: poke,
                )));
              },
              child: Hero(
                tag: poke.img,
                child: Card(
                  elevation: 3.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(poke.img))
                        ),
                      ),
                      Text(
                        poke.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh),
      ),
    );
  }

  void fetchData() async{

  var res = await http.get(url);
  print(res.body);
  var decodeJson = jsonDecode(res.body);
  pokeHub = PokeHub.fromJson(decodeJson);
  setState(() {});
  }
}
