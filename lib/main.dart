import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Infinite Scroll',
      home:RandomWords()
    );
  }}


class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];
  final fevs = <WordPair>{};

  void pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              final tiles = fevs.map(
                    (pair) {
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: const TextStyle(fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'bkant',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  );
                },
              );
              final devided = tiles.isNotEmpty ?
              ListTile.divideTiles(tiles: tiles,
                  context: context).toList() :
              <Widget>[];
              return Scaffold(
                backgroundColor: Colors.grey[900],
                appBar: AppBar(
                  backgroundColor: Colors.grey[800],
                  title: const Text('Saved',
                    style: TextStyle(fontSize: 30,
                        fontFamily: 'ant'
                    ),),
                ),
                body: ListView(children: devided),
              );
            }
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('Infinite Scroll',
              style: TextStyle(fontSize: 30,
                  fontFamily: 'ant'
              ),),
            SizedBox(width: 15),
            Text('-by Keter Titus',
              style: TextStyle(fontSize: 15,
                  fontFamily: 'bkant'
              ),),
          ],),
        actions: [
          IconButton(
              onPressed: pushSaved,
              icon: Icon(Icons.list),
            tooltip: 'Saved',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider(color: Colors.white);
          final index = i ~/ 2;
          if (index >= suggestions.length) {
            suggestions.addAll(generateWordPairs().take(10));
          }
          bool saved = fevs.contains(suggestions[index]);
          return ListTile(
            title: Text(
              suggestions[index].asPascalCase,
              style: const TextStyle(fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'bkant',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
              ),
            ),
            trailing: Icon(
              saved ? Icons.local_fire_department_rounded : Icons
                  .ac_unit_rounded,
              color: saved ? Colors.red : Colors.white,
              semanticLabel: saved ? 'Remove' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (saved) {
                  fevs.remove(suggestions[index]);
                }
                else {
                  fevs.add(suggestions[index]);
                }
              });
            },
            //subtitle: const Divider(color: Colors.white),
          );
        },
      ),
    );
  }
}


class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}