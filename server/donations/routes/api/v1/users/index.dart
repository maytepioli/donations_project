import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';
import 'package:firedart/firedart.dart';
Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method) {
    HttpMethod.get => _getAllUsers(context),
    HttpMethod.post => _createUser(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _getAllUsers(RequestContext context) async {
  try {
    final users = <Map<String, dynamic>>[];

    await Firestore.instance.collection('users').get().then((event) {
      for (final doc in event) {
        users.add(doc.map);
      }
    });

    return Response.json(body: {
      'message': 'Users found',
      'users': users,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error fetching users',
      'error': e.toString(),
    },
    statusCode: HttpStatus.internalServerError,
    );
  }
}

Future<Response> _createUser(RequestContext context) async {
  try {
    final body = await context.request.json();
    final user = User.fromJson(body as Map<String, dynamic>);

    await Firestore.instance.collection('users').add(user.toJson());

    return Response.json(body: {
      'message': 'User created',
      'name': user.name,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error creating user',
      'error': e.toString(),
    },
    statusCode: HttpStatus.internalServerError,
    );
  }
}
