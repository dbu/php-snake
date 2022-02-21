<?php

$finder = PhpCsFixer\Finder::create()
    ->in('src/')
;

$config = new PhpCsFixer\Config();
return $config->setRules([
        '@Symfony' => true,
    ])
    ->setFinder($finder)
;
