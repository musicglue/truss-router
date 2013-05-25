require 'truss/router/node'

describe Truss::Router::Node do
    subject { Truss::Router::Node.new(:get, "/home", "Class") }
    it { should respond_to(:request_method) }
    it { should respond_to(:endpoint) }
    it { should respond_to(:path) }
    it { should respond_to(:matches?) }
end
