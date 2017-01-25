%Mark Asfour
%SID: 861098237
%4/4/16
%CS 171
%PS 1

function plotdata(fname, a1, a2)
%read file
A = load(fname);

%plot
hold on;
for row = 1:size(A, 1),
    if A(row, 5) == 0
        plot(A(row, a1), A(row, a2), 'ro');
    elseif A(row, 5) == 1
        plot(A(row, a1), A(row, a2), 'bx');
    elseif A(row, 5) == 2
        plot(A(row, a1), A(row, a2), 'gs');
    end; 
end;
xlabel(['attribute ', num2str(a1)]);
ylabel(['attribute ', num2str(a2)]);

end

