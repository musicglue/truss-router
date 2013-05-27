require 'truss/router/routeset'
require 'truss/router/node'

describe Truss::Router::Routeset do
    it { should respond_to(:nodes) }
    it { should respond_to(:nodes_for) }
    it { should respond_to(:add_node) }
    it { should respond_to(:total_nodes) }
    it { subject.nodes.keys.sort.should eq(%w[GET HEAD OPTIONS PUT PATCH POST DELETE].sort) } 

    context "adding nodes" do
        let(:app)   { ->(env){[200, {'Content-Type' => 'text/plain'}, ["Hello World"]]} }
        let(:node)  { Truss::Router::Node.new(:get, "/home", app, {}) }
        before(:each) { subject.add_node(node) }

        it  { subject.nodes_for("GET").length.should eq(1) }
        it "can contain multiple nodes" do
            subject.add_node(node)
            subject.nodes_for("GET").length.should eq(2)
        end
    end
end
