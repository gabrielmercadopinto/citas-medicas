import 'package:citas_medicas/core/graphql/queries/appointment_mutations.dart';
import 'package:citas_medicas/core/graphql/queries/appointment_queries.dart';
import 'package:citas_medicas/models/appointment_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AppointmentController {
  final GraphQLClient client;

  AppointmentController(this.client);

  Future<Map<String, dynamic>> createAppointment({
    required int slotNumber,
    required String doctorScheduleId,
  }) async {
    const patientId = "1";
    // print("Appointment Controller $slotNumber, $patientId, $doctorScheduleId");
    final result = await client.mutate(
      MutationOptions(
        document: gql(createAppointmentMutation),
        variables: {
          'slotNumber': slotNumber,
          'patientId': patientId,
          'doctorSheduleId': doctorScheduleId,
        },
      ),
    );
    // print("despues de la peticion");

    if (result.hasException) {
      // print(result.exception!.graphqlErrors!.first!.message);
      throw Exception(result.exception.toString());
    }
    // print("Data Controller: ${result.data}");
    return result.data!['createAppointment'];
  }

  Future<List<Appointment>> fetchAppointments() async {
    const patientId = "1";
    final result = await client.query(
      QueryOptions(
        document: gql(fetchAppointmentsByPatientQuery),
        variables: const {
            'patientId': patientId,
          },
          fetchPolicy: FetchPolicy.networkOnly 
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['appointments'] as List;
    List<Appointment> appointments = data.map((e) => Appointment.fromJson(e)).toList();
    appointments.sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));
    return appointments;
  }
}
