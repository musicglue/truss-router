require 'truss/router/node'
require 'truss/router/routes/put'

describe Truss::Router::Routes::Put do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:put) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
