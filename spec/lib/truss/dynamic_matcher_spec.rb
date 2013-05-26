require 'truss/router'

describe Truss::Router do
    context "dynamic matchers instantiate routing_params in the request object" do
        subject { described_class }
        let(:app) { ->(env){ [200, {'Content-Type' => 'text/plain'}, [env.routing_params['id']]] } }
        let(:env) { Rack::MockRequest.env_for("/posts/9", method: "GET") }
        before :each do
            Truss::Router.reset!
            Truss::Router.draw do |r|
                r.get("/posts/:id", app)
            end
        end

        it "should return the id as the body of the request" do
            response = subject.call(env)
            response[2].first.should eq("9")
        end
    end
end
