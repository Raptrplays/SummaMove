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
            ],
            [
                'naam' => "Push-up",
                'beschrijvingNL' => "Begin in een plankpositie met je handen op schouderbreedte. Buig je ellebogen om je lichaam naar de grond te brengen en duw jezelf weer omhoog.",
                'beschrijvingEN' => "Start in a plank position with your hands shoulder-width apart. Bend your elbows to lower your body to the ground and push yourself back up.",
            ],
            [
                'naam' => "Dip",
                'beschrijvingNL' => "Gebruik een stevige rand of stoel. Plaats je handen erachter en je voeten voor je. Buig je ellebogen om je lichaam naar beneden te brengen en duw jezelf weer omhoog.",
                'beschrijvingEN' => "Use a sturdy edge or chair. Place your hands behind you and your feet in front. Bend your elbows to lower your body and push yourself back up.",
            ],
            [
                'naam' => "Plank",
                'beschrijvingNL' => "Begin in een plankpositie met je ellebogen op de grond en je lichaam in een rechte lijn. Houd deze positie zo lang mogelijk vast.",
                'beschrijvingEN' => "Start in a plank position with your elbows on the ground and your body in a straight line. Hold this position for as long as possible.",
            ],
            [
                'naam' => "Paardentrap",
                'beschrijvingNL' => "Begin op handen en knieën. Trap een been krachtig naar achteren en omhoog, alsof je een paard nadoet.",
                'beschrijvingEN' => "Start on your hands and knees. Kick one leg powerfully backward and upward, imitating a donkey kick.",
            ],
            [
                'naam' => "Mountain climber",
                'beschrijvingNL' => "Begin in een plankpositie. Breng afwisselend je knieën naar je borst in een lopende beweging.",
                'beschrijvingEN' => "Start in a plank position. Alternately bring your knees to your chest in a running motion.",
            ],
            [
                'naam' => "Burpee",
                'beschrijvingNL' => "Begin rechtop, squat naar de grond en plaats je handen op de vloer. Spring je voeten naar achteren in een plankpositie, doe een push-up, spring je voeten terug naar je handen en spring omhoog.",
                'beschrijvingEN' => "Start upright, squat down, and place your hands on the floor. Jump your feet back into a plank position, do a push-up, jump your feet back to your hands, and jump up.",
            ],
            [
                'naam' => "Lunge",
                'beschrijvingNL' => "Sta rechtop en stap een voet naar voren. Buig beide knieën om je achterste knie naar de grond te brengen, houd je voorste knie boven je enkel. Keer terug naar de startpositie en wissel van been.",
                'beschrijvingEN' => "Stand upright and step one foot forward. Bend both knees to lower your back knee toward the ground, keeping your front knee over your ankle. Return to the start position and switch legs.",
            ],
            [
                'naam' => "Wall sit",
                'beschrijvingNL' => "Leun met je rug tegen een muur en zak door je knieën alsof je op een onzichtbare stoel zit. Houd deze positie vast.",
                'beschrijvingEN' => "Lean against a wall and lower yourself into a seated position as if sitting on an invisible chair. Hold this position.",
            ],
            [
                'naam' => "Crunch",
                'beschrijvingNL' => "Ga op je rug liggen met je knieën gebogen. Plaats je handen achter je hoofd en til je schouders van de grond door je buikspieren aan te spannen.",
                'beschrijvingEN' => "Lie on your back with your knees bent. Place your hands behind your head and lift your shoulders off the ground by contracting your abdominal muscles.",
            ],
        ];
        DB::table('oefeningen')->insert($OefeningenArray);
    }
}