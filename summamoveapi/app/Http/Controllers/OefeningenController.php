<?php

namespace App\Http\Controllers;

use App\Models\Oefeningen;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class OefeningenController extends Controller
{
    public function index(Request $request)
    {
        Log::info(
            'modellen opgevraagd op:',
            [
                'ip' => $request->ip(),
                'data' => $request->all()
            ]
        );
        try {
            return Oefeningen::all();
        } catch (Throwable $e) {
            Log::error('Error bij het opvragen van oefeningen: ' . $e->getMessage());
        }

        return response()->json([], 500);
    }

    public function store(Request $request)
    {
        try {
            $oefening = Oefeningen::create($request->all());

            $user = auth()->user();
            $user->tokens()->delete();

            $accessToken = $user->createToken('API Token')->plainTextToken;

            $response = [
                'oefening' => $oefening,
                'access_token' => $accessToken,
                'token_type' => 'Bearer'
            ];
            Log::info('Oefening aangemaakt:', ['ip' => $request->ip()]);
            return response()->json($response, 200);
        } catch (Throwable $e) {
            Log::error('Fout bij het aanmaken van oefeningen: ' . $e->getMessage());
            return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
        }
    }

    public function update(Request $request, Oefeningen $oefeningen)
    {
        try {
            $validatedData = $request->validate([
                'naam' => 'required|string|max:255',
                'beschrijvingNL' => 'required|string',
                'beschrijvingEN' => 'required|string',
            ]);
            $oefeningen->update($validatedData);
        } catch (Throwable $e) {
            Log::error('Error in OefeningController@update: ' . $e->getMessage());
            return response()->json(['error' => ' updaten gefaald'], 500);
        }

        $user = auth()->user();

        $user->tokens()->delete();
        Log::info('oude token verwijdered voor gebruiker', ['user_id' => $user->id]);

        $newToken = $user->createToken('API Token')->plainTextToken;
        Log::info('Nieuwe token gemaakt voor gebruiker', ['user_id' => $user->id]);

        $response = [
            'access_token' => $newToken,
            'token_type' => 'Bearer'
        ];

        return response()->json($response, 200);
    }

    public function destroy(Oefeningen $oefeningen, Request $request)
    {
        try {
            $oefeningen->delete();
            Log::info('oefening verwijdered op:', ['ip' => $request->ip()]);
        } catch (Throwable $e) {
            Log::error('Error in OefeningController@destroy: ' . $e->getMessage());
            return response()->json(['error' => ' verwijderen gefaald'], 500);
        }

        $user = auth()->user();

        $user->tokens()->delete();
        Log::info('oude token verwijdered voor gebruiker', ['user_id' => $user->id]);

        $newToken = $user->createToken('API Token')->plainTextToken;
        Log::info('Nieuwe token gemaakt voor gebruiker', ['user_id' => $user->id]);

        $response = [
            'access_token' => $newToken,
            'token_type' => 'Bearer'
        ];

        return response()->json($response, 200);
    }
}
