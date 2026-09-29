<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * EnsureUserIsOwner
 * -----------------------------------------------------------------------
 * Runs AFTER auth:sanctum (which only confirms "is this a valid logged-in
 * user"). This middleware adds the missing second check: "is this
 * specific user an Owner". Any route using ->middleware('owner') gets
 * this check automatically, rather than relying on every controller
 * method to remember to check $request->user()->isOwner() itself.
 * -----------------------------------------------------------------------
 */
class EnsureUserIsOwner
{
    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->user() || ! $request->user()->isOwner()) {
            return response()->json([
                'message' => 'This action requires Owner privileges.',
            ], 403);
        }

        return $next($request);
    }
}
