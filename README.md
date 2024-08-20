# Computer-Aided-Design-Projects-F2023

- [Computer-Aided-Design-Projects-F2023](#computer-aided-design-projects-f2023)
  - [CA1: Maxnet Neural Network](#ca1-maxnet-neural-network)
  - [CA2: Logic Design and FPGA Synthesis](#ca2-logic-design-and-fpga-synthesis)
  - [CA3: Convolution Neural Network](#ca3-convolution-neural-network)

## CA1: Maxnet Neural Network

In this project, a Maxnet Neural Network is implemented in hardware. It takes four inputs and produces one output. The inputs are 8-bit signed integers and the output is the maximum of the inputs. Formulas for Maxnet:

1. **Activation Function:**

The activation function for Maxnet is linear. If `Ei` is the input and `Ai` is the output, then:

```markdown
Ai = Ei, if Ei > 0
Ai = 0, otherwise
```

2. **Output Function:**

The output function for Maxnet is defined as:

```markdown
Ai(t+1) = Ai(t) - ε * Σ Aj(t), for j ≠ i
```

where:

- `Ai(t)` is the activation of neuron `i` at time `t`,
- `ε` is a small positive constant (ε > 0), and
- The sum is over all neurons `j` in the network, excluding `i`.

3. **Convergence:**

Maxnet will converge such that the neuron with the highest initial activation remains positive and all other neurons go to zero. This is expressed as:

```markdown
Ai(t) -> Ai(0), if Ai(0) = max(Aj(0)), for all j
Ai(t) -> 0, otherwise
```

## CA2: Logic Design and FPGA Synthesis

In this we re-implement the Maxnet Neural Network using logic gates and synthesize it for an FPGA. The design is implemented in Verilog and synthesized using Actel's Basic Module Library (BMF). The design is tested using a testbench and the results are verified using ModelSim. The design is then synthesized for an FPGA and the results are verified using the FPGA.

The design is implemented in the following steps:

1. First the gate-level design is implemented using logic gates.
2. Using those gates, small modules are implemented.
3. Using those modules, the Maxnet Neural Network is implemented.
4. The design is tested using a testbench and the results are verified using ModelSim.


## CA3: Convolution Neural Network

In this project, a Convolution Neural Network (CNN) is implemented in hardware. The CNN takes a matrix as input and produces a matrix as output. In first Phase only one layer is implemented, in the second phase, the CNN is implemented with multiple layers. 

Sure, here are some key formulas used in Convolutional Neural Networks (CNNs):

1. **Convolution Operation:**

The convolution operation in a CNN is defined as:

```markdown
(Z[i, j, k] = Σ Σ Σ X[a, b, c] * W[a, b, c, k]) + b[k]
```

where:

- `Z[i, j, k]` is the output of the convolution,
- `X[a, b, c]` is the input,
- `W[a, b, c, k]` is the weight of the filter,
- `b[k]` is the bias term,
- The sum is over all `a`, `b`, `c`.

2. **ReLU Activation Function:**

The ReLU (Rectified Linear Unit) activation function is commonly used in CNNs and is defined as:

```markdown
f(x) = max(0, x)
```

3. **Pooling Operation:**

The pooling operation in a CNN is defined as:

```markdown
Z[i, j, k] = max/avg (X[a, b, k])
```

where:

- `Z[i, j, k]` is the output of the pooling operation,
- `X[a, b, k]` is the input,
- The operation (max or avg) is applied over a specified window in the input.
