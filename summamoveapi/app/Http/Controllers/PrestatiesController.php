<?php

namespace App\Http\Controllers;

use App\Models\Prestaties;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class PrestatiesController extends Controller
{
    public function index(Request $request)
    {
        Log::info(
            'Prestaties opgevraagd op:',
            [
                'ip' => $request->ip(),
                'data' => $request->all()
            ]
        );
        try {
            return Prestaties::all();
        } catch (Throwable $e) {
            Log::error('Error bij het opvragen van prestaties: ' . $e->getMessage());
        }

        $content = [
            'success' => true,
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer',
        ];
        return response()->json($content, 200);
    }

    public function store(Request $request)
    {
        $validationRules = [
            'gebruikerId' => 'required|integer',
            'oefeningId' => 'required|integer',
            'datum' => 'required|string',
            'aantal' => 'required|integer|min:1',
        ];
    
        $request->validate($validationRules);

        try {
            $prestatie = Prestaties::create([
                'gebruikerId' => $request->input('gebruikerId'),
                'oefeningId' => $request->input('oefeningId'),
                'datum' => $request->input('datum'),
                'aantal' => $request->input('aantal')
            ]);

            $user = auth()->user();
            $user->tokens()->delete();

            $accessToken = $user->createToken('API Token')->plainTextToken;

            $response = [
                'prestatie' => $prestatie,
                'access_token' => $accessToken,
                'token_type' => 'Bearer'
            ];
            Log::info('Prestatie aangemaakt:', ['ip' => $request->ip()]);
            return response()->json($response, 200);
        } catch (Throwable $e) {
            Log::error('Fout bij het aanmaken van prestatie: ' . $e->getMessage());
            return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
        }
    }

    public function update(Request $request, Prestaties $prestaties)
    {
        try {
            Log::info("test");  
            $validatedData = $request->validate([
                'gebruikerId' => 'required|integer',
                'oefeningId' => 'required|integer',
                'datum' => 'required',
                'aantal' => 'required|integer|min:1',
            ]);
            $prestaties->update($validatedData);
            Log::info($validatedData);  

        } catch (Throwable $e) {
            Log::error('Error tijdens het updaten van prestatie: ' . $e->getMessage());
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

    public function destroy(prestaties $prestaties, Request $request)
    {
        try {
            $prestaties->delete();
            Log::info('oefening verwijdered op:', ['ip' => $request->ip()]);
        } catch (Throwable $e) {
            Log::error('Error in PrestatieController@destroy: ' . $e->getMessage());
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
