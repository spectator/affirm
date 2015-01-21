require "affirm"
require "byebug"
require "json"

def to_seconds(datetime)
  Time.parse(datetime.to_s).to_i
end
