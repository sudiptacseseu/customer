class UserInfo {
  late String message;
  late int code;
  late List<Customers> customers;

  UserInfo(
      {required this.message, required this.code, required this.customers});

  UserInfo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.customers != null) {
      data['customers'] = this.customers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  late int id;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? image;
  String? note;

  Customers(
      {required this.id,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.image,
      this.note});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = (json['name'] != null ? json['name'] : null);
    phone = (json['phone'] != null ? json['phone'] : null);
    email = (json['email'] != null ? json['email'] : null);
    address = (json['address'] != null ? json['address'] : null);
    image = (json['image'] != null ? json['image'] : null);
    note = (json['note'] != null ? json['note'] : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['image'] = this.image;
    data['note'] = this.note;
    return data;
  }
}
