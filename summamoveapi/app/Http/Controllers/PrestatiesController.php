<?php

namespace App\Http\Controllers;

use App\Models\Prestaties;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class PrestatiesController extends Controller
{

    public function index()
    {
        try {
            $prestaties = Prestaties::with('oefening:id,naam')
                ->get(['id', 'gebruikerId', 'oefeningId', 'datum', 'aantal']);

            $prestaties = $prestaties->map(function ($prestatie) {
                return [
                    'id' => $prestatie->id,
                    'gebruikerId' => $prestatie->gebruikerId,
                    'oefeningId' => $prestatie->oefeningId,
                    'oefeningNaam' => $prestatie->oefening->naam,
                    'datum' => $prestatie->datum,
                    'aantal' => $prestatie->aantal,
                ];
            });

            return response()->json($prestaties, 200);
        } catch (Throwable $e) {
            Log::error('Error bij het opvragen van prestaties: ' . $e->getMessage());
            return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
        }
    }


    public function store(Request $request)
    {
        $validationRules = [
            'gebruikerId' => 'required|integer',
            'oefeningId' => 'required|integer',
            'datum' => 'required|date', // Ensure datum is validated as a date
            'aantal' => 'required|integer|min:1',
        ];

        $request->validate($validationRules);

        try {
            $prestatie = Prestaties::create([
                'gebruikerId' => $request->input('gebruikerId'),
                'oefeningId' => $request->input('oefeningId'),
                'datum' => $request->input('datum'),
                'aantal' => $request->input('aantal'),
            ]);

            // Assuming you are managing access tokens for authentication
            $user = auth()->user();
            $user->tokens()->delete();

            $accessToken = $user->createToken('API Token')->plainTextToken;

            $response = [
                'prestatie' => $prestatie,
                'access_token' => $accessToken,
                'token_type' => 'Bearer',
            ];

            Log::info('Prestatie created successfully', [
                'gebruikerId' => $request->input('gebruikerId'),
                'oefeningId' => $request->input('oefeningId'),
                'datum' => $request->input('datum'),
                'aantal' => $request->input('aantal'),
                'ip' => $request->ip(),
            ]);

            return response()->json($response, 201);
        } catch (Throwable $e) {
            Log::error('Error creating prestatie: ' . $e->getMessage(), [
                'ip' => $request->ip(),
            ]);
            return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
        }
    }

    public function update(Request $request, Prestaties $prestatie)
{
    $validationRules = [
        'gebruikerId' => 'required|integer',
        'oefeningId' => 'required|integer',
        'datum' => 'required|date',
        'aantal' => 'required|integer|min:1',
    ];

    $request->validate($validationRules);

    try {
        $prestatie->update([
            'gebruikerId' => $request->input('gebruikerId'),
            'oefeningId' => $request->input('oefeningId'),
            'datum' => $request->input('datum'),
            'aantal' => $request->input('aantal'),
        ]);

        $user = auth()->user();
        $user->tokens()->delete();

        $accessToken = $user->createToken('API Token')->plainTextToken;

        $response = [
            'access_token' => $accessToken,
            'token_type' => 'Bearer',
        ];

        Log::info('Prestatie updated successfully', [
            'prestatie_id' => $prestatie->id,
            'ip' => $request->ip(),
        ]);

        return response()->json($response, 200);
    } catch (Throwable $e) {
        Log::error('Error updating prestatie: ' . $e->getMessage(), [
            'prestatie_id' => $prestatie->id,
            'ip' => $request->ip(),
        ]);
        return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
    }
}



public function destroy(Prestaties $prestaties, Request $request)
{
    try {
        $prestaties->delete();
        Log::info('oefening verwijdered op:', ['ip' => $request->ip()]);
    } catch (Throwable $e) {
        Log::error('Error in PrestatieController@destroy: ' . $e->getMessage());
        return response()->json(['error' => 'verwijderen gefaald'], 500);
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
