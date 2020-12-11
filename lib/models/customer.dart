class CustomerModel {
  String email, firstname, lastname, password;

  CustomerModel({this.email, this.firstname, this.lastname, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'email': this.email,
      'first_name': this.firstname,
      'last_name': this.lastname,
      'password': this.password
    });

    return map;
  }
}
