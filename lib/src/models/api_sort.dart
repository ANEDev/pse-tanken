import 'package:meta/meta.dart';

abstract class SortOption {
  final String sortName;
  final String sortApiName;

  SortOption(this.sortName, this.sortApiName);
}

@immutable
class SortPrice extends SortOption {
  SortPrice() : super("Price", "price");
}

@immutable
class SortDistance extends SortOption {
  SortDistance() : super("Distance", "dist");
}

SortOption sortOptionFromMap(Map<String, dynamic> map) {
  switch (map['sortName']) {
    case 'Price' : return SortPrice();
    case 'Distance' : return SortDistance();
  }
}