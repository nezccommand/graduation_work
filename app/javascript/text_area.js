document.addEventListener("turbo:load", function () {
  const autoResize = (id) => {
    const textarea = document.getElementById(id);
    if (!textarea) return;

    const resize = () => {
      textarea.style.height = 'auto';
      textarea.style.height = textarea.scrollHeight + 'px';
    };

    resize();
    textarea.addEventListener('input', resize);
  };

  autoResize("description-textarea");
  autoResize("sample-text-textarea");
  autoResize("auto-resize-textarea");
});