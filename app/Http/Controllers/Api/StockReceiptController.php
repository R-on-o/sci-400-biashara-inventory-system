<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\StockReceipt;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockReceiptController extends Controller
{
    /**
     * GET /api/stock-receipts — mirrors BiasharaDB.getStockReceipts()
     * Returns receipts newest first, with the related product eager-loaded
     * (equivalent to the frontend attaching `.product` to each row).
     */
    public function index()
    {
        $receipts = StockReceipt::with('product')
            ->orderByDesc('date_received')
            ->orderByDesc('id')
            ->get();

        return response()->json($receipts);
    }

    /**
     * POST /api/stock-receipts — mirrors BiasharaDB.addStockReceipt()
     * Creates the receipt AND increments the product's quantity_in_stock,
     * inside a DB transaction so the two writes cannot get out of sync
     * (e.g. if the request is interrupted midway).
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'productId' => ['required', 'exists:products,id'],
            'quantityReceived' => ['required', 'integer', 'min:1'],
            'dateReceived' => ['required', 'date'],
            'supplierName' => ['required', 'string', 'max:255'],
        ]);

        $receipt = DB::transaction(function () use ($data, $request) {
            $product = Product::findOrFail($data['productId']);

            $receipt = StockReceipt::create([
                'product_id' => $product->id,
                'user_id' => $request->user()->id,
                'quantity_received' => $data['quantityReceived'],
                'date_received' => $data['dateReceived'],
                'supplier_name' => $data['supplierName'],
            ]);

            $product->increment('quantity_in_stock', $data['quantityReceived']);

            return $receipt->load('product');
        });

        return response()->json($receipt, 201);
    }
}
