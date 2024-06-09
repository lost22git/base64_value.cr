require "./spec_helper"

describe Base64Value do
  it "parse / to_s" do
    base64_value = Base64Value.parse "Y3J5c3RhbA=="
    base64_value.to_s.should eq "Y3J5c3RhbA=="
  end

  it "from_bytes" do
    base64_value = Base64Value.from_bytes(UInt8.static_array(99, 114, 121, 115, 116, 97, 108).to_slice)
    base64_value.to_s.should eq "Y3J5c3RhbA=="
  end

  it "from plain" do
    base64_value = Base64Value.from_plain("crystal")
    base64_value.to_s.should eq "Y3J5c3RhbA=="
  end

  it "to bytes" do
    base64_value = Base64Value.parse "Y3J5c3RhbA=="
    base64_value.to_bytes.should eq UInt8.static_array(99, 114, 121, 115, 116, 97, 108).to_slice
  end

  it "to plain" do
    base64_value = Base64Value.parse "Y3J5c3RhbA=="
    base64_value.to_plain.should eq "crystal"
  end
end
