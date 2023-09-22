import 'firestore_service.dart'; // Import your Firestore service file here
import 'package:image_picker/image_picker.dart';

final firestoreService = FirestoreService();

Future<void> addVehiclesToFirestore() async {
  // Check if a vehicle with the same name already exists
  final existingVehicle = await firestoreService.getVehicleByName('Tata Nano');

  if (existingVehicle == null) {
    // If the vehicle doesn't exist, add it to Firestore
    await firestoreService.addVehicle(
      'Tata Nano',
      "https://firebasestorage.googleapis.com/v0/b/vehicle-rental-2.appspot.com/o/vehicle_images%2Fvehicle_1.jpg?alt=media&token=9124dc24-00af-487a-a6a9-1d4e156b2254",
      105, // Price per hour
      1449, // Price per day
      'Car', // Type
      ['Borivali','Andheri','Churchgate'],
      ['Andheri','Virar'],
    );

    print('Tata Nano added to Firestore');
  } else {
    // If the vehicle already exists, you can choose to update its details or handle it accordingly
    print('Tata Nano already exists in Firestore');
  }

  // Check if a vehicle with the same name already exists
  final existingVehicle2 = await firestoreService.getVehicleByName('Tata Nexon');

  if (existingVehicle2 == null) {
    // If the vehicle doesn't exist, add it to Firestore
    await firestoreService.addVehicle(
      'Tata Nexon',
      "https://files.prokerala.com/automobile/images/thumbnail/large/tata-nexon-ev-1462/xm.jpg",
      120, // Price per hour
      1749, // Price per day
      'Car', // Type
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
    );

    print('Tata Nexon added to Firestore');
  } else {
    // If the vehicle already exists, you can choose to update its details or handle it accordingly
    print('Tata Nexon already exists in Firestore');
  }

  // Check if a vehicle with the same name already exists
  final existingVehicle3 = await firestoreService.getVehicleByName('Lamborghini');

  if (existingVehicle3 == null) {
    // If the vehicle doesn't exist, add it to Firestore
    await firestoreService.addVehicle(
      'Lamborghini',
      "https://firebasestorage.googleapis.com/v0/b/vehicle-rental-2.appspot.com/o/vehicle_images%2Fvehicle_3.jpg?alt=media&token=2cdcb2bd-b8dc-4339-a407-68cd4b14093f",
      450, // Price per hour
      5799, // Price per day
      'Car', // Type
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
    );

    print('Lamborghini added to Firestore');
  } else {
    // If the vehicle already exists, you can choose to update its details or handle it accordingly
    print('Lamborghini already exists in Firestore');
  }

  // Check if a vehicle with the same name already exists
  final existingVehicle4 = await firestoreService.getVehicleByName('Apache rtr 310');

  if (existingVehicle4 == null) {
    // If the vehicle doesn't exist, add it to Firestore
    await firestoreService.addVehicle(
      'Apache rtr 310',
      "https://firebasestorage.googleapis.com/v0/b/vehicle-rental-2.appspot.com/o/vehicle_images%2Fvehicle_4.jpg?alt=media&token=bbb6a95c-14bf-4a69-b719-8fa64319fdb7",
      90, // Price per hour
      1249, // Price per day
      'Motorbike', // Type
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
    );

    print('Apache rtr 310 added to Firestore');
  } else {
    // If the vehicle already exists, you can choose to update its details or handle it accordingly
    print('Apache rtr 310 already exists in Firestore');
  }

  // Check if a vehicle with the same name already exists
  final existingVehicle5 = await firestoreService.getVehicleByName('Royal Enfield Classic 350');

  if (existingVehicle5 == null) {
    // If the vehicle doesn't exist, add it to Firestore
    await firestoreService.addVehicle(
      'Royal Enfield Classic 350',
      "https://firebasestorage.googleapis.com/v0/b/vehicle-rental-2.appspot.com/o/vehicle_images%2Fvehicle_5.jpg?alt=media&token=c34c3c8e-2d5e-477e-8662-7d003ca05609",
      100, // Price per hour
      1349, // Price per day
      'Motorbike', // Type
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
      ['Borivali','Kandivali','Virar','Vasai Road','Dadar','Bandra'],
    );

    print('Royal Enfield Classic 350 added to Firestore');
  } else {
    // If the vehicle already exists, you can choose to update its details or handle it accordingly
    print('Royal Enfield Classic 350 already exists in Firestore');
  }

  print('Vehicles added to Firestore');
}
