require 'truss/router'

describe Truss::Router do
    let(:app) { ->(env){[200, {'Content-Type' => 'text/plain'}, ["Hello World"]]} }
    subject { described_class }
    before(:each) { subject.reset! } 
    it "requires a block to be passed to #draw" do
        expect {
            subject.draw
        }.to raise_error(ArgumentError)
    end

    context "drawing routes" do
        context "triggers the right route builder" do
            let(:map) { ->(m){ 
                    m.get("/home", app) 
                    m.post("/home", app)
                    m.put("/home", app)
                    m.patch("/home", app)
                    m.options("/home", app)
                    m.head("/home", app)
                    m.delete("/home", app)
                }  
            }

            it { subject.should_receive(:get).with("/home", app);        subject.draw(&map) }
            it { subject.should_receive(:post).with("/home", app);       subject.draw(&map) }
            it { subject.should_receive(:put).with("/home", app);        subject.draw(&map) }
            it { subject.should_receive(:patch).with("/home", app);      subject.draw(&map) }
            it { subject.should_receive(:head).with("/home", app);       subject.draw(&map) }
            it { subject.should_receive(:options).with("/home", app);    subject.draw(&map) }
            it { subject.should_receive(:delete).with("/home", app);     subject.draw(&map) }
        end

        context "populates the routeset" do
            let(:map) { ->(m){
                    m.get("/home", app)
                    m.post("/home", app)
                }
            }
            before(:each) do
                subject.draw(&map)
            end
            it "should have two route" do
                subject.routeset.total_nodes.should eq(3)
            end
            it "should have a Get routeset with one member" do
                subject.routeset.nodes_for("GET").length.should eq(1)
            end
            it "should have an Head routeset with one member" do
                subject.routeset.nodes_for("HEAD").length.should eq(1)
            end
            it "should have a Post routeset with one member" do
                subject.routeset.nodes_for("POST").length.should eq(1)
            end
        end
    end
end
