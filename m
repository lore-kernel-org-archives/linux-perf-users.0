Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323850;
	b=3rkAJiURelF7rZu11igRYA0ldyY8nxmOzohWLPBZq72fqX8ylQHRieWNqBp+PSIuMEln
	 4+ZmHvDPQICBnK3OYJHQ2pYs/mMwDwi4YsmX0TpEr284Pct3oYrE7VaREUZ3VUy6nWVS+
	 I32vBlatyBk4Hz1mFFBUJMi6UI5Yf1M/p6oIURO4xG0EdeUJfEl+vNJFg0xRokPvLXxJG
	 3VEUJUFNAfOsMOuzGjpCXUl7zVjoIjafawjOOTapNPu7IWARn/FvAhDkBnDmExZKQ0Foq
	 BUqTGetSXVjWInQfv8qguUVVmV/tLKp4JxeEJQ1Idigl0PEU/Zbx4wbvGIhatda8CjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wuvPmWr4AEKl08pK8e1x1u+FbpYScm2GERj+bj9eXh4=;
	b=suy2UVDa0r0D6J51kigplTye4PU6wCwji/GAR3RfxJV48qE/KwulqoIQnumBaIl97eYO
	 2itw31xJ6wdTCx+yAVRl9irYfxl5q6EIyvNu9Dtlt0U6SuAZWuTp4mRNE95OBy4nWUMme
	 1GdJ5a/zP8VKj/YHWEgsdkcOO4Tr1npxEcwtncBvMrM+7sSFhLMY4N/xX0UsULQYBP6gz
	 eOKIiBFdYrTbeJxsjP6IygQSpMUKLjeI2AlOl5tVReKxiwkRZ8UM/t9xbGoJAtQhj4X2W
	 Zek4LRXJHEBLR+el5ZME13xKQ9uDnOWF4Jf0Ta9AkRqit0g0KUNBjMScsQpn8URGylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DczOD1LT;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414E606A32A
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3414E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DczOD1LT
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b456fee3b2so684679a91.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323849; x=1795928649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wuvPmWr4AEKl08pK8e1x1u+FbpYScm2GERj+bj9eXh4=;
        b=DczOD1LTP14fxTWPHlzgVdSVg3W74r2U6pcXXfPKHG/tOSdafmYkWhRwYcBE4TVHQF
         ccN1YjievMBJGXN/R2TEwXMAPvamgDw/i8/hF1v2uTh2UcJ89tdq84epYfG9CfD1eHit
         UJHNeJJFfprsgHCYJ+ls9U8/vuBVHCbemeEBJgNHnMwXq6fUbqqFlawYRVru+J4bnpzL
         AOSGcs0W4WHALGv3c/5F0OcWUZYoduE02VxDvUSD8SSUgSSFyMwMlLA/KOTe31Z5WRVh
         lM8eZJ7i2GEPbSmwHHysk4NUoVM4fbZYOtfPvDHS1n4vZmYUUpUlGGnCLhkMT587XQNs
         TzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323849; x=1795928649;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wuvPmWr4AEKl08pK8e1x1u+FbpYScm2GERj+bj9eXh4=;
        b=DMWPnHpdSC9eqkNQLA5JRszeHnLrwLEIfpGE6s19pFlwaz+Et1NXvZvJ7P2hmdvb/m
         y/gLiMGgIxpvJNddYH9+Ktv+A/ZM1d8CEpCVT6KJM8rdd+jDYd3OP0wR6R1RxPZG/s7P
         AwKgJRo6D/pWML/pi9yd9OPrvRwM1qboCikVKoFW4YuNjYYWSd3UAS7ERCxVo4DWvo/P
         CGs9f6jtyyztDq0v5K81Jmt3KtpOZUghwT3JB4dhnRTvJL1Bze07C018kTG5Zz2CrtAw
         2n0wCoLMC71MpeBJUqVekD/IFL+q7eErSsbbBVkvh1ozfK8R6wyLZutJ0JmTPh4Oyfj5
         nsog==
X-Forwarded-Encrypted: i=1; AL+hErEm1oj5dARAh9gy4B8ndifH+/Z8a13YGrHDLR0GuxBMm3N5g/+aw75j/sKlGVYLLtrO7m3EDLxRGTSXzgsdA468@vger.kernel.org
X-Gm-Message-State: APuU4Z85An+RenrLrGVXOB/7CdtcD7f7IdjuAh/+j/4P4zGIIiGee2sM
	NPBK58K5rUfCUl/93T4yiAIgGtzHtjgy7FToIshZ/afqM3AlPzvotsxDWWSnOU7YIG3t7zbuoEC
	kZUH1qXQQaA==
X-Received: from pjtd16.prod.google.com ([2002:a17:90b:50:b0:3b1:cd53:86de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0a:b0:3ac:ea3b:f28b
 with SMTP id 98e67ed59e1d1-3b41c9cd21fmr6671416a91.24.1795323849106; Sat, 21
 Nov 2026 21:04:09 -0800 (PST)
Date: Sat, 21 Nov 2026 21:03:55 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-1-irogers@google.com>
Subject: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned lifetimes, and
 memory shrinking
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When profiling large binaries or long-running workloads with many DSOs and
threads, symbol and DSO tables frequently dominate perf's memory footprint
and startup latency. Currently `struct symbol` still has several structural
limitations:

1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
   `dso->symbols` address rbtree, scattering lookups across non-contiguous
   heap nodes.
2. `dso__symbols()` has no internal synchronization against concurrent
   readers/writers, and unreferenced DSOs and auxiliary symbol/debuginfo
   buffers cannot yet be reclaimed under memory pressure.
3. Sorting `dso->symbols` with `qsort()` does not take advantage of
   pre-ordered ascending runs in ELF symbol tables, and `first_ending_after()`
   in `struct maps` runs a full binary search even for ascending
   `/proc/pid/maps` synthesis.

Thirteen preparatory fixes, benchmarks, `dso_symbol` lifetime conversions,
`symbol_conf.priv_size` removal, and ELF header caching patches from v4-v6
have landed in `perf-tools-next`. The remaining 10 patches convert symbol
iteration to callbacks, replace the `dso->symbols` rbtree with a sorted
pointer array, stage natural-run merge sort and incremental symbol
insertion, and add memory shrinking APIs and unit tests:

- **Preparatory fix, `maps` tail fast-path, and symbol iteration (Patches 1-4)**:
  - Patch 1 fixes an `alloc_func_regex` leak on error returns in
    `builtin-kmem.c`'s `build_alloc_func_list()`.
  - Patch 2 adds an O(1) tail fast-path check in `first_ending_after()` for
    ascending map insertions.
  - Patch 3 converts `symbols__for_each_entry()`, `dso__for_each_symbol()`,
    and `map__for_each_symbol()` to callback-based iteration and updates
    existing callers.
  - Patch 4 converts open-coded `dso__first_symbol()` / `dso__next_symbol()`,
    `rb_first_cached()`, and `dso__symbol_names()` loops to callback
    helpers and removes `dso__{first,last,next}_symbol()`.
- **Sorted symbol arrays and staged sorting optimizations (Patches 5-7)**:
  - Patch 5 replaces `dso->symbols` (`rb_root_cached`) and
    `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
    container backed by sorted pointer arrays, removing `struct rb_node`
    from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
    bytes, or 16 bytes net per symbol after accounting for the array
    pointer).
  - Patch 6 replaces `qsort()` on `struct symbols` with a stable
    natural-run merge sort.
  - Patch 7 optimizes incremental dynamic symbol insertions
    (`dso__insert_symbol()`) and small appends using `@sorted_cnt` and a
    sorted tail buffer with amortized `sqrt(N)` merge.
- **Memory shrinking APIs and unit tests (Patches 8-10)**:
  - Patch 8 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
    `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
    to reclaim `symbols_by_name`, excess array capacity, cached DSO file
    descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
    with no annotated symbols), with transparent on-demand reload via
    `dso__load()`.
  - Patch 9 adds `dso__session()` and `perf_session__malloc()` /
    `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers (leaving
    production caller wiring for follow-up once lazy symbol loading is
    evaluated).
  - Patch 10 adds unit tests in `perf test symbols` covering sorted symbol
    insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
    lifetime pinning, inline frame/srcline cleanup ordering,
    `symbols_by_name` on-demand rebuild, transparent DSO reload, and session
    allocation wrappers.

Changes in v8:
- Rebase onto `tmp.perf-tools-next` (`eb79d2fbc230`), adopting
  `<linux/compiler-context-analysis.h>` annotations (`__guarded_by(&lock)`,
  `__acquires_shared(&symbols->lock)`, `__must_hold(&symbols->lock)`,
  `__context_unsafe()`) on `struct symbols` and `dso` / `tests/symbols.c`
  and adapting `dso__shrink()` / `dso__try_evict()` to `dso__data_open_lock`
  and `close_dso()`.
- Pass `first_unsorted` (`m = symbols->sorted_cnt`) to
  `symbols__insertion_sort_range()` in `symbols__sort_locked()` (`Patch 7`)
  so the `k <= 8` small-append fast path and allocation-failure fallbacks
  skip scanning the already-sorted prefix `[0 .. m)` (Sashiko).

Changes in v7:
- Rebase onto `perf-tools-next` (`bb27ddbaee56`), dropping the 3 patches
  from v6 that have been applied upstream.
- Drop `nr_addr_sorted` and `nr_name_sorted` incremental partial-sort state
  from `struct maps`, keeping only the `first_ending_after()` tail
  fast-path check (`Patch 2`) (Namhyung Kim).
- Split out the `alloc_func_regex` leak fix in `builtin-kmem.c` (`Patch 1`),
  the `map__for_each_symbol()` callback conversion (`Patch 3`), and the
  conversion of open-coded symbol loops (`Patch 4`) ahead of the `rbtree`
  to `struct symbols` array conversion (`Patch 5`) (Namhyung Kim).
- Split symbol sorting optimization into a simple natural-run merge sort
  patch without galloping (`Patch 6`) followed by incremental dynamic
  symbol insertion with a sorted tail (`Patch 7`) (Namhyung Kim).

Changes in v6:
- Fix `symbols__find()` when `sorted_cnt < cnt` so that if the slice
  (sorted prefix or unmerged sorted tail) with the higher `start <= ip`
  group ends before `ip`, `symbols__find()` returns `NULL` rather than
  falling back to an earlier outer symbol in the other slice, matching
  post-merge behavior, and add unmerged-vs-merged prefix/tail overlap and
  equal-start alias unit tests (Sashiko).
- Use positive `ENOMEM` rather than `-ENOMEM` on `symbol__annotation()`
  failure in `symbol__annotate()`, `symbol__annotate2()`, and
  `__hist_entry__tui_annotate()` to match `symbol__strerror_disassemble()`,
  check `symbol__annotate() != 0` in `hist_entry__get_data_type()`, and
  guard against `NULL` `notes` / `notes->src` in `find_disasm_line()`
  (Sashiko).

v7: https://lore.kernel.org/linux-perf-users/20261121071651.67118-1-irogers@google.com/
v6: https://lore.kernel.org/linux-perf-users/20261117185305.108003-1-irogers@google.com/
v5: https://lore.kernel.org/linux-perf-users/20261116063435.2817923-1-irogers@google.com/
v4: https://lore.kernel.org/linux-perf-users/20261113171734.2188066-1-irogers@google.com/
v3: https://lore.kernel.org/linux-perf-users/20261110220803.2503416-1-irogers@google.com/
v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/
v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.com/

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Google Antigravity / Jetski coding assistant and Sashiko
  automated patch review (sashiko.dev and internal Sashiko).
- Summary of prompts and assistance: Interactive pair-programming session to
  replace per-symbol refcounting with `struct dso_symbol` DSO-borrowed
  lifetimes, split symbol callback iteration and staged natural-run merge
  sort / incremental insertion patches, rebase onto `tmp.perf-tools-next`
  context-analysis annotations, and address LKML reviewer and Sashiko
  feedback across `kmem`, `dso`, `map`, `maps`, `symbol`, and
  `tests/symbols.c`.
- Testing performed: Built each commit (`[1/10]` through `[10/10]`) with
  Clang (`-DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-pointer
  -Wthread-safety-beta`), AddressSanitizer, LeakSanitizer, and `DEBUG=1`
  (`REFCNT_CHECKING=1`); ran `perf test` (including `Symbols`, `Maps`, `DSO
  data`, `hists`, `thread`, and `annotate` suites), `perf bench internals`
  (`symbols` and `maps`), and `scripts/checkpatch.pl`.

Ian Rogers (10):
  perf kmem: Fix alloc_func_regex leak on error in
    build_alloc_func_list()
  perf maps: Add tail fast-path check in first_ending_after()
  perf symbol: Convert map__for_each_symbol() to callback-based
    iteration
  perf symbol: Use callback iteration instead of open-coded symbol loops
  perf symbol: Switch backing storage from rbtree to struct symbols
    array
  perf symbol: Replace qsort() with natural-run merge sort
  perf symbol: Optimize incremental symbol insertion with sorted tail
  perf symbol: Add memory shrinking for symbols, DSOs, and machines
  perf session: Add dso__session() and session-scoped allocation
    wrappers
  perf test symbols: Add tests for symbol shrinking and session alloc
    wrappers

 tools/perf/arch/powerpc/util/sym-handling.c |   34 +-
 tools/perf/builtin-annotate.c               |   11 -
 tools/perf/builtin-kmem.c                   |   51 +-
 tools/perf/tests/hists_common.c             |    5 +-
 tools/perf/tests/maps.c                     |   46 +
 tools/perf/tests/symbols.c                  |  851 ++++++++++++++-
 tools/perf/tests/vmlinux-kallsyms.c         |  181 ++--
 tools/perf/ui/browser.c                     |    3 +
 tools/perf/ui/browsers/hists.c              |    3 +-
 tools/perf/ui/browsers/map.c                |   62 +-
 tools/perf/util/auxtrace.c                  |  109 +-
 tools/perf/util/db-export.c                 |    4 +-
 tools/perf/util/dso.c                       |  324 +++++-
 tools/perf/util/dso.h                       |   90 +-
 tools/perf/util/dsos.c                      |   51 +
 tools/perf/util/dsos.h                      |    3 +
 tools/perf/util/intel-pt.c                  |   74 +-
 tools/perf/util/libbfd.c                    |    3 +-
 tools/perf/util/machine.c                   |   60 +-
 tools/perf/util/machine.h                   |    8 +
 tools/perf/util/map.c                       |   36 +-
 tools/perf/util/map.h                       |    8 +-
 tools/perf/util/maps.c                      |    4 +
 tools/perf/util/probe-event.c               |   98 +-
 tools/perf/util/session.c                   |   78 ++
 tools/perf/util/session.h                   |    8 +
 tools/perf/util/symbol-elf.c                |   12 +-
 tools/perf/util/symbol.c                    | 1042 +++++++++++++++----
 tools/perf/util/symbol.h                    |   84 +-
 tools/perf/util/symbol_fprintf.c            |   25 +-
 30 files changed, 2706 insertions(+), 662 deletions(-)


base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
-- 
2.56.1.750.gf70dc682cf-goog

