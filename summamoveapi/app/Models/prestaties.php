<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestaties extends Model
{
    use HasFactory;

    protected $table = 'prestaties';

    protected $fillable = [
        "gebruikerId",
        "oefeningId",
        "datum",
        "aantal",
    ];

    public $timestamps = false;

}
