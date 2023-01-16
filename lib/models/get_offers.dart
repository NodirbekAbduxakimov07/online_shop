

// class GetOfferModel {
//     GetOfferModel({
//         this.success,
//         this.data,
//         this.message,
//         this.errorCode,
//     });

//     bool? success;
//     List<Datum?>? data;
//     String? message;
//     int? errorCode;

//     factory GetOfferModel.fromJson(Map<String, dynamic> json) => GetOfferModel(
//         success: json["success"],
//         data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         message: json["message"],
//         errorCode: json["error_code"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
//         "message": message,
//         "error_code": errorCode,
//     };
// }

// class Datum {
//     Datum({
//         this.id,
//         this.image,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int? id;
//     String? image;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         image: json["image"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }


// To parse this JSON data, do
//
//     final getOfferModel = getOfferModelFromJson(jsonString);

// import 'dart:convert';

// GetOfferModel getOfferModelFromJson(String str) => GetOfferModel.fromJson(json.decode(str));

// String getOfferModelToJson(GetOfferModel data) => json.encode(data.toJson());

class GetOfferModel {
    GetOfferModel({
        this.success,
        this.data,
        this.message,
        this.errorCode,
    });

    bool? success;
    List<Datum>? data;
    String? message;
    int? errorCode;

    factory GetOfferModel.fromJson(Map<String, dynamic> json) => GetOfferModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        errorCode: json["error_code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "error_code": errorCode,
    };
}

class Datum {
    Datum({
        this.id,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
