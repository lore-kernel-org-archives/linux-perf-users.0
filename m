Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810881;
	b=z8t0BAebhuaHlIbpxUrZfeFZHyErhmK79/dhRUgGyT7GJnLqlNfFlrN56pdqsya+yyaj
	 QMEKZau87o4u4kSv+tkm3Rb17j7JaJvhZzpbLfqQ8vxbYoFh0mnYd7tV3THGiatjS8UUe
	 m6+Pzr7BM7E2L0+yxU0i6PpCj9TNaL8I0oQuXeYw2LXEVR81Jc56TXyAqkzOle49bZ/Fe
	 LbvzxbPze5Exusj5lGz+mM4aLSicCEPQKQrdzLbM/C0mmy1L/oSbxENJ6G4NEPPMjwQqq
	 qOWKAxqzKhih2fqIftvZyebZ6xCYj4SLgVGyZnuHQsRKIzXGzxpq7KsNZxz4OuZB41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KfwcGpUM8rwjbZmhFYZ7zowBgn9VWm/BRkA6swDF/6A=;
	b=ntt/GIVlPtQf+e4RErZ1BVys7QGaWepF3ObVyUDYCLggnoxA3MPSnCXSjt8D9oNZVvOb
	 iORD1jaCwRuDeyyAKCCpE5oqhnpgXcaU0ULfK/6o6Vbhj6Or8tyLo0LGLRxptJt8QlQsM
	 H/USn2O37/yu/tqvXLKTtRvRHIwm5kcLFNdJ+H9laaYwqtMdPmTmNwIPsOxMHranzhtdv
	 sEaa5QL9YyYdUaFvhQb7uz9V0kvAojIXRoIrrObUU1Y72YSFyChSZPCRqtJyQYBs1fyre
	 iNTAPIrLiXNTWRFQzwROJfOuPLzV17H5Ys6JKal2kXhfwo8rzLfhEfMDRUXXAn36+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=drU7Y1rW;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A0606A329
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 337A0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=drU7Y1rW
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-378722fd4a3so3634236eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 22:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794810879; x=1795415679; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfwcGpUM8rwjbZmhFYZ7zowBgn9VWm/BRkA6swDF/6A=;
        b=drU7Y1rWbB/458fTeoIRfuHEXjOPwxtmXp4azts+dyH0QgBms52GVm91W6d/lJJu7H
         wIR5QCaBhLNBR4tdhazHo4/dFUG1Zcoyl1gOkL7qc/X/oYmMFWxBZVEXewrt8r7V8XM/
         peW80ax+YYy9iso7KjqUudb6/M7OVK/xN+bI3H7E4n1JUTP9scEKV+kGCiuOsCj6QjLR
         SX+swzenJGzIgAtWVjc6cyYpTzWLG8XQ5PisMZQ+/LPOkk8uiOyxmj4cqtJ6bizrnwL2
         cc+QnphGY8z+8JDdJsMcGqt7Jp16DXUxmKF7LrV8TNGsv5em5xCbD8LdOffASd8r3iFh
         2RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810879; x=1795415679;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfwcGpUM8rwjbZmhFYZ7zowBgn9VWm/BRkA6swDF/6A=;
        b=cucHklugnuMANm2kpG4KLpVPU72UD6FhVt3ShUFlUEWGVDd4I+QTUNslEqO3G7Az8W
         l9i9XqbVpoMDGvxf926TcEn/rJJwuCQhbGPPV8HnAh8EzXCQAHhGgfyAT4/RTZLepfiJ
         0icmkb/iBWHxusRH7uAnCUCRwNpiHCEVj+VSQQ2xElTYlVn8wTij5qjPsULhgNxl/J4S
         rqpmVmfqzTn7M6+ODFikWBFEZhSaVlzateSBrtC5a67ziVYDyCdFFKzEJJ+BJOO9uQox
         v6CtC2NfRVAszln7H0HXJsEntTLqez4g4xifLyPU/ydkSLt7NkQdXeNxzRXgXMTeJXHh
         +0wQ==
X-Forwarded-Encrypted: i=1; AL+hErGv2LTtt1MXsS5NPDysl5oBP1mu3bz7DLPhF4CR3fs4Afb3KFv+9sSPEIzHYKsTBMd8kA8bbMFpIYP5VdLoMmwG@vger.kernel.org
X-Gm-Message-State: APuU4Z8T9QF4rd2pVY/EXr4HmEx6yk+DKTdNlFI3IfEd/XamaibShT8b
	2wPFIXPs2fKshUsmoIWv3pzo2pj5Vd1goFu7M8buZ4Q81pOfGDjTFvdhB67ph7ll9XWtfo+M+98
	YT0i8IJ9qzQ==
X-Received: from dybnj2.prod.google.com ([2002:a05:7300:d082:b0:375:5ce5:6e37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5f0b:b0:378:7434:a526
 with SMTP id 5a478bee46e88-3796628f413mr9228210eec.14.1794810878811; Sun, 15
 Nov 2026 22:34:38 -0800 (PST)
Date: Sun, 15 Nov 2026 22:34:26 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116063435.2817923-1-irogers@google.com>
Subject: [PATCH v5 0/9] perf symbol: Sorted arrays, DSO-owned lifetimes, and
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
and startup latency. Currently `struct symbol` has several structural
limitations:

1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
   `dso->symbols` address rbtree, plus an optional negative-offset
   allocation prefix (`symbol_conf.priv_size`) for `struct annotation`
   state even when only a tiny fraction of symbols are ever annotated.
2. `dso__symbols()` has no internal synchronization against concurrent
   readers/writers, and `struct call_path` (plus Python callchain frames
   and nodes) still retains raw `struct symbol *` pointers without
   retaining a reference on the owning `struct dso`, preventing
   unreferenced DSOs and their symbol tables from being safely reclaimed
   under memory pressure.
3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
   invokes `libelf` section/program header lookups per symbol, calls
   `elf_sym__name()` before filtering out non-function/non-allocated
   symbols, and resorts `dso->symbols` with `qsort()` even when ELF symbol
   tables are already largely ordered in ascending address runs.

Ten preparatory fixes, benchmarks, and cleanups from v4 have landed in
`perf-tools-next`. The remaining 9 patches complete DSO-owned symbol
lifetimes, remove `symbol_conf.priv_size`, speed up ELF symbol and map
loading/sorting, convert `dso->symbols` to a sorted pointer array, and add
memory shrinking APIs and unit tests:

- **DSO-owned symbol lifetimes and `priv_size` removal (Patches 1-2)**:
  - Patch 1 converts `struct call_path` and Python callchain frames/nodes
    to `struct dso_symbol` so retained symbols pin their owning `struct dso`
    for the lifetime of the call path or Python object, and adds kernel-doc
    comments to `struct dso_symbol` and `struct map_symbol` documenting the
    DSO-owned lifetime invariant.
  - Patch 2 moves `struct annotation` into an on-demand hashmap and removes
    `symbol_conf.priv_size` and `symbol__priv()`.
- **Loading and map-sorting optimizations (Patches 3-4)**:
  - Patch 3 caches ELF program and section headers in
    `dso__load_sym_internal()` and defers `elf_sym__name()` lookups until
    after non-symbol/non-allocated entries are filtered out.
  - Patch 4 adds an O(1) tail-insertion fast path and incremental binary
    insertion sort to `struct maps`.
- **Sorted symbol arrays and natural-run merge sort (Patches 5-6)**:
  - Patch 5 replaces `dso->symbols` (`rb_root_cached`) and
    `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
    container backed by sorted pointer arrays, removing `struct rb_node`
    from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
    bytes, or 16 bytes net per symbol after accounting for the array
    pointer).
  - Patch 6 replaces `qsort()` on `struct symbols` with a stable
    natural-run merge sort, galloping merge, and a sorted tail buffer with
    amortized `sqrt(N)` merge for out-of-order insertions.
- **Memory shrinking APIs and unit tests (Patches 7-9)**:
  - Patch 7 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
    `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
    to reclaim `symbols_by_name`, excess array capacity, cached DSO file
    descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
    with no annotated symbols), with transparent on-demand reload via
    `dso__load()`.
  - Patch 8 adds `dso__session()` and `perf_session__malloc()` /
    `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers (leaving
    production caller wiring for follow-up once lazy symbol loading is
    evaluated).
  - Patch 9 adds unit tests in `perf test symbols` covering sorted symbol
    insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
    lifetime pinning, inline frame/srcline cleanup ordering,
    `symbols_by_name` on-demand rebuild, transparent DSO reload, and session
    allocation wrappers.

Changes in v5:
- Rebase onto `perf-tools-next` (`b7ff10b9ddec`), dropping the 10 patches
  from v4 that have been applied upstream.
- Defer `perf_singlethreaded` removal, `rwsem` trylock helpers, and wiring
  `perf_session__*` allocation wrappers into symbol/DSO/thread/hist callers
  to follow-up work while keeping the shrinking APIs and unit tests
  (Namhyung Kim).
- Drop the mechanical `struct symbol` field-accessor refactoring patch
  (`symbol__start()`, `symbol__end()`, `symbol__name()`, etc.) since
  `struct symbol` is no longer wrapped in `DECLARE_RC_STRUCT(symbol)`, and
  add kernel-doc comments on `struct dso_symbol` and `struct map_symbol`
  explaining the DSO-owned symbol lifetime connection (`Patch 1`).
- Drop `SYMBOL_FLAG_ANNOTATED` from `struct symbol::flags` (avoiding the
  bit-14 overlap with lazy symbol loading) and check the `annotations`
  hashmap under `annotations_lock` with an atomic `nr_annotations` fast path
  (`Patch 2`), and return `NULL` instead of `&empty_annotation` on
  allocation failure in `symbol__annotation()` (Namhyung Kim, Alireza
  Haghdoost, Sashiko).
- Shorten `nr_maps_by_address_sorted` and `nr_maps_by_name_sorted` in
  `struct maps` to `nr_addr_sorted` and `nr_name_sorted` (`Patch 4`)
  (Namhyung Kim).
- Avoid `_dso__data_open_lock` <-> `dso__lock` lock inversion when evicting
  unreferenced DSOs or closing open DSO fds in `dsos__shrink()` /
  `dso__shrink()` (`Patch 7`), add a concurrent regression test in
  `perf test symbols` (`Patch 9`), and drop the unused `adjust` field in
  `struct elf_phdr_range` (`Patch 3`) (Sashiko).

Changes in v4:
- Add standalone fix for NULL `th` dereference on allocation failure in
  `__machine__findnew_thread()`, fix `table->lock` read-to-write
  self-deadlock in `threads__for_each_thread()`, and remove
  `perf_singlethreaded` (Sashiko).
- Handle equal-start symbol groups where a sized symbol precedes a
  zero-length or shorter alias at the same start address (`Patches 5-6`):
  use `upper_bound` plus equal-start rewind in `symbols__find_range()`,
  avoid inflating trailing zero-length aliases in `symbols__fixup_end()`
  when a sized symbol already exists at that address, scan trailing
  equal-start groups for maximum `sym->end` in `map__fixup_end()`, and
  always check the unmerged sorted tail in `symbols__find()` when
  `sorted_cnt < cnt` (Sashiko).
- Preserve owning `perf_session` across split kallsyms/kcore and ELF kernel
  DSOs, use `down_write_trylock()` in `machines__shrink()`, and add unit
  tests for equal-start aliases, unmerged tail lookups, and same-shard
  `perf_session__e_machine()` (Sashiko).

Changes in v3:
- Drop per-symbol `DECLARE_RC_STRUCT(symbol)` reference counting and
  partial symbol-table retention (`symbols__merge_retained()`) in favor of
  DSO-owned symbol lifetimes via `struct dso_symbol`, evicting a DSO's
  symbol table only as a whole when `dso` has `refcnt == 1` and no
  annotated symbols (Namhyung Kim, Alireza Haghdoost).
- Reorder the series so bug fixes and small preparatory refactorings come
  first, split the `symbols` and `maps` benchmarks, and split out the three
  independent fixes merged upstream (`c4baf52c7901`, `854dd5e7d099`,
  `baef30dd8308`) (Namhyung Kim, Alireza Haghdoost).
- Remove the `hash_bits(..., 16)` 64K-bucket cap in `annotate` and
  `db-export` hashmaps, preserve insertion order on equal-start symbols
  (`a->start <= b->start`), use stable insertion sort instead of `qsort()`
  as the allocation-failure fallback, add a sorted tail buffer with
  amortized `sqrt(N)` merge in `__symbols__insert_sorted()`, rebuild
  `symbols_by_name` on demand, and expand `perf test symbols` (Alireza
  Haghdoost, Sashiko).

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
  lifetimes, convert `dso->symbols` to a sorted pointer array with
  natural-run merge sort, and address LKML reviewer and Sashiko feedback
  across `call-path`, `annotate`, `dso`, `map`, `symbol`, and
  `tests/symbols.c`.
- Testing performed: Built each commit (`[1/9]` through `[9/9]`) with Clang
  (`-Wthread-safety`), AddressSanitizer, LeakSanitizer, and `DEBUG=1`
  (`REFCNT_CHECKING=1`); ran `perf test` (including `Symbols`, `Maps`, `DSO
  data`, `hists`, `thread`, and `annotate` suites), `perf bench internals`
  (`symbols` and `maps`), and `scripts/checkpatch.pl`.

Ian Rogers (9):
  perf call-path: Use struct dso_symbol to retain symbol DSO lifetimes
  perf annotate: Move struct annotation to a hashmap and remove
    symbol_conf.priv_size
  perf symbol-elf: Cache ELF program/section headers and defer symbol
    name lookup
  perf maps: Optimize tail insertion and small-append sorting
  perf symbol: Switch backing storage from rbtree to struct symbols
    array
  perf symbol: Optimize symbol sorting with natural-run merge sort and
    binary insertion
  perf symbol: Add memory shrinking for symbols, DSOs, and machines
  perf session: Add dso__session() and session-scoped allocation
    wrappers
  perf test symbols: Add tests for symbol shrinking and session alloc
    wrappers

 tools/perf/arch/powerpc/util/sym-handling.c |   34 +-
 tools/perf/builtin-annotate.c               |   16 +-
 tools/perf/builtin-kmem.c                   |   51 +-
 tools/perf/builtin-top.c                    |   21 +-
 tools/perf/tests/builtin-test.c             |    1 -
 tools/perf/tests/hists_common.c             |    5 +-
 tools/perf/tests/maps.c                     |   67 ++
 tools/perf/tests/symbols.c                  |  810 +++++++++++++-
 tools/perf/tests/vmlinux-kallsyms.c         |  181 +--
 tools/perf/ui/browser.c                     |    3 +
 tools/perf/ui/browsers/annotate.c           |   16 +-
 tools/perf/ui/browsers/hists.c              |   26 +-
 tools/perf/ui/browsers/map.c                |   62 +-
 tools/perf/ui/gtk/annotate.c                |    4 +
 tools/perf/util/annotate.c                  |  152 ++-
 tools/perf/util/annotate.h                  |    7 +-
 tools/perf/util/auxtrace.c                  |  109 +-
 tools/perf/util/block-info.c                |    2 +-
 tools/perf/util/block-range.c               |   11 +-
 tools/perf/util/call-path.c                 |   42 +-
 tools/perf/util/call-path.h                 |   10 +-
 tools/perf/util/db-export.c                 |   16 +-
 tools/perf/util/dso.c                       |  368 ++++++-
 tools/perf/util/dso.h                       |   84 +-
 tools/perf/util/dsos.c                      |   51 +
 tools/perf/util/dsos.h                      |    3 +
 tools/perf/util/intel-pt.c                  |   74 +-
 tools/perf/util/libbfd.c                    |    3 +-
 tools/perf/util/machine.c                   |   60 +-
 tools/perf/util/machine.h                   |    8 +
 tools/perf/util/map.c                       |   36 +-
 tools/perf/util/map.h                       |    8 +-
 tools/perf/util/map_symbol.h                |   28 +
 tools/perf/util/maps.c                      |  276 ++++-
 tools/perf/util/probe-event.c               |   98 +-
 tools/perf/util/python.c                    |   53 +-
 tools/perf/util/session.c                   |   78 ++
 tools/perf/util/session.h                   |    8 +
 tools/perf/util/sort.c                      |    9 +-
 tools/perf/util/symbol-elf.c                |  251 ++++-
 tools/perf/util/symbol.c                    | 1100 +++++++++++++++----
 tools/perf/util/symbol.h                    |   92 +-
 tools/perf/util/symbol_conf.h               |    1 -
 tools/perf/util/symbol_fprintf.c            |   25 +-
 tools/perf/util/thread-stack.c              |   40 +-
 45 files changed, 3521 insertions(+), 879 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog

