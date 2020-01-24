var a, b: longint;

begin
    assign(input, 'sum.in');
    reset(input);
    assign(output, 'summ.out');
    rewrite(output);

    read(a, b);
    writeln(a + b);

    close(input);
    close(output);
end.