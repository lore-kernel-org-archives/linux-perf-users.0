Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FA37BE72
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287808; cv=none; b=Vf9PN/K7P2MpSlAGV80PGKVtU3nW3ypuZld4QPFrorP+jgUZdr1FSbF7XneYkxGG7bry8Ysu5Ymspgz+/XNM/c7yRifGG+6LjlBRy+BrHpra1Btr82vEIgBFIrq3fyMAWvLLrRVB5ZDskKppwULZY+72G1q2gYQH76B3wn4kEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287808; c=relaxed/simple;
	bh=kgVzGQj/mbMSmmlzam/SHJzeZCQvlDvnpnJl1vXWrZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kT2ku+uWgx2vDrr0rMr6GZkOUpRqGbFHZr2/+5APJvdUmnOMTLOWj05j2pd4TcLXvlpZYkmiOnOvDrpTnZmSHkZ5Ca89vwpHQv6qjKHJTeDzWiSQJlu7N48/TC/eY0iklzxY+5UCh7QPNlr9gZAr1oP5vbcBVk+1jj4tLFZjhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZQrIsCr; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZQrIsCr"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so3445532eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287805; x=1781892605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAuH9+nfjnWg24eU07do/lRjOxc6w8XVIuQexjV2m1U=;
        b=kZQrIsCrKXuBorBEfhnF8C/Bno++Ev1hYyxbXOgaSb8y4yv7fGtP21vVfMt2DfgBls
         8JZkR3Fb9lRY+lNui4gmLsH/ixRBgrdat2istRh1LNbmjFs0sFo1cCtIGTTBK3F1i6ui
         X7XOe8fMf+lPG0TVexslRd1SJYajx0bRDpuxyift9mVPCm6ugWl9U8uuGaLqWmf9DJHi
         YEzEJ3m4ReglpslFpF0pcl0fORZj74ubf2YYqepGAKKkQqiPOq6KM5jk2H7RwlaLYMga
         YALo4bu9zbvf0bmA8JjWKtMyHHatdXjJK9xqEKw762wzG5FvAMaIQOfL/6PEA72cUmvH
         tZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287805; x=1781892605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAuH9+nfjnWg24eU07do/lRjOxc6w8XVIuQexjV2m1U=;
        b=I5fHHyuWiNYK+9x4aZFzmTPgPzowxu9jSDi4Qd6+Q5DFeGV1N5N1dz1VLEWnHFTW60
         H/z1sUuADwpkeMm/Bj+S9DMYbYGiC8nVs9Ql3lpmliwJSQjXqeqUNSBNcROGhn8M5ef/
         CRwEejYWtkTMNHZySJ5x7s0cLZfrTFzlhLz2R+QQLVidYNQVgGqVnOwTCQv51GvshJEU
         R2I33yPMgEN27ah+rw/Bju03eIHmPwH+JWZWk29CMMeGH4UbZdrV3Uypc5qj6fsWD3qW
         urBPgFnWnPSu0TEZRjKOTsaeYrz8/dZ8H9E/IagA+EGrUNj1tzc7JWE+O3VW13ezCzd5
         soWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xYScH9l0dUxc2vieJ0oeiqAaaNZFivqG973sOw3S3LCmn2RyhgxmEzzJlzq7pDf9+BGkERd0MGG0wakPxzM3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxymEhPmxtDLtRINONK0MNbE48U5nZ8RD0HG1eAJZXwBzGnbbsA
	lRKQW8FLEsWfomPX2n+MJ74ckmn5tC4PFWu0PAHMb0LZ/iYNdcMSIN4DBvuLd4L8LGD9vJ83yFA
	k37SI/BDaRw==
X-Received: from dycao25.prod.google.com ([2002:a05:7301:7d19:b0:304:1e27:a62f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2148:b0:2f5:5dd3:1fcf
 with SMTP id 5a478bee46e88-3081ff97b78mr2588886eec.10.1781287805071; Fri, 12
 Jun 2026 11:10:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:37 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-1-irogers@google.com>
Subject: [PATCH v14 00/19] Add additional python API support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
been split. This v14 series represents "Phase 1: API & Infrastructure" (19 patches).
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
v14 Changes
-----------
- Patch 6: Replaced Py_IsTrue with PyObject_IsTrue to correctly evaluate
  Python truthiness and added error handling returning -1.
- Patch 7: Added comments to `evlist__put` and `evlist__splice_list_tail`
  noting that cycle breaking and pointer rebinding for spliced events will
  be addressed in subsequent patches. Removed "Phase 2" from the previous
  cycle-breaking comment as it doesn't make sense in the wider Linux code
  base context.
- Patch 10: Fixed `pyrf_session__new` missing `tool.tracing_data`
  initialization and wrapped kernel map creation in an access check.
- Patch 15: Exposed remaining bitfields from `struct branch_flags` in
  `pyrf_branch_entry`.
- Patch 18: Cleaned up `perf.pyi` in `Makefile.perf`'s `python-clean`
  target. Renamed `sc_id` to `id` in `syscall_name` stub, and corrected
  property types.
- Patch 19: Fixed `perf_live.py` inner loop to `break` instead of
  `continue` on `TypeError` to properly exit when processing is complete.

v13 Changes
-----------
- Patch 6: Reverted `idx` parsing for `pyrf_evsel__init`. Added explicit NULL
  checks for `evlist` in `session.c` to prevent crashes when accessing properties.
- Patch 7: Rely natively on `evlist.c`'s updated logic through `evlist__add`.
- Patch 8: Fixed memory leak in `intel_pt_synth_ptwrite_sample` by adding
  `perf_sample__exit(&sample)` on exit.
- Patch 9: Zeroed out `perf_data` struct via `memset(&data, 0, sizeof(data))`
  before using it to prevent stale state issues.
- Patch 11: Switched from `PyLong_FromUnsignedLong` to `PyLong_FromUnsignedLongLong`
  to guarantee full 64-bit bounds representation even on 32-bit platforms.
- Patch 18: Modified `Makefile.perf` to correctly install `perf.pyi`.
  Synchronized `.pyi` stubs to fully match the C implementation signatures.
- Patch 19: Updated `pyrf_evlist__read_on_cpu` to safely return `Py_RETURN_NONE`
  on `-EAGAIN` natively from C instead of relying on broken OSError emulation.
  Updated `perf_live.py` loop to handle the native `None` return correctly.

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

 tools/perf/Makefile.perf                    |    7 +-
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
 tools/perf/python/perf_live.py              |   55 +
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
 tools/perf/util/python.c                    | 2632 ++++++++++++++++---
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
 114 files changed, 4441 insertions(+), 1440 deletions(-)
 create mode 100644 tools/perf/python/perf.pyi
 create mode 100755 tools/perf/python/perf_live.py

-- 
2.54.0.1136.gdb2ca164c4-goog

