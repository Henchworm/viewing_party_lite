require 'rails_helper'
RSpec.describe 'the user show(dashboard) page' do
  let!(:user_1) { User.create!(name: 'George Washington', email: 'george@csu.edu') }
  let!(:party_1) do
    Party.create!(movie_id: 1, date: Time.new(2022, 2, 1), duration: 120, start_time: Time.new(2022, 2, 1, 10, 30, 2))
  end
  let!(:party_2) do
    Party.create!(movie_id: 1, date: Time.new(2022, 2, 1), duration: 50, start_time: Time.new(2022, 2, 1, 10, 30, 2),
                  host_id: user_1.id)
  end
  let!(:user_party_1) { UserParty.create!(user_id: user_1.id, party_id: party_1.id) }
  let!(:user_party_2) { UserParty.create!(user_id: user_1.id, party_id: party_2.id) }

  it "displays the user's dashboard" do
    visit "/users/#{user_1.id}"
    expect(page).to have_content("George Washington's Dashboard")
  end

  it 'has a button to discover movies' do
    visit "/users/#{user_1.id}"

    click_button('Discover Movies')
    expect(current_path).to eq("/users/#{user_1.id}/discover")
  end

  it 'has all the details of the party the user is invited to' do
    visit "/users/#{user_1.id}"

    within('#invited') do
      expect(page).to have_content('Date: 02/01/2022')
      expect(page).to have_content('Duration: 120')
      expect(page).to have_content('Start Time: 05:30 PM')
    end
  end

  it 'shows the parties where the user is a host' do
    visit "/users/#{user_1.id}"

    within('#hosting') do
      expect(page).to have_content('Date: 02/01/2022')
      expect(page).to have_content('Duration: 50')
      expect(page).to have_content('Start Time: 05:30 PM')
    end
  end
end
