<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostCommentsResource;
use App\Models\PostComments;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PostCommentsController extends Controller
{
    public function index()
    {
        return $this->success(PostCommentsResource::collection(PostComments::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $user = PostComments::findOrFail($id);

            return $this->success(new PostCommentsResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $user = PostComments::create($request->all());

            return $this->ressourceCreated(new PostCommentsResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $user = PostComments::find($id);
            $user->update($request->all());

            return $this->ressourceUpdated(new PostCommentsResource($user));
        } catch (Exception $e) {
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $user = PostComments::findOrFail($id);
            $user->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
