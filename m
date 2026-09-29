Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE1415B79
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665126; cv=none; b=iGPcOihckzjv8yDOSlqGJMBu/AkN5AKNFNeDvZ3Uq1MwLu6cC3rkFtPnBwSYBEhmG8azrDwFrDUfUNzq8dH+yiWItdZg0inNCWReaPQDwCQsGHb9w/N2Z0iNVG7RBMSx3S+ZhHdaPDmvSQgV+gtcvZZSx1pYlcon+4RXh7NalIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665126; c=relaxed/simple;
	bh=9kqLMfanvdLAQxMxraQPI4SxZw79H5eYL3MjinweS/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pWAQVpiO4Yg0t5LsCVsE9WYwNdth3pdluQp/pFZnnAqBbHtyHJktNMzMf5wrP5mKARwZudYO8hYFNgB7OWLts4GPVGeK+AF7hnQkuB6U20dF9SGMcvX3DbEzk3yjKaWVDNeqFk1nO4fyTc9RAvw6F0K1exOhc940qW0TB9Y9JTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+dhdiwz; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+dhdiwz"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34bbf2e3c5cso140387eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665124; x=1791269924; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExAFyzjlUXFMi++6alO8YF275i9lX0VxhukKiY7LTbE=;
        b=j+dhdiwzNodp91exwLR9MaWXbLsF3Ywo6Du2A6czs175wb369R1DqwlERnwiheQZsL
         4PcdmxKGRz3/jWkDc9d2t0+ZlZtTZhkDLgkfKp84aa1S/xWLMi+cs7eTYezT8J/Fha4L
         uW/f3/tif5wy3Dh9PsWQ2n3s/boMdtss1y4+560HGrH6iWQLgDryue06S73BW5pdryrw
         16gei4BaAhXl2GhPDI+ih7PxF9TdGs0DCj9Sak/bQfL1qr/80RkfkqIVdiV398JSAn+J
         9OFwFSja3dJWFlzpU1T88Ht0CnC7bv/rpd3hNrNxWzMTZX/7fLwAPHtiW4y0GYzgv/ck
         ApZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665124; x=1791269924;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExAFyzjlUXFMi++6alO8YF275i9lX0VxhukKiY7LTbE=;
        b=Ctm6omkwlH9KlxgdOhQtGusrjekz7GzUGmRhXXqIdL713JwCaK3TM3NrhpTZd9cEPN
         nvKtw/1WE/6Rz95ZJcAoJ9YpASj+vWVWJRWBKW37m3+vfj+U2CTYSA4msjrS6F3zBTrL
         S+akq2UTyryUz60Hl+N+TteRivIruVNK4rjsCBaQqcI81fhi/ckhfbzMxEs4XM1yaaBY
         DiBUodmvHIQ6RGgiD0L18Q7tm31+vGV1d8/n9CQ4n6Uny//9rc+fKnv+gVM8wLVsFiiK
         gGsLMk5GdKF9idm/62wD2Dhw/tgCWxemhuRDtMgPGPvSVABxxBLnjNmwhu1y8tAKcZkr
         49ew==
X-Forwarded-Encrypted: i=1; AKwUvBzeYSrmzb5GOeLzRz92a1fZt198TsTvO2rg+8xOveeANSdKVrUAm9OdlYLftVuXxVDVhcQmNBW66rZv0wgTOBRU@vger.kernel.org
X-Gm-Message-State: AFuF++n8tvpcRP1GOcrjwPKQe15X3LmQQRbxHL/HMnn+HytP8yGVB4ej
	tw+5/77IHAhjTGUoFRZE41Lpqjeick8boipMCIRCaR+HdGNrdk5+dzU1RUiJixcyA/aVqrOQu4s
	pwT4lv38ODw==
X-Received: from dlbbt22.prod.google.com ([2002:a05:7022:996:b0:143:c6c8:ff2c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:c083:b0:144:c112:5f24
 with SMTP id a92af1059eb24-146cfbdd167mr13536496c88.25.1790665124051; Mon, 28
 Sep 2026 23:58:44 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:30 -0700
In-Reply-To: <20260929062937.374137-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-1-irogers@google.com>
Subject: [PATCH v3 0/9] perf python: Follow-up fixes and shell test deflaking
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

v3:
- Wrap _open_live_evlist() inside the try/except KeyboardInterrupt block
  in stat-cpi.py so signals arriving during event initialization are
  caught and cleaned up gracefully.

v2:
- Fix 8-byte alignment calculation for PERF_RECORD_TEXT_POKE payload in
  evsel__event_size() by aligning fixed + old_len + new_len.
- Keep offline interval clock advancing on all samples in sctop.py while
  flushing any remaining syscalls at EOF.
- Use 'mktemp -d' private directories in test_sctop_python.sh and
  test_failed_syscalls_python.sh so temporary files are not unlinked and
  recreated directly in /tmp.
- Explicitly include <stdlib.h> in tools/perf/util/pmus.c.

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
 tools/perf/python/sctop.py                    |  7 +-
 tools/perf/python/stat-cpi.py                 | 32 ++++++---
 .../shell/test_check_perf_trace_python.sh     |  8 ++-
 .../shell/test_compaction_times_python.sh     |  8 ++-
 .../test_event_analyzing_sample_python.sh     | 11 ++-
 .../shell/test_export_to_postgresql_python.sh | 49 +++++++------
 .../shell/test_export_to_sqlite_python.sh     | 50 ++++++++------
 .../test_failed_syscalls_by_pid_python.sh     | 68 +++++++++++--------
 .../shell/test_failed_syscalls_python.sh      | 54 +++++++++------
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
 tools/perf/tests/shell/test_sctop_python.sh   | 58 ++++++++--------
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
 tools/perf/util/pmus.c                        | 21 ++++--
 tools/perf/util/python.c                      |  1 +
 tools/perf/util/tp_pmu.c                      |  8 ++-
 36 files changed, 378 insertions(+), 237 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

