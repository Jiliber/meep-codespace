import meep as mp

print("MEEP version:", mp.__version__)

cell = mp.Vector3(16, 8, 0)
geometry = [mp.Block(center=mp.Vector3(),
                     size=mp.Vector3(1, 4, mp.inf))]
sources = [mp.Source(mp.ContinuousSource(frequency=0.15),
                     component=mp.Ez,
                     center=mp.Vector3(-7,0))]

sim = mp.Simulation(cell_size=cell, geometry=geometry,
                    sources=sources, resolution=10)

sim.run(until=20)
print("Simulation complete.")
