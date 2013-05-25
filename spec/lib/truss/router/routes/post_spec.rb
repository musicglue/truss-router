require 'truss/router/node'
require 'truss/router/routes/post'

describe Truss::Router::Routes::Post do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:post) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
