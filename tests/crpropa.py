"""Exercise the installed CRPropa Python binding and one propagation step."""

import math

import crpropa as cp


vector = cp.Vector3d(3, 4, 0)
assert math.isclose(vector.getR(), 5)

candidate = cp.Candidate()
candidate.current.setPosition(cp.Vector3d(0, 0, 0))
candidate.current.setDirection(cp.Vector3d(1, 0, 0))
cp.SimplePropagation(1 * cp.kpc, 1 * cp.kpc).process(candidate)
assert math.isclose(candidate.current.getPosition().x, 1 * cp.kpc, rel_tol=1e-12)
print("CRPropa: vector math and propagation passed")
