class PetrolStation {
  // TODO change num back to double and int
  // ATTENTION: somehow the api returns sometimes an int that can't be cast to double
  final String id;
  final String name;
  final String brand;
  final String street;
  final String place;
  final num latitude;
  final num longitude;
  final num distanceKm;
  final num diesel;
  final num e5;
  final num e10;
  final num price;
  final bool isOpen;
  final String houseNumber;
  final num postCode;

  PetrolStation(
      {this.id,
      this.name,
      this.brand,
      this.street,
      this.place,
      this.latitude,
      this.longitude,
      this.distanceKm,
      this.diesel,
      this.e5,
      this.e10,
      this.price,
      this.isOpen,
      this.houseNumber,
      this.postCode});

  PetrolStation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        brand = json['brand'],
        street = json['street'],
        place = json['place'],
        latitude = json['lat'],
        longitude = json['lng'],
        distanceKm = json['dist'],
        diesel = json['diesel'],
        e5 = json['e5'],
        e10 = json['e10'],
        price = json['price'],
        isOpen = json['isOpen'],
        houseNumber = json['houseNumber'],
        postCode = json['postCode'];

  @override
  String toString() {
    return 'PetrolStation{'
        'id: $id, '
        'name: $name, '
        'brand: $brand, '
        'street: $street, '
        'place: $place, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'distanceKm: $distanceKm, '
        'diesel: $diesel, '
        'e5: $e5, '
        'e10: $e10, '
        'price: $price, '
        'isOpen: $isOpen, '
        'houseNumber: $houseNumber, '
        'postCode: $postCode}';
  }
}
