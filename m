Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD03CF67F;
	Sun, 13 Sep 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338513; cv=none; b=VAxFB+omrgcOEehqeV7/zXz90okLXbVbigGldAwzaI/b2mpdnbAuVRn/uR3qiWH/W6z937J3F1Jlpp2RCETwALnNncHykSdmzbG7gg1KMEwqYbVBWPl1MUEKQB3uSUrhXHQzL6M0ELXgFtOGfc9yrmBEAR0qfmgvkXBT/Q+cMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338513; c=relaxed/simple;
	bh=/roCac09/jOizcPJHFKmue5SFFEdF3FlVduKuSIjXrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M6lIPFgLhIYaBn8NFyT52dKJz0ghluGX4sbDacNaENQEKsZdC3+FWEpl8+4TkoC09/o/j19o1xnZRUdI7geA124L/APpGgUDry7tph0LLD9z74qf5DAzRALXO0bVHiPhgqau+x3GauYwmL2fahhx7doUbiR/QmxyJb9QM/FHedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU4viyuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU4viyuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF11F000FF;
	Sun, 13 Sep 2026 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338509;
	bh=f67JLYQbEowUbOJNF14O8TPQA9CFJutgY/AzAfLcg6U=;
	h=From:To:Cc:Subject:Date;
	b=UU4viyuTOM9zo2bxve38ijYz34gTgvyF4+HGF/oe/ccPvzc/W6rOWhWX/pDFJgU5F
	 XUGLlNYgNz/HBdmdsSfIw49pjCZ2Z2A0wl4U50GTpI1jTUw9DSq7fDnx62OcKwGJPt
	 D43OdM3Dzw70yGwtWDHAPl298aPN5vPwYyvNYnYvEgvGQKc04gsWIE5No3kOVN/4pu
	 nyie0tR8QOAxBr2nCVkfVR4ETYMpKcuXBxLL1WfE8QQAmNQfGoxcgDN+7PhhEB7eKr
	 OAxXcALr8jBKAuTtbksLuO6qkP6Xw0f14JtdrwHjTXO65uH/n0hnxX9bPXvh4tEKAQ
	 zAmoqbJ8+hbiA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v3 0/8] perf tools: Annotate fixes, stdio progress indication, debuginfo-client in more places
Date: Sun, 13 Sep 2026 19:28:12 -0300
Message-ID: <20260913222821.3353-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This came out of work on data type profiling, but none of them depends on that
work and nothing in this series needs anything from it, so sending them
separately.

The fixes:

  - 'perf report -s type' spins forever, burning all of a CPU with no
    output, on the dwz compressed debug info of zlib-ng (libz.so.1):
    die_collect_vars() saves the dwarf_dieoffset() of the type DIE,
    which is relative to the file that DIE lives in, the dwz common
    file for the types shared by more than one CU, and resolving one of
    those offsets in the main debug file does not fail, it parses
    whatever is at that offset there, in this case a typedef whose
    DW_AT_type refers to itself, which is what makes the "follow the
    typedefs and qualifiers until a pointer or an array type" loop in
    die_get_pointer_type() spin.  The offset is now resolved in the file
    it was recorded as coming from, which the CU of the collected DIE
    tells exactly rather than having to be inferred from what is at the
    offset, and the type chases and the struct/union member nesting are
    bounded, so a debug info file broken in some other way makes perf
    give up on a type with a pr_debug instead of looking like it hung
    (patch 7);

  - the data type browser prints, in its samples view (-n,
    annotate.show_nr_samples), a local variable initialized to zero and
    never updated, so every member shows up as having no samples while
    the period and percent columns for the same entry are filled in
    (patch 4);

  - the 'perf data type profiling' shell test turns "this PMU cannot
    record these events" into a test failure: the script runs under
    'set -e', so the bare 'perf mem record' aborts it through the EXIT
    trap, which reports a signal that never happened, instead of
    reaching the code right below meant to report the failure (patch 1).

The features:

  - 'perf report --progress' prints the phase it is in and how far
    along it is to stderr: the TUI shows that with a progress bar, but
    in the stdio case the ui_progress updates that are already there are
    dropped on the floor.  It is what makes a slow run tell itself apart
    from a stuck one (patch 5);

  - the debuginfo for a DSO, and the kernel symbols, can now be fetched
    keyed by the build ID recorded in the perf.data file, using the
    debuginfod client, for the cases where they are not available
    locally under the name the DSO was opened with: a vmlinux for a
    kernel that since got upgraded, or a profile recorded on another
    machine.  Both are off with --no-debuginfod, with
    core.debuginfod=false, and when the build-id cache is turned off
    (patches 2 and 3);

  - 'perf mem record' asks for PERF_SAMPLE_CPU by default, as without
    it the cpu field is the (u32)-1 "no CPU info" sentinel and
    per-sample analysis cannot tell accesses from different cores apart
    from same-CPU traffic (patch 8).

Which file a saved type DIE offset belongs to is settled with
dwarf_cu_getdwarf(), new in elfutils 0.160, so the libdw feature test
now probes for it and the message in Makefile.config says 0.160 where it
said 0.157: 0.157 to 0.159 is from 2014 and has no such symbol, and
those versions now lose dwarf support with that message instead of
failing to link util/dwarf-aux.c.

Best regards,

- Arnaldo

What changed from v2 (00cffc7df5abfa68):

  PATCH 2/8, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod" [sashiko-bot review of PATCH v2 2/8]:

  - The conditions to fetch, debuginfod being enabled, the build-id cache
    being on and the build ID not having been a miss already, are now
    looked at with the fetch lock held, as they are the state the fetch
    itself changes: deciding them outside the lock and fetching inside it
    let a second thread repeat the fetch the first one had just made, or
    repeat one that had just been turned off, and put the same build ID
    on the misses list twice.

  - A build ID that is already being fetched is waited for, instead of
    fetched again: there was nothing that said "this one is in flight", so
    a second thread wanting it blocked on the fetch lock and then did its
    own complete fetch, which, while the first one is still running, is a
    second download of the same file, with a second client, a second
    progress line and a second turn at the terminal, for the same answer.
    It now sleeps on a condition variable and is woken with whatever the
    fetch settled: the file, when there is one, or the not available, when
    it found nothing or the user cancelled it, with no retry.

  - And a fetch that brought a file back is remembered, so that the ones
    that need the same build ID later, e.g. annotating another symbol of
    the same DSO, are answered with a strdup() instead of another client:
    the file stays in the debuginfod client cache, and its path is checked
    before being handed out, in case that cache gets cleaned from under
    us.

  - The fetches are still one at a time, so a fetch for one build ID waits
    for a fetch for another one: the terminal mode, the signal
    dispositions, the progress line and the 's'/'d' keys are process
    global, and sharing them between concurrent fetches, refcounted, is
    left for later, noted in the code.  It matters less than it sounds,
    now that the build IDs of a workload are answered from memory after
    the first pass over them.

  PATCH 3/8, "perf symbol: Fall back to fetching the vmlinux by build ID"
  [sashiko-bot review of PATCH v2 3/8]:

  - The fetch is no longer made with dso->lock held: dso__load() holds it
    across dso__load_kernel_sym(), and a fetch can block for a long time
    on the network, or on the terminal, waiting for the user, which would
    stall every other thread that needs the kernel dso.  It is dropped
    just around the fetch, nothing of the dso is touched while it is, and
    the symbols are loaded with the lock held again, the same way
    dso__debuginfo() already does it for the debuginfo of a DSO.  If
    another thread got the symbols for the dso in the meantime, the file
    that came back is not loaded a second time.

  PATCH 5/8, "perf report: Add --progress option" [sashiko-bot review of
  PATCH v2 5/8]:

  - A phase that starts when the progress stack is full is now just not
    shown, and its finish() is swallowed, instead of force completing the
    phase that encloses it to make room: that one still gets its own
    finish() later, which would then complete the phase above it, and so
    on, one premature completion per nesting level.  Reproduced by
    building with STDIO_PROGRESS__MAX_DEPTH set to 1: v2 prints
    "Processing events... [100.0%]" while it is at 99.7%, before the
    nested phase even runs, v3 warns and keeps the outer phase to
    complete when it really does.  With the 8 slots in the tree this
    cannot be hit, the phases perf has nest at most 2 deep, but the
    bookkeeping was wrong.

  PATCH 6/8, "perf scripts: Add perf-stuck, to tell where a running perf
  is stuck" [sashiko-bot review of PATCH v2 6/8]:

  - The perf-dso GDB macro read dloc->ms.map->dso->name and
    dloc->ms.sym->name, but struct data_loc_info.ms is a
    'struct map_symbol *', so GDB's C evaluator needs -> there: as it
    was, 'perf-stuck.sh -g' would have failed to evaluate it.

  - The one pre-existing issue in PATCH 7/8, the unbounded member type
    chase in die_get_member_type() and the unbounded recursion in
    die_find_member(), is not addressed here, it went to the perf TODO
    list as item 180, as it is not on the path this series fixes.

  Other changes since v2:

  - PATCH 2/8: a refetch made because the cached file was cleaned from
    under us now updates the entry the same way the first fetch does,
    and an entry with no path and no error is fetched again instead of
    answered; as it was, the entry kept the first fetch's success with
    no path, so the later lookups it existed for returned success with
    a NULL path, which debuginfo__new_build_id() cannot open and the
    vmlinux fallback in PATCH 3 would take as a file that came back
    and dereference.

  - PATCH 3/8: the commit message said the ignore_vmlinux_buildid that
    'perf record' and 'perf probe' set internally is what keeps them
    away from the fallback, but 'perf probe' only sets it for the
    commands other than --list, --del and --add when given an offline
    vmlinux; the message now says that and that a 'perf probe' that
    does not set it, e.g. --funcs or --add without --vmlinux on a
    system with a restricted /proc/kallsyms, can have the kernel
    debuginfo fetched, like the other tools.

  - PATCH 7/8: the kerneldoc of die_get_type_die() said the type would
    be looked up in the main file and then in the alt file, using the
    one that has a DIE with the saved tag, but the function
    deliberately resolves in only the file the offset was recorded as
    belonging to, with no fallback, and @from_alt was missing from the
    parameter list; it now describes that, and the die_collect_vars()
    and die_collect_global_vars() kerneldocs, which still said the
    type could be retrieved with dwarf_offdie() and the offset alone,
    now point at die_get_type_die().

  - PATCH 7/8: the comment on the member->truncated flag said the
    browser reads it, but the browser picks between ';' and '{' from
    the children list, so a member cut by the nesting limit is drawn
    like a complete leaf; the comment now says the flag is for the
    JSON exporter added in a later series.

  - PATCH 2/8: a search aborted by the user, with 's' or a signal, is
    now remembered for the rest of the session: the threads already
    waiting for that fetch were told there was nothing to share, but a
    request that arrived later started a new download of the same file,
    which the user may have skipped for being too big.  debuginfod__misses
    now records such a cancellation as a cancellation, the 's' message
    says the build ID will not be fetched again in this session and the
    debug message tells a cancellation and a server miss apart.

  - Patches 1, 4 and 8 are unchanged from v2: sashiko-bot found no
    issues in them.

What changed from v1 (060dccedab1617dc):

  PATCH 2/8, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod" [sashiko-bot review of PATCH 2/8]:

  - Included <limits.h> for PATH_MAX, that was coming in through a
    glibc transitive include and fails to build with musl libc.

  - debuginfod__setup_urls_env() now goes through pthread_once, so that
    the setenv() of DEBUGINFOD_URLS happens exactly once: setenv() is
    not thread safe and this is on the fetch path, which
    dso__debuginfo() deliberately takes outside dso__lock.

  - The fetch now runs with debuginfod__fetch_lock held, so that the
    process global state it uses — the terminal settings, the SIGINT/
    SIGTERM dispositions and the progress and cancellation state — is
    only ever touched by one fetch at a time.  A second concurrent
    fetch would otherwise have taken the first one's raw mode as the
    state to restore, leaving the terminal broken when it was done, and
    would reset the cancellation state from under the fetch already in
    progress.  Serializing also keeps two fetches from racing for the
    same keypresses and the same progress line, and a second fetch has
    nothing to gain from running in parallel with a first one reading
    the same kind of file off the same servers.

  - An interrupt that lands after the fetch already succeeded is no
    longer swallowed: at that point the terminal and the signal
    dispositions are the original ones again, so the signal is re-raised,
    the same way the failure path does, instead of perf carrying on as
    if the user had not asked it to stop.

  PATCH 6/8, "perf scripts: Add perf-stuck, to tell where a running perf
  is stuck" [sashiko-bot review of PATCH 6/8]:

  - /proc/<pid>/stat is now parsed with the parenthesized command name
    removed first, so that a process with spaces in its name no longer
    shifts every field after it: watching a process named 'my sleep'
    used to report "sleep)" as its state and a garbage RSS.

  - The CPU time is printed with awk's printf "%d" instead of relying on
    its default output format, that switches to scientific notation,
    which the bash arithmetic below cannot parse, once the sum of utime
    and stime goes past six digits, i.e. some 16 minutes of CPU at
    100 Hz.

  - The process can go away between the '-d /proc/<pid>' check and the
    read of /proc/<pid>/stat, so the read is now checked: a failed or
    empty one reports "process gone" instead of 'set -u' aborting the
    script on an unbound field, which is what would have hidden the
    very exit the script is meant to report.

  - The command line printed when the script starts has its control
    characters stripped, so that a process started with escape sequences
    in its arguments, e.g. one replaying a log line, does not get them
    replayed on the terminal of whoever runs this.

  - The two pre-existing issues sashiko-bot raised that are outside the
    scope of this series, the child entries and their hists arrays
    leaked by the data type browser teardown and the missing <stdio.h>
    and <stdlib.h> includes in ui/browsers/annotate-data.c, are
    recorded as items 178 and 179 of the perf TODO list for follow-up
    work.

  - Patches 1, 3, 4, 5, 7 and 8 are unchanged from v1: sashiko-bot
    found no issues in them.

Arnaldo Carvalho de Melo (8):
  perf test: Skip data_type_profiling when the PMU cannot record memory
    events
  perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
  perf symbol: Fall back to fetching the vmlinux by build ID
  perf annotate-data: Show the sample count in the data-type browser
  perf report: Add --progress option
  perf scripts: Add perf-stuck, to tell where a running perf is stuck
  perf annotate-data: Resolve type DIEs in the debug file they came from
  perf mem record: Request PERF_SAMPLE_CPU by default

 tools/build/feature/test-libdw.c              |  15 +-
 tools/perf/Documentation/perf-annotate.txt    |  10 +
 tools/perf/Documentation/perf-config.txt      |  19 +
 tools/perf/Documentation/perf-mem.txt         |   4 +
 tools/perf/Documentation/perf-report.txt      |  28 ++
 tools/perf/Documentation/perf-top.txt         |  14 +
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/builtin-annotate.c                 |   2 +
 tools/perf/builtin-mem.c                      |   9 +
 tools/perf/builtin-report.c                   |  17 +
 tools/perf/builtin-top.c                      |   6 +
 tools/perf/scripts/perf-stuck.gdb             | 104 +++++
 tools/perf/scripts/perf-stuck.sh              | 194 ++++++++
 tools/perf/tests/shell/data_type_profiling.sh |  46 +-
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/browsers/annotate-data.c        |   2 +-
 tools/perf/ui/progress.h                      |   2 +
 tools/perf/ui/stdio/progress.c                | 185 ++++++++
 tools/perf/util/annotate-data.c               |  59 ++-
 tools/perf/util/annotate-data.h               |   3 +
 tools/perf/util/config.c                      |   3 +
 tools/perf/util/debuginfo.c                   | 642 ++++++++++++++++++++++++++
 tools/perf/util/debuginfo.h                   |  36 ++
 tools/perf/util/dso.c                         |  19 +
 tools/perf/util/dwarf-aux.c                   | 171 ++++++-
 tools/perf/util/dwarf-aux.h                   |  33 ++
 tools/perf/util/ordered-events.c              |  17 +-
 tools/perf/util/session.c                     |  12 +-
 tools/perf/util/symbol.c                      |  70 ++-
 tools/perf/util/symbol_conf.h                 |   1 +
 30 files changed, 1710 insertions(+), 55 deletions(-)

base-commit: aa18964dd64511305de0711fed912054da6f5d18
v2-head: 00cffc7df5abfa6850beb360deb830d8495163ce
v1-head: 060dccedab1617dcbf6e2be64ed97afe3f3fac63
