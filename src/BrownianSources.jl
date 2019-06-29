module BrownianSources

import Distributions
import DistributionSums

struct immutable BrownianSource
	d::DistributionSums.DistributionSum
end

function BrownianSource(velocities, dispersivities, thresholds, upperbound, numsamples)
	@assert length(velocities) == length(dispersivities)
	@assert length(velocities) == length(thresholds)
	dists = map((v, d, t)->Distributions.InverseGaussian(t / v, t ^ 2 / (2 * v * d)), velocities, dispersivities, thresholds)
	d = DistributionSums.DistributionSum(numsamples, [0., upperbound], dists...)
	return BrownianSource(d)
end

function call(bs::BrownianSource, t::Real)
	return Distributions.pdf(bs.d, t) * (1 - bs.d.truncatedprobability)
end

end
