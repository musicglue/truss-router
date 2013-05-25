require 'truss/router/routeset'
require 'truss/router/node'

describe Truss::Router::Routeset do
    it { should respond_to(:nodes) }
    it { should respond_to(:add_node) }

    context "adding nodes" do
        subject     { Truss::Router::Routeset.new }
        let(:app)   { ->(env){[200, {'Content-Type' => 'text/plain'}, ["Hello World"]]} }
        let(:node)  { Truss::Router::Node.new(:get, "/home", app, {}) }
        before(:each) { subject.add_node(node) }

        it  { subject.nodes.length.should eq(1) }
        it "can contain multiple nodes" do
            subject.add_node(node)
            subject.nodes.length.should eq(2)
        end
    end
end
