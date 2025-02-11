import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String uuid) {
  return Response(body: 'post id: $uuid');
}
