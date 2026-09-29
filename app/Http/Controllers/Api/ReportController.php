<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Sale;
use App\Models\SaleItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportController extends Controller
{
    /**
     * GET /api/reports/today-total — mirrors BiasharaDB.getTodaySalesTotal()
     */
    public function todayTotal()
    {
        $total = Sale::whereDate('created_at', now()->toDateString())->sum('total');

        return response()->json(['total' => (int) $total]);
    }

    /**
     * GET /api/reports/best-sellers?limit=5 — mirrors BiasharaDB.getBestSellers()
     */
    public function bestSellers(Request $request)
    {
        $limit = (int) $request->query('limit', 5);

        $rows = SaleItem::select('product_id', DB::raw('SUM(quantity_sold) as qty'))
            ->groupBy('product_id')
            ->orderByDesc('qty')
            ->limit($limit)
            ->with('product')
            ->get();

        $result = $rows->map(fn ($row) => [
            'product' => $row->product,
            'qty' => (int) $row->qty,
        ]);

        return response()->json($result);
    }
}
