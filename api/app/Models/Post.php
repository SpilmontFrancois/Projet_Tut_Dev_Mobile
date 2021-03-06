<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'content',
        'stars',
        'shares'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function postComments()
    {
        return $this->hasMany(PostComments::class);
    }
}
