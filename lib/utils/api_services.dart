import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({
    required this.baseUrl,
    this.defaultHeaders = const {},
  });

  // Common HTTP request handler
  Future<dynamic> request({
    required String method,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    print("Api url:- $baseUrl");
    print("defaultHeaders:- $defaultHeaders");
    print("header:- $headers");
    print("encoded body:- $body");
    final uri = Uri.parse(baseUrl);
    final combinedHeaders = {...defaultHeaders, if (headers != null) ...headers};

    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: combinedHeaders);
          break;
        case 'POST':
          response = await http.post(uri, headers: combinedHeaders, body: _encodeBody(body));
          break;
        case 'PUT':
          response = await http.put(uri, headers: combinedHeaders, body: _encodeBody(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: combinedHeaders);
          break;
        default:
          throw UnsupportedError('HTTP method $method is not supported.');
      }

      return _handleResponse(response);
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  // GET request
  Future<dynamic> get({Map<String, String>? headers}) {
    return request(method: 'GET', headers: headers);
  }

  // POST request
  Future<dynamic> post({Map<String, String>? headers, dynamic body}) {
    return request(method: 'POST', headers: headers, body: body);
  }

  // PUT request
  Future<dynamic> put({Map<String, String>? headers, dynamic body}) {
    return request(method: 'PUT', headers: headers, body: body);
  }

  // DELETE request
  Future<dynamic> delete({Map<String, String>? headers}) {
    return request(method: 'DELETE', headers: headers);
  }

  // Helper to encode request body
  String? _encodeBody(dynamic body) {
    if (body == null) return null;
    return jsonEncode(body);
  }


  // Multipart request handler
  Future<dynamic> multipartRequest({
    required Map<String, String> fields,
    required List<Map<String, dynamic>> files, // Each file is a map with keys: fieldName, filePath
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl);
    final combinedHeaders = {...defaultHeaders, if (headers != null) ...headers};
    var request = http.MultipartRequest('POST', uri)..headers.addAll(combinedHeaders);

    // Add fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Add files
    for (var file in files) {
      final filePath = file['filePath'] as String;
      final fieldName = file['fieldName'] as String;
      request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      return _handleMultipartResponse(response.statusCode, responseBody);
    } catch (e) {
      throw Exception('Multipart request failed: $e');
    }
  }



  // Handle HTTP responses
  dynamic _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    print("statusCode:- $statusCode");
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.body}');
    }
  }

// Handle multipart responses
  dynamic _handleMultipartResponse(int statusCode, String responseBody) {
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(responseBody);
    } else {
      throw Exception('Error: $responseBody');
    }
  }
}


/*
  void fetchItems() async {
    final apiService = ApiService(
      baseUrl: ApiList.demo,
      defaultHeaders: ApiList.simpleheader,
    );
    try {
      // final data = await apiService.get();
      final data = await ApiService(baseUrl: ApiList.demo, defaultHeaders: ApiList.simpleheader).get();
      print('Fetched Items: $data');
    } catch (e) {
      print('Error: $e');
    }
  }

  void uploadFile() async {
    final apiService = ApiService(
      baseUrl: ApiList.demo,
      defaultHeaders: ApiList.simpleheader,
    );
    try {
      final response = await apiService.multipartRequest(
        fields: {
          'userId': '123',
          'description': 'A sample file upload',
        },
        files: [
          {
            'fieldName': 'file', // Name of the field in the API
            'filePath': '/path/to/your/file.png', // Path to the file
          },
        ],
      );

      print('Upload successful: $response');
    } catch (e) {
      print('Error: $e');
    }
  }*/