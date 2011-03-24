# encoding: UTF-8

require 'itunes/library'

require 'test/unit'

class TestITunes < Test::Unit::TestCase
  include ITunes

  def test_size
    assert_equal 111, library.size
  end

  def test_library_inspect
    assert_equal "#<ITunes::Library size=111>", library.inspect
  end

  def test_playlists
    assert_equal [
      "Library",
      "Music",
      "Movies",
      "Podcasts",
      "Books",
      "Genius",
      "90’s Music",
      "Classical Music",
      "Music Videos",
      "My Top Rated",
      "Recently Added",
      "Recently Played",
      "Top 25 Most Played"
    ], library.playlists.map(&:name)
  end

  def test_playlist_name
    assert_equal "Movies", library.movies.name
  end

  def test_playlist_item_ids
    assert_equal [10981, 11075, 11061, 11068], library.movies.item_ids
  end

  def test_playlist_item_names
    assert_equal ["Casino Royale", "The Dark Knight", "Iron Man", "Ocean's Eleven"], library.movies.items.map(&:name)
  end

  def test_playlist_inspect
    assert_equal "#<ITunes::Playlist name=\"Movies\" size=4>", library.movies.inspect
  end

  def test_track_id
    assert_equal 7944, library.fetch_track(7944).id
  end

  def test_track_artist
    assert_equal "Them Crooked Vultures", library.fetch_track(7944).artist
  end

  def test_track_album
    assert_equal "Them Crooked Vultures", library.fetch_track(7944).album
  end

  def test_track_play_count
    assert_equal 0, library.fetch_track(7944).play_count
  end

  def test_track_unplayed
    assert_equal true, library.fetch_track(7944).unplayed?
  end

  def test_track_date_added
    assert_equal "2010-04-24T13:24:25+00:00", library.fetch_track(7944).date_added.to_s
  end

  def test_audio_track_total_time
    assert_equal 246, library.fetch_track(7944).total_time
  end

  def test_video_track_total_time
    assert_equal 9130, library.fetch_track(11075).total_time
  end

  def test_audiobook_total_time
    assert_equal 27852, library.fetch_track(10999).total_time
  end

  def test_audio_track_kind
    track = library.fetch_track(7944)
    assert_equal "Mind Eraser, No Chaser", track.name
    assert_equal "MPEG audio file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
  end

  def test_movie_track_kind
    track = library.fetch_track(11075)
    assert_equal "The Dark Knight", track.name
    assert_equal "MPEG-4 video file", track.kind
    assert_equal false, track.audio?
    assert_equal true, track.video?
    assert_equal true, track.movie?
    assert_equal false, track.podcast?
  end

  def test_audio_podcast_track_kind
    track = library.fetch_track(9879)
    assert_equal "New High-Viscosity Mayo To Aid In American Swallowing", track.name
    assert_equal "MPEG audio file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
    assert_equal false, track.movie?
    assert_equal true, track.podcast?
  end

  def test_video_podcast_track_kind
    track = library.fetch_track(9889)
    assert_equal "TEDTalks : Omar Ahmad: Political change with pen and paper - Omar Ahmad (2010)", track.name
    assert_equal "MPEG-4 video file", track.kind
    assert_equal false, track.audio?
    assert_equal true, track.video?
    assert_equal true, track.movie?
    assert_equal true, track.podcast?
  end

  def test_audiobook_track_kind
    track = library.fetch_track(10999)
    assert_equal "Blink: The Power of Thinking Without Thinking (Unabridged)", track.name
    assert_equal "Audible file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
    assert_equal false, track.movie?
    assert_equal false, track.podcast?
    assert_equal true, track.audiobook?
  end

  def test_movie_unplayed
    assert_equal true, library.fetch_track(11075).unplayed?
    assert_equal false, library.fetch_track(11068).unplayed?
  end

  def test_movie_played
    assert_equal false, library.fetch_track(11075).played?
    assert_equal true, library.fetch_track(11068).played?
  end

  def test_track_inspect
    assert_equal "#<ITunes::Track name=\"Mind Eraser, No Chaser\">", library.fetch_track(7944).inspect
  end

  private
    def library
      @@library ||= load_library
    end

    def load_library
      Library.load(File.expand_path('../fixtures/iTunes Library.xml', __FILE__))
    end
end
