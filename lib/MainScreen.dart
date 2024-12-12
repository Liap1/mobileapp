import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    List<dynamic> gamesList = [];
    final TextEditingController gameControllerText = TextEditingController();

    void takeGames() async {
      final SupabaseClient supabaseClient = Supabase.instance.client;
      final responseData = await supabaseClient.from('games').select();
      gamesList = responseData as List<dynamic>;
      List<dynamic> tempSearchList = [];
      for (int i = 0; i < gamesList.length; i++)
      {
        if (gamesList[i]['name'].toLowerCase().contains(gameControllerText.text.toLowerCase()))
          {
            tempSearchList.add(gamesList[i]);
          }
      }

      setState(() {
        gamesList = tempSearchList;
      });
    }

    @override
    void initState() {
      super.initState();
      takeGames();
    }

    @override
    Widget build (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
                'GamesINFO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
          backgroundColor: Color.fromRGBO(211, 211, 211, 1),
        ),
        backgroundColor: Color.fromRGBO(211, 211, 211, 1),
        body: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: gameControllerText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Поиск игры',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () { takeGames(); },
                    ),
                  ],
                ),
                Expanded(
                  child: gamesList.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.separated(
                    itemCount: gamesList.length,
                    itemBuilder: (context, index) {
                      var game = gamesList[index];
                      return ListTile(
                        title: Column(children: [Text(game['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                          GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.parse(game['url_wiki']));
                            },
                            child: Image.network(
                              game['url_image'],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Описание: ${game['description']}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text('Жанр: ${game['genre']}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text('Год выхода: ${game['release_year'] + 'г'}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text('Разработчик: ${game['developer']}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.grey);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
}