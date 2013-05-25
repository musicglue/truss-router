require 'truss/router/node'
require 'truss/router/routes/patch'

describe Truss::Router::Routes::Patch do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:patch) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
