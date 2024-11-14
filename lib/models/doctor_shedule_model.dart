class DoctorSchedule {
  final String id; // IDs son String en GraphQL
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final int slotDuration;
  final List<int> reservedSlots;
  final bool status;
  final Doctor doctor;
  final Speciality speciality;
  final ConsultingRoom consultingRoom;

  DoctorSchedule({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.reservedSlots,
    required this.status,
    required this.doctor,
    required this.speciality,
    required this.consultingRoom,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      id: json['id'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      slotDuration: json['slotDuration'],
      reservedSlots: List<int>.from(json['reservedSlots'] ?? []),
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

  Speciality({required this.id, required this.name});

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
