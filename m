Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30B47043B;
	Tue, 29 Sep 2026 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716975; cv=none; b=RPky524sVTN5BGkoe+K0TQQ+WLPez/Cv5LoFUziTEoDZwixpQlfAA2Ae/i9ZP8ck1+kWlMjjfRQcBUXoJcPoxrgbHkGntScrZf9AWi+v5OoVDrUH+v8mvezDlLnr+XPm0LyV7++dVPiwqtSbf4z/0oTfWAf83aUSaLheqUmRdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716975; c=relaxed/simple;
	bh=JOqd+l9NBa5TbLWf6r3BVRwflWjOvxThIxo/m9KNXT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZUodJ1JjUPSNU0SjFGA8j1QJaz/7kiodjdazS33Cj7qrrX7P1oTxBlpFPeTHxE7XmWkvLjaNDSCvkFwpSmztOwyj9kIE5o7X/6KIJzLOmqtzPP/MsM8NtyTxWpDcXOi1nn7xwjdO35RigBSHcCLXrn0gM88QfQsdzOOYUnAxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+n5tnjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+n5tnjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57521F000FF;
	Tue, 29 Sep 2026 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716973;
	bh=ZFHH33FycVFTGXzAbpzu/RLTG3INlTscWx1A0ts6z3Q=;
	h=From:To:Cc:Subject:Date;
	b=M+n5tnjTbzuc4oYNvD/SJb24FVoa5iM6gGoKmJHYtL37jFuO9CBfUWICF86btbaUe
	 aa2s3DiGRw1inAPQ+j654PVxVJgl1ZugtngHpZjuY9d5aMbGEHfmX94YmzBKi0SY88
	 8NpkTlyHpfXWbZYlJJEt12hfUoFc8VPt0OSUAgnXoNo74s1jXIwSUDXeBot5ZNcL0C
	 mHNRbc/ETSKUwpjmM3tbYfh9cGHKfTD/3CbCSXlRHJbICl5gba2fgiipFJ+1xK6XxO
	 NOtFQeyYchyIa0DmsQk2fCrKOHwmKwKzT3stLxWB8Zm8CdliVdpkeEvxp6RDiFdr+h
	 3YV1BEHVAWvuQ==
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
Subject: [PATCH v5 0/5] perf tools: Add progress diagnostics and a false-sharing workload
Date: Tue, 29 Sep 2026 23:22:41 +0200
Message-ID: <20260929212246.2532021-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds progress and stuck-process diagnostics to perf, and a
workload that makes false sharing visible to data type profiling.

The changes are:

  - move perf_config__set_variable() to util/config.c and serialize config
    parser and read-modify-write state, so non-builtin perf code can persist
    configuration changes safely;

  - add 'perf report --progress' for stdio users, showing the current phase,
    percentage, and counts while a session is processed;

  - add 'perf report --no-progress', the counterpart above for the TUI and
    GTK browsers, whose progress there is no other way to turn off;

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

The progress backend handles nested phases and completes them on error paths
as well as successful paths. The false-sharing workload uses a shared
volatile instance so the data type profiler can resolve direct accesses to
the individual members.

The perf-stuck helper is intentionally a prototype and requires the usual
/proc access; its optional GDB mode additionally requires gdb and suitable
debug information. When only one CPU is available, the false-sharing
workload warns that it cannot produce cross-CPU traffic but still runs.

Best regards,

- Arnaldo

What changed from v4:

  - tools/perf/builtin-report.c: mark --progress PARSE_OPT_NOAUTONEG.
    parse_long_opt() claims "--no-progress" for it as soon as any option
    without that flag is tried, before the --no-progress option itself is
    ever reached, so report.no_progress stayed false and patch 3/5 did not
    do what it promises: `--no-progress --progress` printed the phases, and
    the TUI and GTK progress it exists to turn off stayed on.  Checked with
    the option values printed at the hook, and again with a two-option
    program linking the same libsubcmd.  Sashiko found this reviewing v4,
    asking whether the option was shadowed and the branch dead code;

  - tools/perf/util/config.c: format the path buffer inside the critical
    section.  It is shared by every caller, unchanged by the static storage
    it got addressing v3, and mkpath() ran before the lock was taken: two
    callers could still interleave their vsnprintf() there.  Nothing calls
    it from more than one thread today.  Sashiko pointed out the window,
    reviewing v4;

  - tools/perf/tests/workloads/false_sharing.c: look at every bit of the
    affinity mask instead of bounding the walk by
    sysconf(_SC_NPROCESSORS_CONF), that counts configured CPUs, not the
    highest ID allowed.  A cpuset restricted to high numbered ones is then
    smaller than the IDs in it, and no allowed CPU is found at all, which
    unpins every thread: reproduced with a mask holding only CPU 20 and a
    count of 4, where the old bound finds none and the new one finds it.
    Sashiko asked about sparse topologies reviewing v4;

What changed from v3:

  - tools/perf/util/config.c: keep the buffer perf_config__set_variable()
    hands to the parser in static storage.  The parser publishes that
    pointer as config_file_name, and every reader currently only stays
    clear of it by taking config_mutex on the way in, which is too easy to
    lose: nothing reachable races today, a getter would have to run outside
    a parse for that, but the change costs nothing and removes the class.
    Reported by Sashiko while reviewing v3;

  - tools/perf/scripts/perf-stuck.gdb: perf-dso now walks each candidate
    for the dso until one evaluates, so it resolves the REFCNT_CHECKING
    proxy of an ASan/LSan build too instead of aborting there with "There
    is no member named dso", which the previous version could only point
    at in a comment.  Reported by Sashiko while reviewing v3;

  - tools/perf/tests/workloads/false_sharing.c: put sum before cpu in
    struct fs_reader, the implicit padding after cpu pushed the struct to
    68 bytes and aligning it rounded that up to 128, twice the cacheline
    the padding arithmetic was written for.  Reported by Sashiko while
    reviewing v3.

  - tools/perf/builtin-report.c: --quiet asks for no messages at all, so
    --progress leaves the phases uncounted when both are given, documented
    next to --progress in perf-report.txt.  Namhyung Kim asked, reviewing
    v3, what combining them should do;

  - tools/perf/builtin-report.c, tools/perf/ui/progress.c: add
    --no-progress, installing the no-op ui_progress ops after
    setup_browser() installed the ones of the TUI or GTK browser.  Suggested
    by Namhyung Kim while reviewing v3: their progress has had no way to be
    turned off, and the option just added asks for it where there is none.
    It takes precedence over --progress;

  - tools/perf/scripts/perf-stuck.sh: check that gdb is there before
    watching instead of failing when -g first fires, two samples in, which
    can be minutes apart.  Namhyung Kim pointed it out reviewing v3;

What changed from v2:

  - tools/perf/util/config.c: perf_etc_perfconfig() returned NULL when the
    allocation in system_path() fails, and none of its callers check for
    that.  Reported by Sashiko while reviewing v2: the deref reached from
    this series was fixed, and since the same unchecked deref is already
    reachable from the three callers predating it, perf_config_from_file()
    and 'perf daemon' among them, the opportunity was taken to make the
    accessor total as well, falling back to the unresolved path, which for
    the usual absolute ETC_PERFCONFIG is the same string;

  - tools/perf/scripts/perf-stuck.gdb: don't dereference map_symbol.sym
    without checking it for NULL, printing "(no symbol)" instead.  Reported
    by Sashiko while reviewing v2;

  - tools/perf/scripts/perf-stuck.gdb: note next to the structure walks
    that a REFCNT_CHECKING build wraps some structs in a proxy holding the
    original, where this has to read map->orig->dso->orig->name;

  - tools/perf/scripts/perf-stuck.sh: count the samples showing no progress
    when there is no progress to look at, as an empty or missing progress
    log reset the counter on every sample and never fired -g;

  - tools/perf/scripts/perf-stuck.sh: use `--` for pgrep and tail, as a
    process name starting with a hyphen was taken as an option and had the
    script attach to an unrelated process, gdb included when -g is used;

  - tools/perf/scripts/perf-stuck.sh: bound the gdb run with
    `timeout --signal=INT 30`, as the script makes inferior calls and one
    into a perf wedged in a loop never returns, while SIGINT lets gdb
    release the inferior instead of leaving perf stopped.

What changed from v1:

  - avoid calling CPU_SET() with -1 when false_sharing runs with only one
    CPU available in its affinity mask.

      tools/perf/Documentation/perf-report.txt      |  19 ++
  tools/perf/builtin-config.c                   |  70 +----
  tools/perf/builtin-report.c                   |  22 ++
  tools/perf/scripts/perf-stuck.gdb             | 129 +++++++++
  tools/perf/scripts/perf-stuck.sh              | 188 +++++++++++++
  tools/perf/tests/builtin-test.c               |   1 +
  tools/perf/tests/shell/data_type_profiling.sh |   9 +-
  tools/perf/tests/tests.h                      |   1 +
  tools/perf/tests/workloads/Build              |   2 +
  tools/perf/tests/workloads/false_sharing.c    | 250 ++++++++++++++++++
  tools/perf/ui/Build                           |   1 +
  tools/perf/ui/progress.c                      |   6 +
  tools/perf/ui/progress.h                      |   4 +
  tools/perf/ui/stdio/progress.c                | 162 ++++++++++++
  tools/perf/util/config.c                      | 144 +++++++++-
  tools/perf/util/config.h                      |   2 +
  tools/perf/util/ordered-events.c              |  16 +-
  tools/perf/util/session.c                     |  12 +-
  18 files changed, 955 insertions(+), 83 deletions(-)
  create mode 100644 tools/perf/scripts/perf-stuck.gdb
  create mode 100755 tools/perf/scripts/perf-stuck.sh
  create mode 100644 tools/perf/tests/workloads/false_sharing.c
  create mode 100644 tools/perf/ui/stdio/progress.c

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
v3-head: 485532296710225862daf8ffb19802ae327efe2a
v4-head: 38193635508e0a5f04a6ebf70db27534b68b2d5b
--
Assisted-by: OpenCode: GPT-5.6 Luna
