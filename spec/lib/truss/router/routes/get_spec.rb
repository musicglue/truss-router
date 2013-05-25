require 'truss/router/node'
require 'truss/router/routes/get'

describe Truss::Router::Routes::Get do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:get) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
