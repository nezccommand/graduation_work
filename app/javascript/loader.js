document.addEventListener("turbo:load", () => {
  const loader = document.getElementById("loader");
  if (!loader) return;

  window.addEventListener("load", () => {
    loader.style.display = "flex";
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
  if (
    form.id === "simulation-email-form" ||
    form.id === "confirmation-form" ||
    form.id === "password-reset-form"
  ) {
    const loader = document.getElementById("loader");
    if (loader) loader.style.display = "flex";
  }
});

document.addEventListener("turbo:load", (event) => {
  const form = event.target;
  if (
    form.id === "simulation-email-form" ||
    form.id === "confirmation-form" ||
    form.id === "password-reset-form"
  ) {
    const loader = document.getElementById("loader");
    if (loader) loader.style.display = "none";
  }
});