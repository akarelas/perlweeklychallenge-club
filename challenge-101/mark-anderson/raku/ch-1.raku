#!/usr/bin/env raku

use Test;
plan 6;

is-deeply pack-a-spiral(1..4),   ((4,3), (1,2));
is-deeply pack-a-spiral(1..6),   ((6,5,4), (1,2,3));
is-deeply pack-a-spiral(1..12),  ((9,8,7,6), (10,11,12,5), (1,2,3,4));
is-deeply pack-a-spiral(1..13),  ((1,2,3,4,5,6,7,8,9,10,11,12,13),);
is-deeply pack-a-spiral(1..143),
(
(35,  34,  33,  32,  31,  30,  29,  28,  27,  26,  25,  24,  23), 
(36,  73,  72,  71,  70,  69,  68,  67,  66,  65,  64,  63,  22), 
(37,  74, 103, 102, 101, 100,  99,  98,  97,  96,  95,  62,  21), 
(38,  75, 104, 125, 124, 123, 122, 121, 120, 119,  94,  61,  20), 
(39,  76, 105, 126, 139, 138, 137, 136, 135, 118,  93,  60,  19), 
(40,  77, 106, 127, 140, 141, 142, 143, 134, 117,  92,  59,  18), 
(41,  78, 107, 128, 129, 130, 131, 132, 133, 116,  91,  58,  17), 
(42,  79, 108, 109, 110, 111, 112, 113, 114, 115,  90,  57,  16), 
(43,  80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  56,  15), 
(44,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  55,  14), 
( 1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13)
);
is-deeply pack-a-spiral(1..144),
(
(34,  33,  32,  31,  30,  29,  28,  27,  26,  25,  24,  23), 
(35,  72,  71,  70,  69,  68,  67,  66,  65,  64,  63,  22), 
(36,  73, 102, 101, 100,  99,  98,  97,  96,  95,  62,  21), 
(37,  74, 103, 124, 123, 122, 121, 120, 119,  94,  61,  20), 
(38,  75, 104, 125, 138, 137, 136, 135, 118,  93,  60,  19), 
(39,  76, 105, 126, 139, 144, 143, 134, 117,  92,  59,  18), 
(40,  77, 106, 127, 140, 141, 142, 133, 116,  91,  58,  17), 
(41,  78, 107, 128, 129, 130, 131, 132, 115,  90,  57,  16), 
(42,  79, 108, 109, 110, 111, 112, 113, 114,  89,  56,  15), 
(43,  80,  81,  82,  83,  84,  85,  86,  87,  88,  55,  14), 
(44,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  13), 
( 1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12)
);

sub tightest-factor($n) 
{
    my @factors;
          
    for 1..sqrt($n) -> $i 
    {
        @factors.push: ($i, $n div $i) if $n %% $i; 
    }

    @factors.sort({.[1] - .[0]}).head.tail;
}

sub pack-a-spiral(@list is copy) 
{
    my $factor = tightest-factor(+@list);

    my @matrix = @list.keys.rotor($factor).map(*.Array);
    my @keys;

    while @matrix
    {
        @keys.append:   @matrix.pop.flat;
        try @keys.push: @matrix[$_].pop for @matrix.end...0;
        try @keys.push: |@matrix.shift.reverse;
        try @keys.push: @matrix[$_].shift for ^@matrix;
    }

    @list[@keys] = @list;
    @list.rotor($factor);
}
