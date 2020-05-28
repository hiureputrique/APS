import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 16){
        _infoText = "Magreza Grave (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 16 && imc < 17){
        _infoText = "Magreza Moderada (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 17 && imc < 18.5){
        _infoText = "Magreza Leve (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.5 && imc < 25){
        _infoText = "Saudável (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 25 && imc < 30){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 30 && imc < 35){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 35 && imc < 40){
        _infoText = "Obesidade Grau II (severa) (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40 && imc < 45){
        _infoText = "Obesidade Grau III (mórbida) (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso ",
                    labelStyle: TextStyle()),
                style: TextStyle( fontSize: 20.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura",
                    labelStyle: TextStyle()),
                style: TextStyle( fontSize: 20.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle( fontSize: 20.0),
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}