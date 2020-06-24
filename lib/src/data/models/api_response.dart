enum Status {
  COMPLETED,
  ERROR,
}

class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status: $status with message $message\nData: $data';
  }
}
