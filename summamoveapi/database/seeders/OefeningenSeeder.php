<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OefeningenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $OefeningenArray = [
            [
                'naam' => "Squat",
                'beschrijvingNL' => "Ga rechtop staan met je voeten op schouderbreedte. Buig je knieën en heupen om je lichaam naar beneden te brengen alsof je op een stoel gaat zitten, houd je rug recht. Kom terug omhoog.",
                'beschrijvingEN' => "Stand upright with your feet shoulder-width apart. Bend your knees and hips to lower your body as if sitting on a chair, keeping your back straight. Return to standing.",
            ]
        ];
        DB::table('oefeningen')->insert($OefeningenArray);
    }
}
