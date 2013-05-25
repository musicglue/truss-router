require 'truss/router/node'
require 'truss/router/routes/options'

describe Truss::Router::Routes::Options do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:options) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
