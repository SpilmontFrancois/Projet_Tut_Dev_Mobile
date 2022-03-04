<?php

namespace App\Traits;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

trait ApiResponder
{
    protected function success($data = [], $message = null, $code = 200): JsonResponse
    {
        $response = [
            'data' => $data,
            'meta' => [
                'success' => true,
                'message' => $message,
            ],
        ];

        return response()->json($response, $code);
    }

    protected function error($error = "Not Found", $errorMessages = [], $code = 404): JsonResponse
    {
        $response = [
            'data' => $code,
            'meta' => [
                'success' => false,
                'message' => $error,
            ]
        ];

        if (!empty($errorMessages)) {
            $response['data'] = $errorMessages;
        }

        return response()->json($response, $code);
    }

    protected function ressourceCreated($data = null, $message = 'Ressource created with success.'): JsonResponse
    {
        return $this->success($data, $message, 201);
    }

    protected function ressourceUpdated($data = null, $message = 'Ressource updated with success.'): JsonResponse
    {
        return $this->success($data, $message, 201);
    }


    protected function ressourceDeleted(): JsonResponse
    {
        return $this->success(null, null, 204);
    }

    protected function ressourceNotFound(): JsonResponse
    {
        return $this->error('Not Found', 'Resource not found', 400);
    }

    protected function ressourceNotCreated($errors): JsonResponse
    {
        return $this->error('Not Created', $errors, 409);

    }

    protected function ressourceNotUpdated($errors): JsonResponse
    {
        return $this->error('Not Updated', $errors, 409);
    }
}