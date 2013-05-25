require 'truss/router/node'
require 'truss/router/routes/head'

describe Truss::Router::Routes::Head do
    subject { described_class.new("/home", String) }
    its(:request_method)    { should eq(:head) }
    its(:endpoint)          { should eq(String) }
    its(:path)              { should eq("/home") }
end
