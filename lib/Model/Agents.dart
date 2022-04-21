class Agents {
String ?distance;
String ?fullname;
String ?longitude;
String ?latitude;
String ?phonenumber;
String ?address;
String ?id;
String ?image;




Agents(
    {this.fullname,
      this.distance,
      this.address,
      this.longitude,
      this.image,
      this.phonenumber,
      this.latitude,
      this.id,
    });

Map<String, dynamic> toJson() {
  return {
    "fullname": fullname,
    "id": id,
    'image': image,
    'distance': distance,
    'address':address,
    "longitude": longitude,
    "latitude": latitude,
    'phonenumber': phonenumber,
  };
}

factory Agents.fromJson(jsonData) => Agents(
  fullname: jsonData["fullname"],
  distance: jsonData["distance"],
  longitude: jsonData['longitude'],
  image: jsonData['image'],
  phonenumber: jsonData['phonenumber'],
  latitude: jsonData["latitude"],
    address: jsonData['address'],
  id: jsonData['id'],
);

}
