clear all; close all; clc
x = load('ex2x.dat');
y = load('ex2y.dat');

figure; % open a new figure window
plot(x,y,'o');
ylabel('Height in meters')
xlabel('Age in years')


function h_model = make_regression(row, theta, x)
  h_model = theta' * x(row, :)'; % := first row, all columns of x
endfunction


% adds x0 = 1 intercept term to every example
m = length(y); % store the number of training examples
x = [ones(m, 1), x]; % Add a column of ones to x
theta = zeros(size(x(1,:)))';
alpha = 0.07;


for num_iterations = 1:1500
  % This is a vectorized version of the 
  % gradient descent update formula
  % It's also fine to use the summation formula from the videos
  
  % Here is the gradient
  grad = (1/m).* x' * ((x * theta) - y);
  
  % Here is the actual update
  theta = theta - alpha .* grad;
endfor
theta

hold on % Plot new data without clearing old plot
plot(x(:,2), x*theta, '-') % remember that x is now a matrix with 2 columns
                           % and the second column contains the time info
legend('Training data', 'Linear regression')

% Predict values for age 3.5 and 7
predict1 = [1, 3.5] * theta
predict2 = [1, 7] * theta

J_vals = zeros(100, 100);   % initialize Jvals to 100x100 matrix of 0's
theta0_vals = linspace(-3, 3, 100);
theta1_vals = linspace(-1, 1, 100);
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
    t = [theta0_vals(i); theta1_vals(j)];
    J_vals(i,j) = (0.5/m) .* (x * t - y)' * (x * t - y);
    end
end

% Plot the surface plot
% Because of the way meshgrids work in the surf command, we need to 
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals'
figure;
surf(theta0_vals, theta1_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1')
