Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD834BEE58;
	Sun, 13 Sep 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270002; cv=none; b=PqU4TuEtorLFTdfu0K8+yZ+Cb5tyrODFW60JQWlwYFjacfXwukw0E3XhgNfnZrHPW1m/PMKFYIGFMW1jfrJ4W5rCVSZekTgTnbiyAUul9hi1HClUh3jwftAahsZtcRJqeGyaezqC2yoEMn5QxBnnkTG6c73P6/a3Dww5VLRb9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270002; c=relaxed/simple;
	bh=WE5LxN/bAI8vM0bC+VjVhIXOzDsnX2IQFa6cquQ1ye0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1LgXy6M/aOhMFQ0VsdMtJr2dtJLjVpoNVEyIkyc2I1MrzWp2Uj84zcWvqz4feEQidOfcOj8CFIriE0oqOmNpvZnywYqVcAVaFXOYkmY8rFZka1J/C/XcCHpmeRWfyGENDtQZKDAA5B8Gd2sTnkutYmwtgWT0BaNdqOTLnqND9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYTH1oVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYTH1oVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F37E1F000FF;
	Sun, 13 Sep 2026 03:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270001;
	bh=A/+am1mr4ycZkKVAVIg25nwNAmf5601E1yrxiDAH2Mg=;
	h=From:To:Cc:Subject:Date;
	b=OYTH1oVCkAof+psRdTEMMLm2R8nnxRrvipb5W52d/klrDwkZvU1V3gA/Oi+ISJIpl
	 MQMhzUJ22oNLNXlekYoKoxO8Z9B+epo2N83ianJolqgvuW7Qi/Y8omexTIlNV9P4iI
	 S/0fdrNsZu0EvUyjGdQ1Tw7lWPSIbgW+5rb4PTQefpoopkUpxhMazEP9zCZBOT9Hw8
	 ogls5JaPoE/x3ObQ0xwLOUO8nKhtsqcK4FzRUnSb8pczOCEQ2JInIiJ+cJz8+NosDW
	 0lD5KPa2QalcJWDmSNSdQWorI/O3iow3DhXhuyGqRr9iVEluTrU69Ds8kxWyWHyewX
	 nn5MWblX54AlQ==
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
Subject: [PATCH v2 0/8] perf tools: Annotate fixes, stdio progress indication, debuginfo-client in more places
Date: Sun, 13 Sep 2026 00:26:20 -0300
Message-ID: <20260913032632.116277-1-acme@kernel.org>
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
 tools/perf/Documentation/perf-config.txt      |  19 ++
 tools/perf/Documentation/perf-mem.txt         |   4 +
 tools/perf/Documentation/perf-report.txt      |  28 ++
 tools/perf/Documentation/perf-top.txt         |  14 +
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/builtin-annotate.c                 |   2 +
 tools/perf/builtin-mem.c                      |   9 +
 tools/perf/builtin-report.c                   |  17 +
 tools/perf/builtin-top.c                      |   6 +
 tools/perf/scripts/perf-stuck.gdb             | 104 ++++++
 tools/perf/scripts/perf-stuck.sh              | 194 +++++++++++
 tools/perf/tests/shell/data_type_profiling.sh |  46 ++-
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/browsers/annotate-data.c        |   2 +-
 tools/perf/ui/progress.h                      |   2 +
 tools/perf/ui/stdio/progress.c                | 162 ++++++++++
 tools/perf/util/annotate-data.c               |  55 +++-
 tools/perf/util/annotate-data.h               |   3 +
 tools/perf/util/config.c                      |   3 +
 tools/perf/util/debuginfo.c                   | 447 ++++++++++++++++++++++++++
 tools/perf/util/debuginfo.h                   |  36 +++
 tools/perf/util/dso.c                         |  19 ++
 tools/perf/util/dwarf-aux.c                   | 161 ++++++++--
 tools/perf/util/dwarf-aux.h                   |  33 ++
 tools/perf/util/ordered-events.c              |  17 +-
 tools/perf/util/session.c                     |  12 +-
 tools/perf/util/symbol.c                      |  40 ++-
 tools/perf/util/symbol_conf.h                 |   1 +
 30 files changed, 1411 insertions(+), 53 deletions(-)

base-commit: aa18964dd64511305de0711fed912054da6f5d18
v1-head: 060dccedab1617dcbf6e2be64ed97afe3f3fac63
--
Assisted-by: LLM
