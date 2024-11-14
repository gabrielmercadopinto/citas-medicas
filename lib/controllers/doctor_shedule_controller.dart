//import 'package:citas_medicas/core/graphql/queries/doctor_shedule_queries.dart';
import 'package:citas_medicas/core/graphql/queries/doctor_shedule_queries.dart';
import 'package:citas_medicas/models/doctor_shedule_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DoctorScheduleController {
  final GraphQLClient client;

  DoctorScheduleController(this.client);

  Future<List<DoctorSchedule>> fetchDoctorSchedules(int dayOfWeek, String specialityId) async {  
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(fetchDoctorSchedulesQuery),
          variables: {
            'dayOfWeek': dayOfWeek,
            'specialityId': specialityId,
          },
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
      final List data = result.data?['doctorShedules'] ?? [];
      print("Controller: $dayOfWeek - $specialityId - $data");
      return data.map((e) => DoctorSchedule.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error fetching schedules: $e');
    }
  }
}
