enum Status {
  LOADING,
  ERROR,
  SUCCESS,
}

class StateResponse<T> {
  Status status = Status.LOADING;
  String error = "";
  T? data;

  StateResponse.Loading()
      : status = Status.LOADING,
        error = "",
        data = null;

  StateResponse.Error(String errorMsg)
      : status = Status.ERROR,
        error = errorMsg,
        data = null;

  StateResponse.Success(T? bean)
      : status = Status.SUCCESS,
        error = "",
        data = bean;
}