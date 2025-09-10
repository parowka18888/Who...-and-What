class GameEntity<T> {
  final T value;
  bool isSuspected;
  bool isSearched;
  bool isLocked;

  GameEntity({
    required this.value,
    this.isSuspected = true,
    this.isSearched = false,
    this.isLocked = false
  });
}
