// To parse this JSON data, do
//
//     final panSendModel = panSendModelFromJson(jsonString);

import 'dart:convert';

PanSendModel panSendModelFromJson(String str) =>
    PanSendModel.fromJson(json.decode(str));

String panSendModelToJson(PanSendModel data) => json.encode(data.toJson());

class PanSendModel {
  String? date;
  String? time;
  int? temperature;
  String? windowBlinds;
  bool? outdoorLights;
  bool? indoorLights;
  String? indoorLightInfo;
  String? poolTemperature;
  String? tubTemperature;
  String? musicGenre;
  String? flowerType;
  String? flowerLocation;
  String? groceryList;
  String? alcoholList;
  String? housekeepingDetails;
  String? transportationDetails;
  String? automobileDetails;
  String? specialRequests;
  String? userId;

  PanSendModel({
    this.date,
    this.time,
    this.temperature,
    this.windowBlinds,
    this.outdoorLights,
    this.indoorLights,
    this.indoorLightInfo,
    this.poolTemperature,
    this.tubTemperature,
    this.musicGenre,
    this.flowerType,
    this.flowerLocation,
    this.groceryList,
    this.alcoholList,
    this.housekeepingDetails,
    this.transportationDetails,
    this.automobileDetails,
    this.specialRequests,
    this.userId,
  });

  factory PanSendModel.fromJson(Map<String, dynamic> json) => PanSendModel(
        date: json["date"],
        time: json["time"],
        temperature: json["temperature"],
        windowBlinds: json["window_blinds"],
        outdoorLights: json["outdoor_lights"],
        indoorLights: json["indoor_lights"],
        indoorLightInfo: json["indoor_light_info"],
        poolTemperature: json["pool_temperature"],
        tubTemperature: json["tub_temperature"],
        musicGenre: json["music_genre"],
        flowerType: json["flower_type"],
        flowerLocation: json["flower_location"],
        groceryList: json["grocery_list"],
        alcoholList: json["alcohol_list"],
        housekeepingDetails: json["housekeeping_details"],
        transportationDetails: json["transportation_details"],
        automobileDetails: json["automobile_details"],
        specialRequests: json["special_requests"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "temperature": temperature,
        "window_blinds": windowBlinds,
        "outdoor_lights": outdoorLights,
        "indoor_lights": indoorLights,
        "indoor_light_info": indoorLightInfo,
        "pool_temperature": poolTemperature,
        "tub_temperature": tubTemperature,
        "music_genre": musicGenre,
        "flower_type": flowerType,
        "flower_location": flowerLocation,
        "grocery_list": groceryList,
        "alcohol_list": alcoholList,
        "housekeeping_details": housekeepingDetails,
        "transportation_details": transportationDetails,
        "automobile_details": automobileDetails,
        "special_requests": specialRequests,
        "user_id": userId,
      };
}
