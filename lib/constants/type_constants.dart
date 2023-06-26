// TYPE
enum CommonBtnRoundedSize {
  small,
  medium,
}

enum CommonBtnStyle {
  outline,
  yellowBg,
  grayBg,
}

/// This has nothing to to with the video's file type. It's just the place
/// from which the video is fetched from.
enum VideoSourceType {
  /// The video was included in the app's assets files.
  asset,

  /// The video was fetched from the internet.
  network,

  /// The video was fetched from the device's local storage.
  file,

  /// The video is available via contentUri. Android only.
  contentUri,
}
