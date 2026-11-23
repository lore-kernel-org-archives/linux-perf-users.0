Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470405;
	b=smQufsYcIhZOw8IewkKCJTkM9yFhptMP/UVaDe7ASAWnBMfqNfcbChzUHZySpYUZH122
	 YjfhTE/JLd9ecfyDRNoNb3gttReDcUtmnILQkj8ORc9tQ7Ae95RkPmMbJ1C80XYFz/U1d
	 26YH610xlJ0U2DbGhbuJpj0ZCCDe7zDQZZ5uQaNKuoUrNJDhRLwz8MC0UQh6RM6rA7pIU
	 B3vWJn61lSJ+LSJgdcBZn5dStawVBmUlkggvnJzAxIjd7ehb51zKfgAWVGcaDyIhlx4H4
	 425RD6MVCy6I56Uil7hvJDPr0wfyntH/lrUz+3oRM04xg9+i2eQAK1lEfaRAeaMITnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zTJutYqQiy5+Loxe2fukbllHCQvPBB5kBVDNquew1tk=;
	b=b9JfcS5MlcB6VY4Edsihm9Pri9wrVrsV26/jYvpTZQLl5fx2mwBy3A/J98rAJML4lfoX
	 jbdxWknBvZ0fA+u7eRKRaWoD/JcM4poXLvSd6Vl9GhEqO9VYAR+xBefxslHpCmnvPFTVz
	 N8dVslmWf/lW9oKQKLQVUpK/C+7TCVtq0oBHm9t0r7XCzeFWSntQHKatz551O3g/O4ylR
	 CJmnenXLu6XA9Z1t0a5kPGJuh13gqs2fhpGYNCnXx8vRoBnYHak8x8a0C/+tqaICOOGjv
	 wWk1GxK6WTWupZ9XGinhunwAYyuGe+9jNcENKskCOQEmdL+Ytd4Q13Eyq/XtmuQwW4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASppbr1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10689606A31E;
	Mon, 23 Nov 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASppbr1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B91F000C0;
	Mon, 23 Nov 2026 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470404;
	bh=zTJutYqQiy5+Loxe2fukbllHCQvPBB5kBVDNquew1tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ASppbr1T00OUJ3AGGxLSGRf2DZWyyQofa+KfFY856PPcYZw6TuhWcVPyHlz0F3E2A
	 QgbT0yIGE3fQ4mgy5hPPec+VmOXiyvNdM4hUDOlZl7htIZKWHdh26CzyikVXyni68n
	 1kbP/16TUnZW77imKc2Hk5tDX2BJnRX3zseoxc8t/5BKtGSz8WexC1bt7EU6bL0y1i
	 6UNcXiM0Kj1kwr3M7wP/rtK0kzf2oAHzHwtVnAqUacFSOsRfvHIMhaMVFnSmU0GC6v
	 S1ScqfOR63HyDzVz2yY39+Gvfj55LrYiJ7pyvUrZF82dmzP3r8vQKH5bOtE748q3JR
	 L1V78sWuqrbfw==
Date: Mon, 23 Nov 2026 13:46:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Message-ID: <awS0QkL6JuMfC7Z0@google.com>
References: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261122050405.80335-1-irogers@google.com>

Hi Ian,

On Sat, Nov 21, 2026 at 09:03:55PM -0800, Ian Rogers wrote:
> When profiling large binaries or long-running workloads with many DSOs and
> threads, symbol and DSO tables frequently dominate perf's memory footprint
> and startup latency. Currently `struct symbol` still has several structural
> limitations:
> 
> 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
>    `dso->symbols` address rbtree, scattering lookups across non-contiguous
>    heap nodes.
> 2. `dso__symbols()` has no internal synchronization against concurrent
>    readers/writers, and unreferenced DSOs and auxiliary symbol/debuginfo
>    buffers cannot yet be reclaimed under memory pressure.
> 3. Sorting `dso->symbols` with `qsort()` does not take advantage of
>    pre-ordered ascending runs in ELF symbol tables, and `first_ending_after()`
>    in `struct maps` runs a full binary search even for ascending
>    `/proc/pid/maps` synthesis.
> 
> Thirteen preparatory fixes, benchmarks, `dso_symbol` lifetime conversions,
> `symbol_conf.priv_size` removal, and ELF header caching patches from v4-v6
> have landed in `perf-tools-next`. The remaining 10 patches convert symbol
> iteration to callbacks, replace the `dso->symbols` rbtree with a sorted
> pointer array, stage natural-run merge sort and incremental symbol
> insertion, and add memory shrinking APIs and unit tests:

I've applied the first 6 patches to perf-tools-next.

The patch 7 was bigger than I expected.  Can you simplify it more?

Also I don't plan to merge the rest patches as of now.  Let's wait for
the lazy loading and try that for a while.

Thanks,
Namhyung

> 
> - **Preparatory fix, `maps` tail fast-path, and symbol iteration (Patches 1-4)**:
>   - Patch 1 fixes an `alloc_func_regex` leak on error returns in
>     `builtin-kmem.c`'s `build_alloc_func_list()`.
>   - Patch 2 adds an O(1) tail fast-path check in `first_ending_after()` for
>     ascending map insertions.
>   - Patch 3 converts `symbols__for_each_entry()`, `dso__for_each_symbol()`,
>     and `map__for_each_symbol()` to callback-based iteration and updates
>     existing callers.
>   - Patch 4 converts open-coded `dso__first_symbol()` / `dso__next_symbol()`,
>     `rb_first_cached()`, and `dso__symbol_names()` loops to callback
>     helpers and removes `dso__{first,last,next}_symbol()`.
> - **Sorted symbol arrays and staged sorting optimizations (Patches 5-7)**:
>   - Patch 5 replaces `dso->symbols` (`rb_root_cached`) and
>     `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
>     container backed by sorted pointer arrays, removing `struct rb_node`
>     from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
>     bytes, or 16 bytes net per symbol after accounting for the array
>     pointer).
>   - Patch 6 replaces `qsort()` on `struct symbols` with a stable
>     natural-run merge sort.
>   - Patch 7 optimizes incremental dynamic symbol insertions
>     (`dso__insert_symbol()`) and small appends using `@sorted_cnt` and a
>     sorted tail buffer with amortized `sqrt(N)` merge.
> - **Memory shrinking APIs and unit tests (Patches 8-10)**:
>   - Patch 8 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
>     `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
>     to reclaim `symbols_by_name`, excess array capacity, cached DSO file
>     descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
>     with no annotated symbols), with transparent on-demand reload via
>     `dso__load()`.
>   - Patch 9 adds `dso__session()` and `perf_session__malloc()` /
>     `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers (leaving
>     production caller wiring for follow-up once lazy symbol loading is
>     evaluated).
>   - Patch 10 adds unit tests in `perf test symbols` covering sorted symbol
>     insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
>     lifetime pinning, inline frame/srcline cleanup ordering,
>     `symbols_by_name` on-demand rebuild, transparent DSO reload, and session
>     allocation wrappers.
> 
> Changes in v8:
> - Rebase onto `tmp.perf-tools-next` (`eb79d2fbc230`), adopting
>   `<linux/compiler-context-analysis.h>` annotations (`__guarded_by(&lock)`,
>   `__acquires_shared(&symbols->lock)`, `__must_hold(&symbols->lock)`,
>   `__context_unsafe()`) on `struct symbols` and `dso` / `tests/symbols.c`
>   and adapting `dso__shrink()` / `dso__try_evict()` to `dso__data_open_lock`
>   and `close_dso()`.
> - Pass `first_unsorted` (`m = symbols->sorted_cnt`) to
>   `symbols__insertion_sort_range()` in `symbols__sort_locked()` (`Patch 7`)
>   so the `k <= 8` small-append fast path and allocation-failure fallbacks
>   skip scanning the already-sorted prefix `[0 .. m)` (Sashiko).
> 
> Changes in v7:
> - Rebase onto `perf-tools-next` (`bb27ddbaee56`), dropping the 3 patches
>   from v6 that have been applied upstream.
> - Drop `nr_addr_sorted` and `nr_name_sorted` incremental partial-sort state
>   from `struct maps`, keeping only the `first_ending_after()` tail
>   fast-path check (`Patch 2`) (Namhyung Kim).
> - Split out the `alloc_func_regex` leak fix in `builtin-kmem.c` (`Patch 1`),
>   the `map__for_each_symbol()` callback conversion (`Patch 3`), and the
>   conversion of open-coded symbol loops (`Patch 4`) ahead of the `rbtree`
>   to `struct symbols` array conversion (`Patch 5`) (Namhyung Kim).
> - Split symbol sorting optimization into a simple natural-run merge sort
>   patch without galloping (`Patch 6`) followed by incremental dynamic
>   symbol insertion with a sorted tail (`Patch 7`) (Namhyung Kim).
> 
> Changes in v6:
> - Fix `symbols__find()` when `sorted_cnt < cnt` so that if the slice
>   (sorted prefix or unmerged sorted tail) with the higher `start <= ip`
>   group ends before `ip`, `symbols__find()` returns `NULL` rather than
>   falling back to an earlier outer symbol in the other slice, matching
>   post-merge behavior, and add unmerged-vs-merged prefix/tail overlap and
>   equal-start alias unit tests (Sashiko).
> - Use positive `ENOMEM` rather than `-ENOMEM` on `symbol__annotation()`
>   failure in `symbol__annotate()`, `symbol__annotate2()`, and
>   `__hist_entry__tui_annotate()` to match `symbol__strerror_disassemble()`,
>   check `symbol__annotate() != 0` in `hist_entry__get_data_type()`, and
>   guard against `NULL` `notes` / `notes->src` in `find_disasm_line()`
>   (Sashiko).
> 
> v7: https://lore.kernel.org/linux-perf-users/20261121071651.67118-1-irogers@google.com/
> v6: https://lore.kernel.org/linux-perf-users/20261117185305.108003-1-irogers@google.com/
> v5: https://lore.kernel.org/linux-perf-users/20261116063435.2817923-1-irogers@google.com/
> v4: https://lore.kernel.org/linux-perf-users/20261113171734.2188066-1-irogers@google.com/
> v3: https://lore.kernel.org/linux-perf-users/20261110220803.2503416-1-irogers@google.com/
> v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/
> v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.com/
> 
> AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
> and Documentation/process/generated-content.rst):
> - Tools used: Google Antigravity / Jetski coding assistant and Sashiko
>   automated patch review (sashiko.dev and internal Sashiko).
> - Summary of prompts and assistance: Interactive pair-programming session to
>   replace per-symbol refcounting with `struct dso_symbol` DSO-borrowed
>   lifetimes, split symbol callback iteration and staged natural-run merge
>   sort / incremental insertion patches, rebase onto `tmp.perf-tools-next`
>   context-analysis annotations, and address LKML reviewer and Sashiko
>   feedback across `kmem`, `dso`, `map`, `maps`, `symbol`, and
>   `tests/symbols.c`.
> - Testing performed: Built each commit (`[1/10]` through `[10/10]`) with
>   Clang (`-DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-pointer
>   -Wthread-safety-beta`), AddressSanitizer, LeakSanitizer, and `DEBUG=1`
>   (`REFCNT_CHECKING=1`); ran `perf test` (including `Symbols`, `Maps`, `DSO
>   data`, `hists`, `thread`, and `annotate` suites), `perf bench internals`
>   (`symbols` and `maps`), and `scripts/checkpatch.pl`.
> 
> Ian Rogers (10):
>   perf kmem: Fix alloc_func_regex leak on error in
>     build_alloc_func_list()
>   perf maps: Add tail fast-path check in first_ending_after()
>   perf symbol: Convert map__for_each_symbol() to callback-based
>     iteration
>   perf symbol: Use callback iteration instead of open-coded symbol loops
>   perf symbol: Switch backing storage from rbtree to struct symbols
>     array
>   perf symbol: Replace qsort() with natural-run merge sort
>   perf symbol: Optimize incremental symbol insertion with sorted tail
>   perf symbol: Add memory shrinking for symbols, DSOs, and machines
>   perf session: Add dso__session() and session-scoped allocation
>     wrappers
>   perf test symbols: Add tests for symbol shrinking and session alloc
>     wrappers
> 
>  tools/perf/arch/powerpc/util/sym-handling.c |   34 +-
>  tools/perf/builtin-annotate.c               |   11 -
>  tools/perf/builtin-kmem.c                   |   51 +-
>  tools/perf/tests/hists_common.c             |    5 +-
>  tools/perf/tests/maps.c                     |   46 +
>  tools/perf/tests/symbols.c                  |  851 ++++++++++++++-
>  tools/perf/tests/vmlinux-kallsyms.c         |  181 ++--
>  tools/perf/ui/browser.c                     |    3 +
>  tools/perf/ui/browsers/hists.c              |    3 +-
>  tools/perf/ui/browsers/map.c                |   62 +-
>  tools/perf/util/auxtrace.c                  |  109 +-
>  tools/perf/util/db-export.c                 |    4 +-
>  tools/perf/util/dso.c                       |  324 +++++-
>  tools/perf/util/dso.h                       |   90 +-
>  tools/perf/util/dsos.c                      |   51 +
>  tools/perf/util/dsos.h                      |    3 +
>  tools/perf/util/intel-pt.c                  |   74 +-
>  tools/perf/util/libbfd.c                    |    3 +-
>  tools/perf/util/machine.c                   |   60 +-
>  tools/perf/util/machine.h                   |    8 +
>  tools/perf/util/map.c                       |   36 +-
>  tools/perf/util/map.h                       |    8 +-
>  tools/perf/util/maps.c                      |    4 +
>  tools/perf/util/probe-event.c               |   98 +-
>  tools/perf/util/session.c                   |   78 ++
>  tools/perf/util/session.h                   |    8 +
>  tools/perf/util/symbol-elf.c                |   12 +-
>  tools/perf/util/symbol.c                    | 1042 +++++++++++++++----
>  tools/perf/util/symbol.h                    |   84 +-
>  tools/perf/util/symbol_fprintf.c            |   25 +-
>  30 files changed, 2706 insertions(+), 662 deletions(-)
> 
> 
> base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 
