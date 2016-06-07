clear all; close all; clc

% import data
x = load('ex4x.dat');
y = load('ex4y.dat');

[m, n] = size(x);

x = [ones(m, 1), x];

% find returns the indices of the
% rows meeting the specified condition
pos = find(y == 1);
neg = find(y == 0);

% Assume the features are in the 2nd and 3rd
% columns of x
figure
plot(x(pos, 2), x(pos, 3), '+'); hold on
plot(x(neg, 2), x(neg, 3), 'o'); hold on
xlabel('Exam 1 score');
ylabel('Exam 2 score');

g = inline('1.0 ./ (1.0 + exp(-z))'); 
% Usage: To find the value of the sigmoid 
% evaluated at 2, call g(2)

% Initialize fitting parameters
theta = zeros(n+1, 1);

% Newton's method
MAX_ITR = 5;
J = zeros(MAX_ITR, 1);

for i = 1:MAX_ITR
  z = x * theta;
  h = g(z);

  % Calculate gradient and hessian.
  % The formulas below are equivalent to the summation formulas
  % given in the lecture videos.
  grad = (1/m).*x' * (h-y);
  H = (1/m).*x' * diag(h) * diag(1-h) * x;
    
  % Calculate J (for testing convergence)
  J(i) =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h));
    
  theta = theta - H\grad;
end

theta

% Calculate the probability that a student with
% Score 20 on exam 1 and score 80 on exam 2 
% will not be admitted
prob = 1 - g([1, 20, 80]*theta)

% Plot Newton's method result
% Only need 2 points to define a line, so choose two endpoints
plot_x = [min(x(:,2))-2,  max(x(:,2))+2];
% Calculate the decision boundary line
plot_y = (-1./theta(3)).*(theta(2).*plot_x +theta(1));
plot(plot_x, plot_y)
legend('Admitted', 'Not admitted', 'Decision Boundary')
hold off

% Plot J
figure
plot(0:MAX_ITR-1, J, 'o--', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
xlabel('Iteration'); ylabel('J')
% Display J
J