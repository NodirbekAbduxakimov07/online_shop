

class GetCategoriesModel {
    GetCategoriesModel({
        this.success,
        this.data,
        this.message,
        this.errorCode,
    });

    bool? success;
    List<DatumCategory?>? data;
    String? message;
    int? errorCode;

    factory GetCategoriesModel.fromJson(Map<String, dynamic> json) => GetCategoriesModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<DatumCategory?>.from(json["data"]!.map((x) => DatumCategory.fromJson(x))),
        message: json["message"],
        errorCode: json["error_code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "message": message,
        "error_code": errorCode,
    };
}

class DatumCategory {
    DatumCategory({
        this.id,
        this.title,
        this.icon,
        this.parentId,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? icon;
    String? parentId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory DatumCategory.fromJson(Map<String, dynamic> json) => DatumCategory(
        id: json["id"],
        title: json["title"] ?? "",
        icon: json["icon"],
        parentId: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
