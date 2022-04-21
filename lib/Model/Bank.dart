class BankInfo {
  int ?id;
  String ?code;
  String ?name;


  BankInfo(
      {this.name,
        this.id,
        this.code,
        });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "code": code,
      "id": id,
    };
  }

  factory BankInfo.fromJson(jsonData) => BankInfo(
      name: jsonData["name"],
      id: jsonData["id"],
    code: jsonData["code"],
     );

}



class BankInfoUser {
  int ?id;
  String ?bankname;
  String ?accountnumber;
  String ?accountname;
  String ?code;


  BankInfoUser(
      {this.bankname,
        this.id,
        this.accountnumber,
        this.accountname,
        this.code,
      });

  Map<String, dynamic> toJson() {
    return {
      "bankname": bankname,
      'id': id,
      "accountnumber": accountnumber,
      "accountname": accountname,
      "code":code,
    };
  }

  factory BankInfoUser.fromJson(jsonData) => BankInfoUser(
    bankname: jsonData["bankname"],
    accountnumber: jsonData["accountnumber"],
    id: jsonData['id'],
    accountname: jsonData["accountname"],
      code: jsonData['code'],
  );

}
