<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * PRODUCT entity — see Proposal Figure 3.3 (Initial ERD).
 * Fields match: ProductID (PK), ProductName, Category, UnitPrice,
 * ReorderLevel, QuantityInStock.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('category');
            $table->unsignedInteger('unit_price');       // stored in KES, whole shillings
            $table->unsignedInteger('reorder_level');
            $table->unsignedInteger('quantity_in_stock')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
