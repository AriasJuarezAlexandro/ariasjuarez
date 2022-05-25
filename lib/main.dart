import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home:  MenuOffice(title: 'Office Food'),
    );
  }
}

class MenuOffice extends StatefulWidget {
   MenuOffice({Key? key, required this.title}) : super(key: key);
  final String title;
  String nombres="";
  String curso="";
  double precio=0;
  int cantidad=0;
  bool val=false;
  String mensaje="";
  double total=0;
  double totalpagar=0;
  double descuento =0;
  double delivery=0;

  @override
  State<MenuOffice> createState() => _MenuOffice();
}

class _MenuOffice extends State<MenuOffice> {
  final _tfNombres=TextEditingController();
  final _tfPedido=TextEditingController();
  final _tfPrecio=TextEditingController();
  final _tfCantidad=TextEditingController();

  void calcular(){
    setState(() {
      widget.val=false;
      if(_tfPrecio.text.toString()==""||_tfCantidad.text.toString()==""
      ||_tfNombres.text.toString()==""||_tfPedido.text.toString()==""
      ){
        widget.val=true;
        widget.mensaje="Completar todos los campos";
        return;
      }
      widget.precio=double.parse(_tfPrecio.text);
      widget.cantidad=int.parse(_tfCantidad.text);
      widget.total=(widget.precio*widget.cantidad);
      if(widget.total>500){
        widget.descuento=(widget.total*0.05);
      }else
      widget.descuento=0;
      widget.totalpagar=
      (widget.total - widget.descuento + widget.delivery);
    });
  }
  bool isSwitched = false;
  var textValue='Switch OFF';
  void toggleSwitch(bool value){
    if(isSwitched==false){
      setState(() {
        isSwitched=true;
        textValue='Mas delivery son 20 soles mas';
        widget.delivery=20;
      });
    }
    else{
      setState(() {
        isSwitched=false;
        textValue='Recojo en local';
        widget.delivery=0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mensaje;
    return Scaffold(
      appBar: AppBar(
        title: Text("Arias "+widget.title),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(13),
            child: Text("Bienvenido por favor complete sus datos para completar su pedido"),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _tfNombres,
                  decoration: InputDecoration(
                    hintText: "Ingresar nombres",
                    labelText: "Nombres",
                    errorText: _tfNombres.text.toString()==""?widget.mensaje: null,
                  )),
                  TextField(
                    controller: _tfPedido,
                  decoration: InputDecoration(
                    hintText: "Ingresar pedido",
                    labelText: "Pedido",
                    errorText: _tfPedido.text.toString()==""?widget.mensaje: null,
                  )),
                  TextField(
                    controller: _tfPrecio,
                    keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Ingresar precio",
                    labelText: "Precio",
                    errorText: _tfPrecio.text.toString()==""?widget.mensaje: null,
                  )),
                  TextField(
                    controller: _tfCantidad,
                    keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Ingresar cantidad",
                    labelText: "Cantidad",
                    errorText: _tfCantidad.text.toString()==""?widget.mensaje: null,
                  )),
                  Text("Total: "+ widget.total.toString()+" Descuento: "+widget.descuento.toString()
                  ),
                  Text("Delivery"),
                  Switch(
                    onChanged: toggleSwitch,
                    value: isSwitched,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.black,
                  ),
                  Text(
                    '$textValue',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: ""+widget.totalpagar.toString(),
                      labelText: ""+widget.totalpagar.toString(),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    child: Text("Calcular",
                    style: TextStyle(fontSize: 30, fontFamily: "rbold")
                    ),
                    onPressed: calcular,
                  )

              ],
            ),
          ),
        ],
      )
       
    );
  }
}


