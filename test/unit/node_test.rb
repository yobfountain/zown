require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "it should calculate the correct time for a single capture" do
    game = Game.create!
    node = Node.create! :game => game
    runner1 = Runner.create! :mobile_number => '1234567890'
    runner1.join_game_auto_assign_team!
    runner2 = Runner.create! :mobile_number => '1234567899'
    runner2.join_game_auto_assign_team!
    game.start!
    
    runner1.capture node
    Timecop.travel(Time.now + 1.minute)
    runner2.capture node

    times = node.cumulative_times
    assert_in_delta 1.minute, times[runner1.current_team], 1.second
    assert_equal 0.minutes, times[runner2.current_team]
  end
end
