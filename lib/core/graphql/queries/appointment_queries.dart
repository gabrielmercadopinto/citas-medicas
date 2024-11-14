const String fetchAppointmentsByPatientQuery = """
  query GetAppointmentsByPatient(\$patientId: ID!) {
    appointments(
      params: {
        patientId: \$patientId
      }
    ) {
      id
      appointmentDate
      slotNumber
      status    
      doctorShedule {
        id
        dayOfWeek
        startTime
        endTime
        slotDuration
        totalSlots
        status
        doctor {
          id
          code
          user {
            id
            fullName
            email
            userType
            enabled
          }
        }
        speciality {
          id
          name
        }
        consultingRoom {
          id
          roomName
          roomLocation
        }
      }
    }
  }
""";
