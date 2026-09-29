<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'category',
        'unit_price',
        'reorder_level',
        'quantity_in_stock',
    ];

    protected function casts(): array
    {
        return [
            'unit_price' => 'integer',
            'reorder_level' => 'integer',
            'quantity_in_stock' => 'integer',
        ];
    }

    public function stockReceipts()
    {
        return $this->hasMany(StockReceipt::class);
    }

    public function saleItems()
    {
        return $this->hasMany(SaleItem::class);
    }

    /**
     * Mirrors BiasharaDB.isLowStock() in the frontend's data.js.
     */
    public function isLowStock(): bool
    {
        return $this->quantity_in_stock <= $this->reorder_level;
    }

    /**
     * Mirrors BiasharaDB.isCritical() in the frontend's data.js
     * (at or below 40% of the reorder level).
     */
    public function isCritical(): bool
    {
        return $this->quantity_in_stock <= round($this->reorder_level * 0.4);
    }
}
