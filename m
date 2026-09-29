Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB420D4F0
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648372; cv=none; b=G/Ivo6An/LZrhHeX16dbXtP0CiL4FAKLTo0BUuLL9dxDD0ZRLwgp3+0xc+qQUGXX15YA2mYBP8IlHQTCra7tWXxCtro1N/xBKDvKWdpdJAvTuVSvTRLKDjoFz+OQv26U8eWsmcbOPsiLcp5vlG01MGSRRQTybyzd8VylsZzK2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648372; c=relaxed/simple;
	bh=52XmDAN8bZgCgtkqULqcFppdj8qM2NbIr/SfJgbMuDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e/7y37RX5DU5kwXWx5nglIijNfTilUPRpB5ym3Y85nBTeDM0znrVjcH/Q3fH7/4jg3EWrAhHeCVGfD00f1QMkMm/whwS3+E79gvQputoodsD3nUqX0rxZMuO2eGolSq4BoLEnmE3TtRwQVOHiWyG8EG4JesqOCbP+gVKnXuzfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhBo64ld; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhBo64ld"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso5718322eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648370; x=1791253170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ax4EDbtMMFsKrY8M8udEIOZYKHMZbVvVla2aorbb+I8=;
        b=AhBo64ldtuIgvcXnNa5frpEJKwXAFVF6ZmPHIXcQbxEKIgpfgijekmRSSv46mz2dcs
         auM96La1oln+1+BZUPqo9MNeV6UuDqMuCuZCWGv0CxPU26RCDMcxNa3rVxJsA8xsLE5V
         UMFINfgm/bD1+JJ/0ihc8U1QvpdCo0PNIQY0/1f5sbuXOV/DJ5/IpAinOlr44Oj6LzF1
         BT9fahHrMgQFrebtRr4eHMHKCVavGB+r2u2yM//1+kvc97Gl1A54BAUOFcd3XZkIoGnw
         QehYReRF4sMJSNUxR+L8B0Hx/XuWeK4TscVVaVMH0M7g4OZD8RXnNH7oGwHBsREO+Gy/
         frZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648370; x=1791253170;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ax4EDbtMMFsKrY8M8udEIOZYKHMZbVvVla2aorbb+I8=;
        b=o4ObzT3w3zzhre+zlW0FQgpwNvuhAQi3nt6jNhKiTFX8BIMlXFyLvd6j9qcpziWIf7
         5XJ/wsEgLTb7E4bkJMEZiw1n/eibfAtFqrvB0NoYzNK6/ckHi/MI72TJj/7WSapwBrZ6
         q/p9Nq9drqrgKGLebMk6SMlpM+zS/iA5PlxzmTy7RISHRsGGyrddbKhcVs42Jy6pP4jV
         AhhePsv62F+iFdYd5/BcRp1DXztp3HvldsOuV6EO3vbJqGp7c2XGH68COoxZkojAGlkx
         lflXhBcRpd5RFT25FghdZQWKWA959u1Br1swy6/PTvW9RnHYtMHmEJpz6dYj/evimS6P
         HW4A==
X-Forwarded-Encrypted: i=1; AKwUvByGzt3IG9Y4AzBCJ+Z2DKGLxNL5WR+JeyT05Ird+g5QIlp3/wljXzES2SbpgeebaOXbRHxwUy0hbDpOPmzmIihA@vger.kernel.org
X-Gm-Message-State: AFuF++nqYBNyN+xeE7Mmc37ICJNRAhcc8tGjC5KYX6Tzw/Igr+jVYU67
	cscK1xzQyWvcsiCvjWvdT21HToBF1kpRbRFL8joMWxUXUKvm9BiyTo+Oe2yPWl0Mifb62t3iyLl
	nL/RzuzjnGw==
X-Received: from dlbem11.prod.google.com ([2002:a05:7022:100b:b0:14b:4891:4b9b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e85:b0:144:de98:eec3
 with SMTP id a92af1059eb24-146ce29fdfdmr13230191c88.5.1790648369764; Mon, 28
 Sep 2026 19:19:29 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-1-irogers@google.com>
Subject: [PATCH v1 0/9] perf python: Follow-up fixes and shell test deflaking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series contains follow-up fixes for the standalone Python scripts
and their shell tests, particularly when running 'perf test' as root
under heavy parallel load:

- Clamp sample_id size calculation for PERF_RECORD_KSYMBOL,
  PERF_RECORD_BPF_EVENT, and PERF_RECORD_TEXT_POKE records to work
  around kernels without "perf/core: Restore header fields in sideband
  output callbacks" [1].
- Fix offline interval printing in sctop.py and live signal races in
  stat-cpi.py.
- Deflake Intel PT, failed-syscalls, and other Python shell tests under
  parallel 'perf test' load by scoping tracepoint checks to
  'perf list tracepoint', passing '-B -N --no-bpf-event' to 'perf record',
  and avoiding unnecessary system-wide ('-a') recordings.
- Default event_analyzing_sample.py to an in-memory SQLite database
  (':memory:') when '--db' is not specified.
- Initialize perf debug output ('perf_debug_setup()') when loading the
  'perf' Python extension module.
- Fix races in 'perf list' ('perf_pmus__print_pmu_events()' and
  'tp_pmu.c') when concurrent tests dynamically create and remove
  kprobe/uprobes tracepoints.

[1] https://lore.kernel.org/r/20260929014206.4175245-1-irogers@google.com

Ian Rogers (9):
  perf evsel: Clamp sample_id size for ksymbol, bpf, and text_poke
    events
  perf python sctop: Fix offline interval printing and test flakiness
  perf python stat-cpi: Fix live mode signal races and test flakiness
  perf test: Deflake Intel PT Python shell tests under load
  perf test: Deflake failed-syscalls Python shell tests under load
  perf test: Reduce overhead and contention in Python shell tests
  perf python event_analyzing_sample: Default to in-memory SQLite
    database
  perf python: Initialize debug output on module load
  perf pmu: Fix race with concurrent tracepoint creation and removal in
    perf list

 tools/perf/python/event_analyzing_sample.py   | 35 +++-------
 tools/perf/python/sctop.py                    |  9 ++-
 tools/perf/python/stat-cpi.py                 | 19 +++---
 .../shell/test_check_perf_trace_python.sh     |  8 ++-
 .../shell/test_compaction_times_python.sh     |  8 ++-
 .../test_event_analyzing_sample_python.sh     | 11 ++-
 .../shell/test_export_to_postgresql_python.sh | 49 +++++++------
 .../shell/test_export_to_sqlite_python.sh     | 50 ++++++++------
 .../test_failed_syscalls_by_pid_python.sh     | 68 +++++++++++--------
 .../shell/test_failed_syscalls_python.sh      | 44 +++++++-----
 .../tests/shell/test_flamegraph_python.sh     |  5 +-
 .../shell/test_futex_contention_python.sh     |  7 +-
 tools/perf/tests/shell/test_gecko_python.sh   |  3 +-
 .../shell/test_intel_pt_events_python.sh      | 43 ++++++------
 .../tests/shell/test_mem_phys_addr_python.sh  |  8 ++-
 .../shell/test_net_dropmonitor_python.sh      |  9 +--
 .../tests/shell/test_netdev_times_python.sh   |  6 +-
 .../tests/shell/test_powerpc_hcalls_python.sh |  4 +-
 .../tests/shell/test_rw_by_file_python.sh     |  5 +-
 .../perf/tests/shell/test_rw_by_pid_python.sh |  4 +-
 tools/perf/tests/shell/test_rwtop_python.sh   |  4 +-
 .../shell/test_sched_migration_python.sh      |  4 +-
 tools/perf/tests/shell/test_sctop_python.sh   | 48 ++++++-------
 .../tests/shell/test_stackcollapse_python.sh  |  2 +-
 .../perf/tests/shell/test_stat_cpi_python.sh  | 12 +++-
 .../test_syscall_counts_by_pid_python.sh      |  6 +-
 .../tests/shell/test_syscall_counts_python.sh |  5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |  3 +-
 .../tests/shell/test_wakeup_latency_python.sh |  7 +-
 tools/perf/util/debug.c                       |  2 +-
 tools/perf/util/evlist.c                      |  6 +-
 tools/perf/util/evsel.c                       | 59 +++++++++++++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/pmus.c                        | 20 ++++--
 tools/perf/util/python.c                      |  1 +
 tools/perf/util/tp_pmu.c                      |  8 ++-
 36 files changed, 358 insertions(+), 225 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

