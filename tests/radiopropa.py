"""Exercise the installed RadioPropa Python binding and one ray step."""

import math

import radiopropa as rp


vector = rp.Vector3d(3, 4, 0)
assert math.isclose(vector.getR(), 5)

candidate = rp.Candidate()
candidate.current.setPosition(rp.Vector3d(0, 0, 0))
candidate.current.setDirection(rp.Vector3d(1, 0, 0))
rp.SimplePropagation(1 * rp.kpc, 1 * rp.kpc).process(candidate)
assert math.isclose(candidate.current.getPosition().x, 1 * rp.kpc, rel_tol=1e-12)
print("RadioPropa: vector math and propagation passed")
