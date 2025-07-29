require 'rails_helper'

RSpec.describe "基本的なクイズ機能", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "クイズの選択と進行" do
    before do
      create_list(:quiz, 10, genre: "基本知識", difficulty: "easy")
      visit "/quizzes/select"
      choose "genre_0", visible: :all
      choose "difficulty_0", visible: :all
      click_button "クイズスタート"
    end

    it "ジャンルと難易度を選び、クイズに進める" do
      expect(page).to have_content("第 1 問")
      expect(page).to have_selector("form[action='#{answer_quiz_path(id: 1)}']")
    end

    it "1問に答えて次の問題へ進める" do
      first("input[name='selected_choice']", visible: false).choose
      click_button "回答して次へ"

      expect(page).to have_content("第 2 問")
    end

    it "ブラウザをリロードしても同じ問題が表示される" do
      expect(page).to have_content("第 1 問")

      visit current_path

      expect(page).to have_content("第 1 問")
    end

    it "戻るボタンを押すと前の問題に戻れる" do
      first("input[name='selected_choice']", visible: false).choose
      click_button "回答して次へ"
      expect(page).to have_content("第 2 問")

      expect(page).to have_link("前の問題に戻る", href: quiz_path(1))
      click_link "前の問題に戻る"

      expect(page).to have_content("第 1 問")
    end

    it "10問すべてに答えると結果画面に遷移する" do
      10.times do |i|
        expect(page).to have_content("第 #{i + 1} 問")

        first("input[name='selected_choice']", visible: false).choose
        click_button(i == 9 ? "結果を確認する" : "回答して次へ")
      end

      expect(page).to have_current_path("/quizzes/result")
      expect(page).to have_content("結果発表")
    end

    it "全問不正解の場合に結果画面に0問正解と表示される" do
      10.times do |i|
        expect(page).to have_content("第 #{i + 1} 問")

        first("input[name='selected_choice']", visible: false).choose
        click_button(i == 9 ? "結果を確認する" : "回答して次へ")
      end
      
      expect(page).to have_content("10問中 0問 正解しました！")
    end

    it "一部正解・一部不正解の場合に正答数が正しく表示される" do
      10.times do |i|
        expect(page).to have_content("第 #{i + 1} 問")

        if i < 5
          first("input[name='selected_choice']", visible: false).choose
        else
          all("input[name='selected_choice']", visible: false).last.choose
        end
        click_button(i == 9 ? "結果を確認する" : "回答して次へ")
      end

      expect(page).to have_current_path("/quizzes/result")
      expect(page).to have_content("結果発表")
      expect(page).to have_content("10問中 5問 正解しました！")
    end

    it "結果画面で『トップに戻る』ボタンを押すとトップページに遷移する" do
      10.times do |i|
        first("input[name='selected_choice']", visible: false).choose
        click_button(i == 9 ? "結果を確認する" : "回答して次へ")
      end

      expect(page).to have_current_path("/quizzes/result")
      expect(page).to have_content("結果発表")

      click_link "トップに戻る"

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("このサービスについて")
    end
  end
end
