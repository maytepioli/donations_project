import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';

Future<Response> onRequest(RequestContext context) async {
  //Verificamos si es el metodo que esperamos
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: 405,
      body:{'message': 'Error, metodo no permirido'},
      );
  }

  try {
    ///Obtenemos los datos del request
    final body = await context.request.json();

    ///Verificamos q los datos estan completos
    if (
        (body['name'] as String).trim().isEmpty ||
        (body['password'] as String).trim().isEmpty ||
        (body['email'] as String).trim().isEmpty ||
        (body['phoneNumber'] as String).trim().isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'message': 'Faltan datos'},
        );
    }

    ///Si estan completos, es crea el user

    final user = User.fromJson(body as Map<String, dynamic>);

    ///Agregar la logica para guardarloen la base de datos, o sea regisrarlo

    ///Retornamos q se creó con exito
    return Response.json(
      body: {'message': 'Usuario registrado con exito', 'user': user.name, 
      'email': user.email, },
    );

  } catch (e) {
    return Response.json(
      statusCode: 400,
      body: {'message': 'Error al registar el usuario'},
    );
  }
   
}
