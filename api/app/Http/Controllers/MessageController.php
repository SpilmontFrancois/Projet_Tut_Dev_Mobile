<?php

namespace App\Http\Controllers;

use App\Http\Resources\MessageResource;
use App\Models\Message;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class MessageController extends Controller
{
    public function index(): JsonResponse
    {
        return $this->success(MessageResource::collection(Message::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $message = Message::findOrFail($id);

            return $this->success(new MessageResource($message));
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $message = Message::create($request->all());

            return $this->ressourceCreated(new MessageResource($message));
        } catch (Exception $e) {
            return $this->ressourceNotCreated($e);
        }
    }

    public function update(Request $request, $id): JsonResponse
    {
        try {
            $message = Message::find($id);
            $message->update($request->all());

            return $this->ressourceUpdated(new MessageResource($message));
        } catch (Exception $e) {
            return $this->ressourceNotUpdated($e);
        }
    }

    public function destroy($id): JsonResponse
    {
        try {
            $message = Message::findOrFail($id);
            $message->delete();

            return $this->ressourceDeleted();
        } catch (Exception $e) {
            return $this->ressourceNotFound();
        }
    }
}
