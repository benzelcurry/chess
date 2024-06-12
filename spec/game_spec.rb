# TODOS:
# 1. Update tests for game win conditions with appropriate arguments
# 2. TBD

require './lib/game'

describe Game do
  describe '#game_over?' do
    context 'when a player has lost their queen' do
      xit 'returns game over' do
        expect(FIX_ME_test_conditions_here).to eq(true)
      end
    end

    context 'when both players still have their queens' do
      xit 'returns game not over' do
        expect(FIX_ME_test_conditions_here).to eq(false)
      end
    end
  end
end
