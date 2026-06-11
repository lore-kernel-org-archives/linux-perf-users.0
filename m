Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F54378D63
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217901; cv=none; b=cinodp44JWy1J8z5nJONehrmyMHzahLboB4BNGegRWLrq9//7QmPlZdWn9dKNxRUKcyEgi648WWyu1uI0paPbygF7fC8j2eqGffGt++eKXUCvJ+Ji0c6/bZzEm9ju5o5OwmJ50zu6WSGIdwuJsxb78WnylL3QM/Gv+CTaGBgrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217901; c=relaxed/simple;
	bh=7wc8uqyGjhtKodhV032/r7NzNiCnfQFsyiqPlARsF6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FwfuqDOznHgWqn+ZzFMYhRRSeW4EJgQqRH4ze4RK83D4rGO4i2/+vLQvtps6L2YTKNDN+RVmLYSAjzqfKXj654OzZ2aZecU+dk9Ig04+L4XcctwTNq9AeElQta0c89djAfr7yTNm5XcPBKVSNXzQQu6Mz8K9x9FjQfkDIOiNDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEg5kZLd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEg5kZLd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so1130938eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217899; x=1781822699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UF7PU0mIUYFN6/j3Fo15dmFJukDckK4u4WpWQ4VW9M=;
        b=IEg5kZLdEgvgDSZF9xuszdAir21NF5k3L3M7UixrOMqU9N2rOV4InDK1r8alMsp0fT
         yCFaicOP5I/UGf6SCUgr4WU9oc9OdQWQFN9jVNkjv3f1VHVBbU1wAuMg6V2dZ6jx8skM
         UVtUaVKFPpcwIWLXS+8u3vEkUhyV9ztIf16imBC+deI2JEBS2CEx4fEm5ORZxHtqoPve
         GFby+L/e+0tS2PJtoSpK+bW5z+gqBVVmadFFMu6fIx7UgHcPN5VQgFLGdcAwO9BwxduQ
         osxYlJaa3tXfy9qXNk3u3e9k7Z9PwSy50Fl45VmF0Im+mD/M1TDMJHSpBR5lMeEg08WM
         hBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217899; x=1781822699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UF7PU0mIUYFN6/j3Fo15dmFJukDckK4u4WpWQ4VW9M=;
        b=GorQ76/YCQgKb/k2JLhI47Qqs83OkW+xi+9UzQFQJMfVmR+vYYwCQNeFY5cMfuDzgF
         opRZuF+pJhPGMWsaiL3k54Y5JS2rqqTdG1fWOtxPLFYQRIzvw9rFDUbRDOb9NQs1jZ63
         uzBNTRFMhIU17ffPw68uY9oPIKt6OPrdAn7PE2lnk0vwtiV8MYm+i1iPVXm79iw4/3ux
         ouTs3cv5c5aw2889AWw/np06vJ2XvtcOkeXqpeLK+1ow01wERe6ouK/3HUP85cSXjoCn
         SPT5JeVE6YDGq5mNtASz7D7iItBf5t7tfxmtzApEaTW5FsOp6hH9mZ10xqa2c4SN+seH
         jDCg==
X-Forwarded-Encrypted: i=1; AFNElJ9KVgnF0lnLryoGLxFSGRRP7H9kogF2Rrv02Fld3sNEDbl7SCBFNG8OMXsMu3jRwUtX3N3+erIVzxMrZQmkxwb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nvOg55tRpKh8tMHdrYvsO4Mai3IrtiopGjKGksC5My9fnpQM
	4PNcHOKMFkILrMCPiHDedEjsvhhuNULmNDxVb+cRx3eqAsbn4TM735TEJ9hL9yLdgSdWw5A6l8m
	oI40Icmuhog==
X-Received: from dymj31.prod.google.com ([2002:a05:7300:6b1f:b0:304:e97b:1712])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6416:b0:2dd:6937:79b8
 with SMTP id 5a478bee46e88-3081ff63db8mr226311eec.5.1781217898636; Thu, 11
 Jun 2026 15:44:58 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:36 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-1-irogers@google.com>
Subject: [PATCH v13 00/19] Add additional python API support
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
been split. This v13 series represents "Phase 1: API & Infrastructure" (19 patches).
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

