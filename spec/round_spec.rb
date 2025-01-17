require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'


RSpec.describe Round do
  before :each do
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end

  it 'exists' do
    expect(@round).to be_instance_of(Round)
  end

  it 'returns current turns/guesses' do
    expect(@round.turns).to eq([])
  end

  it "returns the current card" do
    expect(@round.current_card).to be_a(Card)
  end

  it "returns new_turn.class as Turn and if correct" do
    @new_turn = @round.take_turn("Juneau")
    expect(@new_turn.class).to eq(Turn)
    expect(@new_turn.correct?).to eq(true)
  end

  it "returns the turns" do
    @new_turn = @round.take_turn("Juneau")
    expect(@round.turns.count).to eq(1)
  end

  it "returns the number correct so far" do
    @new_turn = @round.take_turn("Juneau")
    expect(@round.number_correct).to eq(1)
  end

  it "returns current number of turns" do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")
    expect(@round.turns.count).to eq(2)
  end

  it "returns last feedback" do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")
    expect(@round.turns.last.feedback).to eq("Incorrect.")
  end

  it "returns number correct by category" do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")
    expect(@round.number_correct_by_category(:Geography)).to eq(1)
    expect(@round.number_correct_by_category(:STEM)).to eq(0)
  end

  it "returns percentage correct" do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")
    expect(@round.percent_correct).to eq(33)
    expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
  end

end
