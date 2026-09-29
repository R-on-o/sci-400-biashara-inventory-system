/**
 * app.js (v2 — real backend)
 * -----------------------------------------------------------------------
 * Same shell/helpers as v1, plus a login guard: any page other than
 * index.html now checks for a valid session token before rendering.
 * -----------------------------------------------------------------------
 */

(function () {
  "use strict";

  const NAV_ITEMS = [
    { section: "Overview" },
    { href: "dashboard.html", icon: "&#128202;", label: "Dashboard", key: "dashboard" },
    { section: "Inventory" },
    { href: "products.html", icon: "&#128230;", label: "Products & Stock", key: "products" },
    { href: "stock-receipts.html", icon: "&#128666;", label: "Stock Receipts", key: "stock-receipts" },
    { section: "Sales" },
    { href: "sales.html", icon: "&#128181;", label: "Record a Sale", key: "sales" },
    { section: "Insights" },
    { href: "reports.html", icon: "&#128200;", label: "Reports & Alerts", key: "reports", ownerOnly: true },
    { section: "Administration", ownerOnly: true },
    { href: "users.html", icon: "&#128100;", label: "Users", key: "users", ownerOnly: true },
  ];

  function renderSidebar(activeKey) {
    const user = window.BiasharaDB.getCurrentUser();
    const isOwner = user.role === "Owner";
    const navHtml = NAV_ITEMS
      .filter((item) => !item.ownerOnly || isOwner)
      .map((item) => {
        if (item.section) {
          return `<div class="nav-section-label">${item.section}</div>`;
        }
        const active = item.key === activeKey ? "active" : "";
        return `<a href="${item.href}" class="${active}">
                <span class="icon">${item.icon}</span> ${item.label}
              </a>`;
      }).join("");

    const avatarClass = isOwner ? "avatar-owner" : "avatar-attendant";
    const rolePillClass = isOwner ? "role-owner" : "role-attendant";

    return `
      <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
          <div class="mark">B</div>
          <div>
            <div class="name">Biashara</div>
            <div class="tagline">Inventory &amp; Sales</div>
          </div>
        </div>
        <nav class="sidebar-nav">${navHtml}</nav>
        <div class="sidebar-user">
          <div class="avatar ${avatarClass}">${user.initials}</div>
          <div class="who">
            <div>${user.name}</div>
            <span class="role-pill ${rolePillClass}">${user.role}</span>
          </div>
        </div>
        <div class="sidebar-footer">
          <a href="#" id="signOutLink" style="color:inherit;">&larr; Sign out</a>
        </div>
      </aside>`;
  }

  function renderTopbar(title, subtitle, user) {
    const isOwner = user.role === "Owner";
    const badgeClass = isOwner ? "role-owner" : "role-attendant";
    const badgeLabel = isOwner ? "Owner &middot; Full Access" : "Attendant &middot; Sales &amp; Stock";
    return `
      <header class="topbar">
        <div style="display:flex; align-items:center; gap:0.75rem;">
          <button class="sidebar-toggle" id="sidebarToggle" aria-label="Toggle menu">&#9776;</button>
          <div>
            <h1>${title}</h1>
            ${subtitle ? `<div class="subtitle">${subtitle}</div>` : ""}
          </div>
        </div>
        <div style="display:flex; align-items:center; gap:0.75rem;">
          <span class="role-badge-topbar ${badgeClass}"><span class="dot"></span>${badgeLabel}</span>
          <div id="topbarActions"></div>
        </div>
      </header>`;
  }

  /**
   * Call this at the top of each protected page:
   *   const content = Biashara.mountShell({ active: 'dashboard', title: 'Dashboard' });
   * Redirects to index.html if there's no valid session.
   */
  function mountShell({ active, title, subtitle }) {
    if (!window.BiasharaDB.isLoggedIn()) {
      window.location.href = "index.html";
      return null;
    }

    const currentUser = window.BiasharaDB.getCurrentUser();

    const shellRoot = document.getElementById("appShell");
    shellRoot.innerHTML = `
      ${renderSidebar(active)}
      <div class="main">
        ${renderTopbar(title, subtitle, currentUser)}
        <main class="content" id="pageContent"></main>
      </div>`;

    const toggle = document.getElementById("sidebarToggle");
    const sidebar = document.getElementById("sidebar");
    if (toggle && sidebar) {
      toggle.addEventListener("click", () => sidebar.classList.toggle("open"));
    }

    const signOut = document.getElementById("signOutLink");
    if (signOut) {
      signOut.addEventListener("click", async (e) => {
        e.preventDefault();
        await window.BiasharaDB.logout();
        window.location.href = "index.html";
      });
    }

    return document.getElementById("pageContent");
  }

  function formatKES(amount) {
    return "KES " + Number(amount).toLocaleString("en-KE", { maximumFractionDigits: 0 });
  }

  function escapeHtml(str) {
    const div = document.createElement("div");
    div.textContent = str == null ? "" : String(str);
    return div.innerHTML;
  }

  function toast(message, variant = "success") {
    let holder = document.getElementById("toastHolder");
    if (!holder) {
      holder = document.createElement("div");
      holder.id = "toastHolder";
      holder.style.position = "fixed";
      holder.style.bottom = "1.25rem";
      holder.style.right = "1.25rem";
      holder.style.zIndex = "999";
      document.body.appendChild(holder);
    }
    const el = document.createElement("div");
    el.style.padding = "0.65rem 1rem";
    el.style.marginTop = "0.5rem";
    el.style.boxShadow = "var(--shadow-md)";
    el.style.background = variant === "success" ? "var(--biashara-teal-700)" : "var(--biashara-danger)";
    el.style.color = "#fff";
    el.style.borderRadius = "8px";
    el.style.fontSize = "0.88rem";
    el.textContent = message;
    holder.appendChild(el);
    setTimeout(() => el.remove(), 3200);
  }

  window.Biashara = { mountShell, formatKES, escapeHtml, toast };
})();
