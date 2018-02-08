require 'models/double_hamburger'
require 'models/patty'
require 'models/cheese_slice'

RSpec.describe ErrorIndexer do
  #patties
  let!(:chicken_patty) { Patty.new(meat_type: :chicken) }
  let!(:beef_patty) { Patty.new(meat_type: :beef) }

  let!(:vegeterian_patty) { Patty.new(meat_type: :chickpea) }
  let!(:additional_vegeterian_patty) { Patty.new(meat_type: :chickpea) }

  #cheese slices
  let!(:camambert_slice) { CheeseSlice.new(cheese_type: :camambert) }
  let!(:feta) { CheeseSlice.new(cheese_type: :feta) }

  #burgers
  let!(:nice_burger) { DoubleHamburger.new(patties: [chicken_patty, beef_patty], cheese_slices: [camambert_slice, camambert_slice]) }
  let!(:vegeterian_burger) { DoubleHamburger.new(patties: [vegeterian_patty, additional_vegeterian_patty], cheese_slices: [camambert_slice]) }
  let!(:mixed_burger) { DoubleHamburger.new(patties: [chicken_patty, vegeterian_patty, beef_patty], cheese_slices: [camambert_slice]) }
  let!(:burger_with_feta_cheese) { DoubleHamburger.new(patties: [chicken_patty], cheese_slices: [feta, feta]) }

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

  it "doesnt index not markes for indexing associations" do
    expect(burger_with_feta_cheese.valid?).to be(false)
    expect(burger_with_feta_cheese.errors.count).to eq(1)

    expect(burger_with_feta_cheese.errors.messages.keys.map(&:to_s)).to match(
      [
        "cheese_slices.cheese_type"
      ]
    )
  end
end
