/**
 * data.js
 * -----------------------------------------------------------------------
 * Real data layer for the Biashara Inventory System frontend.
 *
 * This talks to the Laravel API (see biashara-backend/routes/api.php).
 * Every function below returns a Promise (they're all async) except the
 * handful of pure/synchronous helpers noted inline (isLowStock, isCritical,
 * getCurrentUser, isLoggedIn) — those don't need the network.
 *
 * Two mapping jobs happen in here so the rest of the app never has to
 * think about it:
 *   1. Laravel returns snake_case JSON (unit_price, quantity_in_stock);
 *      the pages expect camelCase (unitPrice, quantityInStock). Every
 *      function that returns product/receipt/sale data converts this.
 *   2. The API doesn't send back an "initials" field for avatars, so
 *      it's computed here from the user's name.
 * -----------------------------------------------------------------------
 */

(function () {
  "use strict";

  const API_BASE = "http://127.0.0.1:8000/api";
  const TOKEN_KEY = "biashara_api_token_v1";
  const USER_KEY = "biashara_api_user_v1";

  function computeInitials(name) {
    if (!name) return "?";
    return name
      .split(" ")
      .filter(Boolean)
      .map((n) => n[0])
      .join("")
      .slice(0, 2)
      .toUpperCase();
  }

  function mapProduct(p) {
    if (!p) return p;
    return {
      id: p.id,
      name: p.name,
      category: p.category,
      unitPrice: Number(p.unit_price),
      reorderLevel: Number(p.reorder_level),
      quantityInStock: Number(p.quantity_in_stock),
    };
  }

  function mapUser(u) {
    if (!u) return u;
    return {
      id: u.id,
      name: u.name,
      username: u.username,
      role: u.role,
      initials: computeInitials(u.name),
    };
  }

  function mapStockReceipt(r) {
    if (!r) return r;
    return {
      id: r.id,
      productId: r.product_id,
      userId: r.user_id,
      quantityReceived: Number(r.quantity_received),
      dateReceived: r.date_received,
      supplierName: r.supplier_name,
      product: mapProduct(r.product),
    };
  }

  // Turns a Laravel timestamp like "2026-09-13T08:33:19.000000Z" into the
  // "YYYY-MM-DD HH:mm" display string the pages expect for the `date` field.
  function formatSaleDate(isoString) {
    if (!isoString) return "";
    const d = new Date(isoString);
    const pad = (n) => String(n).padStart(2, "0");
    return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }

  function mapSaleItem(si) {
    if (!si) return si;
    return {
      id: si.id,
      saleId: si.sale_id,
      productId: si.product_id,
      quantitySold: Number(si.quantity_sold),
      unitPriceAtSale: Number(si.unit_price_at_sale),
      product: mapProduct(si.product),
    };
  }

  function mapSale(s) {
    if (!s) return s;
    return {
      id: s.id,
      userId: s.user_id,
      date: formatSaleDate(s.created_at),
      total: Number(s.total),
      user: mapUser(s.user),
      items: Array.isArray(s.items) ? s.items.map(mapSaleItem) : [],
    };
  }

  /* ---------------------------------------------------------------------
   * Session helpers — stores the Sanctum token + a cached copy of the
   * logged-in user (so getCurrentUser() can stay synchronous, matching
   * how every page already calls it).
   * --------------------------------------------------------------------- */
  function getToken() {
    try {
      return sessionStorage.getItem(TOKEN_KEY);
    } catch (e) {
      return null;
    }
  }

  function getCachedUser() {
    try {
      const raw = sessionStorage.getItem(USER_KEY);
      return raw ? JSON.parse(raw) : null;
    } catch (e) {
      return null;
    }
  }

  function setSession(token, user) {
    try {
      sessionStorage.setItem(TOKEN_KEY, token);
      sessionStorage.setItem(USER_KEY, JSON.stringify(mapUser(user)));
    } catch (e) {
      console.warn("Could not persist session to sessionStorage.", e);
    }
  }

  function clearSession() {
    try {
      sessionStorage.removeItem(TOKEN_KEY);
      sessionStorage.removeItem(USER_KEY);
    } catch (e) {
      /* ignore */
    }
  }

  /* ---------------------------------------------------------------------
   * Low-level fetch wrapper: attaches the bearer token, parses JSON,
   * and throws a readable Error (with the server's validation message,
   * if any) on non-2xx responses so callers can show it in a toast.
   * --------------------------------------------------------------------- */
  async function apiFetch(path, options = {}) {
    const token = getToken();
    const headers = Object.assign(
      {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      token ? { Authorization: `Bearer ${token}` } : {},
      options.headers || {}
    );

    let response;
    try {
      response = await fetch(`${API_BASE}${path}`, Object.assign({}, options, { headers }));
    } catch (networkError) {
      throw new Error("Could not reach the server. Is the backend running?");
    }

    const body = await response.json().catch(() => null);

    if (!response.ok) {
      let message = `Request failed (${response.status}).`;
      if (body && body.message) {
        message = body.message;
      } else if (body && body.errors) {
        const firstKey = Object.keys(body.errors)[0];
        if (firstKey) message = body.errors[firstKey][0];
      }
      const error = new Error(message);
      error.status = response.status;
      throw error;
    }

    return body;
  }

  /* ---------------------------------------------------------------------
   * Public API — every page talks to window.BiasharaDB, same as before.
   * --------------------------------------------------------------------- */
  window.BiasharaDB = {
    // ---- Auth / session ----
    login: async (username, password) => {
      try {
        const body = await apiFetch("/login", {
          method: "POST",
          body: JSON.stringify({ username, password }),
        });
        if (!body || !body.token) {
          return { success: false, message: "Unexpected response from server. Please try again." };
        }
        setSession(body.token, body.user);
        return { success: true, user: mapUser(body.user) };
      } catch (err) {
        return { success: false, message: err.message };
      }
    },

    isLoggedIn: () => !!getToken() && !!getCachedUser(),

    logout: async () => {
      try {
        await apiFetch("/logout", { method: "POST" });
      } catch (e) {
        // Even if the server call fails (e.g. token already expired),
        // still clear the local session so the user isn't stuck.
      }
      clearSession();
      return { success: true };
    },

    getCurrentUser: () => getCachedUser(),

    // ---- Users ----
    getUsers: async () => {
      const rows = await apiFetch("/users");
      return rows.map(mapUser);
    },

    addUser: async ({ name, username, email, password, role }) => {
      const created = await apiFetch("/users", {
        method: "POST",
        body: JSON.stringify({ name, username, email, password, role }),
      });
      return mapUser(created);
    },

    deleteUser: async (id) => {
      await apiFetch(`/users/${id}`, { method: "DELETE" });
    },

    // ---- Products ----
    getProducts: async () => {
      const rows = await apiFetch("/products");
      return rows.map(mapProduct);
    },

    getLowStockProducts: async () => {
      const rows = await apiFetch("/products/low-stock");
      return rows.map(mapProduct);
    },

    isLowStock: (p) => p.quantityInStock <= p.reorderLevel,
    isCritical: (p) => p.quantityInStock <= Math.round(p.reorderLevel * 0.4),

    addProduct: async ({ name, category, unitPrice, reorderLevel, quantityInStock }) => {
      const created = await apiFetch("/products", {
        method: "POST",
        body: JSON.stringify({
          name,
          category,
          unitPrice: Number(unitPrice),
          reorderLevel: Number(reorderLevel),
          quantityInStock: Number(quantityInStock) || 0,
        }),
      });
      return mapProduct(created);
    },

    updateProduct: async (id, changes) => {
      const payload = {};
      if (changes.name !== undefined) payload.name = changes.name;
      if (changes.category !== undefined) payload.category = changes.category;
      if (changes.unitPrice !== undefined) payload.unitPrice = Number(changes.unitPrice);
      if (changes.reorderLevel !== undefined) payload.reorderLevel = Number(changes.reorderLevel);
      if (changes.quantityInStock !== undefined) payload.quantityInStock = Number(changes.quantityInStock);

      const updated = await apiFetch(`/products/${id}`, {
        method: "PUT",
        body: JSON.stringify(payload),
      });
      return mapProduct(updated);
    },

    deleteProduct: async (id) => {
      await apiFetch(`/products/${id}`, { method: "DELETE" });
    },

    // ---- Stock Receipts ----
    getStockReceipts: async () => {
      const rows = await apiFetch("/stock-receipts");
      return rows.map(mapStockReceipt);
    },

    addStockReceipt: async ({ productId, quantityReceived, dateReceived, supplierName }) => {
      const created = await apiFetch("/stock-receipts", {
        method: "POST",
        body: JSON.stringify({
          productId: Number(productId),
          quantityReceived: Number(quantityReceived),
          dateReceived,
          supplierName,
        }),
      });
      return mapStockReceipt(created);
    },

    // ---- Sales ----
    getSales: async () => {
      const rows = await apiFetch("/sales");
      return rows.map(mapSale);
    },

    createSale: async ({ items }) => {
      const created = await apiFetch("/sales", {
        method: "POST",
        body: JSON.stringify({
          items: items.map((it) => ({
            productId: Number(it.productId),
            quantitySold: Number(it.quantitySold),
          })),
        }),
      });
      return mapSale(created);
    },

    // ---- Reporting helpers ----
    getTodaySalesTotal: async () => {
      const body = await apiFetch("/reports/today-total");
      return Number(body.total);
    },

    getBestSellers: async (limit = 5) => {
      const rows = await apiFetch(`/reports/best-sellers?limit=${encodeURIComponent(limit)}`);
      return rows.map((row) => ({ product: mapProduct(row.product), qty: Number(row.qty) }));
    },
  };
})();
