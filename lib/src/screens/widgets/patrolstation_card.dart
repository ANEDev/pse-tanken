import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tanken/src/models/petrolstation.dart';
import 'package:url_launcher/url_launcher.dart';

class PetrolStationCard extends StatelessWidget {
  final PetrolStation petrolStation;
  final String selectedFuelType;

  const PetrolStationCard({
    Key key,
    @required this.petrolStation,
    @required this.selectedFuelType,
  })  : assert(petrolStation != null),
        assert(selectedFuelType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 9.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PetrolStationCardImage(
                  petrolStation: petrolStation,
                ),
                Expanded(
                  child: PetrolStationCardNameAndAddress(
                    petrolStation: petrolStation,
                  ),
                ),
                PetrolStationCardPriceAndFav(
                    petrolStation: petrolStation,
                    selectedFuelType: selectedFuelType),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 10,
            ),
            PetrolStationCardFooter(petrolStation: petrolStation),
          ],
        ),
      ),
    );
  }
}

class PetrolStationCardPriceAndFav extends StatelessWidget {
  const PetrolStationCardPriceAndFav({
    Key key,
    @required this.petrolStation,
    @required this.selectedFuelType,
  })  : assert(petrolStation != null),
        assert(selectedFuelType != null),
        super(key: key);

  final PetrolStation petrolStation;
  final String selectedFuelType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          Text(
            "${petrolStation.price}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            selectedFuelType,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class PetrolStationCardNameAndAddress extends StatelessWidget {
  const PetrolStationCardNameAndAddress({
    Key key,
    @required this.petrolStation,
  })  : assert(petrolStation != null),
        super(key: key);

  final PetrolStation petrolStation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            petrolStation.brand,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text("${petrolStation.street} ${petrolStation.houseNumber}"),
          Text("${petrolStation.postCode} ${petrolStation.place}"),
        ],
      ),
    );
  }
}

class PetrolStationCardImage extends StatelessWidget {
  const PetrolStationCardImage({
    Key key,
    @required this.petrolStation,
  })  : assert(petrolStation != null),
        super(key: key);

  final PetrolStation petrolStation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: Image(
          fit: BoxFit.fitHeight,
          alignment: Alignment.topRight,
          image: AssetImage(_imageForBrand(petrolStation.brand)),
        ),
      ),
    );
  }

  String _imageForBrand(String brand) {
    String image;

    switch (brand.toUpperCase()) {
      case "ARAL":
        image = "assets/station_icons/ARALI_logo.png";
        break;
      case "AGIP":
        image = "assets/station_icons/Agipo_logo.png";
        break;
      case "ESSO":
        image = "assets/station_icons/Essoe_logo.png";
        break;
      case "BTF":
        image = "assets/station_icons/wtf_logo.png";
        break;
      case "JET":
        image = "assets/station_icons/met_logo.png";
        break;
      case "SHELL":
        image = "assets/station_icons/SHELLO_logo.png";
        break;
      case "TOTAL":
        image = "assets/station_icons/Brutali_logo.png";
        break;
      default:
        image = "assets/station_icons/default_logo.png";
    }
    return image;
  }
}

class PetrolStationCardFooter extends StatelessWidget {
  const PetrolStationCardFooter({
    Key key,
    @required this.petrolStation,
  })  : assert(petrolStation != null),
        super(key: key);

  final PetrolStation petrolStation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.wifi, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.restaurant, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.wc, color: Colors.grey),
            ),
          ],
        ),
        FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.directions, color: Colors.grey),
              ),
              Text(
                "${petrolStation.distanceKm} km",
              ),
            ],
          ),
          onPressed: () => _launchURL(),
        ) //,
      ],
    );
  }

  void _launchURL() async {
    final url = "https://www.google.com/maps/dir/"
        "?api=1"
        "&destination=${petrolStation.street}"
        "+${petrolStation.houseNumber}"
        "+${petrolStation.postCode}"
        "+${petrolStation.place}"
        "&travelmode=driving";
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }
}
