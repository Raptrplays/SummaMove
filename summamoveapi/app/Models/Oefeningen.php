<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Oefeningen extends Model
{
    use HasFactory;

    protected $table = 'oefeningen';

    protected $fillable = [
        "naam", 
        "beschrijvingNL", 
        "beschrijvingEN",
    ];

    public $timestamps = false;
}
