Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348496;
	b=V3yQeq6J/pph3nFjYuK68vLfq24ZCXSKvQOlhV8dDJJmZwVtBxxpjQAfjJBUxOoUneC2
	 SeXy6dlmO6OMOVbgSxgoQD2ni6IjpDqxlZccz2g+UvVs706jD3KSLx/eqYnJdpKbsAE1n
	 TbzdcTYAtzzkVUCp5Q6sU11XasvoLs+HYk0k3f4b+3RIy+BmX1boWVcBVZwToZphavAD0
	 R7ehbJNPg+INSaKwTH5oE71yNj6F7R71uPiti7LU8U8oJic6GW1A7/4VCVifcec9oB9wC
	 +cFJmtHxpMCNX1vT/0skiFnTucGfoUlbDB8ngSaffJTjAce7oNo3LxL/MJiQIss/v4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4lk1+aZkb+kpaOabz+VVTizTMQdlJpDsiEMXQza+1M4=;
	b=WwCA8rcTZ2h8qZPcGO1aI0IYaAtlMElgCIl9oyhLg4ltEfKr+bQtAVTPUkFGJ7f/woQ1
	 gzZCwuQUKQNzHFuRFL9x1JRu8qEGEl7B6omJWt83RgQk/w1hmi4Q3LDoAfYn4CZccsnC1
	 XmH6A5caid2HDCP4aIqKjjNwJFKEodAYxQlJ1MLPWDwDMXIpqd2CKX0PKL7gKrm8N94/O
	 +xL5AgAdmxoNvsxIxqYR39EwfTNWph/5pBWvwz6hy0jKpchxhsCz2kYj1mgDx/+JPWhFN
	 F/JvIfD755amm1MWOtxhuw//0EPOj6Ssvi4CIrnGIBhvT/KSkOiK65r8rLRPgbaxMXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ntTuHr6i;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94872606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94872606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ntTuHr6i
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5121626eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348495; x=1794953295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lk1+aZkb+kpaOabz+VVTizTMQdlJpDsiEMXQza+1M4=;
        b=ntTuHr6inIDEuZewhUMVB9iEXJwdbLxzi1cWC1J+wCqpfKvIEcxb5dBcvAYo/gwIoP
         jsozC+KLMOcQ6smU/yg6FMjC/0+BUGvhWhQrmJYibGpBw3Bt4J9LCjo2AtswE6+JKFN8
         5Y79BF1kdtJNvcXDfSTsu9b0w2nWA2qO7YyLLQz9x/lJ/A7FYgP7dq0HDukUO7f4tS0j
         sl6Sd3YFnkGlJEdxRB5/WSHKTXn2CZeLjRNBQiJR0e4PhoPlixj2ft9ouCV3tFeqkKz2
         yj3NjGvQhOSPPnfF4y4VED3Qnde91OwxTCIQ5fgHz4sXsQSvnHY84ipp/hcbYYp2fmzF
         njAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348495; x=1794953295;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lk1+aZkb+kpaOabz+VVTizTMQdlJpDsiEMXQza+1M4=;
        b=zRIrdQVv0ovYILdzAWKcxpr8u8BYGPsQO05EGC+/UKtoh7r/EAAcK49Xp0NvXx3Gm+
         llPpZzmA8IE7g4CDNQQ4yw88mvQ2GDhmQZGBtpi1YMVOZjcm3hVP1wtnMPwqpf7EbDLR
         1UldRY/tVnk+fxe+GmbSRfylg7SOdBu5eNbyAVVdhG4stm/cPQZVLL5KytT3lW7xy7UM
         3RVyjp9q4Atsv58Z9Hp9/RLQ61nmUYFiSFmMRX3wYTiUPQ/33qcY2MwT2wQerXav42Wc
         75Lw5OlIWsw9aZaiFpu8+9gWgxXP+TQ6IJI/RddrnQYj+bup1Tb6uGlNFxgSDBuS1IX8
         wokg==
X-Forwarded-Encrypted: i=1; AL+hErECbjHYm/pFrwbrx29j8vIe59sajLH5JCVPVEI6+Q9YqMSAdG/q8n9UVwp7VW3mvXLvo2Bx7yzR6gTSo0U5cL7U@vger.kernel.org
X-Gm-Message-State: APuU4Z9mkzzr3McM39fG9X6bfxRmZsOgyQteS8qTYf33F6L3dca1pVTb
	z8Zfjzc2jPFKAe4WRGVPG/1XvyPBwDVJUq/UgrGXKCvRuGd4SBfX4aaTL01Jt70gagD2SQ7BEvu
	pdGooPXLD8A==
X-Received: from dlbvv25.prod.google.com ([2002:a05:7022:5f19:b0:1b3:ba1e:2c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f51c:b0:144:e246:a0b2
 with SMTP id a92af1059eb24-1b3c0376419mr219766c88.44.1794348494072; Tue, 10
 Nov 2026 14:08:14 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:43 -0800
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-1-irogers@google.com>
Subject: [PATCH v3 00/20] perf symbol: Sorted arrays, DSO-owned lifetimes, and
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
reference counting), removes `symbol_conf.priv_size`, speeds up ELF symbol
and map loading/sorting, and adds on-demand session memory shrinking:

- **Fixes and preparatory cleanups (Patches 1-4)**:
  - Patch 1 fixes a heap buffer corruption in the TUI map browser when
    `symbol_conf.priv_size` was not initialized with `sizeof(u32)` by
    computing symbol browser indices on demand.
  - Patch 2 protects the `machines->guests` rbtree with a `rw_semaphore`.
  - Patch 3 constifies `dso` in `dso__is_vdso()`.
  - Patch 4 adds `down_read_trylock()` and `down_write_trylock()` to
    `util/rwsem.[ch]`.
- **DSO-owned symbol lifetimes and `priv_size` removal (Patches 5-8)**:
  - Patches 5-6 introduce `struct dso_symbol` (`{ struct dso *dso; struct
    symbol *sym; }`) so callers that borrow a symbol's lifetime directly
    from its owning `struct dso` without a `struct map` (`hist_entry`
    parent symbols, `call_path` nodes, and `db-export`) retain a `dso`
    reference for the lifetime of the symbol pointer. (Consolidating
    `map_symbol` and `dso_symbol` back into `symbol.h` as explicit
    DSO/map-borrowed symbol handle types is left for follow-up cleanup.)
  - Patches 7-8 move `db-export` symbol IDs and `struct annotation` into
    on-demand hashmaps and remove `symbol_conf.priv_size` and
    `symbol__priv()`.
- **Benchmarks and loading/sorting optimizations (Patches 9-13)**:
  - Patches 9-10 add standalone `perf bench internals symbols` and
    `perf bench internals maps` subcommands.
  - Patch 11 adds fast-path prefix checks for the Rust and Java demanglers.
  - Patch 12 caches ELF program and section headers in
    `dso__load_sym_internal()` and defers `elf_sym__name()` lookups until
    after non-symbol/non-allocated entries are filtered out.
  - Patch 13 adds an O(1) tail-insertion fast path and incremental binary
    insertion sort to `struct maps`.
- **Sorted symbol arrays and natural-run merge sort (Patches 14-16)**:
  - Patch 14 encapsulates `struct symbol` field accesses behind inline
    accessor functions in preparation for lazy symbol/string loading.
  - Patch 15 replaces `dso->symbols` (`rb_root_cached`) and
    `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
    container backed by sorted pointer arrays, removing `struct rb_node`
    from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
    bytes, or 16 bytes net per symbol after accounting for the array
    pointer).
  - Patch 16 replaces `qsort()` on `struct symbols` with a stable
    natural-run merge sort, galloping merge, and a sorted tail buffer with
    amortized `sqrt(N)` merge for out-of-order insertions.
- **On-demand memory shrinking and tests (Patches 17-20)**:
  - Patch 17 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
    `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
    to reclaim `symbols_by_name`, excess array capacity, cached DSO file
    descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
    with no annotated symbols), with transparent on-demand reload via
    `dso__load()`.
  - Patches 18-19 add `dso__session()` and `perf_session__malloc()` /
    `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
    trigger `perf_session__shrink()` and retry once on allocation failure.
  - Patch 20 adds unit tests in `perf test symbols` covering sorted symbol
    insertion, symbol/DSO shrinking, `dso_symbol` lifetime pinning, inline
    frame/srcline cleanup ordering, `symbols_by_name` on-demand rebuild,
    transparent DSO reload, and session allocation wrappers.

Changes in v3:
- Drop per-symbol `DECLARE_RC_STRUCT(symbol)` reference counting and
  partial symbol-table retention (`symbols__merge_retained()`) in favor of
  DSO-owned symbol lifetimes via `struct dso_symbol` (`Patches 5-6`),
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
- Expand `perf test symbols` (`Patch 20`) to return `TEST_SKIP` on
  unshrinkable DSOs, verify full symbol count and sorted order after reload,
  and test `dso_symbol` pinning, inline/srcline eviction ordering, and
  `dso__next_symbol_by_name()` index rebuild after `dso__shrink()` (Alireza
  Haghdoost, Sashiko).
- Rebase onto `perf-tools-next` (`cc905a18a647`).

v2: https://lore.kernel.org/linux-perf-users/20261027231513.816148-1-irogers@google.com/
v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.com/

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review.
- Summary of prompts and assistance: Interactive pair-programming session to
  replace per-symbol refcounting with `struct dso_symbol` DSO-borrowed
  lifetimes, reorder fixes and preparatory patches ahead of the `struct
  symbol` array conversion, split and refine the `symbols` and `maps`
  benchmarks, and address LKML reviewer and Sashiko feedback across
  `annotate`, `dso`, `symbol`, and `tests/symbols.c`.
- Testing performed: Built with Clang (`-Wthread-safety`), AddressSanitizer,
  LeakSanitizer, and `DEBUG=1` (`REFCNT_CHECKING=1`); ran `perf test`
  (including `Symbols`, `Maps`, and `hists` suites), `perf bench internals
  symbols` and `maps`, `perf report -s parent,symbol`, `export-to-sqlite.py`,
  and `scripts/checkpatch.pl`.

Ian Rogers (20):
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
 tools/perf/builtin-annotate.c                 |   18 +-
 tools/perf/builtin-bench.c                    |    2 +
 tools/perf/builtin-c2c.c                      |   14 -
 tools/perf/builtin-diff.c                     |    4 +-
 tools/perf/builtin-kallsyms.c                 |    7 +-
 tools/perf/builtin-kmem.c                     |   70 +-
 tools/perf/builtin-kwork.c                    |    4 +-
 tools/perf/builtin-lock.c                     |   10 +-
 tools/perf/builtin-mem.c                      |    2 +-
 tools/perf/builtin-report.c                   |   14 -
 tools/perf/builtin-sched.c                    |    6 +-
 tools/perf/builtin-script.c                   |   14 +-
 tools/perf/builtin-timechart.c                |    2 +-
 tools/perf/builtin-top.c                      |   22 +-
 tools/perf/builtin-trace.c                    |   22 +-
 tools/perf/tests/builtin-test.c               |    1 -
 tools/perf/tests/dlfilter-test.c              |    4 +-
 tools/perf/tests/dwarf-unwind.c               |    2 +-
 tools/perf/tests/hists_common.c               |    9 +-
 tools/perf/tests/hists_cumulate.c             |    4 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/maps.c                       |   67 +
 tools/perf/tests/symbols.c                    |  611 ++++++++-
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
 tools/perf/util/annotate.c                    |  205 ++-
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
 tools/perf/util/machine.c                     |  171 ++-
 tools/perf/util/machine.h                     |   14 +-
 tools/perf/util/map.c                         |   27 +-
 tools/perf/util/map.h                         |   10 +-
 tools/perf/util/map_symbol.c                  |   30 +
 tools/perf/util/map_symbol.h                  |   11 +
 tools/perf/util/maps.c                        |  281 +++-
 tools/perf/util/mutex.h                       |    3 +
 tools/perf/util/probe-event.c                 |  133 +-
 tools/perf/util/python.c                      |   65 +-
 tools/perf/util/rwsem.c                       |   20 +
 tools/perf/util/rwsem.h                       |    2 +
 tools/perf/util/session.c                     |   78 ++
 tools/perf/util/session.h                     |   14 +-
 tools/perf/util/sort.c                        |   49 +-
 tools/perf/util/srcline.c                     |   16 +-
 tools/perf/util/symbol-elf.c                  |  269 +++-
 tools/perf/util/symbol.c                      | 1185 +++++++++++++----
 tools/perf/util/symbol.h                      |  146 +-
 tools/perf/util/symbol_conf.h                 |    1 -
 tools/perf/util/symbol_fprintf.c              |   37 +-
 tools/perf/util/thread-stack.c                |   48 +-
 tools/perf/util/unwind-libdw.c                |    2 +-
 tools/perf/util/vdso.c                        |    2 +-
 tools/perf/util/vdso.h                        |    2 +-
 97 files changed, 4430 insertions(+), 1320 deletions(-)
 create mode 100644 tools/perf/bench/maps.c
 create mode 100644 tools/perf/bench/symbols.c

-- 
2.56.0.542.g3ef89b7020-goog

