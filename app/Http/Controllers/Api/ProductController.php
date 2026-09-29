<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * GET /api/products — mirrors BiasharaDB.getProducts()
     */
    public function index()
    {
        return response()->json(Product::orderBy('name')->get());
    }

    /**
     * GET /api/products/low-stock — mirrors BiasharaDB.getLowStockProducts()
     */
    public function lowStock()
    {
        $lowStock = Product::all()->filter(fn ($p) => $p->isLowStock())->values();

        return response()->json($lowStock);
    }

    /**
     * POST /api/products — mirrors BiasharaDB.addProduct()
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'category' => ['required', 'string', 'max:100'],
            'unitPrice' => ['required', 'integer', 'min:0'],
            'reorderLevel' => ['required', 'integer', 'min:0'],
            'quantityInStock' => ['nullable', 'integer', 'min:0'],
        ]);

        $product = Product::create([
            'name' => $data['name'],
            'category' => $data['category'],
            'unit_price' => $data['unitPrice'],
            'reorder_level' => $data['reorderLevel'],
            'quantity_in_stock' => $data['quantityInStock'] ?? 0,
        ]);

        return response()->json($product, 201);
    }

    /**
     * PUT /api/products/{product} — mirrors BiasharaDB.updateProduct()
     */
    public function update(Request $request, Product $product)
    {
        $data = $request->validate([
            'name' => ['sometimes', 'string', 'max:255'],
            'category' => ['sometimes', 'string', 'max:100'],
            'unitPrice' => ['sometimes', 'integer', 'min:0'],
            'reorderLevel' => ['sometimes', 'integer', 'min:0'],
            'quantityInStock' => ['sometimes', 'integer', 'min:0'],
        ]);

        $product->update([
            'name' => $data['name'] ?? $product->name,
            'category' => $data['category'] ?? $product->category,
            'unit_price' => $data['unitPrice'] ?? $product->unit_price,
            'reorder_level' => $data['reorderLevel'] ?? $product->reorder_level,
            'quantity_in_stock' => $data['quantityInStock'] ?? $product->quantity_in_stock,
        ]);

        return response()->json($product);
    }

    /**
     * DELETE /api/products/{product} — mirrors BiasharaDB.deleteProduct()
     */
    public function destroy(Product $product)
    {
        $product->delete();

        return response()->json(['message' => 'Product deleted.']);
    }
}
