require 'rails_helper'

describe ReviewsHelper, :type => :helper do
	context '#star_rating' do
		it 'does nothing for NAN' do
			expect(helper.star_rating('N/A')).to eq 'N/A'
		end

		it 'returns five black stars for rating of five' do
			expect(helper.star_rating(5)).to eq '★★★★★'
		end

		it 'returns 3 black stars and 2 white stars when given rating of 3' do
			expect(helper.star_rating(3)).to eq '★★★☆☆'
		end

		it 'returns four black stars and one white star when given rating of 3.5' do
			expect(helper.star_rating(3.5)).to eq '★★★★☆'
		end
	end
end