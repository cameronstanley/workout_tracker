require 'rails_helper'

RSpec.feature 'User creates workout' do
  given!(:user) do
    create(
      :user, 
      first_name: 'Will', 
      last_name: 'Barrow', 
      email: 'wbarrow@example.com', 
      password: 'Password'
    ) 
  end

  background do
    log_in_user('wbarrow@example.com', 'Password')
  end

  scenario 'successfully' do
    expect(current_path).to eq(dashboard_path)
    click_link 'Workouts'

    expect(current_path).to eq(workouts_path)
    click_button 'New Workout'

    fill_in 'workout[name]', with: 'New Workout'
    click_button 'Start Workout'

    workout = Workout.last
    expect(current_path).to eq(edit_workout_path(workout))
    expect(page).to have_text('Workout was successfully created.')
    expect(workout.user).to eq(user)
    expect(workout.name).to eq('New Workout')
  end
end
