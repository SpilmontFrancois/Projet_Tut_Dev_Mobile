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
            $postComment = PostComments::where('post_id', $id)->get()->sortByDesc('created_at');

            if (!$postComment)
                return $this->ressourceNotFound();

            return $this->success(PostCommentsResource::collection($postComment));
        } catch (Exception $e) {
            dd($e);
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $postComment = PostComments::create($request->all());

            return $this->ressourceCreated(new PostCommentsResource($postComment));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $postComment = PostComments::find($id);
            $postComment->update($request->all());

            return $this->ressourceUpdated(new PostCommentsResource($postComment));
        } catch (Exception $e) {
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $postComment = PostComments::findOrFail($id);
            $postComment->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
