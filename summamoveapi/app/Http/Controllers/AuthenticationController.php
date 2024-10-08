<?php // AuthenticationController
namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Log;

class AuthenticationController extends Controller
{
    public function register(Request $request)
    {
        $attr = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users,email',
            'password' => 'required|string|min:5|confirmed'
        ]);
        $user = User::create([
            'name' => $attr['name'],
            'password' => bcrypt($attr['password']),
            'email' => $attr['email'],
        ]);
        return response()->json(['message' => 'Registration successful'], 200);
    }
    
    public function login(Request $request)
    {
        $attr = $request->validate([
            'email' => 'required|string|email|',
            'password' => 'required|string|min:5'
        ]);
        if (!Auth::attempt($attr)) {
            return response()->json(['message' => 'Credentials not match'], 401);
        }
        $response = [
            'access_token' => auth()->user()->createToken('API Token')->plainTextToken,
            'token_type' => 'Bearer'
        ];
        return response()->json($response, 200);
    }
    public function logout(Request $request)
    {
        Log::info('user uitgelogd op:', ['ip' => $request->ip()]);
        auth()->user()->tokens()->delete();
        return response()->json(['message' => 'Tokens Revoked'], 200);
    }
}
