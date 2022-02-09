# Wright.jl

Fox–Wright Psi function (Φ function) in Julia. (Not to be confused with [Wright Omega function](https://en.wikipedia.org/wiki/Wright_omega_function))

Here, we use the notation in by Professor yuri Luchko which is using Mainardi's notation.

The equation:
$$
W(\rho, \beta; z) = \sum^{\infty}_{k=0}\frac{z^k}{k!\Gamma(\beta + \rho k)}
$$


While the Mittag Leffler function can be expressed by the Wright function $
E_{\alpha,\beta} = \displaystyle\sum_{k=0}^{\infty}\frac{z^k}{\Gamma(\alpha k+\beta)},\quad (\alpha>0, \beta>0)
$
using the Laplace transform :
$$
\mathrm{L}\{W(t; \alpha, \beta);s\} = L\{\sum_{k=0}^{\infty}\frac{t^k}{k!\Gamma(\alpha k +\beta)}; s\}
$$

## Reference
The Wright function and its numerical evaluation. Y.F. Luchko, J.J. Trujillo, M.P. Velasco

January 2010International Journal of Pure and Applied Mathematics 64(4):567-575