import 'package:graphql_flutter/graphql_flutter.dart';
import '../core/graphql/queries/speciality_queries.dart';
import '../models/speciality_model.dart';

class SpecialityController {
  final GraphQLClient client;

  SpecialityController(this.client);

  Future<List<Speciality>> fetchSpecialities() async {
    final result = await client.query(
      QueryOptions(document: gql(fetchSpecialitiesQuery)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['specialities'] as List;
    List<Speciality> specialities = data.map((e) => Speciality.fromJson(e)).toList();
    specialities.sort((a, b) => a.name.compareTo(b.name));
    return specialities;
  }
}
