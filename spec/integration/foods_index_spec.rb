require 'rails_helper'

RSpec.describe User, type: :system do
    before do
        sign_in users(:biruk)
        @food = foods(:one)
    end

    test "should get index" do
        get foods_path
        assert_response :success
    end
end