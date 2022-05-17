<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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

    function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $credentials = request(['email', 'password']);

        if (!auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $token = $request->user()->createToken('Personal Access Token');

        return response()->json([
            'access_token' => $token->plainTextToken,
        ]);
    }

    function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    public function me()
    {
        return response()->json(["user" => Auth::user()]);
    }

    public function register(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'firstname' => 'required|string',
            'lastname' => 'required|string',
            'email' => 'required|email',
            'password' => 'required|string',
            'avatar' => 'sometimes|string',
            'bio' => 'sometimes|string',
        ]);

        $user = new User([
            'username' => $request->username,
            'firstname' => $request->firstname,
            'lastname' => $request->lastname,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'avatar' => $request->avatar,
            'bio' => $request->bio,
        ]);
        $user->save();

        return $this->login($request);
    }
}
