import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: 405,
      body: {'message': 'Método incorrecto'},
    );
  }

  try {
    /// Obtenemos los datos de la solicitud
    final body = await context.request.json();

    /// Verificación de datos
    if ((body['type'] as String).trim().isEmpty ||
        (body['name'] as String).trim().isEmpty ||
        (body['description'] as String).trim().isEmpty) {
      return Response.json(
        statusCode: 400,
        body: {'message': 'Faltan datos'},
      );
    }

    /// Creamos una instancia de la donación
    final donation = Donations.fromJson(body as Map<String, dynamic>);

    /// Retornamos la instancia creada (sin guardar en la base de datos)
    return Response.json(
      statusCode: 201,
      body: {
        'message': 'Donación creada con éxito',
        'uuid': donation.uuid,
        'type': donation.type,
        'name': donation.name,
        'description': donation.description,
        'creationDate': donation.creationDate.toIso8601String(),
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 400,
      body: {
        'message': 'Error al crear la donación',
        'error': e.toString(),
      },
    );
  }
}
