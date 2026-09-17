Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17A4CDDD8;
	Thu, 17 Sep 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660539; cv=none; b=XoNSGglfNe58V1r0Lj065/gatbDSepDyUMkrwO4JKH2MKlSYdUbHhChz+N6NL72j4JB1WTGet0DJIwijeGJTUUdZojxubvQddfII3NXxnnJPtL4nlL8SfmGUPXV7nBbW4XiA8vzrFEsvNRlaRRiKcylDtU8dG976am3J+qsc4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660539; c=relaxed/simple;
	bh=W+y5a3VNLLDOEKOU66AI3Aq3c0KnOMGnjq21ivGkbcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPjf83dl2mD6uGVZK3Kp2Dp1niFg9wS37t79AWfMpFe0x/HITTFNgxFFXf37LpqcIhwg9kS5eaPb6KQHQ+Q1WqJ0Ng0Go9jHUX1/JPiVxxcAPRUYvRTuzHcBaEybwoyRpdYsX7wdGTjGwUOiLow8fjTDG+no9ZoY/4IzCUv7UoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Qwr7YN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Qwr7YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE671F00893;
	Thu, 17 Sep 2026 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660537;
	bh=JJlZjNw3Cp5UevYGLD/ocZ/cjKJxdrZ7OpIzBbDae3Q=;
	h=From:To:Cc:Subject:Date;
	b=k3Qwr7YNJZCmjvoGoV+oyfUTmUFPa1+CPOeFXO4Z857k2B9T5YSlSmwVJFFEBVm5r
	 yMxr7tLE3/wVNwWs34ExLiIC2+SSd4+i1G3gMLhfrAqlm+z4im3mFIVsqLZLczJ+Fv
	 wEiUnif6bKINAao/y0752DYSEJNKoSm3qPBw/Gh5fTsiNTDLZmRv1Shhr41k76i+sm
	 HxK1oe43kIU5RnIeWuH9E2HytZnEVAGIo+esPZ9+cIFV2saTaHsHG/0o+9YlEeEW9T
	 HvSa2HfGUGuzNDdCH/CWumy+aryDOI9S8JM3xPOkrDsS8PHiLY6Chs/JKYv5OyjGba
	 BgCoh0aOxt/bQ==
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
Subject: [PATCH v7 0/15] perf tools: Annotate fixes, stdio progress indication, debuginfo-client in more places
Date: Thu, 17 Sep 2026 12:55:11 -0300
Message-ID: <20260917155528.62607-1-acme@kernel.org>
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

This came out of work on data type profiling, but none of it depends on that
work and nothing in this series needs anything from it, so sending it
separately.

The fixes:

  - 'perf report -s type' spins forever on the dwz compressed debug info of
    zlib-ng (libz.so.1): die_collect_vars() saves a type DIE offset that is
    relative to the file the DIE lives in, the dwz alt file for types shared
    by several CUs, and resolving it in the main file parses whatever is at
    that offset, here a typedef whose DW_AT_type refers to itself, making the
    typedef/qualifier chase spin (patch 12), with the chases bounded so that
    other kinds of broken debug info don't hang perf either (patches 10, 11
    and 13);

  - the data type browser's samples view (-n) prints a local count that is
    initialized to zero and never updated, so every member has no samples
    (patch 7);

The features:

  - 'perf report --progress' prints the current phase and how far along it is
    to stderr (patch 8);

  - the debuginfo of a DSO, and the kernel symbols, can be fetched keyed by
    the build ID recorded in perf.data using debuginfod (patch 1), with
    DEBUGINFOD_URLS set from /etc/debuginfod when needed (patch 2) and
    opt-outs that clear it for libdwfl's own client too;

  - a slow fetch can be skipped ('s') or disabled for the session ('d'), with
    the progress shown on stderr or in a TUI window over the browser (patches
    4 and 5; perf_config__set_variable() moves to util/config.c, patch 3);

  - 'perf mem record' requests PERF_SAMPLE_CPU (patch 14) and uses the IBS
    swfilt filter when the kernel exposes it (patch 15).

Requires elfutils 0.160 for dwarf_cu_getdwarf(), so the libdw feature test
probes for it and Makefile.config says 0.160: older versions now disable
dwarf support with that message instead of failing to link.

What changed from v6 (d39be25e74340e7afa631ff40fa3810a205f04e7):

  General: commit logs and code comments were made more concise throughout,
  following Namhyung Kim's review of the v6 posting
  [<aqsX6GfGu9QnqX5u@google.com>]; no functional change.

  PATCH 1/15, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod", was split [Namhyung Kim review of PATCH v6 2/12,
  <aqrjA6UCNId2Vebq@google.com>]: the fetch is patch 1, the DEBUGINFOD_URLS
  handling, now with the copy perf owns, is patch 2.

  PATCH 12/15, "perf annotate-data: Resolve type DIEs in the debug file they
  came from", was split [Namhyung Kim review of PATCH v6 10/12,
  <aqsN1si6jjWrocIQ@google.com>]: the generic bound on the dwarf-aux type
  chases is patch 10, die_same_file()/die_get_type_die() and the elfutils
  0.160 requirement are patch 11, the fix using them is patch 12, and the
  member nesting bound is the separate patch 13.

  PATCH 3/15, "perf config: Move perf_config__set_variable() to util/config.c"
  [sashiko-bot review of the two v6 postings]:

  - The system_config choice is derived from the file being rewritten, so
    rewriting the system wide file doesn't truncate it;

  - added the <limits.h> include for PATH_MAX;

  - all config file access is serialized with a mutex.

  PATCH 4/15, "perf debuginfo: Let the user skip and disable debuginfod
  fetches" [Namhyung Kim, <aqrlw1YzYHFBdvcz@google.com>, and sashiko-bot]:

  - The 's'/'d' keys are drained with read()s that return zero when nothing
    was typed, so the fetch isn't held up waiting for a keypress;

  - the disable empties the DEBUGINFOD_URLS copy perf owns, not a setenv()
    racing other threads' getenv()s.

  PATCH 5/15, "perf debuginfo: Show the debuginfod fetch progress and keys in
  the TUI" [sashiko-bot]: the progress window clamps its width.

  PATCH 6/15, "perf symbol: Fall back to fetching the vmlinux by build ID"
  [sashiko-bot]: mapping the x86-64 entry trampolines is idempotent.

  PATCH 1/16, "perf test: Skip data_type_profiling when the PMU cannot
  record memory events", was merged upstream as 29f320d2 and is not part
  of this series anymore.

  Patches 7, 8, 9, 14 and 15 have no content changes from v6, only the
  trimming.

What changed from v5 (ef0ac8e44d43d2aa86842d2f83ad41d1c058d949):

  PATCH 2/9, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod", was split [Namhyung Kim review of PATCH v3 2/8,
  <aqdPNG6szS6YJjOi@google.com>]: the fetch stays in patch 2, the way
  to get out of a slow fetch, that was folded at the end of patch 2 in
  v5, is now patches 3 to 5, each separately cherry-pickable, and
  carrying on their own the answer to his "I'm not sure what would be
  the good default.  But with this, it can slow down the process
  especially when the binary is not in the debuginfod": on by default,
  with the way to skip the one in progress and to disable the feature
  right where the wait is felt.  Patch 3, "perf config: Move
  perf_config__set_variable() to util/config.c", is the prep patch,
  patch 4, "perf debuginfo: Let the user skip and disable debuginfod
  fetches", has the stdio 's'/'d' keys, and patch 5, "perf debuginfo:
  Show the debuginfod fetch progress and keys in the TUI", the TUI
  window over the browser.

  PATCH 4/12, "perf debuginfo: Let the user skip and disable debuginfod
  fetches" [that same review of the 'd' key semantics]:

  - 'd' now writes core.debuginfod=false into the configuration file
    directly, the user's ~/.perfconfig or the one named by PERF_CONFIG,
    via perf_config__set_variable(), moved from builtin-config.c to
    util/config.c by the prep patch so that util/debuginfo.c can use
    it, and clears DEBUGINFOD_URLS so that libdwfl's own debuginfod
    client stops for the rest of the session too: in v5 it only
    disabled debuginfod for the rest of the session and pointed at
    'perf config' to make that permanent.

  PATCH 5/12, "perf debuginfo: Show the debuginfod fetch progress and
  keys in the TUI":

  - The progress and the keys are no longer stdio-only: printing to
    stderr would garble the TUI browser display, so in v5 a fetch in
    progress in the TUI showed nothing and there was no way to skip or
    disable it, the thing that makes a slow fetch indistinguishable
    from a stuck perf.  The TUI now draws a window over the browser
    with the fetch progress and drains the 's'/'d' keys from the TUI
    input queue: the TUI owns the terminal and its input queue, and the
    browser thread is the one doing the fetch, so nobody else is
    reading from it while the fetch blocks it.  No terminal settings or
    signal dispositions are touched in that case, the terminal is the
    TUI's own and so are the SIGINT/SIGTERM handlers, that restore it
    before exiting.

  - The slang calls stay in ui/tui/, behind the ui__key_pending()/
    ui__key_read()/ui__progress_window()/ui__progress_window_end()
    primitives declared in ui/util.h and implemented in ui/tui/util.c,
    with inline stubs for builds without slang: the plan is to reduce
    the number of libraries perf needs to build, or swap slang for
    something else, such as ncurses, at some point, so nothing outside
    ui/ calls slang directly.  The text in the window is word wrapped
    to the available columns, as constrained terminals, such as a
    smartphone running termux, crop the tail of a long line and would
    hide the 'd' option hint.

  Patches 1, 3, 4, 5, 6, 7, 8 and 9 are unchanged from v5, renumbered
  as 1, 6, 7, 8, 9, 10, 11 and 12 with the split.

What changed from v4 (f801de4e80289566):

  PATCH 1/8, "perf test: Skip data_type_profiling when the PMU cannot
  record memory events" [Namhyung Kim review of PATCH v3 1/8]:

  - Namhyung suggested adding a fallback to the 'swfilt' term for
    ibs_op instead of only skipping the test on a PMU that refuses
    per-thread memory events.  The new PATCH 9 does that for the ibs_op
    memory events, using the swfilt software privilege filter the
    kernel exposes as a format term since v6.14, which makes the
    per-thread 'perf mem record' the test does work on AMD; the skip
    stays for kernels without it.  The term is in the event name even
    for records that end up without exclude bits, e.g. plain system
    wide ones: 'perf record' adds those bits itself when the first
    open fails with EACCES, after the name was built, and the retry
    only succeeds with the term already in the name:

      $ perf record -v -e ibs_op/ldlat=0/ -- true
      kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
      Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
      Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.

    with no exclude bits the kernel discards nothing.  The 'Test data
    symbol' shell test matches the event string, so its regex now
    accepts terms added after ldlat=150.

  PATCH 2/8, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod" [sashiko-bot review of PATCH v4 2/8]:

  - debuginfod__setup_urls_env() moved from util/debuginfo.c to
    util/util.c, next to perf_debuginfod_setup(), and its declaration
    from util/debuginfo.h to util/util.h: debuginfo.o is only built with
    CONFIG_LIBDW, so with libdebuginfod but without libdw the
    declaration was an empty stub and the setup was skipped exactly for
    build-id.c and probe-event.c, the debuginfod users that are built
    without libdw and that the commit message lists as reading
    DEBUGINFOD_URLS in every debuginfod_begin().

  PATCH 8/8, "perf mem record: Request PERF_SAMPLE_CPU by default"
  [sashiko-bot review of PATCH v4 8/8]:

  - The rec_argv array now reserves room for the fixed arguments
    __cmd_record() adds, up to eight with all the optional flags; a
    pre-existing under-allocation, the array was nine arguments per
    memory PMU plus the user arguments, and on a PMU with separate load
    and store events the four event arguments plus the fixed ones
    already filled it to the last slot, so this new --sample-cpu
    argument would write past it, e.g. with --phys-data --data-page-size
    --all-user.

  Patches 1, 3, 4, 5, 6 and 7 are unchanged from v4: sashiko-bot found
  no issues in them.

What changed from v3 (2433e9f0bf86cfc3):

  PATCH 2/8, "perf debuginfo: Fetch debuginfo keyed by build ID using
  debuginfod" [sashiko-bot review of PATCH v3 2/8]:

  - DEBUGINFOD_URLS is no longer set from the fetch path: setenv() is
    not thread safe and libdebuginfod reads it with getenv() in every
    debuginfod_begin(), which perf also does from build-id.c,
    probe-event.c and probe-finder.c, paths that don't go through the
    fetch lock, so a thread taking one of them could race with the
    setenv() a fetch was doing.  This is now done from symbol__init(),
    before the threads are started, from the .urls files in
    /etc/debuginfod when it isn't set, and the pthread_once() and the
    call in debuginfod__fetch() are gone with it.

  - The in-flight fetch wait was dead code and is gone: with
    debuginfod__fetch_lock held across the whole lookup and fetch, no
    second thread could ever see an entry being fetched, so the
    condition variable, the waiters and the publication dance could not
    run.  debuginfo_lookup__new() became debuginfo_lookup__add(), called
    after a fetch that brought a file back: lookups remember only the
    successful fetches, one entry each, answered with a strdup() and
    re-fetched if that file goes away, and a request for a build ID
    being fetched waits for the lock and is answered from the misses
    list or from the entry, so a download still can't happen twice.
    debuginfod__missed_lock, always taken under the fetch lock, is gone
    with it.

  PATCH 3/8, "perf symbol: Fall back to fetching the vmlinux by build ID"
  [sashiko-bot review of PATCH v3 3/8]:

  - The check for a concurrent load, made after taking dso->lock back
    from the fetch, is now dso__has_symbols() and not dso__loaded():
    dso__load() sets the latter even for an attempt that failed, so a
    thread whose fetch failed could make a thread whose fetch succeeded
    discard the vmlinux it just downloaded and carry on with an empty
    kernel dso, as loaded is set and nothing would try again.

  PATCH 6/8, "perf scripts: Add perf-stuck, to tell where a running perf
  is stuck" [sashiko-bot review of PATCH v3 6/8]:

  - The review asked whether the %s of a dwarf_diename() that returns
    NULL in perf-die-chain would abort the macro.  Checked, not changed:
    with GDB 17.2, printf prints "(null)" for a NULL char *, including
    for an inferior call returning one, and the macro carries on.  The
    other %s in the file, dloc->ms->sym->name in perf-dso, can't be NULL
    either: the only caller of find_data_type() dereferences ms->sym and
    ms->map to build the data_loc_info before that frame can exist, so
    no change there as well.

  - Patches 1, 4, 5, 7 and 8 are unchanged from v3: sashiko-bot found
    no issues in them.

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
    debug message tells a cancellation and a server miss apart.  The
    lookup entry is also now allocated and published by a
    debuginfo_lookup__new() helper called before the fetch, instead of
    an allocation whose failure was only checked after it.

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

Arnaldo Carvalho de Melo (15):
  perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
  perf debuginfo: Set DEBUGINFOD_URLS from /etc/debuginfod when unset
  perf config: Move perf_config__set_variable() to util/config.c
  perf debuginfo: Let the user skip and disable debuginfod fetches
  perf debuginfo: Show the debuginfod fetch progress and keys in the TUI
  perf symbol: Fall back to fetching the vmlinux by build ID
  perf annotate-data: Show the sample count in the data-type browser
  perf report: Add --progress option
  perf scripts: Add perf-stuck, to tell where a running perf is stuck
  perf dwarf-aux: Bound the type chases for broken debug info
  perf dwarf-aux: Add die_same_file() and die_get_type_die()
  perf annotate-data: Resolve type DIEs in the debug file they came from
  perf annotate-data: Bound the member nesting recursion
  perf mem record: Request PERF_SAMPLE_CPU by default
  perf mem record: Use the IBS swfilt filter when available

 tools/build/feature/test-libdw.c           |  13 +-
 tools/perf/Documentation/perf-annotate.txt |  10 +
 tools/perf/Documentation/perf-config.txt   |  19 +
 tools/perf/Documentation/perf-mem.txt      |   4 +
 tools/perf/Documentation/perf-report.txt   |  31 ++
 tools/perf/Documentation/perf-top.txt      |  16 +
 tools/perf/Makefile.config                 |   2 +-
 tools/perf/arch/x86/util/mem-events.c      |  14 +-
 tools/perf/builtin-annotate.c              |   3 +
 tools/perf/builtin-config.c                |  70 +--
 tools/perf/builtin-mem.c                   |  11 +-
 tools/perf/builtin-report.c                |  17 +
 tools/perf/builtin-top.c                   |   7 +
 tools/perf/scripts/perf-stuck.gdb          | 104 +++++
 tools/perf/scripts/perf-stuck.sh           | 194 +++++++++
 tools/perf/tests/shell/test_data_symbol.sh |   6 +-
 tools/perf/ui/Build                        |   1 +
 tools/perf/ui/browsers/annotate-data.c     |   2 +-
 tools/perf/ui/progress.h                   |   2 +
 tools/perf/ui/stdio/progress.c             | 163 +++++++
 tools/perf/ui/tui/util.c                   | 171 ++++++++
 tools/perf/ui/util.h                       |  27 ++
 tools/perf/util/annotate-data.c            |  53 ++-
 tools/perf/util/annotate-data.h            |   3 +
 tools/perf/util/config.c                   |  99 ++++-
 tools/perf/util/config.h                   |   2 +
 tools/perf/util/debuginfo.c                | 481 +++++++++++++++++++++
 tools/perf/util/debuginfo.h                |  35 ++
 tools/perf/util/dso.c                      |  10 +
 tools/perf/util/dwarf-aux.c                | 150 ++++++-
 tools/perf/util/dwarf-aux.h                |  17 +
 tools/perf/util/machine.c                  |  11 +-
 tools/perf/util/mem-events.c               |  18 +-
 tools/perf/util/mem-events.h               |   2 +
 tools/perf/util/ordered-events.c           |  16 +-
 tools/perf/util/session.c                  |  12 +-
 tools/perf/util/symbol.c                   |  64 ++-
 tools/perf/util/symbol_conf.h              |   1 +
 tools/perf/util/util.c                     | 151 ++++++-
 tools/perf/util/util.h                     |   9 +
 40 files changed, 1887 insertions(+), 134 deletions(-)
 create mode 100644 tools/perf/scripts/perf-stuck.gdb
 create mode 100755 tools/perf/scripts/perf-stuck.sh
 create mode 100644 tools/perf/ui/stdio/progress.c
base-commit: 29f320d221c1c4c082c7eafb2251fedf8a4868ec
v6-head: d39be25e74340e7afa631ff40fa3810a205f04e7
v5-head: ef0ac8e44d43d2aa86842d2f83ad41d1c058d949
v4-head: f801de4e80289566670e6b735198606b672e74e8
v3-head: 2433e9f0bf86cfc3d9966b467042563596c9ebdb
v2-head: 00cffc7df5abfa6850beb360deb830d8495163ce
v1-head: 060dccedab1617dcbf6e2be64ed97afe3f3fac63
--
Assisted-by: LLM
