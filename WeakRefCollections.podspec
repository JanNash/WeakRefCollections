
Pod::Spec.new do |s|
  s.name         = "WeakRefCollections"
  s.version      = "0.2.0"
  s.summary      = "A lightweight ensemble of nifty Swift Collections that support weak references to their elements."
  s.description  = <<-DESC
                   Unfortunately, Swift does not (yet?) have built-in (native) Collections (As in 'the Collection protocol'
                   -> Arrays, Sets, Dictionaries) that support weak references to their elements. Sure, there's NSMapTable
                   and NSHashTable. Have you ever tried to work with these? for-in iteration? Nope. .forEach()? Nope.
                   Nifty functional programming with higher order functions like .map(), .reduce() and .filter()? Nope.

                   By using .allObjects or resorting to NSEnumerators, you can achieve these functionalities, too, you might say...
                   But you're using Swift now. You don't want to have to do that, do you? You want lightweight, readable syntax,
                   no annoying hacks and workarounds. Maybe you're even writing a server application, so you don't want to have
                   to import Foundation.

                   This framework is (will be) a humble attempt to provide Collections that properly support weak references
                   to their elements. Not only a pseudo-Set (NSHashTable) and a convoluted Dictionary (NSMapTable).
                   An Array, a Set, a Dictionary, a bidirectional Dictionary and the protocol-conformances one would
                   expect from those types.
                   DESC

  s.homepage     = "https://github.com/JanNash/WeakRefCollections"
  s.license      = "MIT"
  s.author             = { "Jan Nash" => "jnash@jnash.de" }
  s.social_media_url   = "http://twitter.com/JanPNash"

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/JanNash/WeakRefCollections.git", :tag => "v#{s.version}" }
  s.source_files  = "WeakRefCollections/Sources/**/*.swift"

end
