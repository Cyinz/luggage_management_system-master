class Order {
  String orderid;
  String savername;
  String saverphonenumber;
  String recievername;
  String luggagehotel;
  String luggagedecribe;
  String luggagesavetime;
  String luggagesaveforetime;
  String luggagegettime;
  int messagesendstate;
  String luggagegetcode;
  int luggageistoken;

  Order(
      {this.orderid,
      this.savername,
      this.saverphonenumber,
      this.recievername,
      this.luggagehotel,
      this.luggagedecribe,
      this.luggagesavetime,
      this.luggagesaveforetime,
      this.luggagegettime,
      this.messagesendstate,
      this.luggagegetcode,
      this.luggageistoken});

  Order.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    savername = json['savername'];
    saverphonenumber = json['saverphonenumber'];
    recievername = json['recievername'];
    luggagehotel = json['luggagehotel'];
    luggagedecribe = json['luggagedecribe'];
    luggagesavetime = json['luggagesavetime'];
    luggagesaveforetime = json['luggagesaveforetime'];
    luggagegettime = json['luggagegettime'];
    messagesendstate = json['messagesendstate'];
    luggagegetcode = json['luggagegetcode'];
    luggageistoken = json['luggageistoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['savername'] = this.savername;
    data['saverphonenumber'] = this.saverphonenumber;
    data['recievername'] = this.recievername;
    data['luggagehotel'] = this.luggagehotel;
    data['luggagedecribe'] = this.luggagedecribe;
    data['luggagesavetime'] = this.luggagesavetime;
    data['luggagesaveforetime'] = this.luggagesaveforetime;
    data['luggagegettime'] = this.luggagegettime;
    data['messagesendstate'] = this.messagesendstate;
    data['luggagegetcode'] = this.luggagegetcode;
    data['luggageistoken'] = this.luggageistoken;

    return data;
  }
}
