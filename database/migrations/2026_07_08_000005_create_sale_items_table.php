<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * SALE_ITEM entity — see Proposal Figure 3.3 (Initial ERD).
 * Fields match: SaleItemID (PK), SaleID (FK), ProductID (FK),
 * QuantitySold, UnitPriceAtSale.
 *
 * UnitPriceAtSale is stored separately from products.unit_price so that
 * historical sales stay accurate even if a product's price changes later.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('sale_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('sale_id')->constrained('sales')->cascadeOnDelete();
            $table->foreignId('product_id')->constrained('products')->cascadeOnDelete();
            $table->unsignedInteger('quantity_sold');
            $table->unsignedInteger('unit_price_at_sale');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sale_items');
    }
};
