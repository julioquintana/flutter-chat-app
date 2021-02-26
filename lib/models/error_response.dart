import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.ok,
    this.errors,
  });

  bool ok;
  List<Error> errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        ok: json["ok"],
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.msg,
  });

  String msg;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
