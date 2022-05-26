import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimentions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimentions.radius15),
        ),
        child: SizedBox(
          width: Dimentions.screenWidth,
          // child: const Text('Google map dialogue'),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: "Search Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimentions.radius20 / 2),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimentions.font16,
                    ),
              ),
            ),
            suggestionsCallback: (pattern) async {
              // As we type, it gives us suggestions
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimentions.width10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: Dimentions.font16,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
            onSuggestionSelected: (Prediction suggestion) {
              print('Get location selected from dialog');
              Get.find<LocationController>().setLocation(
                suggestion.placeId!,
                suggestion.description!,
                mapController,
              );
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
