Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590277;
	b=b4FuBc5r3BXkRRo+kOkBGDZM1qB0CaauR4BS7mobnMNHFfkZ9uVHmIC6QLcIfG9ILB1v
	 cHAEtYoOWcM6swWGCXHrnnogmSDCXxx6aTHdnWB4TgOn5npUDPmDck7z0LQvix5FFqgXZ
	 z+0NXpxOkjQiDs3icWMr35TRf1V7d845Puyhy+1YC3iZE7xF7fGYIT3gyc+IcAdLK1e50
	 0X4rfRywU5xhb8QW3vPZeKE4ePnBO1hd7tJ5OF7+f4Yi1dv2vlpJvYdf4MCrzs7Nn1Bhp
	 pOv8K8GQhSlDHD8nOy8iCw8j/vSGcNg4KsAZ5ZQlIKwDyzTBgT6yr+bI+8qAu4atqWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=21ic/G6SwlphwtXpLp82zRhwj2Nz5CpD1GqHkVy1quA=;
	b=OlcL8rMEoprGqejJqy0Sg4S56Cq1fco0YZizqKhcbflgqgCKqRKEtXIQG2VIkGb/vTSu
	 DynYy3HtFJM1ru+m/+TXlNksMJqjiORRw4k9AmOLS7CuYyiVdnN+fDxCALTqKg5er7zmz
	 WX236vQNwO1PJJkWvoEyPb27vphyFxlFj2skJvChbgiodvI9sxrHSEHX1CxM0ltJ4j0DM
	 FTjdJHYxIBNMJrEjRvzoqxm4URLajy76Uw13qMEADn4gYi79Cv9xbgxh9GQE3Pe2Lnct5
	 uSUbwVkc0qJ3L4iOI/dZ7yYU0hO5pr8Fnhgc6u+BrvG6fCSDwAASmwQcVXy9jptCz8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DzpPJbys;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB606B204
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EAFB606B204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DzpPJbys
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a5005fd0f8so219332c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590275; x=1795195075; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21ic/G6SwlphwtXpLp82zRhwj2Nz5CpD1GqHkVy1quA=;
        b=DzpPJbys6k6hMhaakTe3+UAdU6R+qnNoFyRMNq7DCCSWy/ukQCRDP6o3TbOlAeE788
         RqtmHJL0SVshCn5YwOdmAgMkfD9rM+nX4dt+KiSKGRF9IuWrHGTVei8EK7pC7cveflwp
         TOYrotiNDAphXqJdBGXH5Y6lkQ9JcAughbcKe92ucRXz+Zb0+VnwBKhMbC4pFcSSqPUM
         GzMdi/gGLgx7P43CUc7ZjWMzTnuNgmv4A8wrMCU6JgJnfltWId8TQ0nVfqp078OtuLQZ
         sgnFcyH/vMeZYbF7rWb1L97mLPz8PY3b7kLXHFbivwiYZrLVzCS9qwlJhDSsTmzK2Ke2
         exvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590275; x=1795195075;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21ic/G6SwlphwtXpLp82zRhwj2Nz5CpD1GqHkVy1quA=;
        b=E/W+0W74HHyulCPfn89TDARX3CPCrBRg4Gc888+kwnq/2xWUk7V7eGZnozfNFPH+bx
         29EeXHqAoogIT0orYUprZa4XvVLok/DtyecV4Zr1HOwhIl9aYfGUN99vVw+g7IMXvEtp
         o76Sfn+B/LZQuv5ErSMD8Mtp24doGpuymHKVlgxWPjMU6u91JplrFqpCbRgvssA+ctdJ
         4Eg+TTlCgNz5x/p+Nntf+Q1Ed9sPR1Slq04PiHECuRozQXGWwW850uTZ3zm3g8H7lsZd
         98npYCWi3MHBU+Muoc5iaPN3Y8GUtGb6S/6iqIhqVkI57hvi5A5fMhIRGdcF+aib1f9n
         5xpA==
X-Forwarded-Encrypted: i=1; AL+hErEE+7VeYkGSQ7ZzKcZw6ZbQya9qkBW4E9Ox1XwFFP17Pz6/3tf9vwF8YZNk6B1IwLFIgY6zZXrtLdbFPxFqdLfi@vger.kernel.org
X-Gm-Message-State: APuU4Z9J/hTUvofvuZjzz13LZihTLlJesXWJuUQdgXh+lLbqJc9Dl1OS
	IRta3M07LXOjM/2aw1fdYBRK5fpWtf5iojxdGoPiaWSPxbGSXt6QVXI1Zk+VxbaUDVH5BEjlPNc
	eO0FVb85G7A==
X-Received: from dlak10.prod.google.com ([2002:a05:701b:290a:b0:19a:1425:bb9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1305:b0:1ab:aaf3:389d
 with SMTP id a92af1059eb24-1b50308b44emr2953814c88.1.1794590274114; Fri, 13
 Nov 2026 09:17:54 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:11 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-1-irogers@google.com>
Subject: [PATCH v4 00/23] perf symbol: Sorted arrays, DSO-owned lifetimes, and
 memory shrinking
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When profiling large binaries or long-running workloads with many DSOs and
threads, symbol and DSO tables frequently dominate perf's memory footprint
and startup latency. Currently `struct symbol` has several structural
limitations:

1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
   `dso->symbols` address rbtree, plus an optional negative-offset
   allocation prefix (`symbol_conf.priv_size`) for TUI browser indices,
   `db-export` IDs, or `struct annotation` state even when only a tiny
   fraction of symbols are ever annotated or exported.
2. `dso__symbols()` has no internal synchronization against concurrent
   readers/writers, and while most symbol holders (`map_symbol`,
   `addr_location`) already pin the owning `struct dso` via `map__get()`, a
   handful of long-lived symbol holders (`hist_entry->parent`, `call_path`,
   and `db-export`) retain raw `struct symbol *` pointers without retaining
   a reference on the owning `struct dso`, preventing unreferenced DSOs and
   their symbol tables from being safely reclaimed under memory pressure.
3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
   invokes `libelf` section/program header lookups per symbol, calls
   `elf_sym__name()` before filtering out non-function/non-allocated
   symbols, runs Rust/Java demanglers on plain C symbols without fast-path
   prefix checks, and resorts `dso->symbols` with `qsort()` even when ELF
   symbol tables are already largely ordered in ascending address runs.

This series modernizes `struct symbol` storage, ties symbol lifetimes
explicitly to their owning `struct dso` (rather than adding per-symbol
reference counting), removes `symbol_conf.priv_size` and
`perf_singlethreaded`, speeds up ELF symbol and map loading/sorting, and
adds on-demand session memory shrinking:

- **Fixes and preparatory locking cleanups (Patches 1-7)**:
  - Patch 1 fixes a NULL pointer dereference in `__machine__findnew_thread()`
    when `threads__findnew()` fails to allocate a thread.
  - Patch 2 snapshots shard threads and drops `table->lock` before invoking
    callbacks in `threads__for_each_thread()` to avoid read-to-write
    self-deadlock when a callback looks up or creates a leader thread in the
    same shard.
  - Patch 3 removes `perf_singlethreaded` so `struct rw_semaphore` always
    uses `pthread_rwlock_t` (allowing non-blocking trylock operations to
    reliably detect locks already held on the current call stack during OOM
    shrinking) and guards `di_cache` in `util/annotate.c` with a mutex.
  - Patch 4 fixes a heap buffer corruption in the TUI map browser when
    `symbol_conf.priv_size` was not initialized with `sizeof(u32)` by
    computing symbol browser indices on demand.
  - Patch 5 protects the `machines->guests` rbtree with a `rw_semaphore`.
  - Patch 6 constifies `dso` in `dso__is_vdso()`.
  - Patch 7 adds `down_read_trylock()` and `down_write_trylock()` to
    `util/rwsem.[ch]`.
- **DSO-owned symbol lifetimes and `priv_size` removal (Patches 8-11)**:
  - Patches 8-9 introduce `struct dso_symbol` (`{ struct dso *dso; struct
    symbol *sym; }`) so callers that borrow a symbol's lifetime directly
    from its owning `struct dso` without a `struct map` (`hist_entry`
    parent symbols, `call_path` nodes, and `db-export`) retain a `dso`
    reference for the lifetime of the symbol pointer. (Consolidating
    `map_symbol` and `dso_symbol` back into `symbol.h` as explicit
    DSO/map-borrowed symbol handle types is left for follow-up cleanup.)
  - Patches 10-11 move `db-export` symbol IDs and `struct annotation` into
    on-demand hashmaps and remove `symbol_conf.priv_size` and
    `symbol__priv()`.
- **Benchmarks and loading/sorting optimizations (Patches 12-16)**:
  - Patches 12-13 add standalone `perf bench internals symbols` and
    `perf bench internals maps` subcommands.
  - Patch 14 adds fast-path prefix checks for the Rust and Java demanglers.
  - Patch 15 caches ELF program and section headers in
    `dso__load_sym_internal()` and defers `elf_sym__name()` lookups until
    after non-symbol/non-allocated entries are filtered out.
  - Patch 16 adds an O(1) tail-insertion fast path and incremental binary
    insertion sort to `struct maps`.
- **Sorted symbol arrays and natural-run merge sort (Patches 17-19)**:
  - Patch 17 encapsulates `struct symbol` field accesses behind inline
    accessor functions in preparation for lazy symbol/string loading.
  - Patch 18 replaces `dso->symbols` (`rb_root_cached`) and
    `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
    container backed by sorted pointer arrays, removing `struct rb_node`
    from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
    bytes, or 16 bytes net per symbol after accounting for the array
    pointer).
  - Patch 19 replaces `qsort()` on `struct symbols` with a stable
    natural-run merge sort, galloping merge, and a sorted tail buffer with
    amortized `sqrt(N)` merge for out-of-order insertions.
- **On-demand memory shrinking and tests (Patches 20-23)**:
  - Patch 20 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
    `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
    to reclaim `symbols_by_name`, excess array capacity, cached DSO file
    descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
    with no annotated symbols), with transparent on-demand reload via
    `dso__load()`.
  - Patches 21-22 add `dso__session()` and `perf_session__malloc()` /
    `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
    trigger `perf_session__shrink()` and retry once on allocation failure.
  - Patch 23 adds unit tests in `perf test symbols` covering sorted symbol
    insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
    lifetime pinning, inline frame/srcline cleanup ordering,
    `symbols_by_name` on-demand rebuild, transparent DSO reload, and session
    allocation wrappers.

Changes in v4:
- Add standalone fix for NULL `th` dereference on allocation failure in
  `__machine__findnew_thread()` (`Patch 1`) so `machine__findnew_thread()`
  can shrink the session and retry cleanly (Sashiko).
- Fix `table->lock` read-to-write self-deadlock in
  `threads__for_each_thread()` (`Patch 2`) and remove `perf_singlethreaded`
  (`Patch 3`) so `rw_semaphore` trylock operations always detect locks held
  on the current call stack during OOM shrinking (Sashiko).
- Handle equal-start symbol groups where a sized symbol precedes a
  zero-length or shorter alias at the same start address (`Patches 18-19`):
  use `upper_bound` plus equal-start rewind in `symbols__find_range()`,
  avoid inflating trailing zero-length aliases in `symbols__fixup_end()`
  when a sized symbol already exists at that address, scan trailing
  equal-start groups for maximum `symbol__end()` in `map__fixup_end()`, and
  always check the unmerged sorted tail in `symbols__find()` when
  `sorted_cnt < cnt` (Sashiko).
- Preserve owning `perf_session` across split kallsyms/kcore and ELF kernel
  DSOs (`ndso->dsos == NULL`) in `maps__split_kallsyms()`,
  `maps__split_kallsyms_for_kcore()`, and `dso__load_sym_internal()`
  (`Patch 22`), use `down_write_trylock()` in `machines__shrink()`
  (`Patch 20`), and add unit tests for equal-start aliases, unmerged tail
  lookups, and same-shard `perf_session__e_machine()` (`Patch 23`)
  (Sashiko).
- Rebase onto `perf-tools-next` (`4af65363b11f`).

Changes in v3:
- Drop per-symbol `DECLARE_RC_STRUCT(symbol)` reference counting and
  partial symbol-table retention (`symbols__merge_retained()`) in favor of
  DSO-owned symbol lifetimes via `struct dso_symbol` (`Patches 8-9`),
  evicting a DSO's symbol table only as a whole when `dso` has `refcnt == 1`
  and no annotated symbols (Namhyung Kim, Alireza Haghdoost).
- Reorder the series so bug fixes and small preparatory refactorings come
  first ahead of the larger `struct symbol` accessor and container patches.
- Split the `perf bench internals` patch into two smaller standalone patches
  (`symbols` and `maps`), separate `dso__load()` timing and `Max RSS` from
  `dso__sort_by_name()` so address-only/lazy symbol loading is measured
  independently of symbol name sorting, replace `mallinfo2()` (and its
  build feature test) with `getrusage()` `ru_maxrss`, skip stripped
  binaries (`nr == 0`) cleanly, call `symbol__exit()`, and include example
  output in the commit messages (Namhyung Kim, Alireza Haghdoost).
- Split out and land upstream the independent fixes uncovered during v2
  review: `c4baf52c7901` ("perf callchain: Fix loss of symbol in
  merge_chain_branch()"), `854dd5e7d099` ("perf annotate: Fix block_range
  symbol loss on split and leaks on exit"), and `baef30dd8308` ("perf
  symbol-elf: Fix zero-size symbol end calculation across .symtab and
  .dynsym") (Alireza Haghdoost).
- Remove the `hash_bits(..., 16)` 64K-bucket cap in `annotate` and
  `db-export` hashmaps, set `symbol__set_annotated()` on the existing-entry
  write path, and share the empty-hashmap cleanup path on `zalloc()`
  failure in `symbol__annotation()` (Alireza Haghdoost, Sashiko).
- Preserve insertion order on equal-start symbols (`symbol__start(a) <=
  symbol__start(b)`), use stable insertion sort instead of `qsort()` as the
  allocation-failure fallback, keep kallsyms "last alias wins" behavior in
  `symbols__fixup_end()`, and add a sorted tail buffer with amortized
  `sqrt(N)` merge in `__symbols__insert_sorted()` to avoid `O(n^2)`
  `memmove()` on random insertions (Alireza Haghdoost).
- Retry `dso_cache_io()` under `dso__lock(dso)` if `dso__shrink()` evicted
  a newly populated cache entry, free `dso->inlined_nodes` and
  `dso->srclines` before `symbols__delete_locked()` in `dso__shrink()`, and
  rebuild `symbols_by_name` on demand via `symbols__sort_by_name_read_lock()`
  in `dso__next_symbol_by_name()`, `dso__find_symbol_by_name()`, and
  `symbols__visit_by_name()` (Alireza Haghdoost, Sashiko).
- Expand `perf test symbols` (`Patch 23`) to return `TEST_SKIP` on
  unshrinkable DSOs, verify full symbol count and sorted order after reload,
  and test `dso_symbol` pinning, inline/srcline eviction ordering, and
  `dso__next_symbol_by_name()` index rebuild after `dso__shrink()` (Alireza
  Haghdoost, Sashiko).

v3: https://lore.kernel.org/linux-perf-users/20261110220803.2503416-1-irogers@google.com/
v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/
v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.com/

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Google Antigravity / Jetski coding assistant and Sashiko
  automated patch review (sashiko.dev and internal Sashiko).
- Summary of prompts and assistance: Interactive pair-programming session to
  replace per-symbol refcounting with `struct dso_symbol` DSO-borrowed
  lifetimes, reorder fixes and preparatory patches ahead of the `struct
  symbol` array conversion, remove `perf_singlethreaded`, split and refine
  the `symbols` and `maps` benchmarks, and address LKML reviewer and Sashiko
  feedback across `machine`, `threads`, `annotate`, `dso`, `map`, `symbol`,
  and `tests/symbols.c`.
- Testing performed: Built with Clang (`-Wthread-safety`), AddressSanitizer,
  LeakSanitizer, and `DEBUG=1` (`REFCNT_CHECKING=1`); ran `perf test`
  (including `Symbols`, `Maps`, `DSO data`, `hists`, `thread`, `annotate`,
  `report`, and `script` suites), `perf bench internals` (`synthesize`,
  `symbols`, and `maps`), and `scripts/checkpatch.pl`.

Signed-off-by: Ian Rogers <irogers@google.com>

Ian Rogers (23):
  perf machine: Fix NULL deref on allocation failure in
    __machine__findnew_thread()
  perf threads: Avoid table->lock self-deadlock in
    threads__for_each_thread()
  perf tools: Remove perf_singlethreaded
  perf map_browser: Fix browser index heap corruption by computing on
    demand
  perf machine: Protect machines->guests rbtree with a rw_semaphore
  perf vdso: Constify dso parameter in dso__is_vdso()
  perf rwsem: Add down_read_trylock() and down_write_trylock()
  perf map_symbol: Add struct dso_symbol and use for parent symbols
  perf call-path: Use struct dso_symbol to retain symbol DSO lifetimes
  perf db-export: Store symbol database IDs in a hashmap
  perf annotate: Move struct annotation to a hashmap and remove
    symbol_conf.priv_size
  perf bench internals: Add symbols benchmark
  perf bench internals: Add maps benchmark
  perf demangle: Add fast-path prefix checks for Rust and Java
    demanglers
  perf symbol-elf: Cache ELF program/section headers and defer symbol
    name lookup
  perf maps: Optimize tail insertion and small-append sorting
  perf symbol: Add accessor functions for struct symbol fields
  perf symbol: Switch backing storage from rbtree to struct symbols
    array
  perf symbol: Optimize symbol sorting with natural-run merge sort and
    binary insertion
  perf symbol: Add memory shrinking for symbols, DSOs, and machines
  perf session: Add dso__session() and session-scoped allocation
    wrappers
  perf symbol: Use session allocation wrappers in symbol, DSO, thread,
    and hist paths
  perf test symbols: Add tests for symbol shrinking and session alloc
    wrappers

 tools/perf/Documentation/perf-bench.txt       |    6 +
 .../arch/powerpc/util/skip-callchain-idx.c    |    2 +-
 tools/perf/arch/powerpc/util/sym-handling.c   |   40 +-
 tools/perf/bench/Build                        |    2 +
 tools/perf/bench/bench.h                      |    2 +
 tools/perf/bench/maps.c                       |  202 +++
 tools/perf/bench/symbols.c                    |  273 ++++
 tools/perf/bench/synthesize.c                 |    7 -
 tools/perf/builtin-annotate.c                 |   18 +-
 tools/perf/builtin-bench.c                    |    2 +
 tools/perf/builtin-c2c.c                      |   14 -
 tools/perf/builtin-diff.c                     |    4 +-
 tools/perf/builtin-kallsyms.c                 |    7 +-
 tools/perf/builtin-kmem.c                     |   70 +-
 tools/perf/builtin-kwork.c                    |    4 +-
 tools/perf/builtin-lock.c                     |   10 +-
 tools/perf/builtin-mem.c                      |    2 +-
 tools/perf/builtin-record.c                   |    5 +-
 tools/perf/builtin-report.c                   |   14 -
 tools/perf/builtin-sched.c                    |    6 +-
 tools/perf/builtin-script.c                   |   16 +-
 tools/perf/builtin-timechart.c                |    2 +-
 tools/perf/builtin-top.c                      |   28 +-
 tools/perf/builtin-trace.c                    |   22 +-
 tools/perf/tests/builtin-test.c               |    1 -
 tools/perf/tests/dlfilter-test.c              |    4 +-
 tools/perf/tests/dwarf-unwind.c               |    2 +-
 tools/perf/tests/hists_common.c               |    9 +-
 tools/perf/tests/hists_cumulate.c             |    4 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/maps.c                       |   67 +
 tools/perf/tests/symbols.c                    |  741 +++++++++-
 tools/perf/tests/vmlinux-kallsyms.c           |  181 +--
 tools/perf/ui/browser.c                       |    3 +
 tools/perf/ui/browsers/annotate.c             |   10 +-
 tools/perf/ui/browsers/hists.c                |   26 +-
 tools/perf/ui/browsers/map.c                  |   85 +-
 tools/perf/ui/gtk/annotate.c                  |    6 +-
 tools/perf/ui/stdio/hist.c                    |   12 +-
 .../perf/util/annotate-arch/annotate-arm64.c  |   12 +-
 .../util/annotate-arch/annotate-loongarch.c   |    4 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |   14 +-
 tools/perf/util/annotate-data.c               |   12 +-
 tools/perf/util/annotate.c                    |  255 +++-
 tools/perf/util/annotate.h                    |    6 +-
 tools/perf/util/auxtrace.c                    |  111 +-
 tools/perf/util/block-info.c                  |    8 +-
 tools/perf/util/block-range.c                 |    3 +-
 tools/perf/util/bpf_lock_contention.c         |   16 +-
 tools/perf/util/c2c-function.c                |   19 +-
 tools/perf/util/call-path.c                   |   42 +-
 tools/perf/util/call-path.h                   |   10 +-
 tools/perf/util/callchain.c                   |   22 +-
 tools/perf/util/callchain.h                   |    3 +-
 tools/perf/util/capstone.c                    |   20 +-
 tools/perf/util/data-convert-json.c           |    4 +-
 tools/perf/util/db-export.c                   |  144 +-
 tools/perf/util/db-export.h                   |   16 +
 tools/perf/util/debug.c                       |    3 +-
 tools/perf/util/demangle-java.c               |   23 +-
 tools/perf/util/disasm.c                      |   49 +-
 tools/perf/util/dlfilter.c                    |   12 +-
 tools/perf/util/dso.c                         |  263 +++-
 tools/perf/util/dso.h                         |   83 +-
 tools/perf/util/dsos.c                        |   77 ++
 tools/perf/util/dsos.h                        |    3 +
 tools/perf/util/event.c                       |    4 +-
 tools/perf/util/evsel_fprintf.c               |    2 +-
 tools/perf/util/hist.c                        |   86 +-
 tools/perf/util/hist.h                        |    8 +-
 tools/perf/util/intel-pt.c                    |   74 +-
 tools/perf/util/libbfd.c                      |    7 +-
 tools/perf/util/llvm.c                        |    6 +-
 tools/perf/util/lock-contention.c             |    2 +-
 tools/perf/util/machine.c                     |  174 ++-
 tools/perf/util/machine.h                     |   14 +-
 tools/perf/util/map.c                         |   38 +-
 tools/perf/util/map.h                         |   10 +-
 tools/perf/util/map_symbol.c                  |   30 +
 tools/perf/util/map_symbol.h                  |   11 +
 tools/perf/util/maps.c                        |  281 +++-
 tools/perf/util/mutex.h                       |    3 +
 tools/perf/util/probe-event.c                 |  133 +-
 tools/perf/util/python.c                      |   65 +-
 tools/perf/util/rwsem.c                       |   29 +-
 tools/perf/util/rwsem.h                       |   11 +
 tools/perf/util/session.c                     |   78 ++
 tools/perf/util/session.h                     |   14 +-
 tools/perf/util/sort.c                        |   49 +-
 tools/perf/util/srcline.c                     |   16 +-
 tools/perf/util/symbol-elf.c                  |  274 +++-
 tools/perf/util/symbol.c                      | 1228 +++++++++++++----
 tools/perf/util/symbol.h                      |  146 +-
 tools/perf/util/symbol_conf.h                 |    1 -
 tools/perf/util/symbol_fprintf.c              |   37 +-
 tools/perf/util/thread-stack.c                |   48 +-
 tools/perf/util/threads.c                     |   35 +-
 tools/perf/util/unwind-libdw.c                |    2 +-
 tools/perf/util/util.c                        |   12 -
 tools/perf/util/util.h                        |    5 -
 tools/perf/util/vdso.c                        |    2 +-
 tools/perf/util/vdso.h                        |    2 +-
 102 files changed, 4695 insertions(+), 1387 deletions(-)
 create mode 100644 tools/perf/bench/maps.c
 create mode 100644 tools/perf/bench/symbols.c

-- 
2.56.1.703.gf848ed807c-goog

