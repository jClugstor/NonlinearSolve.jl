using NonlinearSolveBase, Test

# Test with concrete parameters and u0
prob = NonlinearProblem((u, p) -> u^2 - p, 1.0, 2.0)
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true)

@test prob2.u0 == 1.0
@test prob2.p == 2.0


# Test override parameters
prob = NonlinearProblem((u, p) -> u^2 - p, 1.0, nothing)
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true; p = 2.5)
@test prob2.p === 2.5

# Test override u0
prob = NonlinearProblem((u, p) -> u^2 - p, nothing, 2.0)  
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true; u0 = 1.5)
@test prob2.u0 === 1.5

# Test NonlinearLeastSquaresProblem
prob = NonlinearLeastSquaresProblem((du, u, p) -> (du[1] = u[1]^2 - p; du[2] = u[1] - 1), [1.0], 2.0; resid_prototype = zeros(2))
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true)
@test prob2.u0 == [1.0]
@test prob2.p == 2.0

# Test NonlinearLeastSquaresProblem with concrete parameters
prob = NonlinearLeastSquaresProblem((du, u, p) -> (du[1] = u[1]^2 - p; du[2] = u[1] - 1), [1.5], 3.0; resid_prototype = zeros(2))
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true)
@test prob2.u0 == [1.5]
@test prob2.p == 3.0

# Test SteadyStateProblem with concrete parameters
prob = SteadyStateProblem((u, p, t) -> u^2 - p, 1.5, 3.0)
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true)
@test prob2.u0 == 1.5
@test prob2.p == 3.0



# Test SteadyStateProblem override parameters
prob = SteadyStateProblem((u, p, t) -> u^2 - p, 1.0, nothing)
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true; p = 3.5)
@test prob2.p === 3.5

# Test SteadyStateProblem override u0
prob = SteadyStateProblem((u, p, t) -> u^2 - p, nothing, 2.0)
prob2 = NonlinearSolveBase.get_concrete_problem(prob, true; u0 = 2.5)
@test prob2.u0 === 2.5