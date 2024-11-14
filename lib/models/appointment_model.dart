class Appointment {
  final String id;
  final DateTime appointmentDate;
  final int slotNumber;
  final String status;
  final DoctorShedule doctorShedule;

  Appointment({
    required this.id,
    required this.appointmentDate,
    required this.slotNumber,
    required this.status,
    required this.doctorShedule,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      slotNumber: json['slotNumber'],
      status: json['status'],
      doctorShedule: DoctorShedule.fromJson(json['doctorShedule']),
    );
  }
}

class DoctorShedule {
  final String id;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final int slotDuration;
  final int totalSlots;
  final bool status;
  final Doctor doctor;
  final Speciality speciality;
  final ConsultingRoom consultingRoom;

  DoctorShedule({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.totalSlots,
    required this.status,
    required this.doctor,
    required this.speciality,
    required this.consultingRoom,
  });

  factory DoctorShedule.fromJson(Map<String, dynamic> json) {
    return DoctorShedule(
      id: json['id'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      slotDuration: json['slotDuration'],
      totalSlots: json['totalSlots'],
      status: json['status'],
      doctor: Doctor.fromJson(json['doctor']),
      speciality: Speciality.fromJson(json['speciality']),
      consultingRoom: ConsultingRoom.fromJson(json['consultingRoom']),
    );
  }
}

class Doctor {
  final String id;
  final String code;
  final User user;

  Doctor({
    required this.id,
    required this.code,
    required this.user,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      code: json['code'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String userType;
  final bool enabled;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userType,
    required this.enabled,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      userType: json['userType'],
      enabled: json['enabled'],
    );
  }
}

class Speciality {
  final String id;
  final String name;

  Speciality({
    required this.id,
    required this.name,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ConsultingRoom {
  final String id;
  final String roomName;
  final String roomLocation;

  ConsultingRoom({
    required this.id,
    required this.roomName,
    required this.roomLocation,
  });

  factory ConsultingRoom.fromJson(Map<String, dynamic> json) {
    return ConsultingRoom(
      id: json['id'],
      roomName: json['roomName'],
      roomLocation: json['roomLocation'],
    );
  }
}
