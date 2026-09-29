<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * STOCK_RECEIPT entity — see Proposal Figure 3.3 (Initial ERD).
 * Fields match: ReceiptID (PK), ProductID (FK), UserID (FK),
 * QuantityReceived, DateReceived, SupplierName.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('stock_receipts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained('products')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
            $table->unsignedInteger('quantity_received');
            $table->date('date_received');
            $table->string('supplier_name');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('stock_receipts');
    }
};
