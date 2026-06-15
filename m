Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0F305676
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542218; cv=none; b=PDnkcPz6ie9f0/+vhRNUi/50hXL00biX72WBwOhF79a4eWh4x+a+aQj6a3fBbckyNOqjwSwkzbifRYPJCtPS3fEhG5wyYMePV0YUY9yRCUTOeq2K/ppeFEWQDiUV4musM+vMSJeir2QFihmy8qIgToX8W7jPc2U+UeyPn5/fv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542218; c=relaxed/simple;
	bh=HWsum7IWYTMnHIPl8ClfIme0m+VGaY/DnOk/U1J6Rcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFZMLMJvu+QA3OJ6QRUCS1sdejGw46Pr/fMuOhdPSQgzg+i75NAyDVCIuDsB6ZxNaDuEfzDmfl2//8fd3StixeRyYlleMFaoa+thI/GG+zCuTY7uJVkxo6Apa7ESlKdECxIBnplNPGGnNTBVxeSrMjp8gzdaiKZB4lYH/MnmNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAd05t8a; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAd05t8a"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so5730506eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542215; x=1782147015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1gCCCSL2YvAzDEbo+ue73+grTTfBIfmec6PYsXrcAM=;
        b=YAd05t8aU5kTkO8rOyH+guOTcxT5p0pyNcWOFNuJ2woStmhQgNXkC0+7NCH3kapm3W
         ZmqzhkIPGP9LotT4IBdtK/KV9XOvtYBuUIj9966wS+xhNRgojjq5vebvL71CiZolSj22
         dO2tN5GBNvEnLv5FB9s9y+QM/8FIS5/yljElaQzEVZnVypmTiWMVTauD0FGyzAfRI48F
         AHaL84VZwjgeiU96bSm6P3VeBZCWVDxw4pib3AD9yBu0PQE7LgXAhCSN57JkgNXSFvol
         OvUNzS8K9IBeJsq1XZA0CI3GekkEqN8Uuw/+GYiNLYOO5f5ibMvJGtWwNfReHHbeQ7UE
         jfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542215; x=1782147015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1gCCCSL2YvAzDEbo+ue73+grTTfBIfmec6PYsXrcAM=;
        b=YMCfnkspbwud2H6yxc16HVvwQn6J79E2quLxd+c/55nvIFcf81Y3qbS5v4Xc+HillG
         KSUUiH5ZHpazt1kp0Kvk0/sowNme4e9RI8sXMzTy8jlHbyPOsOqVQzkNpds7e07/tNvH
         5N5yudXPwq6hJfMQq2RpLDHPHcvsdDh3L9C6ci1CeANHVKVLsv3yFOXRB6zSxv7OWR8I
         /ErVtZhIjWxIgNnB1Q7hEdf2hvUQiJHHtMYNME2wn5hpdzBi1oO3oBhlhZwKJktnpCpu
         dzGBm/MTEWIdtuxLXPvdTJVmzo1F8xzIW+mnmRSxXGXkuZVcUFH8420FYVQRBKygUzhS
         awxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j6BMccA7R3pE+6abEKnJkCi5/X/Y425eLXe5f3ZMKJBRgJRBoOIAyBsALP6S2rg+Uf6AGAk/+RR+hgtseSZ3f@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ83UKNcb8mn1q+hVGe472UJkty6fLhZg8ny12kJPUJdhCZ2cm
	nw/ipMLfkM5Uw4f8QNbbZpKm2CpT3C71AUXsVXOWKZIAamfSD2Izvafc1euUGPq+FIrqmcquFEs
	+lXMsVuSktw==
X-Received: from dyfi12.prod.google.com ([2002:a05:7300:238c:b0:2f7:767f:edba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2393:b0:2cb:4b8f:b2bd
 with SMTP id 5a478bee46e88-30935239ecdmr6622561eec.6.1781542214797; Mon, 15
 Jun 2026 09:50:14 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:49:50 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-1-irogers@google.com>
Subject: [PATCH v19 00/20] Add additional python API support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The perf script command has long supported running Python and Perl scripts
by embedding libpython and libperl. This approach has several drawbacks:
 - overhead by creating Python dictionaries for every event (whether used or
   not),
 - complex build dependencies on specific Python/Perl versions,
 - complications with threading due to perf being the interpreter,
 - no clear way to run standalone scripts like ilist.py.

This series takes a different approach with some initial implementation posted
as an RFC last October:
https://lore.kernel.org/linux-perf-users/20231025081156.963491-1-irogers@google.com/

It builds the python extension as part of the normal build. The extension
is able to read perf.data files. The event callbacks are converted to
have a python evsel/evlist/sample passed to them.

To make the review process more manageable, the original 58-patch series has
been split. This v18 series represents "Phase 1: API & Infrastructure" (20 patches).
The first 4 patches of Phase 1 (cleanups and arch-specific header sorting) have
already been merged upstream.

This remaining set contains:
1. Missed explicit dependency cleanups and header sorting for util/ and python.
2. Crucial core safety infrastructure (reference counting for evlist/evsel)
   to support safe lifecycle management in garbage-collected Python.
3. The core Python API extensions (session wrappers, perf_data wrappers,
   sample accessors, stubs, and LiveSession helper).

Phase 2 ("Script Porting & Tool Migration") will migrate the remaining 35+
existing Python/Perl scripts to the new API (which yields up to 35x speedups
as demonstrated previously) and the final removal of embedded interpreters.


Addressing v18 Review Feedback:
- Patch 10 (`perf.thread` initialization): Added missing `CHECK_INITIALIZED()`
  in `pyrf_thread__comm` to prevent NULL dereference when instantiated directly.
- Patch 14 (STAT events): Passed `NULL` to `pyrf_event__new` for STAT events
  to prevent unconditional `evsel__parse_sample` and potential out-of-bounds
  reads.
- Patch 20 (`LiveSession` timeout): Broadened exception handling to explicitly
  ignore "Unexpected header type" for valid but unsupported events.

Note: Other feedback items raised in v18 (TOCTOU cycle races, asymmetric
cycle collection, cross-endian data handling, guest machine symbol resolution,
and pre-existing memory leaks/uninitialized variables) are acknowledged as
limitations of the current implementation and will be addressed in Phase 2
or separate cleanup patches.

Addressing v17 Review Feedback:
 - Patch 8: Added missing `perf_sample__exit(&sample)` to
   `intel_pt_synth_ptwrite_sample()` to fix an evsel reference leak.
 - Patch 10: Fixed a bug in `pyrf_session_tool__sample()` that caused
   double byte-swapping on foreign-endian files by temporarily disabling
   `needs_swap` during re-parsing instead of assigning `*sample`.
 - Patch 11: (Missed fixing address resolution for guest samples - will
   fix in next spin or Phase 2).
 - Patch 19: Prevented `python-clean` from deleting tracked source file
   `python/perf.pyi` when building in tree. Also explicitly exported
   `COUNT_HW_REF_CPU_CYCLES`, `thread`, `callchain`, and `callchain_node`
   types/constants to the module via `PyInit_perf`.
 - Patch 20: Narrowed `except TypeError` in `LiveSession.run()` to explicitly
   check for "Unknown CPU" so legitimate event parsing failures aren't
   swallowed.

Addressing v16 Review Feedback:
 - Patch 10: Removed unconditional `perf_session__create_kernel_maps` to
   prevent corrupting cross-platform offline analysis.
 - Patch 11: Corrected inaccurate commit message regarding memory
   allocation sizing.
 - Patch 19: Fixed numerous type inconsistencies, missing properties, and
   incorrect return types in the `perf.pyi` stubs file.
 - Patch 20: Cleaned up unused `import errno` in `perf_live.py`.

Note: Several issues spotted in v16/v17 review (e.g. pyrf_evsel__init format
string type mismatch, evlist lockless double free, asymmetric memory
leaks, missing Py_None type checks, and lack of NUL-termination for
COMM/MMAP) are pre-existing limitations in the codebase or side-effects
of the transitional cycle-breaking design. As discussed previously, these
structurally complex or pre-existing bugs are deliberately deferred to
the Phase 2 series.

Addressing v15 Review Feedback:
- Patch 2 (buffer overflow & type checks): The buffer overflow in
  `pyrf_event__new()` has been resolved by verifying `event->header.size`
  against the event struct size.
- Patch 2 (PyObject_HEAD_INIT): The initialization macros have been corrected
  to use the proper Python 3 compatibility approach.
- Patch 5 (Memory leak & RC validation): Applied extensive structural fixes
  using `refcount_t` semantics. Added validation wrapper structures to
  statically verify memory access safety in the lockless cycles.
- Patch 8 (`evlist.open` memory leak): Restructured lifecycle management for
  mmap buffers using `do_munmap()` hooks in `evlist__put()`.
- Patch 16 (`perf.pyi` stubs): Corrected return types (`Optional` and proper
  object properties) and missing documentation strings in type stubs.
- Patch 20 (`perf_live.py` timeout): Adjusted poll timeout from 10000ms back
  to 100ms, replacing the tight exception loop.

Ian Rogers (20):
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
  perf python: Handle Py_None for thread and cpu maps
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
 tools/perf/python/perf.pyi                  |  672 +++++
 tools/perf/python/perf_live.py              |   59 +
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
 tools/perf/util/intel-pt.c                  |    8 +-
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
 tools/perf/util/python.c                    | 2654 ++++++++++++++++---
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
 114 files changed, 4492 insertions(+), 1447 deletions(-)
 create mode 100644 tools/perf/python/perf.pyi
 create mode 100755 tools/perf/python/perf_live.py

-- 
2.54.0.1136.gdb2ca164c4-goog

