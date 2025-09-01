document.addEventListener('turbo:load', () => {
  const form = document.getElementById('edit-name-form');
  if (!form) return;

  form.addEventListener('ajax:success', (event) => {
    window.location.href = "<%= mypage_path %>";
  });

  form.addEventListener('ajax:error', (event) => {
    const [data, status, xhr] = event.detail;
    const errorsDiv = document.getElementById('form-errors');

    if (data && data.errors) {
      errorsDiv.textContent = data.errors.join(', ');
    } else {
      errorsDiv.textContent = "更新中にエラーが発生しました。";
    }
  });
});