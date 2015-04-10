class Shortener
  Token = String
  Url = String

  Contract nil => Shortener
  def self.instance
    @instance ||= new
  end

  Contract Url => Token
  def shorten(url)
    token = next_token
    urls[token] = url
    token
  end

  Contract Token => Maybe[Url]
  def expand(token)
    urls[token]
  end

  private

  Contract nil => HashOf[Token, Url]
  def urls
    @urls ||= {}
  end

  Contract nil => Token
  def next_token
    encode_id(next_id)
  end

  Contract nil => Pos
  def next_id
    id_generator.next
  end

  Contract nil => Enumerator
  def id_generator
    @id_generator ||= (1..Float::INFINITY).enum_for
  end

  Contract Pos => String
  def encode_id(id)
    id.to_s(36)
  end
end
