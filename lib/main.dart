import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  final TextEditingController kgTextController = TextEditingController();
  final TextEditingController heightTextController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String infoText = "Informe seus dados!";

  void _resetFields(){
    setState(() {
      kgTextController.clear();
      heightTextController.clear();
      infoText = "Informe seus dados!";
    });
  }
  
  void setInfoText(String string){
    setState(() {
      infoText = string;
    });
  }

  void calculate(){
    double kg = double.parse((kgTextController.text));
    double height = double.parse(heightTextController.text)/100;
    double imc = kg / (height*height);
    if(imc < 18.6){
      setInfoText('Abaixo do Peso. IMC: ${imc.toStringAsPrecision(3)}');
    } else if(imc >= 18.6 && imc < 24.9){
      setInfoText('Peso Ideal. IMC: ${imc.toStringAsPrecision(3)}');
    } else if (imc >= 24.9 && imc < 29.9){
      setInfoText('Levemente acima do peso. IMC: ${imc.toStringAsPrecision(3)}');
    } else if (imc >= 29.9 && imc < 34.9){
      setInfoText('Obesidade Grau I. IMC: ${imc.toStringAsPrecision(3)}');
    } else if (imc >= 34.9 && imc < 39.9){
      setInfoText('Obesidade Grau II. IMC: ${imc.toStringAsPrecision(3)}');
    } else if (imc >= 40){
      setInfoText('Obesidade Severa GRAU III. IMC: ${imc.toStringAsPrecision(3)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: (_resetFields),
            icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            child: Column(
              children:  [
                const Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120,
                ),
                TextFormField(
                  controller: kgTextController,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == ''){
                      return "Insira seu peso!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.green,
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 24
                    )
                  ),
                ),
                TextFormField(
                  controller: heightTextController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == ''){
                      return "Insira sua altura!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.green,
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                      )
                  ),
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  height: 50.0,
                  width: 300.00,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState?.validate() == true){
                        calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.all(16),
                    ),
                    child:
                      const Text('Calcular', style: TextStyle(fontSize: 25.0),)
                  ),
                ),
                const SizedBox(height: 8,),
                SizedBox(
                  child: Text(
                    infoText,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
