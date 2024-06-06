<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('prestaties', function (Blueprint $table) {
            $table->id();
            $table->timestamps();

            $table->unsignedBigInteger('oefeningId');
            $table->foreign('oefeningId')->references('id')->on('oefeningen')->onDelete('cascade');

            $table->unsignedBigInteger('gebruikerId');
            $table->foreign('gebruikerId')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('prestaties');
    }
};
