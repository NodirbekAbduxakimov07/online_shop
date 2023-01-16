

class GetTopProductsModel {
    GetTopProductsModel({
        this.success,
        this.data,
        this.message,
        this.errorCode,
    });

    bool? success;
    List<DatumTopProducts?>? data;
    String? message;
    int? errorCode;

    factory GetTopProductsModel.fromJson(Map<String, dynamic> json) => GetTopProductsModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<DatumTopProducts?>.from(json["data"]!.map((x) => DatumTopProducts.fromJson(x))),
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

class DatumTopProducts {
    DatumTopProducts({
        this.id,
        this.name,
        this.price,
        this.image,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    String? price;
    String? image;
    String? categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory DatumTopProducts.fromJson(Map<String, dynamic> json) => DatumTopProducts(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
