require 'truss/router/node'

describe Truss::Router::Node do
    let(:app)   { ->(env){ [200, {'Content-Type' => 'text/plain'}, ["Hello World"]] } }
    subject     { Truss::Router::Node.new(:get, "/home", app) }
    it { should respond_to(:request_method) }
    it { should respond_to(:endpoint) }
    it { should respond_to(:path) }
    it { should respond_to(:matches?) }
    it { should respond_to(:options) }
    it { should respond_to(:matchable_regex) }
    it { should respond_to(:call) }

    describe "routing regexes" do
        context "for get requests" do
            subject { Truss::Router::Node.new(:get, "/home", app) }
            its(:matchable_regex) { should eq(/\A(GET|HEAD|OPTIONS)\/home\Z/) }
        end

        context "for post requests" do
            subject { Truss::Router::Node.new(:post, "/home", app) }
            its(:matchable_regex) { should eq(/\A(POST|OPTIONS)\/home\Z/) }
        end

        context "for put requests" do
            subject { Truss::Router::Node.new(:put, "/home", app) }
            its(:matchable_regex) { should eq(/\A(PUT|OPTIONS)\/home\Z/) }
        end
        
        context "for patch requests" do
            subject { Truss::Router::Node.new(:patch, "/home", app) }
            its(:matchable_regex) { should eq(/\A(PATCH|OPTIONS)\/home\Z/) }
        end
        
        context "for head requests" do
            subject { Truss::Router::Node.new(:head, "/home", app) }
            its(:matchable_regex) { should eq(/\A(HEAD|OPTIONS)\/home\Z/) }
        end
        
        context "for options requests" do
            subject { Truss::Router::Node.new(:options, "/home", app) }
            its(:matchable_regex) { should eq(/\AOPTIONS\/home\Z/) }
        end
        
        context "for delete requests" do
            subject { Truss::Router::Node.new(:delete, "/home", app) }
            its(:matchable_regex) { should eq(/\A(DELETE|OPTIONS)\/home\Z/) }
        end
    
    end
end
