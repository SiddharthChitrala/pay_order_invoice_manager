abstract class BaseApiServices {
  // GET API Request
  Future<dynamic> getGetApiResponse(String url, {Map<String, String>? headers});

  // POST API Request (create)
  Future<dynamic> getPostApiResponse(String url, dynamic data, {Map<String, String>? headers});

  // PUT or PATCH API Request (update)
  Future<dynamic> getUpdateApiResponse(String url, dynamic data, {Map<String, String>? headers});

  // DELETE API Request
  Future<dynamic> getDeleteApiResponse(String url, {Map<String, String>? headers});
}