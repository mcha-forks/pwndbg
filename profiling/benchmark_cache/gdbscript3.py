import pwndbg


@pwndbg.lib.cache.cache_until("stop")
def foo():
    return 1

cache = foo.cache
N = 5_000_000

with open("results", "w") as f:
    for i in range(5):
        pwndbg.profiling.profiler.start()
        for i in range(N):
            foo()
            cache.clear()
        t = pwndbg.profiling.profiler.stop('profile.prof')
        print(f"AVG: {t/N}")
        f.write(f"{t}\n")
