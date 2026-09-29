<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\Sale;
use App\Models\StockReceipt;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

/**
 * Seeds the same data used in the frontend's mock data.js, so switching
 * from the mock frontend to this real backend feels seamless in a demo.
 */
class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // ---- Users ----
        $owner = User::create([
            'name' => 'Nick Kiprotich',
            'username' => 'nick.owner',
            'email' => 'nick.owner@biashara.test',
            'password' => Hash::make('password'),
            'role' => 'Owner',
        ]);

        $faith = User::create([
            'name' => 'Faith Wanjiru',
            'username' => 'faith.attendant',
            'email' => 'faith.attendant@biashara.test',
            'password' => Hash::make('password'),
            'role' => 'Attendant',
        ]);

        $brian = User::create([
            'name' => 'Brian Otieno',
            'username' => 'brian.attendant',
            'email' => 'brian.attendant@biashara.test',
            'password' => Hash::make('password'),
            'role' => 'Attendant',
        ]);

        // ---- Products ---- (matches frontend/assets/js/data.js exactly)
        $products = [
            ['name' => 'Unga wa Ngano 2kg', 'category' => 'Groceries', 'unit_price' => 220, 'reorder_level' => 15, 'quantity_in_stock' => 8],
            ['name' => 'Cooking Oil 1L', 'category' => 'Groceries', 'unit_price' => 320, 'reorder_level' => 10, 'quantity_in_stock' => 4],
            ['name' => 'Sugar 2kg', 'category' => 'Groceries', 'unit_price' => 260, 'reorder_level' => 20, 'quantity_in_stock' => 42],
            ['name' => 'Bar Soap (Green)', 'category' => 'Household', 'unit_price' => 60, 'reorder_level' => 25, 'quantity_in_stock' => 12],
            ['name' => 'Rice (Pishori) 2kg', 'category' => 'Groceries', 'unit_price' => 280, 'reorder_level' => 15, 'quantity_in_stock' => 30],
            ['name' => 'Maziwa Fresh 500ml', 'category' => 'Beverages', 'unit_price' => 65, 'reorder_level' => 30, 'quantity_in_stock' => 18],
            ['name' => 'Exercise Book 200pg', 'category' => 'Stationery', 'unit_price' => 55, 'reorder_level' => 20, 'quantity_in_stock' => 50],
            ['name' => 'Toothpaste 100g', 'category' => 'Household', 'unit_price' => 130, 'reorder_level' => 15, 'quantity_in_stock' => 3],
            ['name' => 'Blue Band 500g', 'category' => 'Groceries', 'unit_price' => 310, 'reorder_level' => 10, 'quantity_in_stock' => 14],
            ['name' => 'Airtime Scratch Card 100', 'category' => 'Other', 'unit_price' => 100, 'reorder_level' => 40, 'quantity_in_stock' => 6],
        ];

        $createdProducts = collect($products)->map(fn ($p) => Product::create($p));

        $unga = $createdProducts[0];
        $sugar = $createdProducts[2];
        $soap = $createdProducts[3];
        $rice = $createdProducts[4];
        $milk = $createdProducts[5];
        $book = $createdProducts[6];
        $blueBand = $createdProducts[8];

        // ---- Stock Receipts ----
        StockReceipt::create(['product_id' => $sugar->id, 'user_id' => $owner->id, 'quantity_received' => 40, 'date_received' => '2026-06-28', 'supplier_name' => 'Mumias Sugar Distributors']);
        StockReceipt::create(['product_id' => $rice->id, 'user_id' => $owner->id, 'quantity_received' => 30, 'date_received' => '2026-06-30', 'supplier_name' => 'Pishori Wholesalers Ltd']);
        StockReceipt::create(['product_id' => $book->id, 'user_id' => $faith->id, 'quantity_received' => 50, 'date_received' => '2026-07-01', 'supplier_name' => 'Elite Stationers']);
        StockReceipt::create(['product_id' => $unga->id, 'user_id' => $owner->id, 'quantity_received' => 20, 'date_received' => '2026-07-02', 'supplier_name' => 'Unga Millers Co.']);

        // ---- Sales + Sale Items ----
        $sale1 = Sale::create(['user_id' => $faith->id, 'total' => 645]);
        $sale1->items()->create(['product_id' => $unga->id, 'quantity_sold' => 1, 'unit_price_at_sale' => 220]);
        $sale1->items()->create(['product_id' => $milk->id, 'quantity_sold' => 2, 'unit_price_at_sale' => 65]);
        $sale1->items()->create(['product_id' => $soap->id, 'quantity_sold' => 5, 'unit_price_at_sale' => 60]);

        $sale2 = Sale::create(['user_id' => $brian->id, 'total' => 320]);
        $sale2->items()->create(['product_id' => $createdProducts[1]->id, 'quantity_sold' => 1, 'unit_price_at_sale' => 320]);

        $sale3 = Sale::create(['user_id' => $faith->id, 'total' => 260]);
        $sale3->items()->create(['product_id' => $sugar->id, 'quantity_sold' => 1, 'unit_price_at_sale' => 260]);

        $sale4 = Sale::create(['user_id' => $faith->id, 'total' => 195]);
        $sale4->items()->create(['product_id' => $soap->id, 'quantity_sold' => 1, 'unit_price_at_sale' => 60]);
        $sale4->items()->create(['product_id' => $milk->id, 'quantity_sold' => 2, 'unit_price_at_sale' => 65]);

        $sale5 = Sale::create(['user_id' => $brian->id, 'total' => 780]);
        $sale5->items()->create(['product_id' => $rice->id, 'quantity_sold' => 2, 'unit_price_at_sale' => 280]);
        $sale5->items()->create(['product_id' => $blueBand->id, 'quantity_sold' => 1, 'unit_price_at_sale' => 310]);

        $this->command->info('Seeded 3 users, 10 products, 4 stock receipts, 5 sales.');
        $this->command->info('Login with username: nick.owner / password: password');
    }
}
