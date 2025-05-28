document.addEventListener("turbo:load", function () {
  const textarea = document.getElementById('auto-resize-textarea');
  if (!textarea) return;

  const resize = () => {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
  };

  resize();

  textarea.addEventListener('input', resize);
});