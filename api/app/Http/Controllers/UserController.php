<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(UserResource::collection(User::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {

        return response()->json(new UserResource(User::find($id)));
    }

    public function store(Request $request): JsonResponse
    {
        $user = User::create($request->all());

        return response()->json(new UserResource($user));
    }

    public function update(Request $request, $id): JsonResponse
    {
        $user = User::find($id);
        $user->update($request->all());

        return response()->json(new UserResource($user));
    }

    public function destroy($id): JsonResponse
    {
        $user = User::find($id);
        $user->delete();

        return response()->json([
            'message' => 'User deleted',
        ]);
    }
}
