<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index(): JsonResponse
    {
        return $this->success(UserResource::collection(User::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $user = User::findOrFail($id);

            return $this->success(new UserResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $user = User::create($request->all());

            return $this->ressourceCreated(new UserResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $user = User::find($id);
            $user->update($request->all());

            return $this->ressourceUpdated(new UserResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $user = User::findOrFail($id);
            $user->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
