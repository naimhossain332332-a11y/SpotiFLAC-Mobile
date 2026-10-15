import 'package:spotiflac_android/models/track.dart';

/// Bridges "track loved" events from the library collections layer to online
/// playback. When online playback streams a track from a temporary download,
/// loving that track should keep it as a permanent download instead of letting
/// the temporary cache evict it later.
///
/// The playback controller owns the policy (which tracks are actually part of
/// the online queue) and registers a handler here; the collections provider
/// only reports that a track was added to the loved list.
class OnlinePlaybackKeep {
  OnlinePlaybackKeep._();

  static final OnlinePlaybackKeep instance = OnlinePlaybackKeep._();

  void Function(Track track)? _onLoved;

  /// Registered by the playback controller. `null` disables the bridge.
  void register(void Function(Track track)? handler) => _onLoved = handler;

  /// Reports a track that was just added to the loved list.
  void notifyLoved(Track track) => _onLoved?.call(track);
}
