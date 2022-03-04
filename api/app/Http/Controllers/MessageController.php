<?php

namespace App\Http\Controllers;

use App\Http\Resources\MessageResource;
use App\Models\Message;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class MessageController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(MessageResource::collection(Message::all()));
    }

    public function show(Request $request, int $id): JsonResponse
    {

        return response()->json(new MessageResource(Message::find($id)));
    }

    public function store(Request $request): JsonResponse
    {
        $message = Message::create($request->all());

        return response()->json(new MessageResource($message));
    }

    public function update(Request $request, $id): JsonResponse
    {
        $message = Message::find($id);
        $message->update($request->all());

        return response()->json(new MessageResource($message));
    }

    public function destroy($id): JsonResponse
    {
        $message = Message::find($id);
        $message->delete();

        return response()->json([
            'message' => 'Message deleted',
        ]);
    }
}
