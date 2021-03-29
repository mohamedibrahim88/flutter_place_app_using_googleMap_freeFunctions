import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_place_app/models/place.dart';
import 'package:flutter_place_app/provider/great_places.dart';
import 'package:flutter_place_app/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/add_place';

  @override
   _AddPlaceScreenState createState ()=> _AddPlaceScreenState();
}
class _AddPlaceScreenState extends State <AddPlaceScreen>{
  final _titleController=TextEditingController();
  File _pickedImage ;
  PlaceLocation _pickedLocation;
  void _selectedImage (File pickedImage){
    _pickedImage=pickedImage;
  }
  void _selectPlace(double lat , double lng){
    _pickedLocation=PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace(){
     if (_titleController.text.isEmpty || _pickedImage== null){
       return;
     }
     Provider.of<GreatePlaces>(context,listen: false).addPlace(_titleController.text, _pickedImage,_pickedLocation);
     Navigator.of(context).pop();
}

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children:<Widget> [
                  TextField(
                    decoration: InputDecoration(labelText: 'title'),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectedImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace),
                ],
              ),
            ),
          ),
          ),
          RaisedButton.icon(icon:Icon(Icons.add),
          label: Text('Add Place'),
          onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}