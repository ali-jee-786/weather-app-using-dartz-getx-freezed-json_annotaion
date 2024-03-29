import 'package:freezed_annotation/freezed_annotation.dart';
part 'errors.freezed.dart';

@freezed
class FetchError with _$FetchError{
  const factory FetchError.NetworkError() = _NetworkError;
}
