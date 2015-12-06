require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid API key' do
      it 'should call Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid API' do
      before :each do
        allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)
        allow(Tmdb::Api).to receive(:response).and_return({'code' => 401})
      end  
      it 'should raise an InvalidKeyError with no API key' do
        expect { Movie.find_in_tmdb('Inception') }.to raise_error(Movie::InvalidKeyError)
      end
    end
  end
  describe 'searching by one movies director' do
    before :each do
      FactoryGirl.create(:movie, :title => 'ThX-1138', :rating => 'R', :director => "George Lucas")
      FactoryGirl.create(:movie, :title => 'Star Wars', :rating => 'PG', :director => "George Lucas")
      FactoryGirl.create(:movie, :title => 'Blade Runner', :rating => 'PG', :director => "Ridley Scott")
      FactoryGirl.create(:movie, :title => 'Alien', :rating => 'R', :director => "")
    end 
    it 'should find movies by the same director' do
      expect(Movie.where(director: "George Lucas").length).to eq(2)
      Movie.find_with_same_director(1)
    end
    it 'should not find movies by different directors' do
      Movie.where(director: "George Lucas").each { |movie|
        expect(movie.director).to_not eq("Ridley Scott")
        expect(movie.director).to_not eq("")
      }
      Movie.find_with_same_director(1)
    end
  end
end
