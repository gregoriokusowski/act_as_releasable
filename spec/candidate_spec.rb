require 'spec_helper'

describe "the creation of a release candidate" do

  let (:phantoms) { create(:phantoms) }
  let (:jazz_all_stars) { create(:jazz_all_stars) }

  context "when dealing with simple data" do

    let (:new_name) { "Scooby-doo is around!" }

    before do
      phantoms.name = new_name
      phantoms.generate_new_candidate
    end

    it "doesn't update any original attribute" do
      phantoms.reload.name.should eq "Phantoms"
    end

    it "presents the changes on a transient model" do
      phantoms.release_candidate.name.should eq new_name
    end

  end

  context "when dealing with collections" do

    context "on removal" do

      before do
        first_player = jazz_all_stars.players.first
        first_player.mark_for_destruction
        jazz_all_stars.generate_new_candidate
      end

      it "keeps a entire new collection, so deleted data is kept for release candidate" do
        jazz_all_stars.release_candidate.should have(2).players
      end

      it "doesn't remove any item from database" do
        jazz_all_stars.reload.should have(3).players
      end

    end

    context "on addition" do

      before do
        phantoms.players.build attributes_for(:gasper)
        phantoms.generate_new_candidate
      end

      it "adds the items to the release canditate" do
        phantoms.release_candidate.should have(1).player
      end

      it "keeps approved items on the database record" do
        phantoms.reload.should have(:no).players
      end

    end

    context "on change" do

      before do
        jazz_all_stars.players.each do |player|
          player.name = "Mr. #{player.name}"
        end
        jazz_all_stars.generate_new_candidate
      end

      it "keeps non-released data on the database record" do
        Player.where("name like ?", 'Mr.%').should be_empty
      end

      it "makes all changes available on the release candidate" do
        jazz_all_stars.release_candidate.players.each do |player|
          player.name.should match /Mr\./
        end
      end

    end

  end

  describe "after creating a release candidate" do
    before { phantoms.tap{|p| p.name = "bla"}.generate_new_candidate }
    it { phantoms.should have_changes_to_be_approved }
  end

  describe "the calling of the release_candidate method" do
    it "should not clear any collection" do
      jazz_all_stars.players.build attributes_for(:gasper)
      jazz_all_stars.generate_new_candidate

      jazz_all_stars.release_candidate

      jazz_all_stars.reload.should have(3).players
    end
  end

end
