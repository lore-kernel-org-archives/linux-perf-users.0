Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503952F8EAC
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663386; cv=none; b=JcXyozcOOwVXWIvlaifQ9srq2mh1gnByJbLbtvfw+4q/KavDObT5OLsviorPLc1EgmoQ4fecblMAjmDpWdjzQ5c5IQy1sKlhUqIEEC4ATF1pc45NNcwH7DoWsL5lHUNsHsxmL/a11Iu5Wa6kn/sANSwxasHo3hZiOLTkNqyh9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663386; c=relaxed/simple;
	bh=9DZuaMsTLFAyhsZLg5Z56lR2aD4/DMbGbQ5iV+7tCNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z567ohqpcFycR3gxO7+4xuKwUCsoe1cosTkZCKQdL1jUTga/5mSioDDgSfRoeZa7k6HhUraJlZDRYGCht14bVQ+NKxCbxWhQcvEPbibsrON3aDKIc6s6BFfRXfFTBxnGAv3YbCSZTWVUb83VzovQa8tYSXP7v4B3Uu03aFF7dOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv1a04uA; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv1a04uA"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3437d0cc8c7so1944442eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790663384; x=1791268184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1CxTK07QaztXv9sy5Pov3Np+7IDei2vSmYELbENs0Q=;
        b=Dv1a04uAcBdODUGqn0+Rs22zjvUsGRKFvID7QyUzdgZx08C8qFvswlFOess5hD8Oso
         ovvI6vKgWYD4a815nsjoat8sPoOTYlvddJVYh5k06mCArxnEfbPsMZlqYdxOZ8I2uoL7
         Kuj46RmYUl+P1mywtQjajvTZG1qg5g+lF9KhHbDEbZH4t3wlSxMCdwe4DVC5Fx1gNrQ7
         iVqESu1b/ukv81YgJ9Hfr7cWqHr2f80SsHV3SmfkmpAxty0TJkGXS9JNAh+7kMhlqLmN
         1/qsQKGcCBDHhdvBYxc2i5SaDetT3broajolK7fCzRf5FWITF0h6syjrgr5dB79rXgHj
         hWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790663384; x=1791268184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1CxTK07QaztXv9sy5Pov3Np+7IDei2vSmYELbENs0Q=;
        b=q4wde+UP3H3SJy8Ess4InfnEFkDxR/4kuXb0Ya1JXFdemcBYl/8PHb9fNQ6cWKFkfS
         KlMCOThx01bTOlWms0bRCRfV6gL57rNwo3wz885uGQ7dgjUDzZddUi/FBqlVC/VoQKBZ
         RYdnKES5JrXCsp+9tOfx06oqy1cRT2DSkaKHyH55ulmzToHfyo9No7Tar2fUH9HrfA8O
         t6HyyrMMDX10wL29+b7JI1g9pMw0XZA/rbZW78pQ8ySEGqU82d4EOJq5dLBI24ddYGJ5
         FflpFrrUsZ3297ieLpwiT3+IzqPnppQVohTAjX1yGN7XVgL9t/mcG+lChPEV3cpqF4sc
         pVpg==
X-Forwarded-Encrypted: i=1; AKwUvBwRGtRSBFI6IeX8Z1orF2zseULaYzrLJCd5qyUmZ2s0ylb0hNtX0lgIiiDshINi9usx78QRdXl4nR7OzZlVQMey@vger.kernel.org
X-Gm-Message-State: AFq9FYLjL5o5GExZfhGALZx6BSMLab9IW90EKhH3Ja9R5y4EhIFiCufj
	CwXx/Fv+wlkMvlbIWW4l6giXAuHizb641fAFDz1Za9dHgz9n8NTP2OuQ0lPGLkTiiGg079vK4cg
	1JxK1rBHUQw==
X-Received: from dycmz8.prod.google.com ([2002:a05:7300:ea08:b0:341:e362:8413])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1f15:b0:33b:f566:eca9
 with SMTP id 5a478bee46e88-34270ac1b61mr16496794eec.11.1790663384005; Mon, 28
 Sep 2026 23:29:44 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:29:28 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929062937.374137-1-irogers@google.com>
Subject: [PATCH v2 0/9] perf python: Follow-up fixes and shell test deflaking
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
 tools/perf/python/stat-cpi.py                 | 19 +++---
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
 36 files changed, 366 insertions(+), 236 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

