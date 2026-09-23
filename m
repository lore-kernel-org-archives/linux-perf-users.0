Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A1233944
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187158; cv=none; b=gHcnxASFeDMDIG9z3wbo0PzzceDu/m2nQEncZJ/CdnSI0oxJPYBmQiOyJkDZt3MnM7B3xVHD0+J8WgFBlu20nlFCPKElKw1ac1Ya6zbcgjIA6bZDy8UjwrQfpWCf8v1SHy2Q1d00UD7itbuEznvWg6tukSd9zv1W/M2zk7kcNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187158; c=relaxed/simple;
	bh=F++0gZ4CGBsW3dISIfVcqKeKBBNMwGurLHRaRLuMiXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aq4WsGJABbKw8CKxpH+ZGJfeinN6vWjnU6tFJmjAjnn3Y9ZEkGU8N7OBbePPgYJSM0jF9SQG4m+eptXZU54tGYgfZZgPhBHbeJUlt0rFMmO5wM4zGxjHkz6+Ao6KRskIeDfNKnTGE5IyjxHq+ODue14YBw901hOKxoU/bX2W0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sie0Fnoc; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sie0Fnoc"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438fef603cso2362699c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187154; x=1790791954; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEI7Eum47JZ1rVrjRmdaIUAF1BiiH65WcxpIXKkjfIQ=;
        b=sie0FnocFBFQBmUA2hRqT3BCCfILw3jqawmFdQMze4CFRxexfZXe/b7nX2ivneBuqz
         w26UockhBkXJSSnPeXuh5S3+KnHFBW5xLb2STuGyfc6qvcIwzpwo1YzD2E3OYRDGX2O1
         M6dv87cu1sOMXUSMfudvxab4dzhWqDeBWqkXErkWlf/NaVLBX/D4xLxVFB7uTyIEZ9fi
         3FCi9DIjzvIDOgxgK1LXjSER4TsSlq4v9dIUDq5RoBerMnMr9hW71ofzx87dWTC87w2W
         J2RnurkNYdc1AN79aywo2Lki716QBOkHNtaDit3MCIDkPUyjKPimqg7bdPuV/1edxMz4
         2g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187154; x=1790791954;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEI7Eum47JZ1rVrjRmdaIUAF1BiiH65WcxpIXKkjfIQ=;
        b=ft9U7sCBlNB4bjGJWIfWSzvy7ac19fX1ba7Xa4yvNe481HxQgbtppLefZY3vhuQai2
         4wofIQkF7h3U1xwshYBVgAkRcVPJYBTJTWQ3PmZFdkjRDZqoO/x579Qun/Vd7hi4y9yv
         ycbHTsLbe1+6tVpG5xcNcYEi0ImDm4f0tguXzyXNAqlXvu5kxj795kyELk+dZfLdw/9+
         2TSK9RMt5PuBnTPu4kgNEI7i0IKQaw1OaXLMGiDU1g4bpZNyUT14cNLdDrSTMbQhp5FE
         w5v4C/5qKfhM8QRj0aGUCegAsddOEUqz1TGZUpcbaWMz/t/I5dx6IPpdFtuwjXhFR7tp
         hZHQ==
X-Forwarded-Encrypted: i=1; AKwUvBy26zfttlPMyO78jKvrhiAhyTkSQPMUlZDMVwygaJ84lf0pUT0Nr4HCYRqrCN17gVjBkEuqDMLCiFT8wtkNtz+V@vger.kernel.org
X-Gm-Message-State: AFuF++nvi9eXSF5ZXME6fya6EZjzvWnHflMUr6n1sTEOZxxb5+A46Idy
	ypTmlsHnFWkCeMWB6QeCgGSh6sbzhdygKy24ZJP3VED5YQSapTtZLqbFolLVC3BAd2w06J3gH72
	V1/zP3EghBA==
X-Received: from dlbpt9.prod.google.com ([2002:a05:7022:e809:b0:144:bfb6:b5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2305:b0:143:3617:c5ae
 with SMTP id a92af1059eb24-144f90d92b3mr3010379c88.2.1790187153670; Wed, 23
 Sep 2026 11:12:33 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:23 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-1-irogers@google.com>
Subject: [PATCH v3 00/49] perf: Complete transition to standalone Python scripts
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
   - Refine syscall_name()/syscall_id() argument parsing, expose
     perf.arch_strerrno() from the auto-generated trace beauty errno tables,
     and update callchain stubs and session.find_thread() lookup in
     tools/perf/util/python.c and tools/perf/python/perf.pyi.
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

Changes in v3:
 - Expose `perf_env__arch_strerrno()` as `perf.arch_strerrno()` in
   `tools/perf/util/python.c` (and tighten `arch_errno_names.sh` macro matching
   to `E[A-Z0-9]+` with `EM_SPARC32PLUS` support) so `failed-syscalls-by-pid.py`
   uses the auto-generated C beauty errno tables instead of maintaining Python
   errno dictionaries (Patches 01, 24).
 - Change `static char * const kwlist[]` to `static char *kwlist[]` in
   `pyrf_session__new()` in `tools/perf/util/python.c` to support Python < 3.13
   where `PyArg_ParseTupleAndKeywords()` expects `char **` rather than
   `char *const *`, and register `psession->tool.event_update` so pipe-mode
   `PERF_RECORD_EVENT_UPDATE` metadata is processed (Patches 08, 09).
 - Explicitly annotate `d_hcoal: Union[Event, int]` and
   `d_mcoal: Union[Event, int]` in `AmdDtlb()` in
   `tools/perf/pmu-events/amd_metrics.py` so older `mypy` versions do not infer
   `join(Event, int) = object` (Patch 11).
 - Pass `--ignore-missing-imports` to `MYPY` and
   `--ignored-modules=textual,setproctitle` to `PYLINT` in
   `tools/perf/Makefile.perf` so default static analysis builds succeed on
   systems without optional third-party Python packages (`python3-textual`,
   `python3-setproctitle`) installed (Patches 13, 14).
 - Chain `$(INSTALL)` commands with `&&` in `Makefile.perf` for the
   `python-scripts` installation rules and invoke `"perf script "` without `-s`
   from `script_browse()` in `ui/browsers/scripts.c` (Patches 15, 47).
 - Add Subresource Integrity (`integrity="sha256-..."`) attributes to the CDN
   `<link>` and `<script>` tags in `MINIMAL_HTML` in `flamegraph.py`
   (Patch 19).
 - Remove obsolete `AttributeError` fallback in `gecko.py` and ensure SQLite
   connections in `event_analyzing_sample.py` are closed on error in
   `trace_begin()` and `trace_end()` (Patches 20, 21).
 - Continue updating timeslices in `sched_switch()` in `sched-migration.py`
   after printing a rejection warning so runqueue state resynchronizes after
   dropped ring-buffer events (Patch 32).
 - Check `if not irq_list` in `handle_irq_softirq_exit()` in `netdev-times.py`
   so empty `irq_list` entries do not append vacuous hunks (Patch 36).
 - Move `setup_python.sh` path resolution updates to Patch 12, encapsulate
   `cpu_data` on `TraceDisasm` and honor `PERF_SYMBOL_VMLINUX` in
   `arm-cs-trace-disasm.py`, and add `Reviewed-by: James Clark
   <james.clark@linaro.org>` (Patches 12, 38).
 - Fix unpacked `cbr` payload variable names (`cbr_val, max_nonturbo, freq`) in
   `export-to-sqlite.py` and `export-to-postgresql.py`, and catch
   `BaseException` before terminating worker processes and re-raising in
   `parallel-perf.py` (Patches 42, 43, 45).
 - Improve shell test robustness in `test_stat_cpi_python.sh`,
   `test_task_analyzer.sh`, `test_compaction_times_python.sh`,
   `test_net_dropmonitor_python.sh`, and `test_arm_coresight_disasm.sh`, and
   update all Python script shell tests to invoke `perf script <script>` in
   Patch 48 (Patches 16, 31, 34, 35, 38, 48).

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
   shell tests locate `perf.so` when run directly (Patches 12, 38).
 - Populate `branch_types`, `samples_view.branch_type_name`, `calls` parent
   indexes (`pcpid_idx`, `pid_idx`), and `comms.has_calls` in
   `export-to-sqlite.py` for `exported-sql-viewer.py` compatibility (Patch 42).
 - Escape single quotes with `\'` for libpq connection strings in
   `export-to-postgresql.py` (Patch 43).
 - Replace Markdown `###` subsection headers with Asciidoc `~~~~` underlines in
   `perf-script-python.txt` (Patch 49).

This patch series has also been covered by Phoronix:
https://www.phoronix.com/news/Linux-Perf-Python-Module
and a talk about this work will be given by Alice Rogers and Ian Rogers at the
2026 Linux Plumbers Conference:
https://lpc.events/event/20/contributions/2510/

Ian Rogers (49):
  perf python: Update syscall helpers and expose arch_strerrno
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
 .../perf/Documentation/perf-script-python.txt |  797 +--
 tools/perf/Documentation/perf-script.txt      |   82 +-
 tools/perf/Documentation/tips.txt             |    1 -
 tools/perf/Makefile.config                    |   40 +-
 tools/perf/Makefile.perf                      |   94 +-
 tools/perf/builtin-check.c                    |    3 +-
 tools/perf/builtin-script.c                   |  986 ++--
 tools/perf/pmu-events/Build                   |    4 +-
 tools/perf/pmu-events/amd_metrics.py          |   16 +-
 tools/perf/pmu-events/intel_metrics.py        |  259 +-
 tools/perf/pmu-events/jevents.py              |   77 +-
 tools/perf/pmu-events/make_legacy_cache.py    |   34 +-
 tools/perf/pmu-events/metric.py               |   58 +-
 tools/perf/python/SchedGui.py                 |  246 +
 tools/perf/python/arm-cs-trace-disasm.py      |  389 ++
 tools/perf/python/check-perf-trace.py         |  223 +
 tools/perf/python/compaction-times.py         |  362 ++
 tools/perf/python/counting.py                 |    1 +
 tools/perf/python/event_analyzing_sample.py   |  332 ++
 tools/perf/python/export-to-postgresql.py     | 1328 +++++
 tools/perf/python/export-to-sqlite.py         |  946 +++
 tools/perf/python/exported-sql-viewer.py      | 5103 +++++++++++++++++
 tools/perf/python/failed-syscalls-by-pid.py   |  161 +
 tools/perf/python/failed-syscalls.py          |   94 +
 tools/perf/python/flamegraph.py               |  283 +
 tools/perf/python/futex-contention.py         |  107 +
 tools/perf/python/gecko.py                    |  411 ++
 tools/perf/python/ilist.py                    |    8 +-
 tools/perf/python/intel-pt-events.py          |  632 ++
 tools/perf/python/libxed.py                   |  123 +
 tools/perf/python/mem-phys-addr.py            |  136 +
 tools/perf/python/net_dropmonitor.py          |  173 +
 tools/perf/python/netdev-times.py             |  494 ++
 tools/perf/python/parallel-perf.py            | 1250 ++++
 tools/perf/python/perf.pyi                    |  122 +-
 tools/perf/python/perf_live.py                |   10 +-
 .../{scripts => }/python/powerpc-hcalls.py    |  213 +-
 tools/perf/python/rw-by-file.py               |  113 +
 tools/perf/python/rw-by-pid.py                |  205 +
 tools/perf/python/rwtop.py                    |  256 +
 tools/perf/python/sched-migration.py          |  496 ++
 tools/perf/python/sctop.py                    |  246 +
 tools/perf/python/stackcollapse.py            |  145 +
 tools/perf/python/stat-cpi.py                 |  210 +
 tools/perf/python/syscall-counts-by-pid.py    |  108 +
 tools/perf/python/syscall-counts.py           |   91 +
 tools/perf/python/task-analyzer.py            |  908 +++
 tools/perf/python/tracepoint.py               |    5 +-
 tools/perf/python/treport.py                  |   17 +-
 tools/perf/python/twatch.py                   |   81 +-
 tools/perf/python/wakeup-latency.py           |  103 +
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
 .../coresight/test_arm_coresight_disasm.sh    |   15 +-
 tools/perf/tests/shell/lib/attr.py            |   86 +-
 .../perf/tests/shell/lib/perf_brstack_max.py  |   40 +
 .../tests/shell/lib/perf_json_output_lint.py  |   36 +-
 .../tests/shell/lib/perf_metric_validation.py |   53 +-
 tools/perf/tests/shell/lib/setup_python.sh    |   29 +-
 tools/perf/tests/shell/script.sh              |   46 +-
 tools/perf/tests/shell/script_perl.sh         |  102 -
 tools/perf/tests/shell/script_python.sh       |  113 -
 .../shell/test_check_perf_trace_python.sh     |   85 +
 .../shell/test_compaction_times_python.sh     |  127 +
 .../test_event_analyzing_sample_python.sh     |   63 +
 .../shell/test_export_to_postgresql_python.sh |  124 +
 .../shell/test_export_to_sqlite_python.sh     |  109 +
 .../test_failed_syscalls_by_pid_python.sh     |   96 +
 .../shell/test_failed_syscalls_python.sh      |   80 +
 .../tests/shell/test_flamegraph_python.sh     |  110 +
 .../shell/test_futex_contention_python.sh     |  115 +
 tools/perf/tests/shell/test_gecko_python.sh   |   95 +
 tools/perf/tests/shell/test_intel_pt.sh       |   43 +-
 .../shell/test_intel_pt_events_python.sh      |   69 +
 .../tests/shell/test_mem_phys_addr_python.sh  |  103 +
 .../shell/test_net_dropmonitor_python.sh      |  102 +
 .../tests/shell/test_netdev_times_python.sh   |  104 +
 .../tests/shell/test_powerpc_hcalls_python.sh |   95 +
 .../tests/shell/test_rw_by_file_python.sh     |   68 +
 .../perf/tests/shell/test_rw_by_pid_python.sh |   75 +
 tools/perf/tests/shell/test_rwtop_python.sh   |   74 +
 .../shell/test_sched_migration_python.sh      |   72 +
 tools/perf/tests/shell/test_sctop_python.sh   |   78 +
 .../tests/shell/test_stackcollapse_python.sh  |   78 +
 .../perf/tests/shell/test_stat_cpi_python.sh  |  115 +
 .../test_syscall_counts_by_pid_python.sh      |   93 +
 .../tests/shell/test_syscall_counts_python.sh |   81 +
 tools/perf/tests/shell/test_task_analyzer.sh  |   90 +-
 .../tests/shell/test_wakeup_latency_python.sh |   82 +
 tools/perf/trace/beauty/arch_errno_names.sh   |    4 +-
 tools/perf/ui/browsers/scripts.c              |  219 +-
 tools/perf/util/Build                         |    7 +-
 tools/perf/util/python.c                      | 1040 +++-
 tools/perf/util/scripting-engines/Build       |    9 -
 .../util/scripting-engines/trace-event-perl.c |  770 ---
 .../scripting-engines/trace-event-python.c    | 2333 --------
 tools/perf/util/trace-event-parse.c           |   65 -
 tools/perf/util/trace-event-scripting.c       |  407 --
 tools/perf/util/trace-event.h                 |   72 +-
 205 files changed, 20492 insertions(+), 21491 deletions(-)
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
2.56.0.rc1.310.g51773c2048-goog

