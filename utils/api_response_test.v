module utils

fn test_response_is_error() {
	res := response[string](false,"some err")
	assert res.is_error == true
	assert res.result == "some err"
}

fn test_response_is_not_error() {
	res := response[int](true,42)
	assert res.is_error == false
	assert res.result == 42
}