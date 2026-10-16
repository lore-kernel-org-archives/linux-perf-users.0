Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DF1AC44D;
	Fri, 16 Oct 2026 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109931; cv=none; b=WGTm+x6q9pM4tZ1W12fEgKBeV+938i1568BhNuOQA14sfSv3L+IHEoZCCPSlwf3ZuVW2hYm/W/NcBkW3VWNcrGfUlN5fKD40o/UG2uDxKziCZt7VrkDpKIkYDf4LioFel/ChLuZVnojO30b7sYFUB6EBe3IFJydQ+WXXm4EXxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109931; c=relaxed/simple;
	bh=Crezj6kWzeD7Kmx3gaNGEPbL4unBLBvUL8Emj3YuVmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmfkVufYKHuyNLagpGEUt7zShB++P/UCQ55QS4uXP7+IUPgmhtb5z+o5R0t1CXLYTcyqmD/gXDD001XgU4nHGIDbVhZ2fJu3mgsJYeisnSZAJbWrLxHRJZQm3KonQAvMJBx+ESupKpQYuxr36aLdtjw2nLFzUSwt2iYPbwQZ3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgzHGDWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgzHGDWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EF11F000C4;
	Fri, 16 Oct 2026 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109930;
	bh=lr5o6iH1N3MpaHE03Oe5L/R7ev2BlIlKxgAjDKnkGRE=;
	h=From:To:Cc:Subject:Date;
	b=YgzHGDWkD6HvaLz00eEemhVNzN/EdQwdLHLLJVhlqcqDzOhjeXV5sh4VDnfy15xIw
	 I7QLwaFVEo5Eig10WPJwavC8nWEGpvJhFVqOMsJ7nuHHLOL3SnNhDG/ffq5Th1lICL
	 n6F5S4sfmdYVSxGQfhgTSrk/rusYfNVkyL/LOSy5K3ukDoE0cte6mtzYZJe6kWkEaN
	 ZHnkL3tHhduKdNY2vKrRpbmDh67aTQWqh9vCWU0jz3NaYmjKpdYLSQfBdBcX6zDqVG
	 f/R9Y8Muf6ZV2qTNt+Cq3KeYF/Q6KxwMTXVoy/+BUgUjkF+j+3BtZRhga6Q5UY3r3Z
	 kreWD3XKfWxhg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v3 0/19] perf test attr: Report the failures again and cope with more than one core PMU
Date: Thu, 15 Oct 2026 21:18:24 -0300
Message-ID: <20261016001843.71978-1-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hello all,

perf test 82 stopped reporting failures when it got its shell wrapper
(8519e4f44c2af722), so expectations that no longer match perf went
unverified.  The prerequisite fixes are upstream now, so they are not
repeated here.

This series updates those expectations and makes the test cope with
machines with no core PMU, or with more than one.  Asking for one event
on the latter gives one event per core PMU.  The expectations ignore
what that adds; the commit messages say what and why.

The tests that map ring buffers take turns on the per user mlock budget
(kernel.perf_event_mlock_kb) through a robust, process-shared mutex.
The sysctl is left alone.  A test killed while holding the budget does
not leave the next one waiting.

Tested: 'perf test -vv attribute' Ok on an Amlogic A311D (aarch64, as
root), an Intel i7-14700K (hybrid, two core PMUs), x86_64 (AMD Ryzen 9
9950X3D, kernel 7.2.7) and riscv64 (Orange Pi RV).  On riscv64 the stat
tests run and the record tests report unsupp, as sampling is not
available there (no Sscofpmf).

Best regards,

- Arnaldo

What changed from v2:

  - sashiko-bot's v2 review: a one-component kernel_since or
    kernel_until (f.i. kernel_until = 6) no longer crashes attr.py.
  - sashiko-bot's v2 review: mutex_trylock() and cond_wait() now take
    over a robust mutex left behind by a dead owner, as mutex_lock().

What changed from v1:

  - Namhyung's python fix and Michael Petlan's two fixes are upstream
    now, so they are dropped from the series.
  - Namhyung's v1 report (test-record-branch-filter-any_call): probe
    events are no longer dumped, and the core PMU fallout is masked.
  - New, not from review: the 'requires = core-pmu' skip, the skip
    reasons and the mlock budget part.
  - New, not from review: the events of the other core PMUs are left
    out, when the expectations name a core PMU.

 tools/build/Makefile.feature                       |   1 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-all.c                     |   5 +
 tools/build/feature/test-pthread-mutex-robust.c    |  18 +
 tools/perf/Documentation/perf-test.txt             |  36 +-
 tools/perf/Makefile.config                         |   4 +
 tools/perf/tests/backward-ring-buffer.c            |   2 +-
 tools/perf/tests/builtin-test.c                    | 173 +++++++-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/tests/keep-tracking.c                   |   2 +-
 tools/perf/tests/mmap-basic.c                      |   1 +
 tools/perf/tests/openat-syscall-tp-fields.c        |   1 +
 tools/perf/tests/perf-record.c                     |   1 +
 tools/perf/tests/perf-time-to-tsc.c                |   1 +
 tools/perf/tests/shell/attr/README                 |  10 +-
 tools/perf/tests/shell/attr/base-stat-group        |  45 ++
 .../perf/tests/shell/attr/test-record-graph-dwarf  |   2 +-
 .../tests/shell/attr/test-record-group-sampling    |   5 +-
 .../tests/shell/attr/test-record-group-sampling1   |   5 +-
 .../tests/shell/attr/test-record-group-sampling2   |   5 +-
 tools/perf/tests/shell/attr/test-record-group1     |   3 +-
 tools/perf/tests/shell/attr/test-record-group2     |   3 +-
 tools/perf/tests/shell/attr/test-record-group3     |   3 +-
 tools/perf/tests/shell/attr/test-stat-C0           |   1 +
 tools/perf/tests/shell/attr/test-stat-basic        |   1 +
 tools/perf/tests/shell/attr/test-stat-default      |  91 +++--
 tools/perf/tests/shell/attr/test-stat-detailed-1   |  99 +++--
 tools/perf/tests/shell/attr/test-stat-detailed-2   | 111 +++--
 tools/perf/tests/shell/attr/test-stat-detailed-3   | 115 ++++--
 tools/perf/tests/shell/attr/test-stat-group1       |   3 +-
 tools/perf/tests/shell/attr/test-stat-no-inherit   |   1 +
 tools/perf/tests/shell/drm_pmu.sh                  |   2 +-
 tools/perf/tests/shell/ftrace.sh                   |   2 +-
 tools/perf/tests/shell/kallsyms.sh                 |   2 +-
 tools/perf/tests/shell/lib/attr.py                 | 455 +++++++++++++++++++--
 tools/perf/tests/shell/list.sh                     |   2 +-
 tools/perf/tests/shell/perf_sched_stats.sh         |   2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh        |   2 +-
 tools/perf/tests/shell/python-use.sh               |   2 +-
 tools/perf/tests/shell/schedstat_snapshots.sh      |   2 +-
 tools/perf/tests/shell/stat+csv_output.sh          |   2 +-
 tools/perf/tests/shell/stat+csv_summary.sh         |   2 +-
 tools/perf/tests/shell/stat+event_uniquifying.sh   |   2 +-
 tools/perf/tests/shell/stat+json_output.sh         |   2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |   2 +-
 tools/perf/tests/shell/stat+std_output.sh          |   2 +-
 tools/perf/tests/shell/stat.sh                     |   2 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   2 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |   2 +-
 tools/perf/tests/shell/stat_all_pfm.sh             |   2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |   2 +-
 tools/perf/tests/shell/stat_metrics_cgrp.sh        |   2 +-
 tools/perf/tests/shell/stat_metrics_values.sh      |   2 +-
 tools/perf/tests/shell/test_ilist_python.sh        |   2 +-
 tools/perf/tests/shell/test_stat_cpi_python.sh     |   2 +-
 tools/perf/tests/shell/test_test_junit_output.sh   |   5 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |   2 +-
 tools/perf/tests/sw-clock.c                        |   2 +-
 tools/perf/tests/task-exit.c                       |   1 +
 tools/perf/tests/tests-scripts.c                   |  84 +++-
 tools/perf/tests/tests.h                           |  17 +
 tools/perf/util/evsel.c                            |  12 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/mutex.c                            | 101 ++++-
 tools/perf/util/mutex.h                            |   6 +
 tools/perf/util/pfm.c                              |   1 +
 tools/perf/util/print-events.c                     |   1 +
 67 files changed, 1225 insertions(+), 263 deletions(-)

base-commit: cb9dba6f4764fc68ab75c36e332887332339f9c3
v1-head: b1300831ecc4503d
v2-head: da166ef7a002
