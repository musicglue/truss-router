require 'truss/router'

describe Truss::Router do
    let(:app) { ->(env){[200, {'Content-Type' => 'text/plain'}, ["Hello World"]]} }
    it { described_class.should respond_to(:draw) }
    it { should respond_to(:get) }
    it { should respond_to(:post) }
    it { should respond_to(:put) }
    it { should respond_to(:head) }
    it { should respond_to(:options) }
    it { should respond_to(:patch) }
    it { should respond_to(:delete) }
    it { should respond_to(:reset!) }
    its(:routeset) { should be_kind_of(Truss::Router::Routeset) }

    it { should respond_to(:call) }

    it "builds a Get route when #get is called" do
        described_class.should_receive(:build_node).with(:Get, "/home", app, {})
        described_class.get("/home", app)
    end

    it "builds a Post route when #post is called" do
        described_class.should_receive(:build_node).with(:Post, "/home", app, {})
        described_class.post("/home", app)
    end

    it "builds a Put route when #put is called" do
        described_class.should_receive(:build_node).with(:Put, "/home", app, {})
        described_class.put("/home", app)
    end

    it "builds a Patch route when #patch is called" do
        described_class.should_receive(:build_node).with(:Patch, "/home", app, {})
        described_class.patch("/home", app)
    end

    it "builds a Head route when #head is called" do
        described_class.should_receive(:build_node).with(:Head, "/home", app, {})
        described_class.head("/home", app)
    end

    it "builds a Options route when #options is called" do
        described_class.should_receive(:build_node).with(:Options, "/home", app, {})
        described_class.options("/home", app)
    end

    it "builds a Delete route when #delete is called" do
        described_class.should_receive(:build_node).with(:Delete, "/home", app, {})
        described_class.delete("/home", app)
    end
end
