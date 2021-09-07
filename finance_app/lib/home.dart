import 'package:flutter/material.dart';
import 'widgets.dart';
import 'api.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double euro;

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double realC = double.parse(text);
    dollarController.text = (realC / dollar).toStringAsFixed(2);
    euroController.text = (realC / euro).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dollarC = double.parse(text);
    realController.text = (dollarC * this.dollar).toStringAsFixed(2);
    euroController.text = ((dollarC * this.dollar) / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euroC = double.parse(text);
    realController.text = (euroC * this.euro).toStringAsFixed(2);
    dollarController.text = ((euroC * this.euro) / dollar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPrimary,
      appBar: AppBar(
          title: Text("Conversor de Moedas",
              style: TextStyle(color: darkSecondary)),
          backgroundColor: Color.fromRGBO(222, 164, 80, 20),
          centerTitle: true),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: buildTextCharger("Carregando Dados..."));
            default:
              if (snapshot.hasData) {
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.attach_money,
                          size: 150, color: Colors.amberAccent),
                      buildTextField(
                          "Real", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField(
                          "Dolar", "US\$", dollarController, _dollarChanged),
                      Divider(),
                      buildTextField("Euro", "€", euroController, _euroChanged),
                    ],
                  ),
                );
              }
              return Center(
                  child: buildTextCharger("Error ao Carregar os Dados..."));
          }
        },
      ),
    );
  }
}
