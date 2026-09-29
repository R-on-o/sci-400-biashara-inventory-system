<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\ReportController;
use App\Http\Controllers\Api\SaleController;
use App\Http\Controllers\Api\StockReceiptController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes — Biashara Inventory System
|--------------------------------------------------------------------------
| These routes mirror the function names/shapes in the frontend's
| assets/js/data.js (window.BiasharaDB), so switching the frontend from
| mock data to this real API only requires editing data.js, not the pages.
*/

// Public — no token required
Route::post('/login', [AuthController::class, 'login']);

// Protected — requires "Authorization: Bearer <token>" header
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);

    // Products & Stock — everyone can view products (they need this to make
    // sales and check stock), but only the Owner can change the catalog
    // itself (add, edit, delete). Viewing stays open; writes are gated.
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/low-stock', [ProductController::class, 'lowStock']);
    Route::middleware('owner')->group(function () {
        Route::post('/products', [ProductController::class, 'store']);
        Route::put('/products/{product}', [ProductController::class, 'update']);
        Route::delete('/products/{product}', [ProductController::class, 'destroy']);
    });

    // Stock Receipts
    Route::get('/stock-receipts', [StockReceiptController::class, 'index']);
    Route::post('/stock-receipts', [StockReceiptController::class, 'store']);

    // Sales
    Route::get('/sales', [SaleController::class, 'index']);
    Route::post('/sales', [SaleController::class, 'store']);

    // Reports — financial/performance data, Owner only.
    Route::middleware('owner')->group(function () {
        Route::get('/reports/today-total', [ReportController::class, 'todayTotal']);
        Route::get('/reports/best-sellers', [ReportController::class, 'bestSellers']);
    });

    // Users (Owner-only — enforced by the 'owner' middleware below,
    // in addition to the belt-and-suspenders checks already inside
    // UserController for store/destroy)
    Route::middleware('owner')->group(function () {
        Route::get('/users', [UserController::class, 'index']);
        Route::post('/users', [UserController::class, 'store']);
        Route::delete('/users/{user}', [UserController::class, 'destroy']);
    });
});
