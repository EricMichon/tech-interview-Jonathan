
### Technical interview: Quantum Service Developer/Quantum Algorithm Engineer

##### Task
We need a new service on our platform that enables the user to input instances of the Max-Cut Problem and solve them with the QAOA algorithm using the Qiskit AER simulator. You are tasked with developing the python code that should be ready for containerization, as it is the standard for the platform. The code should have at least one main function that runs the entire application and the repository should contain the necessary file to recreate the virtual environment inside the container. 
The user will pass one input which will be a JSON file containing the problem as a dictionary of edges and the relevant parameters for QAOA and receive one output, a JSON file containing the solution mapped to a set of vertices. 

The implementation should be thought as an MVP, keeping in mind for example that QAOA might not be the only solver implemented in the future. And it should be thought in terms of CI-CD workflow allowing to maintain and develop at the same time.

#### Resources

We created a repository that will be available to you. One of the team members will be available and will participate in the task as pair programmer. You are the lead of the task and have responsibility over its execution and its delivery, but the team member is there to help with brain storming, debugging and whatever else you’ll want to use his/her help for. Feel free, for example, to brainstorm on architecture if you need to. The team member can also help you to vocalize your train of thoughts. You are free to use the internet and AI to help you in the task within reasonable usage.

#### Goal
We don’t necessarily expect that the task will be done within the hour but we expect clean implementation, targeted for production and maintenance. We want to see how you:

- prioritize your time under pressure,
- manage resources,
- tackle problems,
- work and collaborate in a small team,
- design the architecture of the code,
- implement clean code directed towards continuous delivery.

We won’t necessarily assess your knowledge of specific Python Libraries or whether you can code without typos. We want to see how you work.


#### Documentation

In what follows we give you summaries of the Max-Cut problem and  the Quantum Approximate Optimization Algorithm (QAOA).


##### Maximum Cut (Max-Cut) Problem

The Max-Cut Problem is a classic combinatorial optimization challenge defined on an undirected graph $G=(V,E)$ with vertex set $V$ and edge set $E$. The goal is to partition the vertex set $V$ into two disjoint subsets $S$ and $V ∖ S$, such that the number of edges crossing the cut —i.e., with one endpoint in each subset—is maximized. The number of edges crossing the cut is also called the weight of the cut and denoted by $w(S)$.

This problem is NP-hard, and classical algorithms often rely on approximation techniques (e.g., semidefinite programming, greedy heuristics). However, quantum algorithms offer a new computational paradigm that can potentially find better solutions or faster approximations.

###### Reformulation for Quantum Optimization
To run this problem on a quantum computer, we first reformulate it as a binary optimization problem. Let $n$ be the number of vertices in the graph, and define a binary variable $z_i ∈ {−1,1}$ (or equivalently, $\{0,1\}$) to each vertex $i ∈ V_i$. An edge $(i, j)$ contributes to the cut if $z_{i} \neq z_j$ which corresponds to:

$$w(z)= \sum\limits_{(i.j) \in E} \frac{(1-z_i)(1-z_j)}{4}$$


Thus, the goal is to maximize the above objective over all $z \in$ { $-1, 1$ } $^n$



#### QAOA
The Quantum Approximate Optimization Algorithm (QAOA) is a variational quantum-classical algorithm designed to solve discrete optimization problems. It leverages quantum circuits to explore solution spaces while relying on classical computation to optimize circuit parameters.
It is particularly well-suited to NISQ (Noisy Intermediate-Scale Quantum) devices due to its shallow circuit depth and flexibility.


##### Problem Formulation
QAOA targets problems expressible in the form:

maximize $C(z)$ where $z \in$ { $-1, 1$ } $^n$


where $C(z)$ is a cost function associated with a binary string $z$. This includes problems like Max-Cut, Max-SAT, and general quadratic unconstrained binary optimization (QUBO).
To proceed, the cost function must be encoded as a problem Hamiltonian—a sum of Pauli $Z$ terms whose ground state encodes the optimal solution.

##### Algorithm Structure
QAOA proceeds through the following major steps:

1. **Setting up the problem Hamiltonian**: The cost Hamiltonian corresponding to the problem encodes the objective function. It is diagonal in the computational basis and assigns energy to each bitstring based on the objective value.
2. **Setting up the mixer Hamiltonian**: The mixer hamiltonian Introduces transitions between bitstrings and ensures exploration of the solution space. Typically it is the same for all problems and equals a sum of Pauli $X$ operators.
3. **Quantum State Preparation**: The algorithm begins with a uniform superposition over all bitstrings.
4. **Construction of the prametrized circuit**: A parameterized quantum circuit applies alternating unitaries derived from the cost and mixer Hamiltonians. Each layer of the circuit is governed by a pair of parameters $(\gamma_k, \beta_k)$, with the number of layers denoted by $p$.

5. **Parameter Optimization**: The expected value of the cost Hamiltonian is measured with respect to the parameterized quantum state. A classical optimization routine adjusts the parameters $\gamma, \beta$ to maximize this expectation. This process consists of an iteration in a hybrid loop until convergence or a stopping condition is met.
6. Measurement and Sampling: After optimization, the final quantum state is measured multiple times using the resulting circuit. Each outcome corresponds to a candidate solution. The solution with the highest cost value is selected as the output.

##### Practical Considerations
- Circuit Depth: QAOA is designed to operate at shallow depths, but deeper circuits (higher ppp) generally yield better approximations.
- Hardware Constraints: Ensure the quantum hardware or simulator supports the required gate operations and connectivity for your problem instance.
- Noise Resilience: QAOA can tolerate moderate levels of noise, especially at low depths. Techniques like error mitigation can further improve performance.
- Initialization: Parameter selection for γ\gammaγ and β\betaβ can impact convergence. Strategies include random sampling, heuristic guessing, or warm-starting from classical solutions.
- Output: The result of a QAOA run includes:
	- A bitstring representing a high-quality or optimal solution,
	- The value of the cost function associated with that solution,
	- The optimized variational parameters used in the quantum circuit.
 
