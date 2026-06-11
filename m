Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFF44D6A1
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198290; cv=none; b=CT5298pHbElx9WnOP6JyEh+Pm9EY+EvCUZ/ywfJ/kx1WZ0EBSkCeEELelKgVZ8tpkyPjp3JWqOZztpvrV4OoHS1FoyRQOAYcEnJcztg/D6OjPCIZwQTAVDJ3QlsSwpNXOTGPKe+bvDX/uVsuM4yl7rNZ69CJFDoaorQPbhvujRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198290; c=relaxed/simple;
	bh=GaUYHnayK4q5UwsajW1QvJMI4Mw0o9QckURQRoVDcDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KB0SgfV557PGsMiClwXJvokyOB8QB8j4XLqYtl+yBeesT/qZpS6PirVyUnDVBBcXc+md6QiT8EjOEfxmFCDXlNOeiBDj7oj1zOCh7LTImff5yR0OjGYcb6RFOblf51O7ck0bRQmyZ+qWwBqKVzvis7hFHYrd3E3jFdcPd+M7gEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ikc2Didi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ikc2Didi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so256196eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198281; x=1781803081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4JuqRsxVqGmEVj3BIiEnL0gj0k7mhdI3z8utGqRvF0=;
        b=Ikc2DidiOrlUwvETqpiBbxC8Dzq6yqHzLb/Kn7QumOHEmuDFYEdjcxp2jmJwmIydlt
         OfzujzeKosDZxI/u19sCKW6QXEAFZbTlWA20NZmwB+A/dYCiU4San//SnVQOZCVgkzgQ
         4KgyWe6KvpfNQdNuGp9ABfmLcy6pq5C0nNrV4SqzN+eaDxkxN32uMq3C/TIe78hVBpoC
         c2/uvI5fk761Cz3ZkhIM4n7O3BLHJ6nV2zFpAkchMSsc46z+jV4fPHO/+GOIVzXOR+Xg
         SpYd3ZZr+5w3UlDFkPnl8aq8FeMa1XQ9GP0B+MNMutan9j0u3Y5x6/90fYPpkuGdDpQP
         NbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198281; x=1781803081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4JuqRsxVqGmEVj3BIiEnL0gj0k7mhdI3z8utGqRvF0=;
        b=iKW2xF4VKXDkaDk8jcWrQQAjCOKH4DroWFx4TOTuOyRCQcWJ54ytrntwKl//qnrw+r
         CZ8FXeQvE0f3yM2SJET0j5EYZMyweWX2MdORypM6nnOl8ZWBfLFRCQh+H3orNMQ7i43l
         rXVZAlZlGMGjEMR1Y2JxGYw0RTW5RbKvGMiUPRk2P60evMaRfGkj3baIQ167REL9NVVM
         IubgViV6nnKPvyXzAEE+SHFMpfOvxQm25O+TeMejEvaEmHgOmgWtroN+Etw2VY+CIjr0
         HCY9hLCUUbtpnys9X9/mO4zbn93Y/9BMvVSUHkgz/M4078QD3q4vBGfnPEYxvBP9GMIO
         mCVw==
X-Forwarded-Encrypted: i=1; AFNElJ/PDBbEXXUa83IG+6dZSiEYe3da1d4VQ1Pa1j2vIhHjtOu7Rrt9PIsqLp2eSfmf1hyNXyDuwKM7/7I+fnWETprt@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDp7rcPofUiqW5dKuH6366VSNdcf/Yt9NzayKLBHcy2znyqzK
	GPORudLUhQUw3nZphKFWtI/ATmc+HVTEw3uC98ZsaDj9NQpGxW7XQ8QmgNfAKJmEP6Tj8+9hBPO
	BHcosTDwVBg==
X-Received: from dybph5.prod.google.com ([2002:a05:7301:4185:b0:2ed:8f25:962c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1015:b0:304:cf6c:4d01
 with SMTP id 5a478bee46e88-30804819c14mr2828480eec.12.1781198280758; Thu, 11
 Jun 2026 10:18:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:37 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-1-irogers@google.com>
Subject: [PATCH v12 00/19] perf python: Modernize and extend Python API (Phase 1)
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The perf script command has long supported running Python and Perl scripts by
embedding libpython and libperl. This approach has several drawbacks:
 - overhead by creating Python dictionaries for every event (whether used or
   not),
 - complex build dependencies on specific Python/Perl versions,
 - complications with threading due to perf being the interpreter,
 - no clear way to run standalone scripts like ilist.py.

This series takes a different approach with some initial implementation posted
as an RFC last October:
https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
with the motivation coming up on the mailing list earlier:
https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/

The ultimate goal is to remove the embedded libpython and libperl support from
perf entirely, expanding the existing perf Python module to provide full access
to perf data files and events, allowing scripts to be run as standalone Python
applications.

To make the review process more manageable, the original 58-patch series has
been split. This v12 series represents "Phase 1: API & Infrastructure" (19 patches).
The first 4 patches of Phase 1 (cleanups and arch-specific header sorting) have
already been merged upstream.

This remaining set contains:
1. Missed explicit dependency cleanups and header sorting for util/ and python.
2. Crucial core safety infrastructure (reference counting for evlist/evsel)
   to support safe lifecycle management in garbage-collected Python.
3. The core Python API extensions (session wrappers, perf_data wrappers,
   sample accessors, stubs, and LiveSession helper).

The subsequent "Phase 2" series will contain the actual porting of all
existing Python/Perl scripts to the new API (which yields up to 35x speedups
as demonstrated previously) and the final removal of embedded interpreters.

Note: The preliminary clang-format patch has been separated from this series to
be sent independently.

---
v12 Changes
-----------
- Patch 6: Restored `idx` parsing in `pyrf_evsel__init` kwargs, and removed
  an erroneous `Py_INCREF(pevsel)` in `pyrf_evlist__add` that caused a
  memory leak.
- Patch 7: Fixed `evlist__put` cycle collection TOCTOU double free race by
  checking `refcount_read == 1`. Fixed `evlist__purge` recursion and cycle
  reference tearing logic.
- Patch 8: Removed an extra `evsel__get` in `evsel__parse_sample` to fix a
  reference leak on error paths.
- Patch 11: Used `copy_size` to bound `max_len` for NUL termination to fix
  an out-of-bounds write in `pyrf_event__new`. Also set
  `pevent->event.header.size = copy_size`.
- Patch 12: Used `copy_size` to bound `max_len` for NUL termination of
  mmap2 and comm events to fix an out-of-bounds write.
- Patch 13: Added an optional `struct machine *` argument to
  `pyrf_event__new` defaulting to the host machine if NULL, avoiding
  regressions for future phases.
- Patch 14: Made `psession->tool.stat = perf_event__process_stat_event;`
  conditional on `!stat` so it doesn't unconditionally overwrite user stat
  callbacks.
- Patch 18: Audited all `perf.pyi` event stubs: added full `sample_members`
  attributes (`pid`, `tid`, `time`, `id`, `stream_id`, `period`, `cpu`) to
  all payload events via inheritance. Fixed `sample_event` unique fields
  (`ip`, `addr`, `phys_addr`, `weight`, `data_src`, `insn_cnt`, `cyc_cnt`).
  Renamed `mmap_event.addr` to `start`. Removed `read_event.value`.
- Patch 19: Replaced `except TypeError` with `continue` to ignore
  unmapped/offline CPUs instead of breaking the poll loop. Replaced
  hardcoded `-11` with `e.errno == errno.EAGAIN` in `LiveSession.run()`.
  Fixed `setup_python.sh` `PYTHONPATH` prepend logic to cleanly append to
  existing paths.

v11 Changes
-----------
- Investigated Patch 8 (evsel leak) review feedback and verified no changes
  were necessary since `perf_sample__exit(data)` handles the `evsel`
  reference internally upon parsing failures.
- Patch 7: Fixed compiler errors when building with `REFCNT_CHECKING=1` by
  replacing direct evlist member accesses with their correct accessor
  functions in `util/bpf_counter_cgroup.c`, `builtin-lock.c`, `builtin-
  sched.c`, `builtin-annotate.c`, and `tests/uncore-event-sorting.c`.
- Patch 9: Added `pdata->data.path = NULL;` after `free` in
  `pyrf_data__init` to prevent double-free/dangling pointers.
- Patch 10 & 14: Added missing default processors (`.attr`, `.feature`,
  `.stat`) to `pyrf_session__new()`.
- Patch 11: Reverted PyObject_Malloc allocation back to PyObject_New and
  clipped memcpy size to `sizeof(union perf_event)` to fix
  `_FORTIFY_SOURCE` aborts without unnecessarily expanding the allocation
  size, and added explicit null termination to `PERF_RECORD_COMM`. Also
  avoided replicating validation logic in `pyrf_event__new` by making
  `perf_event__too_small` non-static and using it directly.
- Patch 18: Fixed `Makefile.perf` for empty `$(OUTPUT)` copying error, and
  rewrote `setup.py`'s `perf.pyi` deployment to override `install_lib`
  using `shutil.copy2` to fix install directories.
- Patch 19: Handled `TypeError` for offline CPUs, handled `-EAGAIN`
  correctly on empty buffers, and allowed user exceptions to bubble up
  instead of being universally caught in `perf_live.py`.

v10 Changes
-----------
- The preliminary clang-format patch has been separated from this series and
  updated independently based on review feedback (using Priority -1 for
  Python.h and eliminating the unused Priority 1 gap).
- Fixed Type Confusion on Python Object instantiation:
    - Added strict type verification `O!O!` to `pyrf_evlist__init` for CPU and
      Thread maps to prevent interpreter crashes from bad inputs.
    - Added `.tp_getattro` and `.tp_setattro` handlers to `evlist`, `evsel`,
      and `session` Python types to safely raise `ValueError` on uninitialized
      access (such as bypassing `__init__` and invoking `__new__` directly)
      instead of dereferencing NULL.
    - Handled NULL structures safely inside string/representation callbacks for
      `evlist` and `evsel` types.
- Fixed Circular Reference memory leaks:
    - Eliminated the `pevent` pointer and unused lazy resolution code from
      `pyrf_callchain`, breaking the cycle that prevented GC collection.
    - Eliminated `pevent` pointer from `pyrf_branch_stack`, breaking the cycle.
    - This prevents permanent leaks of all map, symbol, and event structures for
      every sample containing a callchain or branch stack.
- Converted `callchain` and `branch_stack` to true Python Sequence types:
    - Replaced custom exhaustible iterators with `.tp_as_sequence` sequence methods
      (`sq_length` and `sq_item`).
    - This allows standard Sequence operations like `len(event.callchain)`, list
      index access (e.g. `event.callchain[0]`), and infinite re-iterations.
- Fixed potential Memory Leak on test failure:
    - Fixed a leak of the newly allocated `evsel` structure in `do_test` inside
      `sample-parsing.c` on `malloc` failure by routing through the cleanup block.
- Fixed compiler warning for mixed declarations:
    - Moved the C-statement `perf_sample__init` after struct and variable declarations
      in `cs_etm__synth_branch_sample` to ensure C89/compiler compatibility.
- Fixed compiler warning for discarded const qualifiers:
    - Reverted custom `static char * const kwlist[]` to the standard `static char *kwlist[]`
      for `pyrf__syscall_name` and `pyrf__syscall_id` in `python.c`.
- Fixed unrecoverable file descriptor leak and busy loop in LiveSession:
    - Moved `self.evlist.open()` inside the `try` block of `LiveSession.run()` to
      guarantee `finally` block cleanup and prevent descriptor leaks on early interrupts.
    - Handled unrecoverable `OSError` (like mmap read init errors) by propagating/raising
      them to safely terminate the session instead of getting stuck in an infinite
      CPU-pegging poll busy loop.
    - Bounded `read_on_cpu()` reads to at most 1000 events per CPU per poll iteration
      to prevent high-volume starvation of other CPU channels.
- Exported `stat_event` and `stat_round_event` to the `perf` module namespace to
  allow type checks like `isinstance(event, perf.stat_event)`.
- Fixed Python `stat` callback signatures:
    - Changed Python stat callbacks in C to consistently pass 2 arguments (using `"Oz"`
      and passing `None` for `stat_round` events), preventing `TypeError` failures in
      scripts defining standard 2-parameter signatures.
- Fixed data-corruption in `misc` fields:
    - Changed `misc` member definition from `T_UINT` to `T_USHORT` in both `mmap` and
      `mmap2` events to avoid reading adjacent `size` bytes from 16-bit struct headers.
- Exposed `maj`, `min`, `ino`, and `ino_generation` members to Python `mmap2` events.
- Fixed `mmap2` union overlay field access:
    - Added custom getters to `mmap2` events for `maj`, `min`, `ino`, `ino_generation`,
      and `build_id` based on the `PERF_RECORD_MISC_MMAP_BUILD_ID` misc header flag.
    - This correctly exposes `build_id` (as `bytes`) when present, or `maj`/`min`/`ino`
      when build ID is absent, returning `None` for the inactive union fields.
- Enabled deployment of stubs:
    - Updated `setup.py` to install `perf.pyi` alongside the extension in site-packages.
    - Updated `Makefile.perf` to copy `perf.pyi` to the build directory for in-tree usage.
    - Added `tracepoint` and missing optional `parse_metrics` arguments to stubs.
- Fixed a pre-existing Use-After-Free bug in `iostat_prepare`:
    - Modified `iostat_prepare` to take `struct evlist **evlist_ptr`, allowing it to
      properly reassign the caller's evlist pointer, avoiding use-after-free in `cmd_stat`.
- Fixed in-tree python test runner stability:
    - Updated `setup_python.sh` to automatically export `PYTHONPATH` pointing to the
      in-tree built `perf.so` directory (handling `O=` build folders), preventing Python
      from accidentally loading the system-wide outdated `/usr/lib/perf.so` module and
      failing with `AttributeError` during `perf test`.

v9 Changes
----------
- This series is now split, containing only the first 23 patches of the
  previous 58-patch series. This "Phase 1: API & Infrastructure" set focuses
  on modernizing and extending the Python API and adding crucial safety
  infrastructure (reference counting). The script porting and legacy
  interpreter removal will be sent in a subsequent Phase 2.
- Fixed Type Confusion in `pyrf_evlist__init`: Added strict type validation
  to CPU and Thread map arguments (using O!O!) to prevent crashes from unsafe
  casts.
- Fixed Infinite Loop in `LiveSession.run`: Added a break statement in the
  exception block of the event reading loop to prevent 100% CPU spinning on
  persistent OS errors (like mmap read init failures).
- Fixed Inconsistent Exception Handling in Session Callbacks:
    - Removed the swallowing `PyErr_Print()` call from `pyrf_session_tool__stat`
      to preserve exceptions.
    - Updated `pyrf_session_tool__stat_round` to check the callback return value
      and return -1 on failure, aborting the event loop and propagating the
      exception cleanly.
- Fixed Uninitialized State in `pyrf_session__new`: Added explicit
  `psession->pdata = NULL` initialization immediately after allocation to prevent
  potential crashes in `tp_dealloc` on early failures.

v8 Changes
----------
- Make schedstat and itrace=L fixes separate patches:
https://lore.kernel.org/lkml/20260428070328.1880314-1-irogers@google.com/
https://lore.kernel.org/lkml/20260428070811.1883202-1-irogers@google.com/
- Fixed Heap Out-Of-Bounds / Uninitialized Memory in `pyrf_event__new`:
  Use `/*all=*/true` in `perf_sample__init` to prevent garbage memory in
  sample structures.
- Fixed Type Confusion in `pyrf_evlist__add`: Added strict `O!` type
  validation to avoid unsafe casts when adding evsels to an evlist.
- Exposed Thread Identifiers: Added `pid`, `tid`, `ppid`, and `cpu`
  attributes to the Python `perf.thread` type to allow thread identification.
- Fixed Process Resolution: Wrapped thread resolution in `compaction-times.py`,
  `check-perf-trace.py`, and `task-analyzer.py` in `try-except` blocks to
  safely handle untracked PIDs instead of raising uncaught `TypeError` crashes.
- Fixed Potential Data Loss in `futex-contention.py`: Updated process
  resolution in `handle_start` to fall back to `'unknown'` on lookup errors,
  ensuring events are always tracked.
- Synchronized Type Stubs File: Added the `mmap2_event` class and new `evsel`
  and `thread` attributes to `perf.pyi`.

v7 Changes
----------
- Fixed heap out-of-bounds in `pyrf_event__new` by adding comprehensive
  size checks for all event types.
- Fixed undefined symbol `syscalltbl__id` when building without
  libtraceevent by making `syscalltbl.o` unconditional in `Build`.
- Fixed several issues in `python.c`:
    - Handled NULL return from `thread__comm_str` in `pyrf_thread__comm`.
    - Avoided swallowing exceptions in module initialization.
    - Added custom `tp_new` methods for `evlist`, `evsel`, and `data` types
      to zero-initialize pointers and avoid crashes on re-initialization.
- Fixed lower priority review comments:
    - Avoided permanent iterator exhaustion on `brstack` in
      `perf_brstack_max.py` by converting it to a list.
    - Removed dead code (unused `self.unhandled` dictionary) in
      `failed-syscalls-by-pid.py`.

v6 Changes
----------
- Refactored `pyrf_event__new` to take `evsel` and `session` arguments,
  and use dynamic allocation based on the actual event size to improve
  memory safety and efficiency.
- Moved callchain and branch stack resolution logic from
  `pyrf_session_tool__sample` into `pyrf_event__new`, centralizing
  initialization.
- Added an optional keyword-only `elf_machine` argument to `syscall_name`
  and `syscall_id` functions to allow specifying non-host architectures,
  defaulting to `EM_HOST`.
- Renamed `process` method to `find_thread` in the Python API and C
  implementation for better intention-revealing naming.
- Fixed a terminal injection vulnerability in `flamegraph.py` by not
  printing unverified downloaded content in the prompt.
- Fixed CWD exposure and symlink attack risks in `gecko.py` by using a
  secure temporary directory for the HTTP server.
- Fixed a severe performance issue in `event_analyzing_sample.py` by
  removing SQLite autocommit mode and batching commits.
- Fixed `AttributeError` crashes in `rw-by-file.py` and `rw-by-pid.py` by
  correctly extracting event names.
- Fixed man page formatting issues in `perf-script-python.txt` by using
  indented code blocks.
- Updated `perf.pyi` stubs file to reflect all API changes.
- Verified all commit messages with `checkpatch.pl` and ensured lines are
  wrapped appropriately.
- Fixed segmentation faults in `perf sched stats` in diff mode.

v5 Changes
----------
Resending due to partial send of v4 due to a quota limit.

v4 Changes
----------
1. Git Fixup Cleanups
- Squashed the lingering `fixup!` commit remaining from the previous session back
  into `perf check-perf-trace: Port check-perf-trace to use python module`.

v3 Changes
----------
1. Memory Safety & Reference Counting Fixes
- Stored transient mmap event data inside the Python object's permanent
  `pevent->event` and invoked `evsel__parse_sample()` to safely point
  attributes into it, resolving Use-After-Free vulnerabilities.
- Nullified `sample->evsel` after calling `evsel__put()` in
  `perf_sample__exit()` to protect against potential refcount double-put
  crashes in error paths.
- Reordered operations inside `evlist__remove()` to invoke
  `perf_evlist__remove()` before reference release.
- Patched an `evsel` reference leak inside `evlist__deliver_deferred_callchain()`.

2. Sashiko AI Review Cleanups
- Corrected the broken event name equality check in `gecko.py` to search
  for a substring match within the parsed event string.
- Fixed a latent `AttributeError` crash in `task-analyzer.py` by properly
  assigning the session instance.
- Safeguarded thread reporting in `check-perf-trace.py` by utilizing
  `sample_tid` instead of `sample_pid`, and wrapping the session thread
  resolution in a try-except block.

3. Omitted Minor Issues
- The minor review comments (such as permanent iterator exhaustion on
  `brstack`, or dead-code in `failed-syscalls-by-pid.py`) have been omitted
  because they do not affect correctness, lead to crashes, or require
  significant architectural rework.

v2 Changes
----------
1. String Match and Event Name Accuracy
- Replaced loose substring event matching across the script suite with exact
  matches or specific prefix constraints (syscalls:sys_exit_,
  evsel(skb:kfree_skb), etc.).
- Added getattr() safety checks to prevent script failures caused by
  unresolved attributes from older kernel traces.

2. OOM and Memory Protections
- Refactored netdev-times.py to compute and process network statistics
  chronologically on-the-fly, eliminating an unbounded in-memory list
  that caused Out-Of-Memory crashes on large files.
- Implemented threshold limits on intel-pt-events.py to cap memory allocation
  during event interleaving.
- Optimized export-to-sqlite.py to periodically commit database transactions
  (every 10,000 samples) to reduce temporary SQLite journal sizes.

3. Portability & Environment Independence
- Re-keyed internal tracking dictionaries in scripts like powerpc-hcalls.py to
  use thread PIDs instead of CPUs, ensuring correctness when threads migrate.
- Switched net_dropmonitor.py from host-specific /proc/kallsyms parsing to
  perf's built-in symbol resolution API. 
- Added the --iomem parameter to mem-phys-addr.py to support offline analysis
  of data collected on different architectures.

4. Standalone Scripting Improvements
- Patched builtin-script.c to ensure --input parameters are successfully passed
  down to standalone execution pipelines via execvp().
- Guarded against string buffer overflows during .py extension path resolving.

5. Code Cleanups
- Removed stale perl subdirectories from being detected by the TUI script
  browser.
- Ran the entire script suite through mypy and pylint to achieve strict static
  type checking and resolve unreferenced variables.


Ian Rogers (19):
  perf util: Sort includes and add missed explicit dependencies
  perf python: Add missed explicit dependencies
  perf evsel/evlist: Avoid unnecessary #includes
  perf data: Add open flag
  perf evlist: Add reference count
  perf evsel: Add reference count
  perf evlist: Add reference count checking
  perf python: Use evsel in sample in pyrf_event
  perf python: Add wrapper for perf_data file abstraction
  perf python: Add python session abstraction wrapping perf's session
  perf python: Refactor and add accessors to sample event
  perf python: Add mmap2 event
  perf python: Add callchain support
  perf python: Extend API for stat events in python.c
  perf python: Expose brstack in sample event
  perf python: Add syscall name/id to convert syscall number and name
  perf python: Add config file access
  perf python: Add perf.pyi stubs file
  perf python: Add LiveSession helper

 tools/perf/Makefile.perf                    |    5 +-
 tools/perf/arch/arm/util/cs-etm.c           |   10 +-
 tools/perf/arch/arm64/util/arm-spe.c        |    8 +-
 tools/perf/arch/arm64/util/hisi-ptt.c       |    2 +-
 tools/perf/arch/x86/tests/hybrid.c          |   22 +-
 tools/perf/arch/x86/tests/topdown.c         |    4 +-
 tools/perf/arch/x86/util/auxtrace.c         |    2 +-
 tools/perf/arch/x86/util/intel-bts.c        |    6 +-
 tools/perf/arch/x86/util/intel-pt.c         |    9 +-
 tools/perf/arch/x86/util/iostat.c           |   14 +-
 tools/perf/bench/evlist-open-close.c        |   29 +-
 tools/perf/builtin-annotate.c               |    7 +-
 tools/perf/builtin-ftrace.c                 |   14 +-
 tools/perf/builtin-inject.c                 |    9 +-
 tools/perf/builtin-kvm.c                    |   14 +-
 tools/perf/builtin-kwork.c                  |    8 +-
 tools/perf/builtin-lock.c                   |    4 +-
 tools/perf/builtin-record.c                 |   95 +-
 tools/perf/builtin-report.c                 |    6 +-
 tools/perf/builtin-sched.c                  |   30 +-
 tools/perf/builtin-script.c                 |   15 +-
 tools/perf/builtin-stat.c                   |   83 +-
 tools/perf/builtin-top.c                    |  104 +-
 tools/perf/builtin-trace.c                  |   65 +-
 tools/perf/python/perf.pyi                  |  646 +++++
 tools/perf/python/perf_live.py              |   61 +
 tools/perf/tests/backward-ring-buffer.c     |   26 +-
 tools/perf/tests/code-reading.c             |   14 +-
 tools/perf/tests/event-times.c              |    6 +-
 tools/perf/tests/event_update.c             |    4 +-
 tools/perf/tests/evsel-roundtrip-name.c     |    8 +-
 tools/perf/tests/evsel-tp-sched.c           |    4 +-
 tools/perf/tests/expand-cgroup.c            |   12 +-
 tools/perf/tests/hists_cumulate.c           |    2 +-
 tools/perf/tests/hists_filter.c             |    2 +-
 tools/perf/tests/hists_link.c               |    2 +-
 tools/perf/tests/hists_output.c             |    2 +-
 tools/perf/tests/hwmon_pmu.c                |    7 +-
 tools/perf/tests/keep-tracking.c            |   10 +-
 tools/perf/tests/mmap-basic.c               |   24 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |    6 +-
 tools/perf/tests/openat-syscall-tp-fields.c |   26 +-
 tools/perf/tests/openat-syscall.c           |    6 +-
 tools/perf/tests/parse-events.c             |  139 +-
 tools/perf/tests/parse-metric.c             |    8 +-
 tools/perf/tests/parse-no-sample-id-all.c   |    2 +-
 tools/perf/tests/perf-record.c              |   38 +-
 tools/perf/tests/perf-time-to-tsc.c         |   12 +-
 tools/perf/tests/pfm.c                      |   12 +-
 tools/perf/tests/pmu-events.c               |   11 +-
 tools/perf/tests/pmu.c                      |    4 +-
 tools/perf/tests/sample-parsing.c           |   45 +-
 tools/perf/tests/shell/lib/setup_python.sh  |   13 +
 tools/perf/tests/sw-clock.c                 |   20 +-
 tools/perf/tests/switch-tracking.c          |   11 +-
 tools/perf/tests/task-exit.c                |   20 +-
 tools/perf/tests/time-utils-test.c          |   14 +-
 tools/perf/tests/tool_pmu.c                 |    7 +-
 tools/perf/tests/topology.c                 |    4 +-
 tools/perf/tests/uncore-event-sorting.c     |    6 +-
 tools/perf/ui/browsers/annotate.c           |    2 +-
 tools/perf/ui/browsers/hists.c              |   22 +-
 tools/perf/util/Build                       |    1 -
 tools/perf/util/amd-sample-raw.c            |    2 +-
 tools/perf/util/annotate-data.c             |    2 +-
 tools/perf/util/annotate.c                  |   10 +-
 tools/perf/util/auxtrace.c                  |   14 +-
 tools/perf/util/block-info.c                |    4 +-
 tools/perf/util/bpf_counter.c               |    2 +-
 tools/perf/util/bpf_counter_cgroup.c        |   14 +-
 tools/perf/util/bpf_ftrace.c                |    9 +-
 tools/perf/util/bpf_lock_contention.c       |   12 +-
 tools/perf/util/bpf_off_cpu.c               |   44 +-
 tools/perf/util/bpf_trace_augment.c         |    8 +-
 tools/perf/util/cgroup.c                    |   26 +-
 tools/perf/util/cs-etm.c                    |    5 +-
 tools/perf/util/data-convert-bt.c           |    2 +-
 tools/perf/util/data.c                      |   27 +-
 tools/perf/util/data.h                      |    4 +-
 tools/perf/util/evlist.c                    |  496 ++--
 tools/perf/util/evlist.h                    |  273 +-
 tools/perf/util/evsel.c                     |   39 +-
 tools/perf/util/evsel.h                     |   40 +-
 tools/perf/util/expr.c                      |    2 +-
 tools/perf/util/header.c                    |   69 +-
 tools/perf/util/header.h                    |    2 +-
 tools/perf/util/intel-pt.c                  |    2 +-
 tools/perf/util/intel-tpebs.c               |    7 +-
 tools/perf/util/iostat.c                    |    2 +-
 tools/perf/util/iostat.h                    |    2 +-
 tools/perf/util/map.h                       |    9 +-
 tools/perf/util/metricgroup.c               |   12 +-
 tools/perf/util/parse-events.c              |   10 +-
 tools/perf/util/parse-events.y              |    2 +-
 tools/perf/util/perf_api_probe.c            |   20 +-
 tools/perf/util/pfm.c                       |    4 +-
 tools/perf/util/print-events.c              |    2 +-
 tools/perf/util/python.c                    | 2629 ++++++++++++++++---
 tools/perf/util/record.c                    |   11 +-
 tools/perf/util/s390-sample-raw.c           |   20 +-
 tools/perf/util/sample-raw.c                |    4 +-
 tools/perf/util/sample.c                    |   17 +-
 tools/perf/util/session.c                   |   69 +-
 tools/perf/util/session.h                   |    2 +
 tools/perf/util/setup.py                    |    5 +
 tools/perf/util/sideband_evlist.c           |   40 +-
 tools/perf/util/sort.c                      |    2 +-
 tools/perf/util/stat-display.c              |    6 +-
 tools/perf/util/stat-shadow.c               |   24 +-
 tools/perf/util/stat.c                      |   20 +-
 tools/perf/util/stream.c                    |    4 +-
 tools/perf/util/synthetic-events.c          |   11 +-
 tools/perf/util/time-utils.c                |   12 +-
 tools/perf/util/top.c                       |    4 +-
 114 files changed, 4441 insertions(+), 1441 deletions(-)
 create mode 100644 tools/perf/python/perf.pyi
 create mode 100755 tools/perf/python/perf_live.py

-- 
2.54.0.1136.gdb2ca164c4-goog

