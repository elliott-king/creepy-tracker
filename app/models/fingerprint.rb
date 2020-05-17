require 'digest/sha1'

class Fingerprint < ApplicationRecord
  belongs_to :user 
  
  def serialize
    # TODO: think of some dividers to make it easier to deserialize if necessary
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

  def self.FINGERPRINT_IDENTIFIERS
    ["video", "timezone", "user_agent", "accept_headers_full", "cookies_enabled", "plugins",
      "fonts"]
  end

  def video
    "#{self.width}x#{self.height}x#{self.depth}"
  end

  def accept_headers_full
    "#{self.accept_headers} #{self.accept_language} #{self.accept_encoding}"
  end

  # See section 5.2 of "How Unique Is Your Web Browser?" white paper by EFF & Peter Eckersley
  def guess_other_fingerprint
    candidates = []

    Fingerprint.all.each do |fingerprint|
      if fingerprint != self
        Fingerprint.FINGERPRINT_IDENTIFIERS.each do |identifier_to_omit|
          almost_all_identical = true
          Fingerprint.FINGERPRINT_IDENTIFIERS.each do |identifier|
            if identifier != identifier_to_omit && self.send(identifier) != fingerprint.send(identifier)
              almost_all_identical = false
              break
            end
          end
          if almost_all_identical
            candidates << {match: fingerprint, changed_identifier: identifier_to_omit}
          end
        end
      end
    end
    
    if candidates.size == 1
      changed_identifier = candidates[0][:changed_identifier]
      # TODO: add supercookies
      if ["cookies_enabled", "video", "timezone"].include?(changed_identifier)
        return candidates[0][:match]
      else
        # On the pdf, they check ratio < .85, but I think that is accidentaly backwards...?
        # Note that ratio == 1.0 indicates an exact match
        changed_value = candidates[0][:match].send(changed_identifier)
        if Fingerprint.ratio(self.send(changed_identifier), changed_value) > 0.85
          return candidates[0][:match]
        end
      end
    end
    return nil
  end

  # Adapted from Python difflib.SequenceMatcher
  # https://github.com/python/cpython/blob/3.8/Lib/difflib.py#L446
  def self.ratio(a, b)
    if a.size + b.size == 0
      return 1.0
    end
    return (2 * matching_blocks(a, b).sum { |block| block[2]}).to_f / (a.size + b.size).to_f
  end

  def self.matching_blocks(a, b)
    la, lb = a.size - 1, b.size - 1
    queue = [[0, la, 0, lb]]
    matching_blocks = []

    while queue.size > 0
      alo, ahi, blo, bhi = queue.pop
      i, j, n = longest_match(a[alo .. ahi], b[blo .. bhi])
      i += alo 
      j += blo
      if n > 0
        matching_blocks << [i,j,n]
        if alo < i && blo < j
          queue. << [alo, i - 1, blo, j - 1]
        end
        if (i + n) <= ahi && (j + n) <= bhi
          queue.append([i + n, ahi, j + n, bhi])
        end
      end
    end
    matching_blocks.sort_by { |block| block[0] }
    return matching_blocks
  end

  # stolen from https://gist.github.com/Joseph-N/fbf061aa2347ed2c104f0b3fe1a5b9f2
  # Return [i, j, n] such that s1[i .. i+n] == s2[j .. j+n]
  def self.longest_match(s1, s2)
    if (s1 == "" || s2 == "")
      return [0,0,0]
    end
    m = Array.new(s1.length){ [0] * s2.length }
    longest_length, longest_end_s1, longest_end_s2 = 0,0,0
    (0 .. s1.length - 1).each do |x|
      (0 .. s2.length - 1).each do |y|
        if s1[x] == s2[y]
          m[x][y] = 1
          if (x > 0 && y > 0)
            m[x][y] += m[x-1][y-1]
          end
          if m[x][y] > longest_length
            longest_length = m[x][y]
            longest_end_s1 = x
            longest_end_s2 = y
          end
        end
      end
    end
    if longest_length == 0
      return [0,0,0]
    end
    return [longest_end_s1 - longest_length + 1, longest_end_s2 - longest_length + 1, longest_length]
  end
end
