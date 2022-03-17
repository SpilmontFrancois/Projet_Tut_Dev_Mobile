<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostResource;
use App\Models\Post;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PostController extends Controller
{
    public function index(): JsonResponse
    {
        return $this->success(PostResource::collection(Post::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $post = Post::findOrFail($id);

            return $this->success(new PostResource($post));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $post = Post::create($request->all());

            return $this->ressourceCreated(new PostResource($post));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $post = Post::findOrFail($id);
            DB::beginTransaction();
            $post->update($request->all());
            DB::commit();

            return $this->ressourceUpdated(new PostResource($post));
        } catch (Exception $e) {
            DB::rollBack();
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $post = Post::findOrFail($id);
            $post->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function share(Request $request, int $id): JsonResponse
    {
        try {
            $post = Post::findOrFail($id);
            $post->update(['shares' => $post->shares + 1]);

            return $this->success(new PostResource($post));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function star(Request $request, int $id): JsonResponse
    {
        try {
            $post = Post::findOrFail($id);
            $post->update(['stars' => $post->stars + 1]);

            return $this->success(new PostResource($post));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
