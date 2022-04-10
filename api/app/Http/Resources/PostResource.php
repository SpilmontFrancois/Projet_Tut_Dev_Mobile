<?php

namespace App\Http\Resources;

use App\Models\PostComments;
use App\Models\User;
use App\Models\User2Post;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'user' => [
                'id' => $this->user->id,
                'name' => $this->user->username,
                'avatar' => $this->user->avatar,
            ],
            'content' => $this->content,
            'stars' => User2Post::where('post_id', $this->id)->where('stared', true)->count(),
            'shares' => User2Post::where('post_id', $this->id)->where('shared', true)->count(),
            'comments' => PostComments::where('post_id', $this->id)->count(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
