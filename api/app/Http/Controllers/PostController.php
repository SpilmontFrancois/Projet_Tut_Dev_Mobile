<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostResource;
use App\Models\Post;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function index(): JsonResponse
    {
        return $this->success(PostResource::collection(Post::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $Post = Post::findOrFail($id);

            return $this->success(new PostResource($Post));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $Post = Post::create($request->all());

            return $this->ressourceCreated(new PostResource($Post));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $Post = Post::find($id);
            $Post->update($request->all());

            return $this->ressourceUpdated(new PostResource($Post));
        } catch (Exception $e) {
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $Post = Post::findOrFail($id);
            $Post->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
