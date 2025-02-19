import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:donations/donations.dart';
import 'package:firedart/firedart.dart';


Future<Response> onRequest(RequestContext context) async{
  return switch(context.request.method){
    HttpMethod.post => _createDonation(context),
    HttpMethod.get => _getAllDonations(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}
Future<Response> _getAllDonations(RequestContext context) async {
  try {
    final donations = <Map<String, dynamic>>[];

    await Firestore.instance.collection('donations').get().then((event) {
      for (final doc in event) {
        donations.add(doc.map);
      }
    });

    return Response.json(body: {
      'message': 'Donations found', 
      'donations': donations,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error fetching donations',
      'error': e.toString(),
    },
      statusCode: HttpStatus.internalServerError,
    );
  }
}

Future<Response> _createDonation(RequestContext context) async {
  try {
    final body = await context.request.json();
    // final donationData = Donations.fromJson(body as Map<String, dynamic>);

    // final user = context.read<User?>();

    // if (user == null) {
    //   return Response.json(
    //     body: {'message': 'Usuario no autenticado'},
    //     statusCode: HttpStatus.unauthorized,
    //   );
    // }

    // donationData.creator = user.toJson() as User;
    
    // final donation = user.addDonation(donationData.toJson());

    final donation = Donations.fromJson(body as Map<String, dynamic>);
    await Firestore.instance.collection('donations').add(donation.toJson());

    return Response.json(body: {
      'message': 'Donation created',
      'name': donation.name,
      'type': donation.type,
      },
    );
  } catch(e) {
    return Response.json(body: {
      'message': 'Error creating donation',
      'error': e.toString(),
    },
    statusCode: HttpStatus.internalServerError,
    );
  }
}
