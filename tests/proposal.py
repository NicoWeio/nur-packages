"""Exercise PROPOSAL's Python binding and particle/medium definitions."""

import math

import proposal as pp


muon = pp.particle.MuMinusDef()
antimuon = pp.particle.MuPlusDef()
assert math.isclose(muon.mass, antimuon.mass)
assert muon.charge == -antimuon.charge
assert muon.mass > 100  # MeV

water = pp.medium.Water()
assert water.mass_density > 0
print("PROPOSAL: particle and medium definitions passed")
