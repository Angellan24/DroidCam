import 'package:flutter/material.dart';
import 'welcome.dart';
class DropDown extends StatefulWidget {
  DropDown() : super();
  @override
  DropDownState createState() => DropDownState();
}
 
class Wifi {
  int id;
  String name;
 
  Wifi(this.id, this.name);
 
  static List<Wifi> getWifi() {
    return <Wifi>[
      Wifi(1, 'Globe@HomeWifi'),
      Wifi(2, 'PDLTwifi'),
      Wifi(3, 'Smart@Homewifi'),
      Wifi(4, 'DITOwifi'),
      Wifi(5, 'Parasat'),
    ];
  }
}
 
class DropDownState extends State<DropDown> {
 //
  List<Wifi> _wifi = Wifi.getWifi();
  List<DropdownMenuItem<Wifi>> _dropdownMenuItems;
  Wifi _selectedWifi;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_wifi);
    _selectedWifi = _dropdownMenuItems[0].value;
    super.initState();
  }
 
  List<DropdownMenuItem<Wifi>> buildDropdownMenuItems(List wifi) {
    List<DropdownMenuItem<Wifi>> items = List();
    for (Wifi wifi in wifi) {
      items.add(
        DropdownMenuItem(
          value: wifi,
          child: Text(wifi.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Wifi selectedWifi) {
    setState(() {
      _selectedWifi = selectedWifi;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            elevation: 0.0,
            backgroundColor:Colors.transparent,
            iconTheme: new IconThemeData(color: Color(0xFF18D191)),
        ),
        body: new Container(
            color: Color(0xFF18D191),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select wifi connect"),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedWifi,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
    );
  }
}