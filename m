Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713489;
	b=jXrRjW+fN9oRcqmO+cOITPeRVzTBMKUfSl3FAxN4LquFB9SW7rmOEjEr8fk9fbli6CFL
	 MrDnKI2IVT0RnwAKqzhgz+bRO+pKFLqP/aO7I3q+17JefKFsbO2rkaJcHb0tZ6mxN5GP3
	 3f8+t8TkAB84CYyKtccoIC2WsjBNizMBwRHXtpNQ4cBtCIMPgozPCra2tynsxTQvszBgW
	 kDEaAxsmd4JFR1Lpo0HzPfzetlmvx1u0rKGqert7BDKPB1WBI74JpCYBzeChVh44ZhVSh
	 iPCWlWJxdz3Dk0pqU30Ru5ScgodF6EXP/T4+wawuG9QBaay0IdLQNlCmWIZxLRK04ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EU763uC8mbFJQgIW11oaU6Ni+k3Dc7v20GcO/2cQf6I=;
	b=jiEqWEaTAd3/KEfWbw4baS74IQ4vS1LxGV3fJh2aCJ5vqIyryLSOArGh9O2Ae8p2QRxD
	 3qAygcH7cY4+zJofVt5H3YyWBIIBDLArXzgn8awA/OL1IT8dZeolH+IDJJmT7WymG0IEI
	 2wQ+uHYo421UE8tXBBNVbUO3WfeTEbtRdhqvPFMwmx6Z4YRGEx2yKGriCusGtC/7ICDFN
	 X3i3PZnrFsCfxaJlKWD7OuZS88acmWzCXLsxu+dxJEUsLmKU9M7GpwFY7G7cygxlK1cs6
	 fD8iiY4JQT+rDRuhxlHWmvLll58YH7/fqoQlqHhL66jsHc8wLguc8lrExwHLQeGi9Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm7jl96N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2821606A323;
	Sun, 15 Nov 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm7jl96N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE37B1F000C4;
	Sun, 15 Nov 2026 03:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794713489;
	bh=EU763uC8mbFJQgIW11oaU6Ni+k3Dc7v20GcO/2cQf6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jm7jl96N3VX/zg05ed9Op2v2tSsduelDtoXC8g2PQG2aCIvfRoytxKdzfp/ZZvyIG
	 XTQDoITM/YMdNquPBGBbhFLl5X9qvNP+iLUWsm/q1wc9H4vFTfvBDfub5c+f5PFxhc
	 P8GbPmX3Orn34+riZgH4AK9rHFPO/1wy+v/hOUnBB67Uo5IGVidGEZKqlq7Usfg0f3
	 fO5GuCcCYSuVk6S17krYlB263s6pi6Sac2RJL8lS6dcnjRyPYqp6A6rtkqIS3T/6v8
	 5ywvaVEzaTA0sPLIQmyXqgRDz3VNcTKOoiSj/aHtWrM/Uw0+gh325J5NWJJrEy4wlx
	 Dhbzrz+vYEKEA==
Date: Sat, 14 Nov 2026 19:31:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, haghdoost@uber.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 00/23] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Message-ID: <avknjzKVrwXWYvUW@z2>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
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
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>

Hi Ian,

Thanks for working on this.

On Fri, Nov 13, 2026 at 09:17:11AM -0800, Ian Rogers wrote:
> When profiling large binaries or long-running workloads with many DSOs and
> threads, symbol and DSO tables frequently dominate perf's memory footprint
> and startup latency. Currently `struct symbol` has several structural
> limitations:
> 
> 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
>    `dso->symbols` address rbtree, plus an optional negative-offset
>    allocation prefix (`symbol_conf.priv_size`) for TUI browser indices,
>    `db-export` IDs, or `struct annotation` state even when only a tiny
>    fraction of symbols are ever annotated or exported.
> 2. `dso__symbols()` has no internal synchronization against concurrent
>    readers/writers, and while most symbol holders (`map_symbol`,
>    `addr_location`) already pin the owning `struct dso` via `map__get()`, a
>    handful of long-lived symbol holders (`hist_entry->parent`, `call_path`,
>    and `db-export`) retain raw `struct symbol *` pointers without retaining
>    a reference on the owning `struct dso`, preventing unreferenced DSOs and
>    their symbol tables from being safely reclaimed under memory pressure.
> 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
>    invokes `libelf` section/program header lookups per symbol, calls
>    `elf_sym__name()` before filtering out non-function/non-allocated
>    symbols, runs Rust/Java demanglers on plain C symbols without fast-path
>    prefix checks, and resorts `dso->symbols` with `qsort()` even when ELF
>    symbol tables are already largely ordered in ascending address runs.
> 
> This series modernizes `struct symbol` storage, ties symbol lifetimes
> explicitly to their owning `struct dso` (rather than adding per-symbol
> reference counting), removes `symbol_conf.priv_size` and
> `perf_singlethreaded`, speeds up ELF symbol and map loading/sorting, and
> adds on-demand session memory shrinking:

Some high-level feedback.  I'll check the code later.

> 
> - **Fixes and preparatory locking cleanups (Patches 1-7)**:
>   - Patch 1 fixes a NULL pointer dereference in `__machine__findnew_thread()`
>     when `threads__findnew()` fails to allocate a thread.
>   - Patch 2 snapshots shard threads and drops `table->lock` before invoking
>     callbacks in `threads__for_each_thread()` to avoid read-to-write
>     self-deadlock when a callback looks up or creates a leader thread in the
>     same shard.

These are good.


>   - Patch 3 removes `perf_singlethreaded` so `struct rw_semaphore` always
>     uses `pthread_rwlock_t` (allowing non-blocking trylock operations to
>     reliably detect locks already held on the current call stack during OOM
>     shrinking) and guards `di_cache` in `util/annotate.c` with a mutex.

I'm a bit skeptical about this.  As I said previously I'd like to hold
the shrinking and want to test first if the lazy loading is enough.

Also about the locking itself, mostly perf code runs single-threaded
now.  And I remember people complained about performance of perf itself
for a while.

Instead you may want to enable the locking on debug builds even if it's
single-threaded to verify the code?  I think we need to change the mutex
code to do nothing when single threaded.


>   - Patch 4 fixes a heap buffer corruption in the TUI map browser when
>     `symbol_conf.priv_size` was not initialized with `sizeof(u32)` by
>     computing symbol browser indices on demand.
>   - Patch 5 protects the `machines->guests` rbtree with a `rw_semaphore`.
>   - Patch 6 constifies `dso` in `dso__is_vdso()`.

These look good.


>   - Patch 7 adds `down_read_trylock()` and `down_write_trylock()` to
>     `util/rwsem.[ch]`.

If it's for the shrinking, I'll skip this for now.


> - **DSO-owned symbol lifetimes and `priv_size` removal (Patches 8-11)**:
>   - Patches 8-9 introduce `struct dso_symbol` (`{ struct dso *dso; struct
>     symbol *sym; }`) so callers that borrow a symbol's lifetime directly
>     from its owning `struct dso` without a `struct map` (`hist_entry`
>     parent symbols, `call_path` nodes, and `db-export`) retain a `dso`
>     reference for the lifetime of the symbol pointer. (Consolidating
>     `map_symbol` and `dso_symbol` back into `symbol.h` as explicit
>     DSO/map-borrowed symbol handle types is left for follow-up cleanup.)
>   - Patches 10-11 move `db-export` symbol IDs and `struct annotation` into
>     on-demand hashmaps and remove `symbol_conf.priv_size` and
>     `symbol__priv()`.

Looks good.


> - **Benchmarks and loading/sorting optimizations (Patches 12-16)**:
>   - Patches 12-13 add standalone `perf bench internals symbols` and
>     `perf bench internals maps` subcommands.
>   - Patch 14 adds fast-path prefix checks for the Rust and Java demanglers.
>   - Patch 15 caches ELF program and section headers in
>     `dso__load_sym_internal()` and defers `elf_sym__name()` lookups until
>     after non-symbol/non-allocated entries are filtered out.
>   - Patch 16 adds an O(1) tail-insertion fast path and incremental binary
>     insertion sort to `struct maps`.

Nice, I'm curious how much they improved.  Thanks for adding the
benchmarks.


> - **Sorted symbol arrays and natural-run merge sort (Patches 17-19)**:
>   - Patch 17 encapsulates `struct symbol` field accesses behind inline
>     accessor functions in preparation for lazy symbol/string loading.
>   - Patch 18 replaces `dso->symbols` (`rb_root_cached`) and
>     `dso->symbol_names` with a `rw_semaphore`-protected `struct symbols`
>     container backed by sorted pointer arrays, removing `struct rb_node`
>     from `struct symbol` (shrinking `sizeof(struct symbol)` from 48 to 24
>     bytes, or 16 bytes net per symbol after accounting for the array
>     pointer).

Yeah, I'm really looking forward to applying this.


>   - Patch 19 replaces `qsort()` on `struct symbols` with a stable
>     natural-run merge sort, galloping merge, and a sorted tail buffer with
>     amortized `sqrt(N)` merge for out-of-order insertions.

Interesting.


> - **On-demand memory shrinking and tests (Patches 20-23)**:
>   - Patch 20 adds `symbols__shrink()`, `dso__shrink()`, `dsos__shrink()`,
>     `machine__shrink()`, `machines__shrink()`, and `perf_session__shrink()`
>     to reclaim `symbols_by_name`, excess array capacity, cached DSO file
>     descriptors/data/DWARF state, and unreferenced user DSOs (`refcnt == 1`
>     with no annotated symbols), with transparent on-demand reload via
>     `dso__load()`.
>   - Patches 21-22 add `dso__session()` and `perf_session__malloc()` /
>     `zalloc()` / `calloc()` / `realloc()` / `strdup()` wrappers that
>     trigger `perf_session__shrink()` and retry once on allocation failure.
>   - Patch 23 adds unit tests in `perf test symbols` covering sorted symbol
>     insertion, equal-start aliases, symbol/DSO shrinking, `dso_symbol`
>     lifetime pinning, inline frame/srcline cleanup ordering,
>     `symbols_by_name` on-demand rebuild, transparent DSO reload, and session
>     allocation wrappers.

As I said, I don't plan to merge this part yet.  You can drop it in the
next revision (if needed).

Thanks,
Namhyung

> 
> Changes in v4:
> - Add standalone fix for NULL `th` dereference on allocation failure in
>   `__machine__findnew_thread()` (`Patch 1`) so `machine__findnew_thread()`
>   can shrink the session and retry cleanly (Sashiko).
> - Fix `table->lock` read-to-write self-deadlock in
>   `threads__for_each_thread()` (`Patch 2`) and remove `perf_singlethreaded`
>   (`Patch 3`) so `rw_semaphore` trylock operations always detect locks held
>   on the current call stack during OOM shrinking (Sashiko).
> - Handle equal-start symbol groups where a sized symbol precedes a
>   zero-length or shorter alias at the same start address (`Patches 18-19`):
>   use `upper_bound` plus equal-start rewind in `symbols__find_range()`,
>   avoid inflating trailing zero-length aliases in `symbols__fixup_end()`
>   when a sized symbol already exists at that address, scan trailing
>   equal-start groups for maximum `symbol__end()` in `map__fixup_end()`, and
>   always check the unmerged sorted tail in `symbols__find()` when
>   `sorted_cnt < cnt` (Sashiko).
> - Preserve owning `perf_session` across split kallsyms/kcore and ELF kernel
>   DSOs (`ndso->dsos == NULL`) in `maps__split_kallsyms()`,
>   `maps__split_kallsyms_for_kcore()`, and `dso__load_sym_internal()`
>   (`Patch 22`), use `down_write_trylock()` in `machines__shrink()`
>   (`Patch 20`), and add unit tests for equal-start aliases, unmerged tail
>   lookups, and same-shard `perf_session__e_machine()` (`Patch 23`)
>   (Sashiko).
> - Rebase onto `perf-tools-next` (`4af65363b11f`).
> 
> Changes in v3:
> - Drop per-symbol `DECLARE_RC_STRUCT(symbol)` reference counting and
>   partial symbol-table retention (`symbols__merge_retained()`) in favor of
>   DSO-owned symbol lifetimes via `struct dso_symbol` (`Patches 8-9`),
>   evicting a DSO's symbol table only as a whole when `dso` has `refcnt == 1`
>   and no annotated symbols (Namhyung Kim, Alireza Haghdoost).
> - Reorder the series so bug fixes and small preparatory refactorings come
>   first ahead of the larger `struct symbol` accessor and container patches.
> - Split the `perf bench internals` patch into two smaller standalone patches
>   (`symbols` and `maps`), separate `dso__load()` timing and `Max RSS` from
>   `dso__sort_by_name()` so address-only/lazy symbol loading is measured
>   independently of symbol name sorting, replace `mallinfo2()` (and its
>   build feature test) with `getrusage()` `ru_maxrss`, skip stripped
>   binaries (`nr == 0`) cleanly, call `symbol__exit()`, and include example
>   output in the commit messages (Namhyung Kim, Alireza Haghdoost).
> - Split out and land upstream the independent fixes uncovered during v2
>   review: `c4baf52c7901` ("perf callchain: Fix loss of symbol in
>   merge_chain_branch()"), `854dd5e7d099` ("perf annotate: Fix block_range
>   symbol loss on split and leaks on exit"), and `baef30dd8308` ("perf
>   symbol-elf: Fix zero-size symbol end calculation across .symtab and
>   .dynsym") (Alireza Haghdoost).
> - Remove the `hash_bits(..., 16)` 64K-bucket cap in `annotate` and
>   `db-export` hashmaps, set `symbol__set_annotated()` on the existing-entry
>   write path, and share the empty-hashmap cleanup path on `zalloc()`
>   failure in `symbol__annotation()` (Alireza Haghdoost, Sashiko).
> - Preserve insertion order on equal-start symbols (`symbol__start(a) <=
>   symbol__start(b)`), use stable insertion sort instead of `qsort()` as the
>   allocation-failure fallback, keep kallsyms "last alias wins" behavior in
>   `symbols__fixup_end()`, and add a sorted tail buffer with amortized
>   `sqrt(N)` merge in `__symbols__insert_sorted()` to avoid `O(n^2)`
>   `memmove()` on random insertions (Alireza Haghdoost).
> - Retry `dso_cache_io()` under `dso__lock(dso)` if `dso__shrink()` evicted
>   a newly populated cache entry, free `dso->inlined_nodes` and
>   `dso->srclines` before `symbols__delete_locked()` in `dso__shrink()`, and
>   rebuild `symbols_by_name` on demand via `symbols__sort_by_name_read_lock()`
>   in `dso__next_symbol_by_name()`, `dso__find_symbol_by_name()`, and
>   `symbols__visit_by_name()` (Alireza Haghdoost, Sashiko).
> - Expand `perf test symbols` (`Patch 23`) to return `TEST_SKIP` on
>   unshrinkable DSOs, verify full symbol count and sorted order after reload,
>   and test `dso_symbol` pinning, inline/srcline eviction ordering, and
>   `dso__next_symbol_by_name()` index rebuild after `dso__shrink()` (Alireza
>   Haghdoost, Sashiko).
> 
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
>   lifetimes, reorder fixes and preparatory patches ahead of the `struct
>   symbol` array conversion, remove `perf_singlethreaded`, split and refine
>   the `symbols` and `maps` benchmarks, and address LKML reviewer and Sashiko
>   feedback across `machine`, `threads`, `annotate`, `dso`, `map`, `symbol`,
>   and `tests/symbols.c`.
> - Testing performed: Built with Clang (`-Wthread-safety`), AddressSanitizer,
>   LeakSanitizer, and `DEBUG=1` (`REFCNT_CHECKING=1`); ran `perf test`
>   (including `Symbols`, `Maps`, `DSO data`, `hists`, `thread`, `annotate`,
>   `report`, and `script` suites), `perf bench internals` (`synthesize`,
>   `symbols`, and `maps`), and `scripts/checkpatch.pl`.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ian Rogers (23):
>   perf machine: Fix NULL deref on allocation failure in
>     __machine__findnew_thread()
>   perf threads: Avoid table->lock self-deadlock in
>     threads__for_each_thread()
>   perf tools: Remove perf_singlethreaded
>   perf map_browser: Fix browser index heap corruption by computing on
>     demand
>   perf machine: Protect machines->guests rbtree with a rw_semaphore
>   perf vdso: Constify dso parameter in dso__is_vdso()
>   perf rwsem: Add down_read_trylock() and down_write_trylock()
>   perf map_symbol: Add struct dso_symbol and use for parent symbols
>   perf call-path: Use struct dso_symbol to retain symbol DSO lifetimes
>   perf db-export: Store symbol database IDs in a hashmap
>   perf annotate: Move struct annotation to a hashmap and remove
>     symbol_conf.priv_size
>   perf bench internals: Add symbols benchmark
>   perf bench internals: Add maps benchmark
>   perf demangle: Add fast-path prefix checks for Rust and Java
>     demanglers
>   perf symbol-elf: Cache ELF program/section headers and defer symbol
>     name lookup
>   perf maps: Optimize tail insertion and small-append sorting
>   perf symbol: Add accessor functions for struct symbol fields
>   perf symbol: Switch backing storage from rbtree to struct symbols
>     array
>   perf symbol: Optimize symbol sorting with natural-run merge sort and
>     binary insertion
>   perf symbol: Add memory shrinking for symbols, DSOs, and machines
>   perf session: Add dso__session() and session-scoped allocation
>     wrappers
>   perf symbol: Use session allocation wrappers in symbol, DSO, thread,
>     and hist paths
>   perf test symbols: Add tests for symbol shrinking and session alloc
>     wrappers
> 
>  tools/perf/Documentation/perf-bench.txt       |    6 +
>  .../arch/powerpc/util/skip-callchain-idx.c    |    2 +-
>  tools/perf/arch/powerpc/util/sym-handling.c   |   40 +-
>  tools/perf/bench/Build                        |    2 +
>  tools/perf/bench/bench.h                      |    2 +
>  tools/perf/bench/maps.c                       |  202 +++
>  tools/perf/bench/symbols.c                    |  273 ++++
>  tools/perf/bench/synthesize.c                 |    7 -
>  tools/perf/builtin-annotate.c                 |   18 +-
>  tools/perf/builtin-bench.c                    |    2 +
>  tools/perf/builtin-c2c.c                      |   14 -
>  tools/perf/builtin-diff.c                     |    4 +-
>  tools/perf/builtin-kallsyms.c                 |    7 +-
>  tools/perf/builtin-kmem.c                     |   70 +-
>  tools/perf/builtin-kwork.c                    |    4 +-
>  tools/perf/builtin-lock.c                     |   10 +-
>  tools/perf/builtin-mem.c                      |    2 +-
>  tools/perf/builtin-record.c                   |    5 +-
>  tools/perf/builtin-report.c                   |   14 -
>  tools/perf/builtin-sched.c                    |    6 +-
>  tools/perf/builtin-script.c                   |   16 +-
>  tools/perf/builtin-timechart.c                |    2 +-
>  tools/perf/builtin-top.c                      |   28 +-
>  tools/perf/builtin-trace.c                    |   22 +-
>  tools/perf/tests/builtin-test.c               |    1 -
>  tools/perf/tests/dlfilter-test.c              |    4 +-
>  tools/perf/tests/dwarf-unwind.c               |    2 +-
>  tools/perf/tests/hists_common.c               |    9 +-
>  tools/perf/tests/hists_cumulate.c             |    4 +-
>  tools/perf/tests/hists_output.c               |    2 +-
>  tools/perf/tests/maps.c                       |   67 +
>  tools/perf/tests/symbols.c                    |  741 +++++++++-
>  tools/perf/tests/vmlinux-kallsyms.c           |  181 +--
>  tools/perf/ui/browser.c                       |    3 +
>  tools/perf/ui/browsers/annotate.c             |   10 +-
>  tools/perf/ui/browsers/hists.c                |   26 +-
>  tools/perf/ui/browsers/map.c                  |   85 +-
>  tools/perf/ui/gtk/annotate.c                  |    6 +-
>  tools/perf/ui/stdio/hist.c                    |   12 +-
>  .../perf/util/annotate-arch/annotate-arm64.c  |   12 +-
>  .../util/annotate-arch/annotate-loongarch.c   |    4 +-
>  tools/perf/util/annotate-arch/annotate-x86.c  |   14 +-
>  tools/perf/util/annotate-data.c               |   12 +-
>  tools/perf/util/annotate.c                    |  255 +++-
>  tools/perf/util/annotate.h                    |    6 +-
>  tools/perf/util/auxtrace.c                    |  111 +-
>  tools/perf/util/block-info.c                  |    8 +-
>  tools/perf/util/block-range.c                 |    3 +-
>  tools/perf/util/bpf_lock_contention.c         |   16 +-
>  tools/perf/util/c2c-function.c                |   19 +-
>  tools/perf/util/call-path.c                   |   42 +-
>  tools/perf/util/call-path.h                   |   10 +-
>  tools/perf/util/callchain.c                   |   22 +-
>  tools/perf/util/callchain.h                   |    3 +-
>  tools/perf/util/capstone.c                    |   20 +-
>  tools/perf/util/data-convert-json.c           |    4 +-
>  tools/perf/util/db-export.c                   |  144 +-
>  tools/perf/util/db-export.h                   |   16 +
>  tools/perf/util/debug.c                       |    3 +-
>  tools/perf/util/demangle-java.c               |   23 +-
>  tools/perf/util/disasm.c                      |   49 +-
>  tools/perf/util/dlfilter.c                    |   12 +-
>  tools/perf/util/dso.c                         |  263 +++-
>  tools/perf/util/dso.h                         |   83 +-
>  tools/perf/util/dsos.c                        |   77 ++
>  tools/perf/util/dsos.h                        |    3 +
>  tools/perf/util/event.c                       |    4 +-
>  tools/perf/util/evsel_fprintf.c               |    2 +-
>  tools/perf/util/hist.c                        |   86 +-
>  tools/perf/util/hist.h                        |    8 +-
>  tools/perf/util/intel-pt.c                    |   74 +-
>  tools/perf/util/libbfd.c                      |    7 +-
>  tools/perf/util/llvm.c                        |    6 +-
>  tools/perf/util/lock-contention.c             |    2 +-
>  tools/perf/util/machine.c                     |  174 ++-
>  tools/perf/util/machine.h                     |   14 +-
>  tools/perf/util/map.c                         |   38 +-
>  tools/perf/util/map.h                         |   10 +-
>  tools/perf/util/map_symbol.c                  |   30 +
>  tools/perf/util/map_symbol.h                  |   11 +
>  tools/perf/util/maps.c                        |  281 +++-
>  tools/perf/util/mutex.h                       |    3 +
>  tools/perf/util/probe-event.c                 |  133 +-
>  tools/perf/util/python.c                      |   65 +-
>  tools/perf/util/rwsem.c                       |   29 +-
>  tools/perf/util/rwsem.h                       |   11 +
>  tools/perf/util/session.c                     |   78 ++
>  tools/perf/util/session.h                     |   14 +-
>  tools/perf/util/sort.c                        |   49 +-
>  tools/perf/util/srcline.c                     |   16 +-
>  tools/perf/util/symbol-elf.c                  |  274 +++-
>  tools/perf/util/symbol.c                      | 1228 +++++++++++++----
>  tools/perf/util/symbol.h                      |  146 +-
>  tools/perf/util/symbol_conf.h                 |    1 -
>  tools/perf/util/symbol_fprintf.c              |   37 +-
>  tools/perf/util/thread-stack.c                |   48 +-
>  tools/perf/util/threads.c                     |   35 +-
>  tools/perf/util/unwind-libdw.c                |    2 +-
>  tools/perf/util/util.c                        |   12 -
>  tools/perf/util/util.h                        |    5 -
>  tools/perf/util/vdso.c                        |    2 +-
>  tools/perf/util/vdso.h                        |    2 +-
>  102 files changed, 4695 insertions(+), 1387 deletions(-)
>  create mode 100644 tools/perf/bench/maps.c
>  create mode 100644 tools/perf/bench/symbols.c
> 
> -- 
> 2.56.1.703.gf848ed807c-goog
> 
