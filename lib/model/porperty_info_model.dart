// To parse this JSON data, do
//
//     final propertyInformationResponse = propertyInformationResponseFromJson(jsonString);

import 'dart:convert';

PropertyInformationResponse propertyInformationResponseFromJson(String str) =>
    PropertyInformationResponse.fromJson(json.decode(str));

String propertyInformationResponseToJson(PropertyInformationResponse data) =>
    json.encode(data.toJson());

class PropertyInformationResponse {
  bool? success;
  String? message;
  Data? data;

  PropertyInformationResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PropertyInformationResponse.fromJson(Map<String, dynamic> json) =>
      PropertyInformationResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? address;
  String? sizeOfHome;
  String? numberOfStories;
  String? constructionType;
  String? hasPool;
  String? poolType;
  String? gatedCommunity;
  String? yearBuilt;
  String? impactWindows;
  String? hasHoa;
  String? gatedProperty;
  String? contactName;
  String? contactEmail;
  String? contactCell;
  String? preferredContactMethod;
  String? managerId;
  String? tenantIds;
  String? contactedIds;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Floor>? floors;
  Manager? manager;

  Data({
    this.id,
    this.address,
    this.sizeOfHome,
    this.numberOfStories,
    this.constructionType,
    this.hasPool,
    this.poolType,
    this.gatedCommunity,
    this.yearBuilt,
    this.impactWindows,
    this.hasHoa,
    this.gatedProperty,
    this.contactName,
    this.contactEmail,
    this.contactCell,
    this.preferredContactMethod,
    this.managerId,
    this.tenantIds,
    this.contactedIds,
    this.createdAt,
    this.updatedAt,
    this.floors,
    this.manager,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        address: json["address"],
        sizeOfHome: json["size_of_home"],
        numberOfStories: json["number_of_stories"],
        constructionType: json["construction_type"],
        hasPool: json["has_pool"],
        poolType: json["pool_type"],
        gatedCommunity: json["gated_community"],
        yearBuilt: json["year_built"],
        impactWindows: json["impact_windows"],
        hasHoa: json["has_hoa"],
        gatedProperty: json["gated_property"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactCell: json["contact_cell"],
        preferredContactMethod: json["preferred_contact_method"],
        managerId: json["manager_id"],
        tenantIds: json["tenant_ids"],
        contactedIds: json["contacted_ids"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        floors: json["floors"] == null
            ? []
            : List<Floor>.from(json["floors"]!.map((x) => Floor.fromJson(x))),
        manager:
            json["manager"] == null ? null : Manager.fromJson(json["manager"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "size_of_home": sizeOfHome,
        "number_of_stories": numberOfStories,
        "construction_type": constructionType,
        "has_pool": hasPool,
        "pool_type": poolType,
        "gated_community": gatedCommunity,
        "year_built": yearBuilt,
        "impact_windows": impactWindows,
        "has_hoa": hasHoa,
        "gated_property": gatedProperty,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_cell": contactCell,
        "preferred_contact_method": preferredContactMethod,
        "manager_id": managerId,
        "tenant_ids": tenantIds,
        "contacted_ids": contactedIds,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "floors": floors == null
            ? []
            : List<dynamic>.from(floors!.map((x) => x.toJson())),
        "manager": manager?.toJson(),
      };
}

class Floor {
  int? id;
  String? floorName;
  String? floorImage;
  String? propertyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Room>? rooms;

  Floor({
    this.id,
    this.floorName,
    this.floorImage,
    this.propertyId,
    this.createdAt,
    this.updatedAt,
    this.rooms,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        id: json["id"],
        floorName: json["floor_name"],
        floorImage: json["floor_image"],
        propertyId: json["property_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rooms: json["rooms"] == null
            ? []
            : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor_name": floorName,
        "floor_image": floorImage,
        "property_id": propertyId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rooms": rooms == null
            ? []
            : List<dynamic>.from(rooms!.map((x) => x.toJson())),
      };
}

class Room {
  int? id;
  String? roomName;
  String? propertyId;
  String? floorId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Room({
    this.id,
    this.roomName,
    this.propertyId,
    this.floorId,
    this.createdAt,
    this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        roomName: json["room_name"],
        propertyId: json["property_id"],
        floorId: json["floor_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_name": roomName,
        "property_id": propertyId,
        "floor_id": floorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Manager {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? phoneNumber;
  String? city;
  String? address;
  dynamic note;
  dynamic title;
  dynamic emailVerifiedAt;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Manager({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.phoneNumber,
    this.city,
    this.address,
    this.note,
    this.title,
    this.emailVerifiedAt,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        city: json["city"],
        address: json["address"],
        note: json["note"],
        title: json["title"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone_number": phoneNumber,
        "city": city,
        "address": address,
        "note": note,
        "title": title,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
