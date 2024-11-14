const String fetchDoctorSchedulesQuery = """
  query GetDoctorSchedules(\$dayOfWeek: Int!, \$specialityId: ID!) {
    doctorShedules(
      params: { dayOfWeek: \$dayOfWeek, specialityId: \$specialityId }
    ) {
      id
      dayOfWeek
      startTime
      endTime
      slotDuration
      reservedSlots
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
""";