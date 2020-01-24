var a, b: longint;

begin
    assign(input, 'sum.in');
    reset(input);
    assign(output, 'sum.out');
    rewrite(output);

    a := 0;
    b := 3 div a;

    read(a, b);
    writeln(a + b);

    close(input);
    close(output);
end.
