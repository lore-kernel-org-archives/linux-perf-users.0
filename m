Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18932A3D7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967244; cv=none; b=AKfwI67AlN2itR3W44swjz52lKCmANwGef2FwzG25jrHwZ+a3CaV9lparzzcw0dvRl1XCNlZeYsTIaiNXaofBtrlIfmV6uYi374LTp+9Fml57xehOV8fXkyWw55UUyIrqU/uR/+KEHr6YT9Va35laTUwgtVAszmt6uUse2H8Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967244; c=relaxed/simple;
	bh=HdceHAbn/vS2tMjegc4Usi3vo2l/w8Y0fI3l1bdqYg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kaTCtPIpGbWVM8RZCriS57lbZDzM8odJDGegmGzmbWWvTan1ZM+vTxSoER4qDQvH4i5gzXDH4G8xmRw6igEyq8QmPMNW+FMDtH2dz3o8ZpoONSeVL/lBOA0qQHtFUY4vpuwj2zwOvWPWoWib2iFaJOpbK8k9rKgV45hdxlbHq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kumbf/gM; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kumbf/gM"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc44d708055so5253346a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967241; x=1790572041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ha2ZowlcdHWhDkV98nn3+1rr04+De6pRrJQ6KZa8qO8=;
        b=Kumbf/gMBpf5MwdJGIH6p7gcPBhKHlAauvK956MSuDhomlRozxBwH6O/WiVnhm2Uiz
         QlLPAqp7sN5sWWzQ+lA+A3mhREVA6FEg1gHI5ABW3uCsckHgbh33nZ8TUPXvmGfr0h/r
         VUAQx5c5y3ckT/k8onvqt8Kteov5aenjUy0YEcWyUEKqHdROfE8g5N9k3tY2pWLYDEPh
         +i0sth2kOCZWnudJhKQI4s/QawpBMpmfONBRj7aNX45ihXsS0s/wA/v/qmxIl27wXMWA
         1NIC0/a1QfzAA34LXw3iQBTdYXzTrxXfqwp7HqZCvt4J+fqU2D8+da/x3FB9ymCZfBvy
         ylpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967241; x=1790572041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ha2ZowlcdHWhDkV98nn3+1rr04+De6pRrJQ6KZa8qO8=;
        b=l5b0N4Vh98HtvXNrfS4EuKMM68qZWNdjZUsKVE7h13BDSzGlPyopOknilpravfKxqK
         7978ZPCJCwDd8MSne4uiOYz0dLiT4NOY+R6dTc1PeFAuIHe6+CqmCfVyigomrSxDdH76
         p/w2URHvzDXcn1UMzKWY1Bo69JFwaH4RAjweTCHOnS0BwTw7rDFJ0CbAolTKeCuq2v4m
         iq08pWSnMnbKSFOFsi7y4PN/Bw9XQMO2MCmqvvV0m3tYfQeGBSelf0zy99CDy4k0tv+o
         2w4f3HpS0XP7MdBs3dSEChy2SQ8ycccypVgn60RcyX5n5W2mveQkP1HIvtLowNvznpF0
         3okw==
X-Forwarded-Encrypted: i=1; AKwUvBw7OhOXpcRel7BKvL6F1RZVXnEuyx9MypDXNZGL3IuPc+ToDk7pG0mBmxoqb4uSwrS2KDrgxvsI8KKGk0QGAD3t@vger.kernel.org
X-Gm-Message-State: AFuF++n5HCYgTGWkbQwpO7JEZfT3/6PRWAK0yiE5xFd0mlXokWU54lm9
	LgyFJmEv2uLGAZh5Q8oAvcRxHPTrw6qCa0TshnZ2Gdf4xc8N4K2SH30CLSDp/meziyrvvJ7CoQW
	d0wYH4STDuw==
X-Received: from dloo27-n2.prod.google.com ([2002:a05:7023:a5b:20b0:143:8d74:244a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b03:b0:3a0:3700:fe9
 with SMTP id 98e67ed59e1d1-3a037001482mr4217167a91.36.1789967240687; Sun, 20
 Sep 2026 22:07:20 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:18 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <cover.1789966896.git.irogers@google.com>
Subject: [PATCH v2 00/49] perf: Complete transition to standalone Python scripts
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The perf script command has historically supported running Python and Perl
scripts by embedding libpython and libperl. That approach has several
drawbacks:
 - high overhead from constructing Python dictionaries for every event
   (whether used by the script or not),
 - complex build dependencies on specific Python/Perl libraries,
 - threading and interpreter lifecycle complications from embedding the
   interpreter inside perf,
 - no unified model for standalone scripts such as ilist.py, treport.py,
   tracepoint.py, and twatch.py.

Parts of this series were previously posted as part of the larger
"perf: Reorganize scripting support" series:
https://lore.kernel.org/linux-perf-users/20260428071903.1886173-1-irogers@google.com/
with earlier RFC and mailing list discussion at:
https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/

From that earlier series, the prerequisite patches (header dependency cleanups,
evlist/evsel reference counting, initial perf.data and perf.session C extension
wrappers, callchain/brstack/stat/syscall/config accessors, perf.pyi type stubs,
LiveSession, and removal of embedded libperl support) have now been merged. We
restarted the version number at v1 for the remaining patches, along with
additional C extension capabilities, build-time static analysis (mypy and
pylint), and review fixes.

Running scripts as standalone Python applications using the perf Python C
extension module provides a dramatic speedup. For example, with
mem-phys-addr.py:

Before (using embedded libpython in perf script):
```
$ perf mem record -a sleep 1
$ time perf script tools/perf/scripts/python/mem-phys-addr.py
Event: cpu_core/mem-loads-aux/
Memory type                                    count  percentage
 ---------------------------------------  ----------  ----------
0-fff : Reserved                                3217       100.0

real    0m3.754s
user    0m0.023s
sys     0m0.018s
```

After (using standalone Python script with perf module):
```
$ PYTHONPATH=/tmp/perf/python time python3 tools/perf/python/mem-phys-addr.py
Event: evsel(cpu_core/mem-loads-aux/)
Memory type                                    count  percentage
 ---------------------------------------  ----------  ----------
0-fff : Reserved                                3217       100.0

real    0m0.106s
user    0m0.021s
sys     0m0.020s
```

The 49 patches in this series are organized into four groups:

1. Perf Python C Extension & Existing Script Updates (Patches 01-10):
   - Refine syscall_name()/syscall_id() argument parsing, callchain stubs, and
     session.find_thread() lookup in tools/perf/util/python.c and
     tools/perf/python/perf.pyi.
   - Clean up pylint warnings and improve `perf script -l` descriptions in
     existing standalone scripts (ilist.py, treport.py, tracepoint.py,
     twatch.py).
   - Expose destination address location attributes (addr_dso, addr_symbol,
     addr_sym_offset), branch/transaction fields, sym_offset, context_switch
     callbacks, and Intel PT call_return / itrace synthesis directly in the
     perf Python extension (many parts previously posted in
     https://lore.kernel.org/linux-perf-users/20260428071903.1886173-1-irogers@google.com/).
   - Allow KeyboardInterrupt to propagate cleanly in LiveSession.

2. Build-Time Python Static Analysis (Patches 11-14):
   - Clean up mypy and pylint warnings in tools/perf/pmu-events/ and
     tools/perf/tests/shell/lib/.
   - Make MYPY and PYLINT build checks enabled by default when mypy and
     pylint (>= 2.16.0) are installed, with NO_MYPY=1 and NO_PYLINT=1 opt-out
     controls (matching NO_SHELLCHECK=1), so all Python scripts in tools/perf
     are continuously type-checked and linted at build time.

3. Porting Legacy Python & Perl Scripts to tools/perf/python/ (Patches 15-45):
   - Previously sent as part of
     https://lore.kernel.org/linux-perf-users/20260428071903.1886173-1-irogers@google.com/
     and updated with static type annotations, mypy/pylint cleanups, and
     accompanying shell tests under tools/perf/tests/shell/. Sashiko-driven
     review and improvement was undertaken while porting so that the ported
     scripts are in the best shape possible:
     * Temporarily install tools/perf/python/ scripts during the transition
       (Patch 15).
     * General & profiling scripts: stat-cpi.py, mem-phys-addr.py,
       stackcollapse.py, flamegraph.py, gecko.py, event_analyzing_sample.py
       (Patches 16-21).
     * Syscall & I/O scripts (ported from legacy Python and Perl):
       syscall-counts.py, syscall-counts-by-pid.py,
       failed-syscalls-by-pid.py, failed-syscalls.py, sctop.py, rw-by-file.py,
       rw-by-pid.py, rwtop.py (Patches 22-29).
     * Scheduling, locking, MM & networking scripts: futex-contention.py,
       task-analyzer.py, sched-migration.py (with SchedGui.py),
       wakeup-latency.py, compaction-times.py, net_dropmonitor.py,
       netdev-times.py, check-perf-trace.py (Patches 30-37).
     * Hardware trace & architecture-specific scripts: arm-cs-trace-disasm.py,
       powerpc-hcalls.py, intel-pt-events.py (with libxed.py), and migrating
       the Intel PT virtual LBR test to the Python API (Patches 38-41).
     * Database export & viewer utilities: export-to-sqlite.py,
       export-to-postgresql.py, exported-sql-viewer.py, and parallel-perf.py
       (Patches 42-45).

4. Removing Embedded libpython & Updating Build, CLI, and Docs (Patches 46-49):
   - Previously sent as part of
     https://lore.kernel.org/linux-perf-users/20260428071903.1886173-1-irogers@google.com/ :
     * Remove embedded libpython support (scripting-engines/trace-event-python.c)
       and delete the legacy tools/perf/scripts/python/ directory (Patch 46).
     * Replace the libpython feature check with test-python-module.c and
       update Python script installation paths (Patch 47).
     * Update `perf script` (builtin-script.c) to execute standalone scripts
       directly and remove embedded scripting engine support (Patch 48).
     * Update perf man pages (perf-script.txt, perf-script-python.txt,
       perf-check.txt) for standalone Python scripts (Patch 49).

Changes in v2:
 - Mark `session.find_thread()` parameters as positional-only (`/`) and update
   `sample_event.srccode()` return type annotation to
   `Optional[tuple[Optional[str], int, Optional[str]]]` in `perf.pyi` (Patches
   02, 08).
 - Break `self -> self.session -> bound method callback` reference cycles in
   `flamegraph.py`, `failed-syscalls.py`, `wakeup-latency.py`, and
   `arm-cs-trace-disasm.py` via `try ... finally: self.session = None` (Patches
   19, 25, 33, 38).
 - Separate `raw_syscalls:sys_enter` (`id`) from `syscalls:sys_enter*`
   (`__syscall_nr` / `nr`) and support x32 ABI syscall numbers (`0x40000000`)
   in `syscall-counts.py`, `syscall-counts-by-pid.py`, and `sctop.py` (Patches
   22, 23, 26).
 - Prevent non-generic architectures in `_ARCH_ERRNO_TABLES` from falling
   through into `_GENERIC_ERRNO_OVERRIDES` in `failed-syscalls-by-pid.py`
   (Patch 24).
 - Treat 0-byte read/write return values as non-errors in `rw-by-pid.py`
   (Patch 28).
 - Avoid repeated `/proc/kallsyms` parsing and cache fallback symbol
   resolutions in `net_dropmonitor.py` (Patch 35).
 - Check `is None` instead of truthiness for `event_list` in `netdev-times.py`
   so valid softirqs with empty event lists are not dropped (Patch 36).
 - Handle `objdump` subprocess errors gracefully in `arm-cs-trace-disasm.py`
   and update `setup_python.sh` / `test_arm_coresight_disasm.sh` so nested
   shell tests locate `perf.so` when run directly (Patch 38).
 - Populate `branch_types`, `samples_view.branch_type_name`, `calls` parent
   indexes (`pcpid_idx`, `pid_idx`), and `comms.has_calls` in
   `export-to-sqlite.py` for `exported-sql-viewer.py` compatibility (Patch 42).
 - Escape single quotes with `\'` for libpq connection strings in
   `export-to-postgresql.py` (Patch 43).
 - Replace Markdown `###` subsection headers with Asciidoc `~~~~` underlines in
   `perf-script-python.txt` (Patch 49).

Ian Rogers (49):
  perf python: Update syscall format string to optional positional
  perf python: Update callchain stubs and session thread lookup
  perf python: Clean up pylint warnings in ilist.py
  perf python: Clean up pylint warnings in treport.py
  perf python: Clean up pylint warnings in tracepoint.py
  perf python: Clean up pylint warnings in twatch.py
  perf python: Improve perf script -l descriptions
  perf python: Expose addr location, transaction, and context_switch
  perf python: Add Intel PT call_return and itrace capability
  perf python: Allow KeyboardInterrupt to propagate in LiveSession
  perf pmu-events: Clean up mypy and pylint issues
  perf test: Clean up mypy and pylint issues in shell test libraries
  perf build: Make mypy build test opt-out (NO_MYPY=1)
  perf build: Make pylint build test opt-out (NO_PYLINT=1)
  perf Makefile: Install standalone Python scripts during transition
  perf python: Port stat-cpi to perf module
  perf python: Port mem-phys-addr to perf module
  perf python: Port stackcollapse to perf module
  perf python: Port flamegraph to perf module
  perf python: Port gecko to perf module
  perf python: Port event_analyzing_sample to perf module
  perf python: Port syscall-counts to perf module
  perf python: Port syscall-counts-by-pid to perf module
  perf python: Port failed-syscalls-by-pid to perf module
  perf python: Port failed-syscalls from Perl to perf module
  perf python: Port sctop to perf module
  perf python: Port rw-by-file from Perl to perf module
  perf python: Port rw-by-pid from Perl to perf module
  perf python: Port rwtop from Perl to perf module
  perf python: Port futex-contention to perf module
  perf python: Port task-analyzer to perf module
  perf python: Port sched-migration and SchedGui to perf module
  perf python: Port wakeup-latency from Perl to perf module
  perf python: Port compaction-times to perf module
  perf python: Port net_dropmonitor to perf module
  perf python: Port netdev-times to perf module
  perf python: Port check-perf-trace to perf module
  perf python: Port arm-cs-trace-disasm to perf module
  perf python: Port powerpc-hcalls to perf module
  perf python: Port intel-pt-events and libxed to perf module
  perf test: Migrate Intel PT virtual LBR test to Python API
  perf python: Port export-to-sqlite to perf module
  perf python: Port export-to-postgresql to perf module
  perf python: Move and clean up exported-sql-viewer.py
  perf python: Move and clean up parallel-perf.py
  perf: Remove libpython support and legacy Python scripts
  perf Makefile: Update Python script installation path
  perf script: Support standalone scripts and remove embedded scripting
  perf Documentation: Update for standalone Python scripts

 tools/build/Makefile.feature                  |    5 +-
 tools/build/feature/Makefile                  |   24 +-
 tools/build/feature/test-all.c                |    6 +-
 tools/build/feature/test-libperl.c            |   10 -
 tools/build/feature/test-libpython.c          |   10 -
 tools/build/feature/test-python-module.c      |   13 +
 tools/perf/Build                              |    5 +-
 tools/perf/Documentation/db-export.txt        |   20 +-
 tools/perf/Documentation/perf-check.txt       |    3 +-
 tools/perf/Documentation/perf-script-perl.txt |  216 -
 .../perf/Documentation/perf-script-python.txt |  725 +--
 tools/perf/Documentation/perf-script.txt      |   80 +-
 tools/perf/Documentation/tips.txt             |    1 -
 tools/perf/Makefile.config                    |   38 +-
 tools/perf/Makefile.perf                      |   83 +-
 tools/perf/builtin-check.c                    |    3 +-
 tools/perf/builtin-script.c                   |  824 ++-
 tools/perf/pmu-events/Build                   |    4 +-
 tools/perf/pmu-events/amd_metrics.py          |   10 +-
 tools/perf/pmu-events/intel_metrics.py        |  259 +-
 tools/perf/pmu-events/jevents.py              |   77 +-
 tools/perf/pmu-events/make_legacy_cache.py    |   34 +-
 tools/perf/pmu-events/metric.py               |   58 +-
 tools/perf/python/SchedGui.py                 |  246 +
 tools/perf/python/arm-cs-trace-disasm.py      |  356 ++
 tools/perf/python/check-perf-trace.py         |  213 +
 tools/perf/python/compaction-times.py         |  350 ++
 tools/perf/python/counting.py                 |    1 +
 tools/perf/python/event_analyzing_sample.py   |  321 ++
 tools/perf/python/export-to-postgresql.py     | 1320 +++++
 tools/perf/python/export-to-sqlite.py         |  937 +++
 tools/perf/python/exported-sql-viewer.py      | 5104 +++++++++++++++++
 tools/perf/python/failed-syscalls-by-pid.py   |  176 +
 tools/perf/python/failed-syscalls.py          |   91 +
 tools/perf/python/flamegraph.py               |  277 +
 tools/perf/python/futex-contention.py         |   93 +
 tools/perf/python/gecko.py                    |  415 ++
 tools/perf/python/ilist.py                    |    8 +-
 tools/perf/python/intel-pt-events.py          |  606 ++
 tools/perf/python/libxed.py                   |  123 +
 tools/perf/python/mem-phys-addr.py            |  137 +
 tools/perf/python/net_dropmonitor.py          |  163 +
 tools/perf/python/netdev-times.py             |  486 ++
 tools/perf/python/parallel-perf.py            | 1250 ++++
 tools/perf/python/perf.pyi                    |   68 +-
 tools/perf/python/perf_live.py                |    5 +-
 .../{scripts => }/python/powerpc-hcalls.py    |  209 +-
 tools/perf/python/rw-by-file.py               |  109 +
 tools/perf/python/rw-by-pid.py                |  189 +
 tools/perf/python/rwtop.py                    |  247 +
 tools/perf/python/sched-migration.py          |  486 ++
 tools/perf/python/sctop.py                    |  220 +
 tools/perf/python/stackcollapse.py            |  145 +
 tools/perf/python/stat-cpi.py                 |  208 +
 tools/perf/python/syscall-counts-by-pid.py    |   97 +
 tools/perf/python/syscall-counts.py           |   80 +
 tools/perf/python/task-analyzer.py            |  881 +++
 tools/perf/python/tracepoint.py               |    5 +-
 tools/perf/python/treport.py                  |   12 +-
 tools/perf/python/twatch.py                   |   81 +-
 tools/perf/python/wakeup-latency.py           |   97 +
 tools/perf/scripts/Build                      |   30 -
 tools/perf/scripts/install-build-deps.sh      |    4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |    9 -
 .../scripts/perl/Perf-Trace-Util/Context.c    |  122 -
 .../scripts/perl/Perf-Trace-Util/Context.xs   |   42 -
 .../scripts/perl/Perf-Trace-Util/Makefile.PL  |   18 -
 .../perf/scripts/perl/Perf-Trace-Util/README  |   59 -
 .../Perf-Trace-Util/lib/Perf/Trace/Context.pm |   55 -
 .../Perf-Trace-Util/lib/Perf/Trace/Core.pm    |  192 -
 .../Perf-Trace-Util/lib/Perf/Trace/Util.pm    |   94 -
 .../perf/scripts/perl/Perf-Trace-Util/typemap |    1 -
 .../scripts/perl/bin/check-perf-trace-record  |    2 -
 .../scripts/perl/bin/failed-syscalls-record   |    3 -
 .../scripts/perl/bin/failed-syscalls-report   |   10 -
 tools/perf/scripts/perl/bin/rw-by-file-record |    3 -
 tools/perf/scripts/perl/bin/rw-by-file-report |   10 -
 tools/perf/scripts/perl/bin/rw-by-pid-record  |    2 -
 tools/perf/scripts/perl/bin/rw-by-pid-report  |    3 -
 tools/perf/scripts/perl/bin/rwtop-record      |    2 -
 tools/perf/scripts/perl/bin/rwtop-report      |   20 -
 .../scripts/perl/bin/wakeup-latency-record    |    6 -
 .../scripts/perl/bin/wakeup-latency-report    |    3 -
 tools/perf/scripts/perl/check-perf-trace.pl   |  106 -
 tools/perf/scripts/perl/failed-syscalls.pl    |   47 -
 tools/perf/scripts/perl/rw-by-file.pl         |  106 -
 tools/perf/scripts/perl/rw-by-pid.pl          |  184 -
 tools/perf/scripts/perl/rwtop.pl              |  203 -
 tools/perf/scripts/perl/wakeup-latency.pl     |  107 -
 .../perf/scripts/python/Perf-Trace-Util/Build |    4 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  225 -
 .../Perf-Trace-Util/lib/Perf/Trace/Core.py    |  116 -
 .../lib/Perf/Trace/EventClass.py              |   97 -
 .../lib/Perf/Trace/SchedGui.py                |  184 -
 .../Perf-Trace-Util/lib/Perf/Trace/Util.py    |   92 -
 .../scripts/python/arm-cs-trace-disasm.py     |  356 --
 .../python/bin/compaction-times-record        |    2 -
 .../python/bin/compaction-times-report        |    4 -
 .../python/bin/event_analyzing_sample-record  |    8 -
 .../python/bin/event_analyzing_sample-report  |    3 -
 .../python/bin/export-to-postgresql-record    |    8 -
 .../python/bin/export-to-postgresql-report    |   29 -
 .../python/bin/export-to-sqlite-record        |    8 -
 .../python/bin/export-to-sqlite-report        |   29 -
 .../python/bin/failed-syscalls-by-pid-record  |    3 -
 .../python/bin/failed-syscalls-by-pid-report  |   10 -
 .../perf/scripts/python/bin/flamegraph-record |    2 -
 .../perf/scripts/python/bin/flamegraph-report |    3 -
 .../python/bin/futex-contention-record        |    2 -
 .../python/bin/futex-contention-report        |    4 -
 tools/perf/scripts/python/bin/gecko-record    |    2 -
 tools/perf/scripts/python/bin/gecko-report    |    7 -
 .../scripts/python/bin/intel-pt-events-record |   13 -
 .../scripts/python/bin/intel-pt-events-report |    3 -
 .../scripts/python/bin/mem-phys-addr-record   |   19 -
 .../scripts/python/bin/mem-phys-addr-report   |    3 -
 .../scripts/python/bin/net_dropmonitor-record |    2 -
 .../scripts/python/bin/net_dropmonitor-report |    4 -
 .../scripts/python/bin/netdev-times-record    |    8 -
 .../scripts/python/bin/netdev-times-report    |    5 -
 .../scripts/python/bin/powerpc-hcalls-record  |    2 -
 .../scripts/python/bin/powerpc-hcalls-report  |    2 -
 .../scripts/python/bin/sched-migration-record |    2 -
 .../scripts/python/bin/sched-migration-report |    3 -
 tools/perf/scripts/python/bin/sctop-record    |    3 -
 tools/perf/scripts/python/bin/sctop-report    |   24 -
 .../scripts/python/bin/stackcollapse-record   |    8 -
 .../scripts/python/bin/stackcollapse-report   |    3 -
 .../python/bin/syscall-counts-by-pid-record   |    3 -
 .../python/bin/syscall-counts-by-pid-report   |   10 -
 .../scripts/python/bin/syscall-counts-record  |    3 -
 .../scripts/python/bin/syscall-counts-report  |   10 -
 .../scripts/python/bin/task-analyzer-record   |    2 -
 .../scripts/python/bin/task-analyzer-report   |    3 -
 tools/perf/scripts/python/check-perf-trace.py |   84 -
 tools/perf/scripts/python/compaction-times.py |  311 -
 .../scripts/python/event_analyzing_sample.py  |  192 -
 .../scripts/python/export-to-postgresql.py    | 1114 ----
 tools/perf/scripts/python/export-to-sqlite.py |  799 ---
 .../scripts/python/exported-sql-viewer.py     | 5030 ----------------
 .../scripts/python/failed-syscalls-by-pid.py  |   79 -
 tools/perf/scripts/python/flamegraph.py       |  267 -
 tools/perf/scripts/python/futex-contention.py |   57 -
 tools/perf/scripts/python/gecko.py            |  395 --
 tools/perf/scripts/python/intel-pt-events.py  |  494 --
 tools/perf/scripts/python/libxed.py           |  107 -
 tools/perf/scripts/python/mem-phys-addr.py    |  127 -
 tools/perf/scripts/python/net_dropmonitor.py  |   78 -
 tools/perf/scripts/python/netdev-times.py     |  473 --
 tools/perf/scripts/python/parallel-perf.py    |  989 ----
 tools/perf/scripts/python/sched-migration.py  |  462 --
 tools/perf/scripts/python/sctop.py            |   89 -
 tools/perf/scripts/python/stackcollapse.py    |  127 -
 tools/perf/scripts/python/stat-cpi.py         |   79 -
 .../scripts/python/syscall-counts-by-pid.py   |   75 -
 tools/perf/scripts/python/syscall-counts.py   |   65 -
 tools/perf/scripts/python/task-analyzer.py    |  934 ---
 tools/perf/tests/Build                        |    4 +-
 tools/perf/tests/make                         |   10 +-
 .../coresight/test_arm_coresight_disasm.sh    |   24 +-
 tools/perf/tests/shell/lib/attr.py            |   86 +-
 .../perf/tests/shell/lib/perf_brstack_max.py  |   37 +
 .../tests/shell/lib/perf_json_output_lint.py  |   36 +-
 .../tests/shell/lib/perf_metric_validation.py |   47 +-
 tools/perf/tests/shell/lib/setup_python.sh    |    4 +
 tools/perf/tests/shell/script.sh              |   43 +-
 tools/perf/tests/shell/script_perl.sh         |  102 -
 tools/perf/tests/shell/script_python.sh       |  113 -
 .../shell/test_check_perf_trace_python.sh     |   79 +
 .../shell/test_compaction_times_python.sh     |   81 +
 .../test_event_analyzing_sample_python.sh     |   58 +
 .../shell/test_export_to_postgresql_python.sh |  119 +
 .../shell/test_export_to_sqlite_python.sh     |  108 +
 .../test_failed_syscalls_by_pid_python.sh     |   92 +
 .../shell/test_failed_syscalls_python.sh      |   81 +
 .../tests/shell/test_flamegraph_python.sh     |  106 +
 .../shell/test_futex_contention_python.sh     |   67 +
 tools/perf/tests/shell/test_gecko_python.sh   |   95 +
 tools/perf/tests/shell/test_intel_pt.sh       |   41 +-
 .../shell/test_intel_pt_events_python.sh      |   69 +
 .../tests/shell/test_mem_phys_addr_python.sh  |  101 +
 .../shell/test_net_dropmonitor_python.sh      |  103 +
 .../tests/shell/test_netdev_times_python.sh   |   61 +
 .../tests/shell/test_powerpc_hcalls_python.sh |   95 +
 .../tests/shell/test_rw_by_file_python.sh     |   70 +
 .../perf/tests/shell/test_rw_by_pid_python.sh |   77 +
 tools/perf/tests/shell/test_rwtop_python.sh   |   76 +
 .../shell/test_sched_migration_python.sh      |   69 +
 tools/perf/tests/shell/test_sctop_python.sh   |   71 +
 .../tests/shell/test_stackcollapse_python.sh  |   77 +
 .../perf/tests/shell/test_stat_cpi_python.sh  |  106 +
 .../test_syscall_counts_by_pid_python.sh      |   81 +
 .../tests/shell/test_syscall_counts_python.sh |   74 +
 tools/perf/tests/shell/test_task_analyzer.sh  |   97 +-
 .../tests/shell/test_wakeup_latency_python.sh |   83 +
 tools/perf/ui/browsers/scripts.c              |  217 +-
 tools/perf/util/Build                         |    6 +-
 tools/perf/util/python.c                      |  872 ++-
 tools/perf/util/scripting-engines/Build       |    9 -
 .../util/scripting-engines/trace-event-perl.c |  770 ---
 .../scripting-engines/trace-event-python.c    | 2333 --------
 tools/perf/util/trace-event-parse.c           |   65 -
 tools/perf/util/trace-event-scripting.c       |  407 --
 tools/perf/util/trace-event.h                 |   72 +-
 204 files changed, 19632 insertions(+), 21385 deletions(-)
 delete mode 100644 tools/build/feature/test-libperl.c
 delete mode 100644 tools/build/feature/test-libpython.c
 create mode 100644 tools/build/feature/test-python-module.c
 delete mode 100644 tools/perf/Documentation/perf-script-perl.txt
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py
 create mode 100755 tools/perf/python/check-perf-trace.py
 create mode 100755 tools/perf/python/compaction-times.py
 create mode 100755 tools/perf/python/event_analyzing_sample.py
 create mode 100755 tools/perf/python/export-to-postgresql.py
 create mode 100755 tools/perf/python/export-to-sqlite.py
 create mode 100755 tools/perf/python/exported-sql-viewer.py
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/python/flamegraph.py
 create mode 100755 tools/perf/python/futex-contention.py
 create mode 100755 tools/perf/python/gecko.py
 create mode 100755 tools/perf/python/intel-pt-events.py
 create mode 100755 tools/perf/python/libxed.py
 create mode 100755 tools/perf/python/mem-phys-addr.py
 create mode 100755 tools/perf/python/net_dropmonitor.py
 create mode 100755 tools/perf/python/netdev-times.py
 create mode 100755 tools/perf/python/parallel-perf.py
 rename tools/perf/{scripts => }/python/powerpc-hcalls.py (54%)
 mode change 100644 => 100755
 create mode 100755 tools/perf/python/rw-by-file.py
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/python/rwtop.py
 create mode 100755 tools/perf/python/sched-migration.py
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/python/stackcollapse.py
 create mode 100755 tools/perf/python/stat-cpi.py
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/python/task-analyzer.py
 create mode 100755 tools/perf/python/wakeup-latency.py
 delete mode 100644 tools/perf/scripts/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.xs
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/README
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/typemap
 delete mode 100644 tools/perf/scripts/perl/bin/check-perf-trace-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-report
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-record
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-report
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-record
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-report
 delete mode 100644 tools/perf/scripts/perl/check-perf-trace.pl
 delete mode 100644 tools/perf/scripts/perl/failed-syscalls.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-file.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-pid.pl
 delete mode 100644 tools/perf/scripts/perl/rwtop.pl
 delete mode 100644 tools/perf/scripts/perl/wakeup-latency.pl
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
 delete mode 100755 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
 delete mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-record
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-report
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-record
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-report
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-record
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-report
 delete mode 100644 tools/perf/scripts/python/bin/gecko-record
 delete mode 100755 tools/perf/scripts/python/bin/gecko-report
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-record
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-report
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-record
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-report
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-record
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-report
 delete mode 100644 tools/perf/scripts/python/bin/sctop-record
 delete mode 100644 tools/perf/scripts/python/bin/sctop-report
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-record
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-report
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
 delete mode 100644 tools/perf/scripts/python/check-perf-trace.py
 delete mode 100644 tools/perf/scripts/python/compaction-times.py
 delete mode 100644 tools/perf/scripts/python/event_analyzing_sample.py
 delete mode 100644 tools/perf/scripts/python/export-to-postgresql.py
 delete mode 100644 tools/perf/scripts/python/export-to-sqlite.py
 delete mode 100755 tools/perf/scripts/python/exported-sql-viewer.py
 delete mode 100644 tools/perf/scripts/python/failed-syscalls-by-pid.py
 delete mode 100755 tools/perf/scripts/python/flamegraph.py
 delete mode 100644 tools/perf/scripts/python/futex-contention.py
 delete mode 100644 tools/perf/scripts/python/gecko.py
 delete mode 100644 tools/perf/scripts/python/intel-pt-events.py
 delete mode 100644 tools/perf/scripts/python/libxed.py
 delete mode 100644 tools/perf/scripts/python/mem-phys-addr.py
 delete mode 100755 tools/perf/scripts/python/net_dropmonitor.py
 delete mode 100644 tools/perf/scripts/python/netdev-times.py
 delete mode 100755 tools/perf/scripts/python/parallel-perf.py
 delete mode 100644 tools/perf/scripts/python/sched-migration.py
 delete mode 100644 tools/perf/scripts/python/sctop.py
 delete mode 100755 tools/perf/scripts/python/stackcollapse.py
 delete mode 100644 tools/perf/scripts/python/stat-cpi.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts-by-pid.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts.py
 delete mode 100755 tools/perf/scripts/python/task-analyzer.py
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py
 delete mode 100755 tools/perf/tests/shell/script_perl.sh
 delete mode 100755 tools/perf/tests/shell/script_python.sh
 create mode 100755 tools/perf/tests/shell/test_check_perf_trace_python.sh
 create mode 100755 tools/perf/tests/shell/test_compaction_times_python.sh
 create mode 100755 tools/perf/tests/shell/test_event_analyzing_sample_python.sh
 create mode 100755 tools/perf/tests/shell/test_export_to_postgresql_python.sh
 create mode 100755 tools/perf/tests/shell/test_export_to_sqlite_python.sh
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_python.sh
 create mode 100755 tools/perf/tests/shell/test_flamegraph_python.sh
 create mode 100755 tools/perf/tests/shell/test_futex_contention_python.sh
 create mode 100755 tools/perf/tests/shell/test_gecko_python.sh
 create mode 100755 tools/perf/tests/shell/test_intel_pt_events_python.sh
 create mode 100755 tools/perf/tests/shell/test_mem_phys_addr_python.sh
 create mode 100755 tools/perf/tests/shell/test_net_dropmonitor_python.sh
 create mode 100755 tools/perf/tests/shell/test_netdev_times_python.sh
 create mode 100755 tools/perf/tests/shell/test_powerpc_hcalls_python.sh
 create mode 100755 tools/perf/tests/shell/test_rw_by_file_python.sh
 create mode 100755 tools/perf/tests/shell/test_rw_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_rwtop_python.sh
 create mode 100755 tools/perf/tests/shell/test_sched_migration_python.sh
 create mode 100755 tools/perf/tests/shell/test_sctop_python.sh
 create mode 100755 tools/perf/tests/shell/test_stackcollapse_python.sh
 create mode 100755 tools/perf/tests/shell/test_stat_cpi_python.sh
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_python.sh
 create mode 100755 tools/perf/tests/shell/test_wakeup_latency_python.sh
 delete mode 100644 tools/perf/util/scripting-engines/Build
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-perl.c
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-python.c
 delete mode 100644 tools/perf/util/trace-event-scripting.c

-- 
2.55.0.1082.g2b9226bbc0-goog

