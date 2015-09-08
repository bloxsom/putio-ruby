module Helpers
  def fixture(name)
    File.read(File.dirname(__FILE__) + '/fixtures/' + name)
  end
end
