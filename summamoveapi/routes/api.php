<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\OefeningenController;
use App\Http\Controllers\PrestatiesController;
use App\Http\Controllers\AuthenticationController;
use Database\Seeders\OefeningenSeeder;



Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);

Route::get('oefeningen', [OefeningenController::class, 'index']);

Route::group(['middleware' => ['auth:sanctum']], function () {

    Route::get('profile', function (Request $request) {
        return auth()->user();
    });

    Route::apiResource('oefeningen', OefeningenController::class)->only(['store', 'update', 'destroy']);
    Route::apiResource('prestaties', PrestatiesController::class)->only(['index', 'store', 'update', 'destroy']);
    Route::post('/logout', [AuthenticationController::class, 'logout']);
});
