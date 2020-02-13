-module(b64).
-export([encode/1, decode/1]).

encode(<<>>)                    -> [];
encode(<<Sextet:6, Rest/bits>>) -> [todigit(Sextet)|encode(Rest)];
encode(Remainder)               ->
    %% less than 6 bits remain, so we need padding characters
    %% if 4 bits remain -> pad with two 0 bits and add one padding character to output
    %% if 2 bits remain -> pad with four 0 bits and add two padding characters to output
    case bit_size(Remainder) of
        4 ->
            <<Sextet:6>> = <<Remainder/bits, 0:2>>,
            [todigit(Sextet),$=|encode(<<>>)];
        2 ->
            <<Sextet:6>> = <<Remainder/bits, 0:4>>,
            [todigit(Sextet),$=,$=|encode(<<>>)]
    end.


decode(Text)           -> decode(Text, <<>>).
decode([], Bytes)      -> Bytes;
decode("==", Bits)     ->
    Len = (bit_size(Bits) - 4) div 8,
    <<Bytes:Len/binary, 0:4>> = Bits,
    Bytes;
decode("=", Bits)      ->
    Len = (bit_size(Bits) - 2) div 8,
    <<Bytes:Len/binary, 0:2>> = Bits,
    Bytes;
decode([C|Rest], Bits) ->
    Decoded = fromdigit(C),
    decode(Rest, <<Bits/bits, Decoded:6>>).


todigit(2#000000) -> $A;
todigit(2#000001) -> $B;
todigit(2#000010) -> $C;
todigit(2#000011) -> $D;
todigit(2#000100) -> $E;
todigit(2#000101) -> $F;
todigit(2#000110) -> $G;
todigit(2#000111) -> $H;
todigit(2#001000) -> $I;
todigit(2#001001) -> $J;
todigit(2#001010) -> $K;
todigit(2#001011) -> $L;
todigit(2#001100) -> $M;
todigit(2#001101) -> $N;
todigit(2#001110) -> $O;
todigit(2#001111) -> $P;
todigit(2#010000) -> $Q;
todigit(2#010001) -> $R;
todigit(2#010010) -> $S;
todigit(2#010011) -> $T;
todigit(2#010100) -> $U;
todigit(2#010101) -> $V;
todigit(2#010110) -> $W;
todigit(2#010111) -> $X;
todigit(2#011000) -> $Y;
todigit(2#011001) -> $Z;
todigit(2#011010) -> $a;
todigit(2#011011) -> $b;
todigit(2#011100) -> $c;
todigit(2#011101) -> $d;
todigit(2#011110) -> $e;
todigit(2#011111) -> $f;
todigit(2#100000) -> $g;
todigit(2#100001) -> $h;
todigit(2#100010) -> $i;
todigit(2#100011) -> $j;
todigit(2#100100) -> $k;
todigit(2#100101) -> $l;
todigit(2#100110) -> $m;
todigit(2#100111) -> $n;
todigit(2#101000) -> $o;
todigit(2#101001) -> $p;
todigit(2#101010) -> $q;
todigit(2#101011) -> $r;
todigit(2#101100) -> $s;
todigit(2#101101) -> $t;
todigit(2#101110) -> $u;
todigit(2#101111) -> $v;
todigit(2#110000) -> $w;
todigit(2#110001) -> $x;
todigit(2#110010) -> $y;
todigit(2#110011) -> $z;
todigit(2#110100) -> $0;
todigit(2#110101) -> $1;
todigit(2#110110) -> $2;
todigit(2#110111) -> $3;
todigit(2#111000) -> $4;
todigit(2#111001) -> $5;
todigit(2#111010) -> $6;
todigit(2#111011) -> $7;
todigit(2#111100) -> $8;
todigit(2#111101) -> $9;
todigit(2#111110) -> $+;
todigit(2#111111) -> $/.


fromdigit($A) -> 2#000000;
fromdigit($B) -> 2#000001;
fromdigit($C) -> 2#000010;
fromdigit($D) -> 2#000011;
fromdigit($E) -> 2#000100;
fromdigit($F) -> 2#000101;
fromdigit($G) -> 2#000110;
fromdigit($H) -> 2#000111;
fromdigit($I) -> 2#001000;
fromdigit($J) -> 2#001001;
fromdigit($K) -> 2#001010;
fromdigit($L) -> 2#001011;
fromdigit($M) -> 2#001100;
fromdigit($N) -> 2#001101;
fromdigit($O) -> 2#001110;
fromdigit($P) -> 2#001111;
fromdigit($Q) -> 2#010000;
fromdigit($R) -> 2#010001;
fromdigit($S) -> 2#010010;
fromdigit($T) -> 2#010011;
fromdigit($U) -> 2#010100;
fromdigit($V) -> 2#010101;
fromdigit($W) -> 2#010110;
fromdigit($X) -> 2#010111;
fromdigit($Y) -> 2#011000;
fromdigit($Z) -> 2#011001;
fromdigit($a) -> 2#011010;
fromdigit($b) -> 2#011011;
fromdigit($c) -> 2#011100;
fromdigit($d) -> 2#011101;
fromdigit($e) -> 2#011110;
fromdigit($f) -> 2#011111;
fromdigit($g) -> 2#100000;
fromdigit($h) -> 2#100001;
fromdigit($i) -> 2#100010;
fromdigit($j) -> 2#100011;
fromdigit($k) -> 2#100100;
fromdigit($l) -> 2#100101;
fromdigit($m) -> 2#100110;
fromdigit($n) -> 2#100111;
fromdigit($o) -> 2#101000;
fromdigit($p) -> 2#101001;
fromdigit($q) -> 2#101010;
fromdigit($r) -> 2#101011;
fromdigit($s) -> 2#101100;
fromdigit($t) -> 2#101101;
fromdigit($u) -> 2#101110;
fromdigit($v) -> 2#101111;
fromdigit($w) -> 2#110000;
fromdigit($x) -> 2#110001;
fromdigit($y) -> 2#110010;
fromdigit($z) -> 2#110011;
fromdigit($0) -> 2#110100;
fromdigit($1) -> 2#110101;
fromdigit($2) -> 2#110110;
fromdigit($3) -> 2#110111;
fromdigit($4) -> 2#111000;
fromdigit($5) -> 2#111001;
fromdigit($6) -> 2#111010;
fromdigit($7) -> 2#111011;
fromdigit($8) -> 2#111100;
fromdigit($9) -> 2#111101;
fromdigit($+) -> 2#111110;
fromdigit($/) -> 2#111111.
