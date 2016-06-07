clear all; close all; clc

% Import data
x = load('ex3x.dat');
y = load('ex3y.dat');

m = length(y); % number of training examples

x = [ones(m, 1), x];
x_unscaled = x;

% scale inputs by their SD and set their means to 0
sigma = std(x);
mu = mean(x);
x(:,2) = (x(:,2) - mu(2))./ sigma(2); % (feature - avg) / SD
x(:,3) = (x(:,3) - mu(3))./ sigma(3); % (feature - avg) / SD

theta = zeros(size(x(1,:)))'; % initialize fitting parameters
alpha = 1.0; % initial learning rate
MAX_ITR = 50;
J = zeros(MAX_ITR, 1); 

for num_iterations = 1:MAX_ITR
    % cost function
    J(num_iterations) = (0.5/m) .* (x * theta - y)' * (x * theta - y);
    
    % Here is the gradient
    grad = (1/m) .* x' * ((x * theta) - y);
  
    % Here is the actual update
    theta = theta - alpha .* grad;
end

% now plot J
% technically, the first J starts at the zero-eth iteration
% but Matlab/Octave doesn't have a zero index
figure;
plot(0:49, J(1:50), '-');
xlabel('Number of iterations');
ylabel('Cost J');

format long

%% prediction using gradient decent
predict_grad_desc = [1, (1650 - mu(2))/sigma(2), (3 - mu(3))/sigma(3)] * theta

% normal equation calculation
theta_norm = inv(x_unscaled' * x_unscaled) * x_unscaled' * y;

% prediction using normal equation
predict_normal = [1, 1650, 3] * theta_norm