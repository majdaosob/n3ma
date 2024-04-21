class FoodItem {
  var key, name, quantity, expiry;

  FoodItem.fromJson(json) {
    name = json["name"];
    quantity = json["quantity"];
    expiry = json["expiry"];
  }

  String? get category => null;
}