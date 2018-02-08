require 'models/double_hamburger'
require 'models/patty'

RSpec.describe ErrorIndexer do
  #patties
  let!(:chicken_patty) { Patty.new(meat_type: :chicken) }
  let!(:beef_patty) { Patty.new(meat_type: :beef) }

  let!(:vegeterian_patty) { Patty.new(meat_type: :chickpea) }
  let!(:additional_vegeterian_patty) { Patty.new(meat_type: :chickpea) }

  #burgers
  let!(:nice_burger) { DoubleHamburger.new(patties: [chicken_patty, beef_patty]) }
  let!(:vegeterian_burger) { DoubleHamburger.new(patties: [vegeterian_patty, additional_vegeterian_patty]) }
  let!(:mixed_burger) { DoubleHamburger.new(patties: [chicken_patty, vegeterian_patty, beef_patty]) }

  it "has a version number" do
    expect(ErrorIndexer::VERSION).not_to be nil
  end

  it "index errors for nested models" do
    expect(nice_burger.valid?).to be(true)

    expect(vegeterian_burger.valid?).to be(false)
    expect(vegeterian_burger.errors.count).to eq(2)

    expect(vegeterian_burger.errors.messages.keys.map(&:to_s)).to match(
      [
        "patties.0.meat_type",
        "patties.1.meat_type"
      ]
    )
  end

  it "puts correct indexes on error messages for nested models" do
    expect(mixed_burger.valid?).to be(false)
    expect(mixed_burger.errors.count).to eq(1)

    expect(mixed_burger.errors.messages.keys.map(&:to_s)).to match(
      [
        "patties.1.meat_type"
      ]
    )
  end
end
