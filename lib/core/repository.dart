import 'package:http_client_helper/http_client_helper.dart';
import 'package:http/http.dart' as http;

abstract class Enum<T> {
  const Enum(this._value);
  final T _value;

  T get value => _value;

  @override
  String toString() => 'Enum(${T.runtimeType})> value: $value';
}

class HttpMethod extends Enum<String> {
  const HttpMethod._(String val) : super(val);

  static const HttpMethod GET = HttpMethod._('GET');
  static const HttpMethod POST = HttpMethod._('POST');
  static const HttpMethod PUT = HttpMethod._('PUT');
  static const HttpMethod PATCH = HttpMethod._('PATCH');
  static const HttpMethod DELETE = HttpMethod._('DELETE');
  static const HttpMethod FILE = HttpMethod._('FILE');
}

class Repository {
  Repository._();
  static final Repository instance = Repository._();
  final Duration timeout = const Duration(seconds: 30);

  Future<Response?> request({
    required String path,
    required HttpMethod? method,
    Uri? uri,
    CancellationToken? cancellationToken,
    Object? requestPayload,
  }) async {
    // Uri url = path;
    // ?? Uri.parse(<String>[basePath!, path].join('/'))
    CancellationToken token = cancellationToken ?? CancellationToken();
    try {
      Response? response;
      switch (method!.value) {
        case 'GET':
          response = await _get(Uri.parse(path), token);
          break;
        case 'POST':
          response = await _post(Uri.parse(path), token, body: requestPayload);
          break;
        // case 'PUT':
        //   response = await _put(url, token, body: requestPayload);
        //   break;
        // case 'PATCH':
        //   response = await _patch(url, token, body: requestPayload);
        //   break;
        // case 'DELETE':
        //   response = await _delete(url, token, body: requestPayload);
        //   break;
        // case 'FILE':
        //   response = await _file(url, token, file!);
        //   break;
        default:
          throw UnimplementedError();
      }
      // if (response!.statusCode >= 400) {
      //   throw RepositoryException(
      //     response.body,
      //     path: uri.toString(),
      //     verb: method,
      //     statusCode: response.statusCode,
      //   );
      // }
      return response;
    } on Exception catch (e) {
      print(e);
      // if (e is RepositoryException && e.isBearerError && onExpiredToken != null) {
      //   onExpiredToken!();
      // }
      rethrow;
    }
  }

  Future<Response?> _get(
    Uri url,
    CancellationToken cancellationToken,
  ) async {
    try {
      return (await HttpClientHelper.get(
        url,
        cancelToken: cancellationToken,
        timeLimit: timeout,
        headers: _headers,
      ));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Response?> _post(
    Uri url,
    CancellationToken cancellationToken, {
    Object? body,
  }) async {
    try {
      return await HttpClientHelper.post(
        url,
        // body: formatJson(body),
        body: body,
        cancelToken: cancellationToken,
        timeLimit: timeout,
        headers: _headers,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Map<String, String> get _headers => <String, String>{
        'Accept': 'application/json',
        'ContentType': 'application/json',
      };
}
