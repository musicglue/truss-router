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

    describe "routing constraints" do
        context "for get requests" do
            subject { Truss::Router::Node.new(:get, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[GET HEAD]) }
        end

        context "for post requests" do
            subject { Truss::Router::Node.new(:post, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[POST]) }
        end

        context "for put requests" do
            subject { Truss::Router::Node.new(:put, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[PUT]) }
        end
        
        context "for patch requests" do
            subject { Truss::Router::Node.new(:patch, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[PATCH]) }
        end
        
        context "for head requests" do
            subject { Truss::Router::Node.new(:head, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[HEAD]) }
        end
        
        context "for options requests" do
            subject { Truss::Router::Node.new(:options, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[OPTIONS]) }
        end
        
        context "for delete requests" do
            subject { Truss::Router::Node.new(:delete, "/home", app) }
            its(:matchable_regex) { should eq(%r[\A/home\Z]) }
            its(:path_segments)   { should eq(1) }
            its(:allowed_methods) { should eq(%w[DELETE]) }
        end
    end

    describe "dynamic segments" do
        context "single dynamic matcher" do
            subject { Truss::Router::Node.new(:delete, "/:id", app) }
            it { subject.matchable_regex.to_s.should eq(/\A\/(?<id>[\w\-]+)\Z/.to_s) }
        end
        
        context "multiple dynamic matchers" do
            subject { Truss::Router::Node.new(:delete, "/posts/:post_id/comments/:id", app) }
            it { subject.matchable_regex.to_s.should eq(/\A\/posts\/(?<post_id>[\w\-]+)\/comments\/(?<id>[\w\-]+)\Z/.to_s) }
        end
   end
end
