class APIResponse{
  final String data;

  APIResponse({this.data});

  factory APIResponse.fromJson(final json){
    return APIResponse(
      data: json["data"]
    );
  }
}