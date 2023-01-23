module utils

struct ApiResponse[T] {
	is_error bool
	result T
}

pub fn response[T](ok bool, payload T) ApiResponse[T] {
	return ApiResponse[T] {
		is_error: !ok,
		result: payload
	}
}