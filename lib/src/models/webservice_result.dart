import 'package:meta/meta.dart';

class WebServiceResult{
  final int status;
  final dynamic data;

  @immutable
  WebServiceResult(this.status, this.data);
}
