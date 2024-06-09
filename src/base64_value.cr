require "base64"

class Base64Value
  VERSION = "0.1.0"
  @base64 : LazyValue(String)
  @bytes : LazyValue(Bytes)
  @plain : LazyValue(String)

  protected def initialize(@base64, @bytes, @plain)
  end

  # parse base64 string to Base64Value
  #
  # ```
  # base64_value = Base64Value.parse("Y3J5c3RhbA==")
  # puts base64_value.to_s # => Y3J5c3RhbA==
  # ```
  #
  def self.parse(base64 : String) : Base64Value
    Base64Value.new(
      base64: LazyValue(String).create(base64),
      bytes: LazyValue(Bytes).create { Base64.decode(base64) },
      plain: LazyValue(String).create { Base64.decode_string(base64) }
    )
  end

  # create Base64Value from bytes
  #
  # ```
  # base64_value = Base64Value.from_bytes(UInt8.static_array(99, 114, 121, 115, 116, 97, 108).to_slice)
  # puts base64_value.to_s # => Y3J5c3RhbA==
  # ```
  #
  def self.from_bytes(bytes : Bytes, urlsafe : Bool = false) : Base64Value
    Base64Value.new(
      base64: LazyValue(String).create { urlsafe ? Base64.urlsafe_encode(bytes) : Base64.strict_encode(bytes) },
      bytes: LazyValue(Bytes).create(bytes),
      plain: LazyValue(String).create { String.new(bytes) }
    )
  end

  # create Base64Value from plain string
  #
  # ```
  # base64_value = Base64Value.from_plain("crystal")
  # puts base64_value.to_s # => Y3J5c3RhbA==
  # ```
  #
  def self.from_plain(plain : String, urlsafe : Bool = false) : Base64Value
    Base64Value.new(
      base64: LazyValue(String).create { urlsafe ? Base64.urlsafe_encode(plain.to_slice) : Base64.strict_encode(plain.to_slice) },
      bytes: LazyValue(Bytes).create { plain.to_slice },
      plain: LazyValue(String).create(plain)
    )
  end

  # to base64 string
  #
  # ```
  # base64_value = Base64Value.parse("Y3J5c3RhbA==")
  # puts base64_value.to_s # => Y3J5c3RhbA==
  # ```
  #
  def to_s : String
    @base64.get
  end

  # to bytes
  #
  # ```
  # base64_value = Base64Value.parse("Y3J5c3RhbA==")
  # puts base64_value.to_bytes # => Bytes[99, 114, 121, 115, 116, 97, 108]
  # ```
  #
  def to_bytes : Bytes
    @bytes.get
  end

  # to plain string
  #
  # ```
  # base64_value = Base64Value.parse("Y3J5c3RhbA==")
  # puts base64_value.to_plain # => crystal
  # ```
  #
  def to_plain : String
    @plain.get
  end
end

# :nodoc:
#
class LazyValue(T)
  @value : T?

  @loader : Proc(Nil, T)?

  @load_lock : Mutex = Mutex.new

  protected def initialize(@value : T? = nil, @loader : Proc(Nil, T)? = nil)
  end

  def self.create(value : T) : LazyValue(T) forall T
    LazyValue(T).new(value: value)
  end

  def self.create(&loader : Proc(Nil, T)) : LazyValue(T) forall T
    LazyValue(T).new(loader: loader)
  end

  def get : T
    if v = @value
      return v
    end

    @load_lock.synchronize do
      if v = @value
        return v
      end

      @value = v = @loader.not_nil!.call nil
      return v
    end
  end
end
