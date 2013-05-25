require 'truss/router/node'
require 'truss/router/routes/delete'

describe Truss::Router::Routes::Delete do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:delete) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
