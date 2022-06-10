require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '内容に問題ない場合' do
      it 'nickname,email,passwordとpassword_confirmation,family_nameとfirst_name,kana_familyとkana_frst,date_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailには@が含まれていないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", 'Password は半角英数を両方含む必要があります')
      end
      it 'passwordは5文字以下では登録できない' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英数字混合でないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = '12345a'
        @user.password_confirmation = '12345b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '英字のみのpasswordでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'aaaaa１'
        @user.password_confirmation = 'aaaaa１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end
      it '姓（全角）が空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
      end
      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.family_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end
      it '名（全角）が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '姓（カナ）が空だと登録できない' do
        @user.kana_family = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family can't be blank", 'Kana family is invalid')
      end
      it '姓（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.kana_family = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family is invalid')
      end
      it '姓（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.kana_family = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family is invalid')
      end
      it '姓（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.kana_family = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family is invalid')
      end
      it '姓（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do
        @user.kana_family = '???'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family is invalid')
      end
      it '名（カナ）が空だと登録できない' do
        @user.kana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first can't be blank", 'Kana first is invalid')
      end
      it '名（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.kana_first = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first is invalid')
      end
      it '名（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.kana_first = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first is invalid')
      end
      it '名（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.kana_first = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first is invalid')
      end
      it '名（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do
        @user.kana_first = '???'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first is invalid')
      end
      it '生年月日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
