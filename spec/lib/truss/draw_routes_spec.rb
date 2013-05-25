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
                subject.routeset.length.should eq(2)
            end
            it "should have a Get route as the first member of the routeset" do
                subject.routeset[0].should be_kind_of(Truss::Router::Routes::Get)
            end
            it "should have a Post route as the second member of the routeset" do
                subject.routeset[1].should be_kind_of(Truss::Router::Routes::Post)
            end
        end
    end
end
