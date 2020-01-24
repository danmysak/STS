var a, b, i, j: longint;
c: array[0..9999] of array[0..9999] of longint;
begin
    assign(input, 'sum.in');
    reset(input);
    assign(output, 'sum.out');
    rewrite(output);

    read(a, b);

    for i := 0 to 9999 do
        for j := 0 to 9999 do
            if i mod 2 = 1 then
                c[i][j] := a
            else
                c[i][j] := b;

    writeln(c[9998][9998] + c[9999][9999]);

    close(input);
    close(output);
end.
