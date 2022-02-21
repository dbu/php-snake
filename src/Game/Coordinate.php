<?php

namespace Dbu\Snake\Game;

class Coordinate
{
    public int $x;

    public int $y;

    public function __construct(int $x, int $y)
    {
        $this->x = $x;
        $this->y = $y;
    }

    public function equals(Coordinate $goal): bool
    {
        return $goal->x === $this->x && $goal->y === $this->y;
    }
}
