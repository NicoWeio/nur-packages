"""Build a small flow, sample it, and evaluate its log density."""

import torch

import jammy_flows


torch.manual_seed(1)
flow = jammy_flows.pdf("e2", "gg")
samples, _, log_prob, _ = flow.sample(samplesize=4)
assert samples.shape == (4, 2)
assert log_prob.shape == (4,)
assert torch.isfinite(samples).all()
assert torch.isfinite(log_prob).all()
evaluated, *_ = flow(samples)
assert torch.allclose(evaluated, log_prob, atol=1e-4)
print("jammy-flows: sampling and log density passed")
