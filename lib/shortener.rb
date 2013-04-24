class Shortener
  def shorten(url)
    token = next_token
    urls[token] = url
    token
  end

  def expand(token)
    urls[token]
  end

  private

  def urls
    @urls ||= {}
  end

  def next_token
    encode_id(next_id)
  end

  def next_id
    id_generator.next
  end

  def id_generator
    @id_generator ||= (1..Float::INFINITY).enum_for
  end

  def encode_id(id)
    id.to_s(36)
  end
end
