function initMobileMenuToggle() {
  const toggle = document.getElementById("mobile-toggle");
  const menu = document.getElementById("mobile-menu");

  if (toggle && menu) {
    // Remove any existing listener before adding
    toggle.removeEventListener("click", toggle._handler);

    // Define the handler
    toggle._handler = () => {
      menu.classList.toggle("hidden");
    };

    // Attach it
    toggle.addEventListener("click", toggle._handler);
  }
}

// Run on full reloads
document.addEventListener("DOMContentLoaded", initMobileMenuToggle);

// Run again after Turbo navigation
document.addEventListener("turbo:load", initMobileMenuToggle);


