import 'package:rock_in_rio/show.dart';
import 'package:flutter/material.dart';

import 'constantes.dart';

/// Todo aplicativo Flutter é iniciado no método main()
///
void main() => runApp(
      RockInRio(),
    );

class RockInRio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock In Rio',
      theme: ThemeData(
        //Indica a "paleta de cores" do aplicativo.
        primarySwatch: Colors.indigo,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Rock in Rio',
                style: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/party.jpg',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RowInformacoes(),
          Divider(),
          SizedBox(
            height: 30,
          ),
          RowDicas('Beba água'),
          SizedBox(
            height: 15,
          ),
          RowDicas('Pets são bem vindos'),
          SizedBox(
            height: 15,
          ),
          RowDicas('Aproveite sem moderação'),
          Spacer(),
          RowDicas('#RockInRio nas redes sociais'),
          Spacer(),
          RaisedButton(
            color: Colors.blue.shade900,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShowsScreen();
              }));
            },
            child: Text(
              'Shows',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

/// Widget customizado que contém as principais informações do evento.
class RowInformacoes extends StatelessWidget {
  final _style = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.calendar_today),
            SizedBox(height: 5),
            Text(
              '27/Set',
              style: _style,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Icon(Icons.timer),
            SizedBox(height: 5),
            Text(
              '15:00',
              style: _style,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Icon(Icons.pin_drop),
            SizedBox(height: 5),
            Text(
              'Cidade do Rock',
              style: _style,
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget customizado que contém dicas para os usuários.
class RowDicas extends StatelessWidget {
  final String descricao;

  const RowDicas(this.descricao);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline),
          SizedBox(
            width: 10,
          ),
          Text(
            descricao,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

/// Tela que exibe toda a grade de shows.
class ShowsScreen extends StatefulWidget {
  ShowsScreen({Key key}) : super(key: key);

  _ShowsScreenState createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  List<Show> _listaFavoritos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shows'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AgendaScreen(listaFavoritos: _listaFavoritos);
              }));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listaShow.length,
        itemBuilder: (context, index) {
          final show = listaShow[index];
          bool _isFavorito = _listaFavoritos.contains(show);
          return ListTile(
            title: Text(show.banda),
            subtitle: Text(show.palco),
            leading: Text(show.horario),
            trailing: IconButton(
              icon: _isFavorito
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border,
                    ),
              onPressed: () {
                setState(() {
                  if (_isFavorito) {
                    _listaFavoritos.remove(listaShow[index]);
                  } else {
                    _listaFavoritos.add(listaShow[index]);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}

/// Tela para exibir os shows que foram escolhidos pelo usuário.
class AgendaScreen extends StatefulWidget {
  final List<Show> listaFavoritos;
  AgendaScreen({this.listaFavoritos});

  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  TextStyle _style = TextStyle(
    fontSize: 26,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14.0),
        itemCount: widget.listaFavoritos.length,
        itemBuilder: (context, index) {
          final show = widget.listaFavoritos[index];
          return Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        show.banda,
                        style: _style,
                      ),
                      Text(
                        show.horario,
                        style: _style,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.thumb_up),
                      Icon(Icons.comment),
                      Icon(Icons.share),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
