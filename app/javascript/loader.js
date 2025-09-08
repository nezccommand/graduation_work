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

document.addEventListener("turbo:submit-start", (event) => {
  const form = event.target;
  if (form.id === "password-form") {
    const loader = document.getElementById("loader");
    if (loader) loader.style.display = "block";
  }
});

document.addEventListener("turbo:submit-end", (event) => {
  const form = event.target;
  if (form.id === "password-form") {
    const loader = document.getElementById("loader");
    if (loader) loader.style.display = "none";
  }
});