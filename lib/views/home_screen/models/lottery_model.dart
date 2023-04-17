class ApiResult {
  bool? isSuccess;
  String? failReason;
  String? failReasonContent;
  int? totalRecords;
  int? storeID;
  int? userID;
  SuccessContents? successContents;
  String? suggestedContents;
  String? apIname;

  ApiResult(
      {this.isSuccess,
      this.failReason,
      this.failReasonContent,
      this.totalRecords,
      this.storeID,
      this.userID,
      this.successContents,
      this.suggestedContents,
      this.apIname});

  ApiResult.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    failReason = json['failReason'];
    failReasonContent = json['failReasonContent'];
    totalRecords = json['totalRecords'];
    storeID = json['storeID'];
    userID = json['userID'];
    successContents = json['successContents'] != null
        ? SuccessContents.fromJson(json['successContents'])
        : null;
    suggestedContents = json['suggestedContents'];
    apIname = json['apIname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['failReason'] = failReason;
    data['failReasonContent'] = failReasonContent;
    data['totalRecords'] = totalRecords;
    data['storeID'] = storeID;
    data['userID'] = userID;
    if (successContents != null) {
      data['successContents'] = successContents!.toJson();
    }
    data['suggestedContents'] = suggestedContents;
    data['apIname'] = apIname;
    return data;
  }
}

class SuccessContents {
  String? lotteryState;
  String? storeName;
  String? tvid;
  String? wideList;
  String? heightList;
  String? backGroundImage;
  List<Lotteries>? lotteries;

  SuccessContents(
      {this.lotteryState,
      this.storeName,
      this.tvid,
      this.wideList,
      this.heightList,
      this.backGroundImage,
      this.lotteries});

  SuccessContents.fromJson(Map<String, dynamic> json) {
    lotteryState = json['lotteryState'];
    storeName = json['storeName'];
    tvid = json['tvid'];
    wideList = json['wideList'];
    heightList = json['heightList'];
    backGroundImage = json['backGroundImage'];
    if (json['lotteries'] != null) {
      lotteries = <Lotteries>[];
      json['lotteries'].forEach((v) {
        lotteries!.add(Lotteries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lotteryState'] = lotteryState;
    data['storeName'] = storeName;
    data['tvid'] = tvid;
    data['wideList'] = wideList;
    data['heightList'] = heightList;
    data['backGroundImage'] = backGroundImage;
    if (lotteries != null) {
      data['lotteries'] = lotteries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lotteries {
  String? imageLink;
  String? lotteryName;
  String? lotterySequence;
  String? lotteryPrice;
  String? lotteryStartNumber;
  String? lotteryEndNumber;
  String? lotteryRemaining;
  String? lotteryPackSize;
  String? lotteryPackNumber;
  List<Remainings>? remainings;

  Lotteries(
      {this.imageLink,
      this.lotteryName,
      this.lotterySequence,
      this.lotteryPrice,
      this.lotteryStartNumber,
      this.lotteryEndNumber,
      this.lotteryRemaining,
      this.lotteryPackSize,
      this.lotteryPackNumber,
      this.remainings});

  Lotteries.fromJson(Map<String, dynamic> json) {
    imageLink = json['imageLink'];
    lotteryName = json['lotteryName'];
    lotterySequence = json['lotterySequence'];
    lotteryPrice = json['lotteryPrice'];
    lotteryStartNumber = json['lotteryStartNumber'];
    lotteryEndNumber = json['lotteryEndNumber'];
    lotteryRemaining = json['lotteryRemaining'];
    lotteryPackSize = json['lotteryPackSize'];
    lotteryPackNumber = json['lotteryPackNumber'];
    if (json['remainings'] != null) {
      remainings = <Remainings>[];
      json['remainings'].forEach((v) {
        remainings!.add(Remainings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageLink'] = imageLink;
    data['lotteryName'] = lotteryName;
    data['lotterySequence'] = lotterySequence;
    data['lotteryPrice'] = lotteryPrice;
    data['lotteryStartNumber'] = lotteryStartNumber;
    data['lotteryEndNumber'] = lotteryEndNumber;
    data['lotteryRemaining'] = lotteryRemaining;
    data['lotteryPackSize'] = lotteryPackSize;
    data['lotteryPackNumber'] = lotteryPackNumber;
    if (remainings != null) {
      data['remainings'] = remainings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Remainings {
  String? amount;
  String? issued;
  String? claimed;
  String? remaining;

  Remainings({this.amount, this.issued, this.claimed, this.remaining});

  Remainings.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    issued = json['issued'];
    claimed = json['claimed'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['issued'] = issued;
    data['claimed'] = claimed;
    data['remaining'] = remaining;
    return data;
  }
}

class LotteryModel {
  int? remainingTickets;
  String? ticketAmount;
  String? ticketNo;
  String? image;

  LotteryModel(
      {this.remainingTickets, this.ticketAmount, this.ticketNo, this.image});

  LotteryModel.fromJson(Map<String, dynamic> json) {
    remainingTickets = json['remainingTickets'];
    ticketAmount = json['ticketAmount'];
    ticketNo = json['ticketNo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remainingTickets'] = remainingTickets;
    data['ticketAmount'] = ticketAmount;
    data['image'] = image;

    return data;
  }
}
