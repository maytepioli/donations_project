import 'package:/src/models/user_model.dart'; // Adjust the import path as necessary
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  //Verificamos si es el metodo que esperamos
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405, body: 'Metodo incorrecto');
  }

  try {
    //Obtenemos los datos del request
    final body = await context.request.json();

    //Creamos un nuevo usuario
    final user = User.fromJson(body);

    if (user.name.isEmpty || user.email.isEmpty || user.password.isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'Faltan datos'},
        );
    }

    return Response.json(
      body: {'message': 'Usuario registrado con exito', 'user': user.name},
    );
  } catch (e) {
    return Response.json(
      statusCode: 400,
      body: {'message': 'Error al registar el usuario'},
    );
  }
   
}
