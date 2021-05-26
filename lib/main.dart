import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:conversor_moedas/main.dart';
import 'dart:convert';
import 'dart:async';

import 'app_bar/app_bar.dart';

var request = "https://api.hgbrasil.com/finance/quotations?key=e8785535";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amberAccent,
      primaryColor: Colors.amberAccent,
    ),
  ));
}

Future<Map> getData() async {
  // var uri = Uri.parse(request);
  http.Response response = await http.get(Uri.parse(request));
  return (json.decode(response.body));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final cotacaoDolarController = TextEditingController();

  double dolar;
  double euro;
  double cotacao;

  void _cotacaoDoloar(String text) {
     cotacao.toStringAsFixed(2);
  }

  void _realAtualizar(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarAtualizar(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroAtualizar(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _botaoreset() {
    setState(() {
      realController.text = "";
      dolarController.text = "";
      euroController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),

      /*AppBar(
        title: Text(" \$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _botaoreset,
          ),
        ],
      ),*/
      body: FutureBuilder<Map>(
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Carregando Dados.....",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Erro ao Carregar Dados :( ",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  cotacao = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                       // Icon(Icons.monetization_on,
                            //size: 150.0, color: Colors.amber),
                        buildTextField(
                            "Reais", "R\$", realController, _realAtualizar,false),
                        Divider(),
                        buildTextField("Dolares", "US\$", dolarController,
                            _dolarAtualizar,false),
                        Divider(),
                        buildTextField(
                            "Euros", "€\$ ", euroController, _euroAtualizar,false),
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Card(
                            color: Colors.teal,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[

                                  Text(
                                    "Dolar Hoje US\$: ${cotacao.toStringAsFixed(2)}",
                                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

buildTextField(String label, String prefix, TextEditingController moeda,
    Function atualizarMoedas, bool mexer ) {
  return TextField(
     readOnly: mexer,
    //enableInteractiveSelection: false,
    controller: moeda,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefix,
      labelStyle: TextStyle(color: Colors.amber),
      // border: OutlineInputBorder(
      enabledBorder: const OutlineInputBorder(
        // width: 0.0 produces a thin "hairline" border
        borderSide: const BorderSide(color: Colors.amber, width: 2.0),
      ),
      border: const OutlineInputBorder(),
    ),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: atualizarMoedas,
    keyboardType: TextInputType.number,
  );
}
