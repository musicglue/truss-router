require 'truss/router'

describe Truss::Router do
    let(:app) { ->(env){ [200, {'Content-Type' => 'text/plain'}, ["Hello World"]] } }
    let(:map) { ->(r){ r.get("/home", app) } }
    let(:env) { Rack::MockRequest.env_for("/home", method: "GET") }
    subject   { described_class.routeset }
    context "single route dispatch" do
        before(:each) do
            described_class.reset!
            described_class.draw(&map)
        end

        it "should interrogate the routeset when called" do
            subject.should_receive(:find_route).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(env)
        end

        it "should return the first route for a matching path" do
            subject[0].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(env)
        end

        it "should return 404 response for no matching routes" do
            bad_env = Rack::MockRequest.env_for("/noroute", method: "PATCH")
            described_class.call(bad_env)[0].should be(404)
        end
    end

    context "multiple routes present" do
        let(:multiple_map) { ->(r){
                r.get("/", app)
                r.get("/home", app)
                r.get("/about", app)
                r.post("/login", app)
                r.post("/home", app)
            }
        }

        before(:each) do
            described_class.reset!
            described_class.draw(&multiple_map)
        end

        it "should call the second node given a get request for /home" do
            subject[1].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(env)
        end

        it "should call the third node given a get request for /about" do
            about_env = Rack::MockRequest.env_for("/about", method: "GET")
            subject[2].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(about_env)
        end

        it "should call the fourth node given a post request for /login" do
            login_env = Rack::MockRequest.env_for("/login", method: "POST")
            subject[3].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(login_env)
        end

        it "should call the fifth node given a post request for /home" do
            post_home_env = Rack::MockRequest.env_for("/home", method: "POST")
            subject[4].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(post_home_env)
        end

        it "should call the second node given an options request for /home" do
            options_home_env = Rack::MockRequest.env_for("/home", method: "OPTIONS")
            subject[1].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(options_home_env)
        end

        it "should call the second node given a head request for /home" do
            head_home_env = Rack::MockRequest.env_for("/home", method: "HEAD")
            subject[1].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(head_home_env)
        end

        it "should call the fourth node given an options request for /login" do
            options_login_env = Rack::MockRequest.env_for("/login", method: "OPTIONS")
            subject[3].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(options_login_env)
        end

        it "should call the first node given a get request for /" do
            home_env = Rack::MockRequest.env_for("/", method: "GET")
            subject[0].should_receive(:call).exactly(1).times.with(kind_of(Truss::Router::Request))
            described_class.call(home_env)
        end

        it "should return a 404 response if the route doesn't match" do
            missing_env = Rack::MockRequest.env_for("/noroutehere", method: "GET")
            described_class.call(missing_env)[0].should be(404)
        end
    end
end
