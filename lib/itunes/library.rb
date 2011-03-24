require 'plist'

require 'itunes/playlist'
require 'itunes/track'

module ITunes
  class Library
    def self.load(file)
      new(Plist::parse_xml(file))
    end

    def initialize(properties)
      @properties = properties || {}
    end

    def [](key)
      @properties[key]
    end

    def playlists
      @playlists ||= self['Playlists'].map { |h| Playlist.new(self, h) }
    end

    def find_playlist(name)
      playlists.detect { |p| p.name == name }
    end

    def track_ids
      self['Tracks']
    end

    def fetch_track(id)
      Track.new(self, track_ids[id.to_s])
    end

    def tracks
      @tracks ||= self['Tracks'].values.map { |properties| Track.new(self, properties) }
    end

    def size
      track_ids.size
    end

    def inspect
      "#<#{self.class.name} size=#{size}>"
    end
  end
end
