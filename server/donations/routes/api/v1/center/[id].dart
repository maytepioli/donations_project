import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch(context.request.method) {
    HttpMethod.get => _getCenterByID(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getCenterByID(RequestContext context, String id) async {
  try {

    final doc = await Firestore.instance.collection('centers').document(id).get();

    final center = doc.map;
    return Response.json(body: {
      'message': 'Center found',
      'center': center,
      },
    );
  

  } catch(e) {
    return Response.json(body: {
      'message': 'Error fetching center',
      'error': e.toString(),
    },
      statusCode: HttpStatus.internalServerError,
    );
  }
}
