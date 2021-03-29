import 'package:flutter/material.dart';
import 'package:flutter_place_app/provider/great_places.dart';
import 'package:provider/provider.dart';
import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
 static const routeName='/detail_screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)
        .settings
        .arguments;
    final selectedPlace = Provider.of<GreatePlaces>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
        Container(
        height: 250,
        width: double.infinity,
        child: Image.file(selectedPlace.image,
          fit: BoxFit.cover,
          width: double.infinity,),
      ),
      SizedBox(height: 10,),
      Text(selectedPlace.location.address, textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: 10,),
      FlatButton(

        child: Text('view on Map'),
        textColor: Theme
            .of(context)
            .primaryColor,

        onPressed:() {Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx)=>
                MapScreen(
                  initialLocation: selectedPlace.location, isSelecting: false,
                ),
          ),
        );
        }
    )
        ],
      ),
    );
  }

}