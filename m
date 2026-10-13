Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD952E073;
	Tue, 13 Oct 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922468; cv=none; b=OjbUREs0zOTay3olhaX024Y9Am8SOr1dLbW51iKMJ5Gzt8BIvv/09ztgOysolQr4vHFwuXisoZvGJnoUNX3gDe1Xc0t/Zdz1Z5KQ957mZbRPBdmopTzZuXHNRQZBoT8V2C/bM9G6YDp58xKuUtp4DwWiqlV5C6YJ9xcXE+yeR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922468; c=relaxed/simple;
	bh=PT7++2pxXRMrbVFS8n/Mt6LpVHE/OhukGNof6ooJyVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faiyjKkk4XpScTd6ZKRooD2f9DgRuVo1RP1m752E+0JZViVcTDTDuJaSG0WGz5KwivcrwALwu65Ym6OMoqABHqfCsIiNapp4XzC2sQu/K9Y1De6tmdauuw8CZzWLzd5zeyiyOdM0VdQRQM7z6X7KCLjgTmWT+PlE0xp3hWN+hEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv8x6QSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv8x6QSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C1F1F000FF;
	Tue, 13 Oct 2026 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922467;
	bh=SVWJPeXdQb2YVPIAXEcWCyL3B5XU2fnjo/pLXHg8r7E=;
	h=From:To:Cc:Subject:Date;
	b=Yv8x6QSnZIf2mhA5G71oB+TzecGRAaUtbz9JVrA/4qGYvGj70CZlh9IF0Re93s6ZX
	 HHeP5+cP7X35MsVqzEZ90NcZcflK0X/ybAjb0oIbxnTRQ6oFGDfuePSVJaB5XmFf85
	 fxZ3gNaiH8/QQFU9o1U6ElESUHYdLjYUGPk45tgrTv/yyYzDeyysSGvqfD1cgzkvoH
	 xDKUwZQzoHTTdgwJOlSuB7jXADwKf2a0O03QQ6zdcGlrZTYXfy16Q1aD4Vbw73LP6O
	 AvlexcTvRajADGlO7REQ3uZAhWjnna0XUSF/lWjlRGV1z+eymW1SPYbBgnnBTF0nj5
	 ywzDs85pmfwQg==
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
Subject: [PATCH v2 0/19] perf test attr: Report the failures again and cope with more than one core PMU
Date: Tue, 13 Oct 2026 17:13:55 -0300
Message-ID: <20261013201415.36428-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
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

What changed from v1:

  - Namhyung's python fix and Michael Petlan's two fixes are upstream
    now, so they are dropped from the series.
  - Namhyung's v1 report (test-record-branch-filter-any_call): probe
    events are no longer dumped, and the core PMU fallout is masked.
  - New, not from review: the 'requires = core-pmu' skip, the skip
    reasons and the mlock budget part.
  - New, not from review: the events of the other core PMUs are left
    out, when the expectations name a core PMU.

 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-all.c                |   5 +
 .../build/feature/test-pthread-mutex-robust.c |  19 +
 tools/perf/Documentation/perf-test.txt        |  28 +-
 tools/perf/Makefile.config                    |   4 +
 tools/perf/tests/backward-ring-buffer.c       |   2 +-
 tools/perf/tests/builtin-test.c               | 138 +++++-
 tools/perf/tests/code-reading.c               |   2 +-
 tools/perf/tests/keep-tracking.c              |   2 +-
 tools/perf/tests/mmap-basic.c                 |   1 +
 tools/perf/tests/openat-syscall-tp-fields.c   |   1 +
 tools/perf/tests/perf-record.c                |   1 +
 tools/perf/tests/perf-time-to-tsc.c           |   1 +
 tools/perf/tests/shell/attr/README            |  10 +-
 tools/perf/tests/shell/attr/base-stat-group   |  45 ++
 .../tests/shell/attr/test-record-graph-dwarf  |   2 +-
 .../shell/attr/test-record-group-sampling     |   5 +-
 .../shell/attr/test-record-group-sampling1    |   5 +-
 .../shell/attr/test-record-group-sampling2    |   5 +-
 .../perf/tests/shell/attr/test-record-group1  |   3 +-
 .../perf/tests/shell/attr/test-record-group2  |   3 +-
 .../perf/tests/shell/attr/test-record-group3  |   3 +-
 tools/perf/tests/shell/attr/test-stat-C0      |   1 +
 tools/perf/tests/shell/attr/test-stat-basic   |   1 +
 tools/perf/tests/shell/attr/test-stat-default |  91 ++--
 .../tests/shell/attr/test-stat-detailed-1     |  99 +++--
 .../tests/shell/attr/test-stat-detailed-2     | 111 +++--
 .../tests/shell/attr/test-stat-detailed-3     | 115 +++--
 tools/perf/tests/shell/attr/test-stat-group1  |   3 +-
 .../tests/shell/attr/test-stat-no-inherit     |   1 +
 tools/perf/tests/shell/drm_pmu.sh             |   2 +-
 tools/perf/tests/shell/ftrace.sh              |   2 +-
 tools/perf/tests/shell/kallsyms.sh            |   2 +-
 tools/perf/tests/shell/lib/attr.py            | 415 ++++++++++++++++--
 tools/perf/tests/shell/list.sh                |   2 +-
 tools/perf/tests/shell/perf_sched_stats.sh    |   2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
 tools/perf/tests/shell/python-use.sh          |   2 +-
 tools/perf/tests/shell/schedstat_snapshots.sh |   2 +-
 tools/perf/tests/shell/stat+csv_output.sh     |   2 +-
 tools/perf/tests/shell/stat+csv_summary.sh    |   2 +-
 .../tests/shell/stat+event_uniquifying.sh     |   2 +-
 tools/perf/tests/shell/stat+json_output.sh    |   2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh    |   2 +-
 tools/perf/tests/shell/stat+std_output.sh     |   2 +-
 tools/perf/tests/shell/stat.sh                |   2 +-
 .../perf/tests/shell/stat_all_metricgroups.sh |   2 +-
 tools/perf/tests/shell/stat_all_metrics.sh    |   2 +-
 tools/perf/tests/shell/stat_all_pfm.sh        |   2 +-
 .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
 tools/perf/tests/shell/stat_metrics_cgrp.sh   |   2 +-
 tools/perf/tests/shell/stat_metrics_values.sh |   2 +-
 tools/perf/tests/shell/test_ilist_python.sh   |   2 +-
 .../perf/tests/shell/test_stat_cpi_python.sh  |   2 +-
 .../tests/shell/test_test_junit_output.sh     |   2 +-
 .../shell/test_uprobe_from_different_cu.sh    |   2 +-
 tools/perf/tests/sw-clock.c                   |   2 +-
 tools/perf/tests/task-exit.c                  |   1 +
 tools/perf/tests/tests-scripts.c              |  47 +-
 tools/perf/tests/tests.h                      |  17 +
 tools/perf/util/evsel.c                       |  12 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/mutex.c                       |  86 +++-
 tools/perf/util/mutex.h                       |   5 +
 tools/perf/util/pfm.c                         |   1 +
 tools/perf/util/print-events.c                |   1 +
 67 files changed, 1092 insertions(+), 258 deletions(-)

base-commit: 3b05843302202598a6d25f3e2543c8182e6a930c
v1-head: b1300831ecc4503d
