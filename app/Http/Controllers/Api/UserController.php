<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    /**
     * GET /api/users — mirrors BiasharaDB.getUsers()
     */
    public function index()
    {
        return response()->json(User::select('id', 'name', 'username', 'role')->get());
    }

    /**
     * POST /api/users — Owner only. Enforced via the 'owner' middleware
     * registered in routes/api.php (see StockReceipt/Sale routes for the
     * pattern), not re-checked here to avoid duplicating the same guard.
     */
    public function store(Request $request)
    {
        if (! $request->user()->isOwner()) {
            throw ValidationException::withMessages([
                'role' => ['Only the Owner can add new users.'],
            ]);
        }

        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'username' => ['required', 'string', 'max:100', 'unique:users,username'],
            'email' => ['required', 'email', 'unique:users,email'],
            'password' => ['required', 'string', 'min:6'],
            'role' => ['required', 'in:Owner,Attendant'],
        ]);

        $user = User::create([
            'name' => $data['name'],
            'username' => $data['username'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'role' => $data['role'],
        ]);

        return response()->json($user->only(['id', 'name', 'username', 'role']), 201);
    }

    /**
     * DELETE /api/users/{user} — Owner only.
     */
    public function destroy(Request $request, User $user)
    {
        if (! $request->user()->isOwner()) {
            throw ValidationException::withMessages([
                'role' => ['Only the Owner can remove users.'],
            ]);
        }

        if ($user->id === $request->user()->id) {
            throw ValidationException::withMessages([
                'user' => ['You cannot remove your own account.'],
            ]);
        }

        $user->delete();

        return response()->json(['message' => 'User removed.']);
    }
}
