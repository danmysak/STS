var a, b: longint;

begin
    assign(input, 'sum.in');
    reset(input);
    assign(output, 'sum.out');
    rewrite(output);

    while true do;

    read(a, b);
    writeln(a + b);

    close(input);
    close(output);
end.
