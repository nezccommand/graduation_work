document.addEventListener("turbo:load", () => {
  const loader = document.getElementById("loader");
  if (!loader) return;

  window.addEventListener("load", () => {
    loader.style.display = "none";
  });

  setTimeout(() => {
    loader.style.display = "none";
  }, 2000);
});

document.addEventListener("turbo:render", () => {
  const loader = document.getElementById("loader");
  if (loader) {
    loader.style.display = "none";
  }
});