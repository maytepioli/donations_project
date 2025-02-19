import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context, String id) async{
  return switch(context.request.method){
    HttpMethod.delete => _deleteDonation(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _deleteDonation(RequestContext context, String id) async {
  try {
    await Firestore.instance.collection('donations').document(id).delete();
    return Response.json(body: {
        'message': 'deleted',
      },
        statusCode: HttpStatus.noContent,
    );
  } catch(e) {
      return Response.json(body: {
        'message': 'error',
      },
        statusCode: HttpStatus.badRequest,
    );
  }
}
