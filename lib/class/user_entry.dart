class user_entry {
  String? id;
  String? date;
  String? particular;
  String? amount;
  String? type;
  String? clId;

  user_entry(
      {this.id, this.date, this.particular, this.amount, this.type, this.clId});

  user_entry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    particular = json['particular'];
    amount = json['amount'];
    type = json['type'];
    clId = json['cl_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['particular'] = this.particular;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['cl_id'] = this.clId;
    return data;
  }

  @override
  String toString() {
    return 'user_entry{id: $id, date: $date, particular: $particular, amount: $amount, type: $type, clId: $clId}';
  }
}