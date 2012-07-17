require 'spec_helper'

describe "the release of a candidate" do

  let (:phantoms) { create(:phantoms) }
  let (:jazz_all_stars) { create(:jazz_all_stars) }

  let (:new_name) { "Phantoms All-Stars" }

  it "updates" do
    phantoms.name = new_name
    phantoms.generate_new_candidate

    phantoms.reload.name.should_not == new_name
    phantoms.release_version!
    phantoms.reload.name.should == new_name
  end

  it "add items" do
    phantoms.players.build attributes_for(:gasper)
    phantoms.generate_new_candidate

    expect do
      phantoms.release_version!
    end.to change(Player, :count).by(1)
  end

  it "remove items" do
    jazz_all_stars.players.first.mark_for_destruction
    jazz_all_stars.generate_new_candidate

    expect do
      jazz_all_stars.release_version!
    end.to change(Player, :count).by(-1)
  end

  it "updates items" do
    captain = jazz_all_stars.players.first
    original_name = captain.name
    captain_name = "Captain #{original_name}"
    captain.name = captain_name
    jazz_all_stars.generate_new_candidate

    captain.reload.name.should == original_name
    jazz_all_stars.release_version!
    released_captain = jazz_all_stars.reload.players.detect { |player| player.name.starts_with? 'Captain' }
    released_captain.name.should == captain_name
  end

end
