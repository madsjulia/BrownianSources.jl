import PyPlot
import BrownianSources

#PyPlot.clf()
velocities = Float64[1., 2.]
dispersivities = Float64[.1, 10.]
thresholds = Float64[2., 7.]
upperbound = 5.
bs = BrownianSources.BrownianSource(velocities, dispersivities, thresholds, upperbound, 10000)
bs2 = BrownianSources.BrownianSource(velocities, dispersivities, thresholds, 40., 10000)
ts = linspace(0, upperbound, 1001)
PyPlot.plot(ts, map(bs, ts) ./ map(bs2, ts))
PyPlot.plot(ts, map(bs2, ts))
PyPlot.ylim(0, 2)
