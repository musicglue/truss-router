require 'truss/router/request'

describe Truss::Router::Request do
    let(:env) { Rack::MockRequest.env_for("/home") }
    subject { described_class.new(env) }

    it { should be_kind_of(Rack::Request) }
    it { should respond_to(:routing_path) }
    it { should respond_to(:routing_params) }
    its(:routing_params) { should eq({}) }
end
