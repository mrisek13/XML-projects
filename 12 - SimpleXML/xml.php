<?php
$xml = simplexml_load_file('tablica_kalorija.xml');

if ($xml === false) {
    die("Greška pri učitavanju XML datoteke.");
}

echo "Namirnice iz kategorije VOĆE:<br><br>";
foreach ($xml->vrsta_hrane as $vrsta) {
    if ($vrsta['tip'] == 'voce') {
        foreach ($vrsta->namirnica as $namirnica) {
            $naziv = $namirnica->naziv;
            $energija_kj = $namirnica->energija[0];
            $energija_kcal = $namirnica->energija[1];
            echo "- $naziv: $energija_kj kJ, $energija_kcal kcal<br>";
        }
    }
}

echo "<br>Namirnice s više od 10 g bjelančevina:<br><br>";
foreach ($xml->vrsta_hrane as $vrsta) {
    foreach ($vrsta->namirnica as $namirnica) {
        $bjelancevine = floatval($namirnica->bjelancevine);
        if ($bjelancevine > 10) {
            $naziv = $namirnica->naziv;
            echo "- $naziv: $bjelancevine g bjelančevina<br>";
        }
    }
}

$newXml = new SimpleXMLElement('<tablica_kalorija></tablica_kalorija>');
foreach ($xml->vrsta_hrane as $vrsta) {
    foreach ($vrsta->namirnica as $namirnica) {
        $kcal = intval($namirnica->energija[1]);
        if ($kcal < 100) {
            $novaNamirnica = $newXml->addChild('namirnica');
            $novaNamirnica->addChild('naziv', $namirnica->naziv);
            $novaNamirnica->addChild('energija', $namirnica->energija[0])->addAttribute('mjera', 'kJ');
            $novaNamirnica->addChild('energija', $namirnica->energija[1])->addAttribute('mjera', 'kcal');
            $novaNamirnica->addChild('uh', $namirnica->uh);
            $novaNamirnica->addChild('bjelancevine', $namirnica->bjelancevine);
            $novaNamirnica->addChild('masti', $namirnica->masti);
        }
    }
}

$newXml->asXML('namirnice_ispod_100kcal.xml');

$novaKategorija = $xml->addChild('vrsta_hrane');
$novaKategorija->addAttribute('tip', 'bezglutenski_proizvodi');

$namirnice = [
    [
        'naziv' => 'Kvinoja',
        'energija_kcal' => 368,
        'energija_kj' => 1540,
        'uh' => 64,
        'bjelancevine' => 14,
        'masti' => 6
    ],
    [
        'naziv' => 'Kukuruzno brašno',
        'energija_kcal' => 370,
        'energija_kj' => 1548,
        'uh' => 79,
        'bjelancevine' => 7,
        'masti' => 3
    ],
    [
        'naziv' => 'Heljda',
        'energija_kcal' => 343,
        'energija_kj' => 1436,
        'uh' => 71.5,
        'bjelancevine' => 13.3,
        'masti' => 3.4
    ]
];

foreach ($namirnice as $namirnica) {
    $novaNamirnica = $novaKategorija->addChild('namirnica');
    $novaNamirnica->addChild('naziv', $namirnica['naziv']);
    $novaNamirnica->addChild('energija', $namirnica['energija_kj'])->addAttribute('mjera', 'kJ');
    $novaNamirnica->addChild('energija', $namirnica['energija_kcal'])->addAttribute('mjera', 'kcal');
    $novaNamirnica->addChild('uh', $namirnica['uh']);
    $novaNamirnica->addChild('bjelancevine', $namirnica['bjelancevine']);
    $novaNamirnica->addChild('masti', $namirnica['masti']);
}

$xml->asXML('tablica_kalorija_azurirano.xml');
?>
