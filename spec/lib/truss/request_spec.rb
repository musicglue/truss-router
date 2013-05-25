require 'truss/router/request'

describe Truss::Router::Request do
    let(:env) { Rack::MockRequest.env_for("/home") }
    subject { described_class.new(env) }

    it { should be_kind_of(Rack::Request) }
end
