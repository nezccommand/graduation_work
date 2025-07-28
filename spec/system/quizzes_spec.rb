require 'rails_helper'

RSpec.describe "基本的なクイズ機能", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "クイズの選択と進行" do
    before do
      create_list(:quiz, 10, genre: "基本知識", difficulty: "easy")
    end

    def start_quiz
      visit "/quizzes/select"
      choose "genre_0", visible: :all
      choose "difficulty_0", visible: :all
      click_button "クイズスタート"
    end

    it "ジャンルと難易度を選び、クイズに進める" do
      start_quiz

      expect(page).to have_content("第 1 問")
      expect(page).to have_selector("form[action='#{answer_quiz_path(id: 1)}']")
    end

    it "1問に答えて次の問題へ進める" do
      start_quiz

      first("input[name='selected_choice']", visible: false).choose
      click_button "回答して次へ"

      expect(page).to have_content("第 2 問")
    end

    it "ブラウザをリロードしても同じ問題が表示される" do
      start_quiz

      expect(page).to have_content("第 1 問")

      visit current_path

      expect(page).to have_content("第 1 問")
    end

    it "戻るボタンを押すと前の問題に戻れる" do
      start_quiz

      first("input[name='selected_choice']", visible: false).choose
      click_button "回答して次へ"
      expect(page).to have_content("第 2 問")

      expect(page).to have_link("前の問題に戻る", href: quiz_path(1))
      click_link "前の問題に戻る"

      expect(page).to have_content("第 1 問")
    end

    it "10問すべてに答えると結果画面に遷移する" do
      start_quiz

      10.times do |i|
        expect(page).to have_content("第 #{i + 1} 問")

        first("input[name='selected_choice']", visible: false).choose

        if i == 9
          click_button "結果を確認する"
        else
          click_button "回答して次へ"
        end
      end

      expect(page).to have_current_path("/quizzes/result")
      expect(page).to have_content("結果発表")
    end
  end

  describe "ログインユーザーのクイズ履歴とバッジ付与" do
    let!(:badge) { create(:badge, difficulty: "easy", genre: "基本知識") }
    let!(:quizzes) { create_list(:quiz, 10, genre: "基本知識", difficulty: "easy") }

    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      visit "/quizzes/select"
      choose "genre_0", visible: :all
      choose "difficulty_0", visible: :all
      click_button "クイズスタート"
    end

    it "クイズ回答後にQuizHistoryが作成される" do
      10.times do |i|
        first("input[name='selected_choice']", visible: false).choose
        if i == 9
          click_button "結果を確認する"
        else
          click_button "回答して次へ"
        end
      end

      @user.reload

      expect(@user.quiz_histories.count).to eq 1
      history = @user.quiz_histories.last
      expect(history.difficulty).to eq "easy"
      expect(history.genre).to eq "基本知識"
      expect(history.total_count).to eq 10
    end

    it "全問正解の場合にバッジが付与される" do
      quizzes.each_with_index do |quiz, i|
        correct_choice_id = quiz.choices.find_by(is_correct: true).id
        find("input[value='#{correct_choice_id}']", visible: false).choose
        if i == 9
          click_button "結果を確認する"
        else
          click_button "回答して次へ"
        end
      end

      user_badge = UserBadge.find_by(user: user, badge: badge)
      expect(user_badge).not_to be_nil
      expect(user_badge.rank).to eq "gold"
    end
  end
end

