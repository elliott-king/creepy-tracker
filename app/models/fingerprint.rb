require 'digest/sha1'

class Fingerprint < ApplicationRecord
  belongs_to :user 
  
  def serialize
    # TODO: rethink this
    s = "#{self.width}x#{self.height}x#{self.depth}"
    s += "#{self.user_agent}#{self.accept_headers}#{self.accept_encoding}#{self.accept_language}"
    s += "#{self.cookies_enabled.to_s}#{self.timezone}#{self.fonts}#{self.plugins}"
    return s
  end

  def hash
    Digest::SHA1.hexdigest(self.serialize)
  end

  def self.deserialize(s)
    puts "TODO: create new fingerprint from serialization."
  end
end
