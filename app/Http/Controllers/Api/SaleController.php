<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class SaleController extends Controller
{
    /**
     * GET /api/sales — mirrors BiasharaDB.getSales()
     * Returns sales newest first, each with its user and line items
     * (with each item's product) eager-loaded.
     */
    public function index()
    {
        $sales = Sale::with(['user', 'items.product'])
            ->orderByDesc('created_at')
            ->get();

        return response()->json($sales);
    }

    /**
     * POST /api/sales — mirrors BiasharaDB.createSale()
     * Body: { "items": [ { "productId": 4, "quantitySold": 2 }, ... ] }
     *
     * Validates that every item has enough stock BEFORE writing anything,
     * then creates the sale + sale_items and decrements product stock,
     * all inside a single DB transaction.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'items' => ['required', 'array', 'min:1'],
            'items.*.productId' => ['required', 'exists:products,id'],
            'items.*.quantitySold' => ['required', 'integer', 'min:1'],
        ]);

        $sale = DB::transaction(function () use ($data, $request) {
            $total = 0;
            $products = [];

            // Step 1: lock and validate stock for every line item first.
            foreach ($data['items'] as $item) {
                $product = Product::lockForUpdate()->findOrFail($item['productId']);

                if ($item['quantitySold'] > $product->quantity_in_stock) {
                    throw ValidationException::withMessages([
                        'items' => ["Only {$product->quantity_in_stock} of \"{$product->name}\" in stock."],
                    ]);
                }

                $products[$item['productId']] = $product;
                $total += $product->unit_price * $item['quantitySold'];
            }

            // Step 2: create the sale record.
            $sale = Sale::create([
                'user_id' => $request->user()->id,
                'total' => $total,
            ]);

            // Step 3: create each sale item and decrement stock.
            foreach ($data['items'] as $item) {
                $product = $products[$item['productId']];

                $sale->items()->create([
                    'product_id' => $product->id,
                    'quantity_sold' => $item['quantitySold'],
                    'unit_price_at_sale' => $product->unit_price,
                ]);

                $product->decrement('quantity_in_stock', $item['quantitySold']);
            }

            return $sale->load(['user', 'items.product']);
        });

        return response()->json($sale, 201);
    }
}
