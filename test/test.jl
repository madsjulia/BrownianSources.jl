using Base.Test
import BrownianSources
import Distributions

function sanitycheck()
	#make sure it reproduces the inverse gaussian in the case of only one brownian motion
	velocities = Float64[1.]
	dispersivities = Float64[.1]
	thresholds = Float64[2.]
	upperbound = 5.
	bs = BrownianSources.BrownianSource(velocities, dispersivities, thresholds, upperbound, 10000)
	ig = Distributions.InverseGaussian(thresholds[1] / velocities[1], thresholds[1] ^ 2 / (2 * velocities[1] * dispersivities[1]))
	ts = linspace(0, upperbound, 1001)
	pdfs = map(bs, ts)
	truepdfs = map(t->Distributions.pdf(ig, t), ts)
	@test maximum(abs(pdfs - truepdfs)) < 1e-4
end

sanitycheck()
