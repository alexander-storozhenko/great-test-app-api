require 'rails_helper'

describe API::Profile::UserData do
  context 'when admin' do
    let(:path) {'/api/v1/profile/user_data'
}
    it 'test' do
        get path,
            headers: { 'Access-Token': access_token}
      expect(response.status).to eq 200
    end
  end
end