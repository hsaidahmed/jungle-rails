require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'should save a new user successfully' do

      @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

      @user.save!

      expect(@user).to be_valid

    end

    it 'should confirm password and password confirmation are the same' do

      @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: '4321')

      @user.save

      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

    end

    it 'should only save emails that are unique' do

      @user1 = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')
      @user1.save!

      @user2 = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

      @user2.save

      expect(@user2).not_to be_valid 

    end

    it 'should only save users with password mini mum length of 5 characters' do

      @user1 = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: '4321', password_confirmation: '4321')

      @user1.save

      expect(@user1).not_to be_valid 

    end
 end

describe '.authenticate_with_credentials' do

  it 'should log in user if correct credentials' do
    @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

    @user.save

    user = User.authenticate_with_credentials("lhl@gmail.com", "lhllhl")
    expect(user).to be == @user 

  end

  it 'should not log in user if incorrect credientials' do

    @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

    @user.save

    user = User.authenticate_with_credentials("lhl@gmail.com", "4321")
    expect(user).not_to be == @user 

  end

  it 'should still allow authentication if spaces before or after email' do
    @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

    @user.save

    user = User.authenticate_with_credentials(" lhl@gmail.com ", "lhllhl")
    expect(user).to be == @user 


  end

  it 'should still allow authentication if wrong case is used for correct email' do
    @user = User.new(first_name: 'Mr', last_name:'Sir', email: 'lhl@gmail.com', password: 'lhllhl', password_confirmation: 'lhllhl')

    @user.save

    user = User.authenticate_with_credentials(" lhl@GMAIL.com ", "lhllhl")
    expect(user).to be == @user 


  end


end


end 