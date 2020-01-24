var a, b: longint;

begin
    assign(input, 'sum.in');
    reset(input);
    assign(output, 'sum.out');
    rewrite(output);

    read(a, b);
    write(a + b);

    close(input);
    close(output);
end.