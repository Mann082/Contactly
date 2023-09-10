class Contact {
  final String id;
  final String name;
  final String mobileNum;
  String? groupId;
  String? email;
  String? profession;
  String? dob;
  String? address;
  String? city;
  String? pincode;
  String? gender;
  String? relation;
  String? allGroupsName = "";

  Contact({
    required this.id,
    required this.name,
    required this.mobileNum,
    this.groupId,
    this.email,
    this.profession,
    this.dob,
    this.address,
    this.city,
    this.gender,
    this.pincode,
    this.relation,
  });

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> m = Map();
    m['id'] = id;
    m['name'] = name;
    m['mobileNum'] = mobileNum;
    m['groupId'] = groupId;
    m['email'] = email;
    m['profession'] = profession;
    m['dob'] = dob;
    m['address'] = address;
    m['city'] = city;
    m['gender'] = gender;
    m['pincode'] = pincode;
    m['relation'] = relation;
    return m;
  }

  List<String?> toList() {
    return [
      id,
      mobileNum,
      name,
      null,
      email,
      profession,
      relation,
      dob,
      address,
      city,
      pincode,
      gender,
    ];
  }
}

class ContactList {
  List<Contact> items = [];

  ContactList(this.items);

  List<Map<String, dynamic>> toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
