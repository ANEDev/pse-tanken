class Price {
  final String diesel;
  final String e5;
  final String e10;
  final String status;

  Price({this.diesel, this.e5, this.e10, this.status});

  Price.fromJson(Map<String, dynamic> json)
      : diesel = json['diesel'].toString(),
        e5 = json['e5'].toString(),
        e10 = json['e10'].toString(),
        status = json['status'];

  @override
  String toString() {
    return 'Price{'
        'diesel: $diesel, '
        'e5: $e5, '
        'e10: $e10, '
        'status: $status}';
  }
}

class PricesForStation {
  final String id;
  final Price prices;

  PricesForStation({this.id, this.prices});
}
