<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Throwable;

class GebruikersController extends Controller
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
            return User::all();
        } catch (Throwable $e) {
            Log::error('Error bij het opvragen van oefeningen: ' . $e->getMessage());
        }

        return response()->json([], 500);
    }

    public function store(Request $request)
    {

        try {
            $attr = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string|min:5|confirmed'
            ]);
            $gebruiker = User::create([
                'name' => $attr['name'],
                'password' => bcrypt($attr['password']),
                'email' => $attr['email'],
            ]);

            $user = auth()->user();
            $user->tokens()->delete();

            $accessToken = $user->createToken('API Token')->plainTextToken;

            $response = [
                'gebruiker' => $gebruiker,
                'access_token' => $accessToken,
                'token_type' => 'Bearer'
            ];
            Log::info('Gebruiker aangemaakt:', ['ip' => $request->ip()]);
            return response()->json($response, 200);
        } catch (Throwable $e) {
            Log::error('Fout bij het aanmaken van gebruiker: ' . $e->getMessage());
            return response()->json(['error' => 'Er is iets misgegaan. Probeer het opnieuw.'], 500);
        }
    }

    public function update(Request $request, User $gebruiker)
    {
        try {
            $validatedData = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string',
                'password' => 'required|string',
            ]);
            $gebruikerInfo = [
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
            ];
            $gebruiker->update($validatedData);
        } catch (Throwable $e) {
            Log::error('Error in GebruikerController@update: ' . $e->getMessage());
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

    public function destroy(User $gebruiker, Request $request)
    {
        try {
            $gebruiker->delete();
            Log::info('oefening verwijdered op:', ['ip' => $request->ip()]);
        } catch (Throwable $e) {
            Log::error('Error in GebruikerController@destroy: ' . $e->getMessage());
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
