import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';


Future<Response> onRequest(RequestContext context) async{
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: 405,
      body: {'message': 'Metodo incorrecto'},
      );
  }

  try {
    ///Obtenemos los datos de la soli
    final body = await context.request.json();

    //Verificacion d ataos
    if (
        //(body['creator'] as String).trim().isEmpty ||
        (body['type'] as String).trim().isEmpty ||
        (body['name'] as String).trim().isEmpty ||
        (body['description'] as String).trim().isEmpty
        //(body['creationDate'] as String).trim().isEmpty
        ) {
      return Response.json(
        statusCode: 400,
        body: {'message': 'Faltan datos'},
        );
    }
    ///Creamos una donacion
    final donation = Donations.fromJson(body as Map<String, dynamic>);

    ///aca va la logica de el guardado de la donacion

    return Response.json(
      body: {'message': 'Donacion crreada con exito', 
      'type': donation.type, 
      'name': donation.name,
      'description': donation.description,
      },
    );

  }catch(e) {
    return Response.json(
      statusCode: 400,
      body: {'message': 'Error al crear donacion'},
    );
  }
}
