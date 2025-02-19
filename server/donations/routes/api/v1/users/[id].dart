import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch(context.request.method) {
    HttpMethod.get => _getUserByID(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getUserByID(RequestContext context, String id) async {
  try {

    final doc = await Firestore.instance.collection('users').document(id).get();

    final user = doc.map;
    return Response.json(body: {
      'message': 'User found',
      'center': user,
      },
    );
  

  } catch(e) {
    return Response.json(body: {
      'message': 'Error fetching user',
      'error': e.toString(),
    },
      statusCode: HttpStatus.internalServerError,
    );
  }
}
