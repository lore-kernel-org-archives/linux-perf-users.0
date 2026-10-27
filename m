Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142919;
	b=5GGJRiMKBtEW40NJoSFy8awPO1X2x6g03BjGYjrJISLIbzZ98xHNRrrvtZRDLMXOONW3
	 Hz8BWepR5PzoaNNwIXFNYTCKltKesS1VPRP1UHQH+E0I3gBBlvi3/MhuPrZKVqKJIT3jK
	 4tKMJTPG2KFD3lx++2pSiBAaX3aSfqo9IPnuv3N2TUah6bkoxqln0fiSAkA725eTPzkkc
	 dC+R89IDRPVy11armCUtH7MDm2wHJLQymGqy1Phk992CYuQoLFlfTCDvEKQ83vjI/6Tls
	 MxXsA8cbOlIfvdI6fRM3bEeFkk3cptsDRDVffRx08QHZdTAF71p1GoE6ERgWaYBo72Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C4jfBN9nctBGPjsIL2hgf9L5BVjV73jNSnLq3fCJMzQ=;
	b=FC2JBb+5XCOKm5O4U7qBoUXHZAWERLg52dcbfeH86S45MpfEeYoWqexUsV5BAJ12Wuyi
	 mIVbz0LgxXZcANkZESrn1LEaA+8uP5gpf4da+XG/MmF94Uyga7ZtE0J4LLKYI0mGkKYEL
	 suNyQKx5MfFw89U0ZCssZe+cB+orIig9KyZkrm95CQGnpBqU8Lg7lG+noWff3Q3gwlfsK
	 deqx9QzMMJlUNWfeK0FZtx13+vUSvBH0Bm0hTDoxCWiA13x6n21s5n7rcPdBsROLFFSak
	 bVF3vo5dlSQbO2oY2wWZdel8nUrsB+XOeIWUseQL7PM+/9TT3Xs+MlO/pRc8F4jthmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llMa2VCf;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2F606A31F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llMa2VCf
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35cbea41088so486696eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142918; x=1793747718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4jfBN9nctBGPjsIL2hgf9L5BVjV73jNSnLq3fCJMzQ=;
        b=llMa2VCfvgb2LA41VfJsU+BEbf0whtfdTq5JBnQIWd7UGJmvODTcIimpPpiwtNOiHX
         exdHQsbiDEDrR5rPKJiMhOpIWzgMLqS+C9SkeZxlFz0n3vWIUWVsqQFIGHFooR2kYQO4
         4ASTsrHXW3ZjwR3Bi2I13oxbip8r3RGBDr5lKdvQQXorBqq3DJsdhMkObgc75umUeBGn
         aDuev1H7AUO30xZIWQseN4OihwST/ady4JMyebFz6VsCX6pBl0lNjqCJDZwqRKPzWLOh
         qCIf/8YkggaojilRtLljeOTtMaBZtwu4UkRc+JiPh7QfahwMjj6xYAwS4GmV2cQr9O70
         qbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142918; x=1793747718;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4jfBN9nctBGPjsIL2hgf9L5BVjV73jNSnLq3fCJMzQ=;
        b=XCe/XSw9X5UHXapPvKfqk7giTXWbBotl43NvrBTNjlIyRnVlkty1zBLFniQL4fFNFj
         1p/GgKXyNtqEqYPYGXYiK+wwxjcZjFLzZeEQWiPbPu0JFx0TiN4OkzYAHrUITxD+z7C6
         GgNskNcmuuw17+0dTLMi45bRG5z2evp8iL44tCEem+3+tq2OOWU9YZPpVooLR1NvG8Yd
         MRRr3OfEeFgTTan6YJAtvL6tn+W9yzwL2BOeMAcPrb00AUSTTUn7uwvh2VMlk4lzG0Vz
         9tVjf/lOoPrnFB6DEpGaI9ip97ip/JfQ4iEwTk8+pCjRGdA6Mwo6S/2kUH0xG36NAx2Z
         BbxA==
X-Forwarded-Encrypted: i=1; AKwUvBwwIvYZILkkw4FGr7NMO99EBcx3JhN8YVUSfiPnifHlsGyxylMS6x5YHRAH/VTWp9z6bc0EWNn6uCcB3Xm0Rgwf@vger.kernel.org
X-Gm-Message-State: AFq9FYKX3CWYS4lMwlDmReuB4GFJJMIV1s5oHxG9NTVRFwNQsi8sgcr6
	MoRpw/L58dNgKVQ/6vWLqMVNDH9B3nOTZVC2bla9N964qAYU7/3QA1UoHnhwm7iyGHMxslj0PZv
	W/P+bEZXZxQ==
X-Received: from dyz26.prod.google.com ([2002:a05:693c:409a:b0:36a:13d2:4db1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:808e:b0:36a:1434:c691
 with SMTP id 5a478bee46e88-36a20054610mr1319693eec.14.1793142917379; Tue, 27
 Oct 2026 16:15:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:14:54 -0700
In-Reply-To: <20260928075237.3055101-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-1-irogers@google.com>
Subject: [PATCH v2 00/18] perf symbol: Reference counting, sorted arrays, and
 memory shrinking
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When profiling large binaries or long-running workloads with many DSOs and
threads, symbol and DSO tables frequently dominate perf's memory footprint
and startup latency. Currently `struct symbol` has several structural
limitations:

1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
   `dso->symbols` address rbtree, plus an optional negative-offset
   allocation prefix (`symbol_conf.priv_size`) for TUI browser indices,
   `db-export` IDs, or `struct annotation` state even when only a tiny
   fraction of symbols are ever annotated or exported.
2. Unlike `struct map`, `struct dso`, and `struct thread`, `struct symbol`
   is not reference-counted: once loaded into a `struct dso`, symbols can
   never be safely evicted while `hist_entry`, `callchain_cursor_node`, or
   `map_symbol` references exist, and `dso__symbols()` has no internal
   synchronization against concurrent readers/writers.
3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
   invokes `libelf` section/program header lookups per symbol, calls
   `elf_sym__name()` before filtering out non-function/non-allocated
   symbols, runs Rust/Java demanglers on plain C symbols without fast-path
   prefix checks, and resorts `dso->symbols` with `qsort()` even when ELF
   symbol tables are already largely ordered in ascending address runs.

This series modernizes `struct symbol` to match the rest of `tools/perf/uti=
l`
(`DECLARE_RC_STRUCT`, `struct rw_semaphore`, sorted pointer arrays) and
introduces symbol/DSO memory shrinking and faster ELF symbol loading:

- Patch 1 adds `perf bench internals symbols` and `perf bench internals map=
s`
  to benchmark ELF symbol loading, bulk symbol insertion/sorting/lookup,
  incremental symbol appends, ascending map insertion, and incremental map
  appends.
- Patch 2 adds fast-path prefix checks in `dso__demangle_sym()` (before
  calling `rust_demangle_demangle()`, keeping `demangle-rust-v0.c`
  unmodified relative to upstream `rustc-demangle`) and in
  `java_demangle_sym()`.
- Patches 3-6 encapsulate `struct symbol` field access behind accessor
  functions (annotated with `__attribute__((nonnull))`) and replace the
  negative-offset `symbol_conf.priv_size` allocation prefix with on-demand
  browser index calculation and per-DSO/per-exporter hashmaps for
  `db-export` and `struct annotation`.
- Patch 7 replaces `dso->symbols` (`rb_root_cached`) and `dso->symbol_names=
`
  with a locked `struct symbols` container backed by sorted pointer arrays
  (`symbols` and `symbols_by_name`) protected by a `struct rw_semaphore`,
  removing `struct rb_node` from `struct symbol`.
- Patch 8 wraps `struct symbol` in `DECLARE_RC_STRUCT(symbol)` with
  `refcount_t` (`symbol__get()` / `symbol__put()` / `symbol__zput()`) for
  sanitizer-checked reference counting across `map_symbol`, `addr_location`=
,
  `hist_entry`, `callchain`, `thread_stack`, and `db-export`.
- Patch 9 replaces `qsort()` in `struct symbols` with a natural-run merge
  sort and galloping merge (taking advantage of pre-ordered runs in
  `.symtab`/`.dynsym` and `kallsyms`) plus an in-place binary insertion
  fast path for small incremental appends.
- Patch 10 applies the same incremental binary-insertion sort and an O(1)
  tail-insertion fast path to `struct maps` for `/proc/<pid>/maps` synthesi=
s
  and runtime `PERF_RECORD_MMAP2` / JIT map insertions.
- Patch 11 caches ELF program and section headers during
  `dso__load_sym_internal()`, defers `elf_sym__name()` string table lookups
  until after symbol filtering, and runs `symbols__fixup_end()` /
  `symbols__fixup_duplicate()` once per DSO load.
- Patches 12-17 add `down_read_trylock()` / `down_write_trylock()`, protect
  `machines->guests` with a `rw_semaphore`, implement `symbols__shrink()`,
  `dso__shrink()`, `dsos__shrink()`, and `perf_session__shrink()` (with
  transparent on-demand reload in `dso__load()` that preserves pointer
  identity for retained symbols), and provide `perf_session__malloc()` /
  `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
  automatically shrink unreferenced symbols and DSOs on allocation failure.
- Patch 18 adds unit tests in `perf test symbols` covering sorted symbol
  insertion, symbol/DSO shrinking, transparent DSO reload after shrink, and
  session allocation wrappers.

End-to-end benchmark results across the series:

  perf bench internals symbols (perf binary):
    Average DSO load + sort:      7.348 msec ->   5.324 msec (-27.5%)
    Average DSO memory usage:        1401 KB ->      1308 KB ( -6.6%)
    Average bulk insert + lookup: 1453.95 us -> 1161.00 us   (-20.1%)
    Average append + lookup (200 interior inserts into 10,000 symbols):
      rbtree: 42.85 us -> array+qsort: 40429.75 us -> array+binary-insert: =
152.70 us

  perf bench internals symbols -b libLLVM.so.21.1:
    Average DSO load + sort:     81.196 msec ->  62.582 msec (-22.9%)
    Average DSO memory usage:        9530 KB ->      9164 KB ( -3.8%)

  perf bench internals symbols -b libLLVM.so.21.1 --no-demangle:
    Average DSO load + sort:     32.675 msec ->  19.122 msec (-41.5%)
    Average DSO memory usage:        7589 KB ->      7229 KB ( -4.7%)

  perf bench internals maps:
    Average ascending insert + lookup:   63.37 us -> 58.97 us ( -6.9%)
    Average append + lookup:           7477.45 us -> 96.67 us (-98.7%, 77.3=
x faster)

Net performance and memory trade-offs:
- Replacing the per-symbol rbtree (`struct rb_node`) and negative-offset
  `symbol_conf.priv_size` allocation prefix with a contiguous sorted pointe=
r
  array reduces per-symbol heap overhead by 16 to 24+ bytes (saving 3.8% to
  6.6% of total DSO symbol table heap memory unconditionally, and allowing
  unreferenced symbols and DSOs to be shrunk on demand under memory
  pressure).
- For the dominant symbol workloads=E2=80=94loading ELF binaries (`-22.9%` =
to
  `-41.5%`) and bulk symbol insertion, sorting, and lookup (`-20.1%`)=E2=80=
=94the
  contiguous array, natural-run merge sort, ELF header caching, and
  demangler fast paths yield substantial speedups over the rbtree baseline.
- For synthetic single-symbol interior insertions interleaved with immediat=
e
  lookups into an already-large 10,000-symbol DSO (`dso__insert_symbol()`),
  an rbtree rotation takes ~0.21 us/op (`42.85 us` for 200 ops) whereas
  shifting the contiguous pointer array tail with `memmove()` after binary
  search takes ~0.76 us/op (`152.70 us` for 200 ops, down from `40429.75 us=
`
  with naive `qsort()`). In real workloads, symbols are either loaded in
  bulk (`dso__load()`) or inserted into small per-prog BPF/JIT DSOs where
  the array fits in a few cache lines, making this sub-microsecond
  difference negligible in practice.
- Overall, the series reduces memory consumption across all workloads while
  significantly improving=E2=80=94or remaining neutral on=E2=80=94runtime p=
erformance.

v2:
- Rebased onto perf-tools-next (dropping "perf symbols: Fix broken
  ELF_C_READ_MMAP fallback guard", which was merged upstream, and splitting
  "perf libdw: Optimize fallback logic for missing DWARF" into a separate
  fixes series).
- Added 'perf bench internals symbols' and 'perf bench internals maps'
  benchmarks (Patch 1) and included before/after numbers in the optimizatio=
n
  patches.
- Added __attribute__((nonnull)) annotations to struct symbol accessor
  functions (Patch 3).
- Split the symbol_conf.priv_size removal patch into three separate patches
  for map_browser (Patch 4), db-export (Patch 5), and annotate (Patch 6).
- Added dedicated optimization patches for Rust/Java demangler prefix check=
s
  (Patch 2), natural-run merge sort and binary insertion in struct symbols
  (Patch 9), tail-insertion and incremental binary-insertion sort in struct
  maps (Patch 10), and ELF program/section header caching and deferred
  symbol name lookup (Patch 11).
- Replaced periodic heuristic LRU shrinking and windowed ELF symbol loading
  with on-demand shrinking (symbols__shrink(), dso__shrink(),
  dsos__shrink(), perf_session__shrink()) triggered on allocation failure v=
ia
  session-scoped allocation wrappers, plus transparent DSO reload preservin=
g
  retained symbol pointers (Patches 12-18).

v1: https://lore.kernel.org/lkml/20260928075237.3055101-1-irogers@google.co=
m/

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>

Ian Rogers (18):
  perf bench internals: Add symbols and maps benchmarks
  perf demangle: Add fast-path prefix checks for Rust and Java
    demanglers
  perf symbol: Add accessor functions for struct symbol fields
  perf map_browser: Compute symbol browser index on demand
  perf db-export: Store symbol database IDs in a hashmap
  perf annotate: Move struct annotation to a hashmap and remove
    symbol_conf.priv_size
  perf symbol: Switch backing storage from rbtree to struct symbols
    array
  perf symbol: Add reference counting and DECLARE_RC_STRUCT(symbol)
  perf symbol: Optimize symbol sorting with natural-run merge sort and
    binary insertion
  perf maps: Optimize tail insertion and small-append sorting
  perf symbol-elf: Cache ELF program/section headers and defer symbol
    name lookup
  perf rwsem: Add down_read_trylock() and down_write_trylock()
  perf vdso: Constify dso parameter in dso__is_vdso()
  perf machine: Protect machines->guests rbtree with a rw_semaphore
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
 tools/perf/bench/maps.c                       |  186 +++
 tools/perf/bench/symbols.c                    |  239 +++
 tools/perf/builtin-annotate.c                 |   22 +-
 tools/perf/builtin-bench.c                    |    2 +
 tools/perf/builtin-c2c.c                      |   14 -
 tools/perf/builtin-diff.c                     |    4 +-
 tools/perf/builtin-kallsyms.c                 |    9 +-
 tools/perf/builtin-kmem.c                     |   82 +-
 tools/perf/builtin-kwork.c                    |    4 +-
 tools/perf/builtin-lock.c                     |   25 +-
 tools/perf/builtin-mem.c                      |    2 +-
 tools/perf/builtin-report.c                   |   14 -
 tools/perf/builtin-sched.c                    |    6 +-
 tools/perf/builtin-script.c                   |   18 +-
 tools/perf/builtin-timechart.c                |    2 +-
 tools/perf/builtin-top.c                      |   24 +-
 tools/perf/builtin-trace.c                    |   23 +-
 tools/perf/tests/builtin-test.c               |    1 -
 tools/perf/tests/dlfilter-test.c              |   12 +-
 tools/perf/tests/dwarf-unwind.c               |    2 +-
 tools/perf/tests/hists_common.c               |    9 +-
 tools/perf/tests/hists_cumulate.c             |    8 +-
 tools/perf/tests/hists_filter.c               |   10 +-
 tools/perf/tests/hists_link.c                 |   16 +-
 tools/perf/tests/hists_output.c               |    9 +-
 tools/perf/tests/kallsyms-split.c             |    5 +-
 tools/perf/tests/maps.c                       |   58 +
 tools/perf/tests/pe-file-parsing.c            |    1 +
 tools/perf/tests/symbols.c                    |  454 +++++-
 tools/perf/tests/vmlinux-kallsyms.c           |  187 ++-
 tools/perf/ui/browser.c                       |    3 +
 tools/perf/ui/browsers/annotate.c             |   10 +-
 tools/perf/ui/browsers/hists.c                |   35 +-
 tools/perf/ui/browsers/map.c                  |   88 +-
 tools/perf/ui/gtk/annotate.c                  |    6 +-
 tools/perf/ui/stdio/hist.c                    |    6 +-
 tools/perf/util/addr2line.c                   |    8 +-
 tools/perf/util/addr_location.c               |    4 +
 .../perf/util/annotate-arch/annotate-alpha.c  |    5 +-
 .../perf/util/annotate-arch/annotate-arm64.c  |   12 +-
 .../util/annotate-arch/annotate-loongarch.c   |   15 +-
 tools/perf/util/annotate-arch/annotate-s390.c |    6 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |   14 +-
 tools/perf/util/annotate-data.c               |   12 +-
 tools/perf/util/annotate.c                    |  211 ++-
 tools/perf/util/annotate.h                    |    6 +-
 tools/perf/util/auxtrace.c                    |  111 +-
 tools/perf/util/block-info.c                  |   12 +-
 tools/perf/util/bpf_lock_contention.c         |   35 +-
 tools/perf/util/c2c-function.c                |   32 +-
 tools/perf/util/call-path.c                   |   15 +-
 tools/perf/util/callchain.c                   |   23 +-
 tools/perf/util/capstone.c                    |   22 +-
 tools/perf/util/data-convert-json.c           |    4 +-
 tools/perf/util/db-export.c                   |   99 +-
 tools/perf/util/db-export.h                   |    8 +
 tools/perf/util/debug.c                       |    3 +-
 tools/perf/util/demangle-java.c               |   23 +-
 tools/perf/util/disasm.c                      |   69 +-
 tools/perf/util/dlfilter.c                    |   12 +-
 tools/perf/util/dso.c                         |  257 ++-
 tools/perf/util/dso.h                         |   94 +-
 tools/perf/util/dsos.c                        |   76 +
 tools/perf/util/dsos.h                        |    3 +
 tools/perf/util/event.c                       |   12 +-
 tools/perf/util/evsel_fprintf.c               |    2 +-
 tools/perf/util/hist.c                        |   70 +-
 tools/perf/util/intel-pt.c                    |   74 +-
 tools/perf/util/libbfd.c                      |   14 +-
 tools/perf/util/libdw.c                       |    5 +-
 tools/perf/util/llvm.c                        |    8 +-
 tools/perf/util/lock-contention.c             |    8 +-
 tools/perf/util/machine.c                     |  189 ++-
 tools/perf/util/machine.h                     |    9 +
 tools/perf/util/map.c                         |   27 +-
 tools/perf/util/map.h                         |   18 +-
 tools/perf/util/map_symbol.c                  |    4 +-
 tools/perf/util/maps.c                        |  284 +++-
 tools/perf/util/mutex.h                       |    3 +
 tools/perf/util/probe-event.c                 |  148 +-
 tools/perf/util/python.c                      |   36 +-
 tools/perf/util/rwsem.c                       |   20 +
 tools/perf/util/rwsem.h                       |    2 +
 tools/perf/util/session.c                     |   78 +
 tools/perf/util/session.h                     |    8 +
 tools/perf/util/sort.c                        |   47 +-
 tools/perf/util/srcline.c                     |   22 +-
 tools/perf/util/symbol-elf.c                  |  311 +++-
 tools/perf/util/symbol.c                      | 1438 +++++++++++++----
 tools/perf/util/symbol.h                      |  187 ++-
 tools/perf/util/symbol_conf.h                 |    1 -
 tools/perf/util/symbol_fprintf.c              |   37 +-
 tools/perf/util/thread-stack.c                |   18 +-
 tools/perf/util/threads.c                     |   17 +-
 tools/perf/util/unwind-libdw.c                |    4 +-
 tools/perf/util/unwind-libunwind.c            |    2 +-
 tools/perf/util/vdso.c                        |    2 +-
 tools/perf/util/vdso.h                        |    2 +-
 103 files changed, 4557 insertions(+), 1389 deletions(-)
 create mode 100644 tools/perf/bench/maps.c
 create mode 100644 tools/perf/bench/symbols.c

--=20
2.56.0.313.g2479322e68-goog

