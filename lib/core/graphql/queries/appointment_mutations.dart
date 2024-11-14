const String createAppointmentMutation = """
  mutation CreateAppointment(\$slotNumber: Int!, \$patientId: ID!, \$doctorSheduleId: ID!) {
    createAppointment(
      input: {
        slotNumber: \$slotNumber
        patientId: \$patientId
        doctorSheduleId: \$doctorSheduleId
      }
    ) {
      appointmentDate
      slotNumber
      doctorShedule {
        id
        dayOfWeek
        startTime
        endTime
        slotDuration
        doctor {
          user {
            fullName
          }
        }
        speciality {
          name
        }
        consultingRoom {
          roomName
          roomLocation
        }
      }
    }
  }
""";
