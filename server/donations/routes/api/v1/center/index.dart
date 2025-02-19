import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';
import 'package:firedart/firedart.dart';
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.get => _getAllCenters(context),
    HttpMethod.post => _createCenter(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getAllCenters(RequestContext context) async {
  try {
    final centers = <Map<String, dynamic>>[];

    await Firestore.instance.collection('centers').get().then((event) {
      for (final doc in event) {
        centers.add(doc.map);
      }
    });

    return Response.json(body: {
      'message': 'Centers found',
      'centers': centers,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error fetching centers',
      'error': e.toString(),
    },
      statusCode: HttpStatus.internalServerError,
    );
  }
}

Future<Response> _createCenter(RequestContext context) async {
  try {
    final body = await context.request.json();
    final center = Center.fromJson(body as Map<String, dynamic>);

    await Firestore.instance.collection('centers').add(center.toJson());

    return Response.json(body: {
      'message': 'Center created',
      'name': center.name,
      'address': center.address,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error creating center',
      'error': e.toString(),
    },
    statusCode: HttpStatus.internalServerError,
    );
  }
}
