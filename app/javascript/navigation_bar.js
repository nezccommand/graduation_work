document.addEventListener("turbo:load", () => {
  const bar = document.getElementById("progress-bar");
  if (!bar) return;

  const currentProgress = parseInt(bar.dataset.currentProgress, 10);

  const previousProgress = parseInt(sessionStorage.getItem("previousProgress") || "0", 10);

  console.log("current:", currentProgress);
  console.log("previous:", previousProgress);

  bar.style.width = `${previousProgress}%`;

  setTimeout(() => {
    bar.style.width = `${currentProgress}%`;
  }, 10);

  sessionStorage.setItem("previousProgress", currentProgress);
});
