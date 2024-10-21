import 'package:adopt_app/models/pet.dart';
import 'package:dio/dio.dart';

final String _baseUrl = "https://coded-pets-api-crud.eapi.joincoded.com";
final Dio _dio = Dio();

class DioClient {
  // Default
  Future<List<Pet>> getPets() async {
    List<Pet> pets = [];
    try {
      Response response =
          await _dio.get("https://coded-pets-api-crud.eapi.joincoded.com/pets");
      pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return pets;
  }
}

// Create
class PetsServices {
  Future<Pet> createPet({required Pet pet}) async {
    late Pet retrievedPet;
    try {
      FormData data = FormData.fromMap({
        "Name": pet.name,
        "Age": pet.age,
        "Gender": pet.gender,
        "Image": await MultipartFile.fromFile(pet.image)
      });

      Response response = await _dio.post(_baseUrl + '/pets', data: data);
      retrievedPet = Pet.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
    return retrievedPet;
  }
}
