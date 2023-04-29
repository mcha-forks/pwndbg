import pwndbg


@pwndbg.lib.cache.cache_until("stop")
def foo():
    return 1

cache = foo.cache
N = 5_000_000

foo()

# This benchmark profiles just clearing empty cache entries
with open("results", "w") as f:
    for i in range(5):
        pwndbg.profiling.profiler.start()
        for i in range(N):
            cache.clear()
        t = pwndbg.profiling.profiler.stop('profile.prof')
        print(f"AVG: {t/N}")
        f.write(f"{t}\n")
