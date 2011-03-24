module ITunes
  class Track
    def initialize(library, properties)
      @library    = library
      @properties = properties
    end

    def to_hash
      @properties
    end

    def [](key)
      @properties[key]
    end

    def id
      self['Track ID']
    end

    def name
      self['Name']
    end

    def artist
      self['Artist']
    end

    def album
      self['Album']
    end

    def date_added
      self['Date Added']
    end

    def play_count
      self['Play Count'] || 0
    end

    def total_time
      self['Total Time'] / 1000
    end

    def kind
      self['Kind']
    end

    def audio?
      !video?
    end

    def video?
      self['Has Video'] || false
    end

    def movie?
      self['Movie'] || false
    end

    def podcast?
      self['Podcast'] || false
    end

    def audiobook?
      kind =~ /Audible/ ? true : false
    end

    def unplayed?
      self['Unplayed'] == true || play_count == 0
    end

    def played?
      !unplayed?
    end

    def inspect
      "#<#{self.class.name} name=#{name.inspect}>"
    end
  end
end
