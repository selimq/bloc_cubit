abstract class CatsState {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompleted extends CatsState {
  final List<String> response;
  const CatsCompleted(this.response);
}

class CatsError extends CatsState {
  final String message;
  const CatsError(this.message);
}
