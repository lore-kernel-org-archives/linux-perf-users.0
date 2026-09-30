Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4283BBFBB;
	Wed, 30 Sep 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767511; cv=none; b=LJSoc83dhRNnLrfg+jBEzxTrQHY/lUpxR36g3axy7Vkdw2GCOO7bBtEpZF7UFDyS7Pq+CWpp61aDnysxuQUbjHzPzILLYqfH13jwrJ4J4ow0uVfUu5R+ERdxeelNquBKVFG/BDa3IFZFpxStFCXDd61kVlck6U/AFcHOI19706E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767511; c=relaxed/simple;
	bh=9dNVt0LU5RjwDzJtH0dpP/DAfVWGMDtRNZ7U910IA0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPPr5MGX5vQWiQUkTeclS8Pkbrzxz/VTPiMPMTmz/DJMy/6kiFRc4Q8QCwGhAGWVvhU5zeCKwovco1LHKTw5kNamS2t2t3GIrIbmQiOq7UUEt/PnyMiMZhC6HSoGdUo3Xbwa/u+D9Ln0GtFHH99rwhQzFcrJVH67ZiuWCX7XxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwyvdsDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwyvdsDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B021F00899;
	Wed, 30 Sep 2026 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767505;
	bh=qh5GfFNfaLcfol76DMC9iAtdWkxzhCeQmgzqacgbibA=;
	h=From:To:Cc:Subject:Date;
	b=LwyvdsDTn2/BNMzplZjkL98U/iROBzhmc48tUHVbN+0E4KnS8N5ZLLs5rc6ZD/xic
	 SUVzTbQEWIgMThlJ8ZgvBeJKFLTjW6w8+I5BGqWjZajnBz7eMg1UpT5niuXsmonH0j
	 rjta4NGbv2ixkfp84r7Vwc7STrvVfshjH/YWYL+FMOlgxOB6zdYLE/mpNYYeInya6q
	 mGm1j1I9qNrpOLBR+PkLJmG7b9R9+GDOSP6Dfkbt20te61SEnYlTH/1M2iQQPo4oTM
	 ok1jFnBu5XkwGOTJC4A+i4EZKKooz9/h/OfJEs3WEIIlYAYj2gIkhsKiMBJGDgL+xt
	 /r9NrROVnpatw==
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
Subject: [PATCH v6 0/5] perf tools: Add progress diagnostics and a false-sharing workload
Date: Wed, 30 Sep 2026 13:24:49 +0200
Message-ID: <20260930112454.16331-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
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

  - wire up 'perf report --no-progress', the counterpart of the option
    above, for the TUI and GTK browsers, whose progress there is no other
    way to turn off;

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

Best regards,

- Arnaldo

What changed from v5:

  - tools/perf/util/config.c: drop the config_file_name read in
    bad_config() rather than take config_mutex for it.

  - tools/perf/util/config.c: guard the lazy init, the pointer and the
    teardown of the shared set with a new config_set_mutex taken in
    perf_config() and perf_config__exit().	

  - tools/perf/builtin-report.c, tools/perf/Documentation/perf-report.txt:
    --progress already gives --no-progress for free, so drop the second
    option and make --progress OPT_BOOLEAN_SET: parse-options provides
    --no-progress as its auto negation.

What changed from v4:

  - tools/perf/builtin-report.c: mark --progress PARSE_OPT_NOAUTONEG.

  - tools/perf/util/config.c: format the path buffer inside the critical
    section.

  - tools/perf/tests/workloads/false_sharing.c: look at every bit of the
    affinity mask instead of bounding the walk by
    sysconf(_SC_NPROCESSORS_CONF), that counts configured CPUs, not the
    highest ID allowed.

What changed from v3:

  - tools/perf/util/config.c: keep the buffer perf_config__set_variable()
    hands to the parser in static storage.

  - tools/perf/scripts/perf-stuck.gdb: perf-dso now walks each candidate
    for the dso until one evaluates.

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
 tools/perf/builtin-config.c                   |  70 +-------
 tools/perf/builtin-report.c                   |  23 +++
 tools/perf/scripts/perf-stuck.gdb             | 129 +++++++++++++
 tools/perf/scripts/perf-stuck.sh              | 188 +++++++++++++++++++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/data_type_profiling.sh |   9 +-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/false_sharing.c    | 250 ++++++++++++++++++++++++++
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/progress.c                      |   6 +
 tools/perf/ui/progress.h                      |   4 +
 tools/perf/ui/stdio/progress.c                | 162 +++++++++++++++++
 tools/perf/util/config.c                      | 215 +++++++++++++++++++---
 tools/perf/util/config.h                      |   2 +
 tools/perf/util/ordered-events.c              |  16 +-
 tools/perf/util/session.c                     |  12 +-
 18 files changed, 1011 insertions(+), 99 deletions(-)
  create mode 100644 tools/perf/scripts/perf-stuck.gdb
  create mode 100755 tools/perf/scripts/perf-stuck.sh
  create mode 100644 tools/perf/tests/workloads/false_sharing.c
  create mode 100644 tools/perf/ui/stdio/progress.c

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
v3-head: 485532296710225862daf8ffb19802ae327efe2a
v4-head: 38193635508e0a5f04a6ebf70db27534b68b2d5b
v5-head: e99bc48f6c72b9cc67b4e4143a0364acac5523bb
--
Assisted-by: OpenCode: GPT-5.6 Luna
