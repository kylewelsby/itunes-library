Gem::Specification.new do |s|
  s.name      = 'itunes-library'
  s.version   = '0.1.0'
  s.date      = '2011-03-24'

  s.homepage    = "https://github.com/josh/itunes-library"
  s.summary     = "Wrapper around iTunes Library.xml"
  s.description = <<-EOS
    A Ruby library that makes it easy to dig around your iTunes Library metadata.
  EOS

  s.files = [
    'lib/itunes/library.rb',
    'lib/itunes/playlist.rb',
    'lib/itunes/track.rb',
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'plist'

  s.authors = ["Joshua Peek"]
  s.email   = "josh@joshpeek.com"
end
