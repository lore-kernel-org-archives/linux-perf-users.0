Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C673783C5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573271; cv=none; b=OR5XbFinG4S2CioLC5pPHWacdr3aHPjgPraKSIlPgm26TY8r35G7S+yh8CnpkTYEcnk/2Mnav0r3TxMqWiEA+BK63+kE7xAbIZKdUtmy3pOxpHoPVr/5FUKFvHkrV+fiSlSVOUd95926WihHMYSUXDXwd3T7PbHpULxOSaKG/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573271; c=relaxed/simple;
	bh=Tiqo9IaW/wwyI484NeDMg+gc4SLAznxpgxGxO/dP7XY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=GVsL9RRMeduefs2XPu9l112oRH4hEkA13GmEn4IZFTy/c6ibgB+tSgglNHKh8DlRoMAcMWAAH41kIDCozI8pbdPaq2xQuouoRjNPqSPP++y3RE/FyLHlGK6Abn710XcF7C35bIFiENN4qLtSnuGIqBeuYQ8szUYcV2Mu+e/yAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHaKJJGP; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHaKJJGP"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137e49e896aso3509719c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573268; x=1782178068; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydpgY4RgnVhCmW55zQPEcy6WxaTHb+YujBSQ2McuqmQ=;
        b=VHaKJJGPjGx7wG8cdXzgxCVccKvO18eaE08CI+R2uQy53UOCfVsZbCShBjzHKHQ/KF
         SBGjscjGUwLSjVZAi7IdjdI6M2/CVGr4nIuNZ5JYFmB/681l+UQ8Ai/Pw+m8ezez/c6p
         hg6dCPuU/3v9IkCdkkoJGJMQN4Q9keS4IMDj+NK03IhTiiR5tHKCYlfNuxh4iIcU7DWD
         dlhNjwILq7YnZ/+JPyJ8VH48SnevQyFEb7UNiRoabUfW8gTz+6CL0JWdvUFOX9zLwnLR
         lPnxUl4ukORLpAUNyOPUx7RLkdCbynbkIuH0f9++Fb8NTVx5+zz7Mgp4ZhFS+kuVXlBM
         Du9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573268; x=1782178068;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydpgY4RgnVhCmW55zQPEcy6WxaTHb+YujBSQ2McuqmQ=;
        b=gbTQbUcEYiYZWeO/QV/4e6liiKRSqg7Wn8gEBqg9N5sCrAQmZ97AMpO4PumY5fe4U4
         q1wO+b1DBtFhV/dufubYyY/pCHKBBfSWFzJzPRF/giQ56FrtahdGzJtGXavcGmOBp/59
         gLqF7HRTRBhJAbVRCwD8QFld6CCEadIo2uyfhLYmD93Xtf3Il6e137mXtdMGM3a0Fj38
         CkXGr1VZy3a0Ct0dbO5MNn+vpxwFCxHVxIzV2wU4RF7U8RrWJNg+2vmD0ljeokMLb1d4
         wPLyrO+UZ3UAnxWSUvyOHWLMAIMZOG3OCk48w6waEFUsZQEJJ2vbsisHfBrKshgtTVQ+
         4ARw==
X-Forwarded-Encrypted: i=1; AFNElJ9n2V2OAUsJtMmOpKtRnzr94eGFNfkkdwH549sL5LRjrie3PhFmmDfX1EKMMBaXt4/EXgcXTaT+NRq5ht8jZI5a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uGjI43y6ACey6RGTG1LScAA+v6Onu+aIp7M9xkHooFQRT3wN
	mSaRBmCTS7K36zJSloXI3YveAGFFKY1cCq1c5uuM42i/xK67eTffFRmruXk0TjrnSPX3xxYHFWy
	qrzqQWjJwUA==
X-Received: from dlep14-n1.prod.google.com ([2002:a05:701b:458e:10b0:139:43a0:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2525:b0:135:e781:74af
 with SMTP id a92af1059eb24-1398580cb94mr849103c88.18.1781573267625; Mon, 15
 Jun 2026 18:27:47 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:27:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012744.4049193-1-irogers@google.com>
Subject: [PATCH v1 00/12] perf tests: Enhancements, speedups, and flakiness fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a comprehensive set of improvements to the perf
test suite, focusing on execution speed, reliability, and correctness.

It contains the following key updates:
1. Speed optimizations for shell tests (lock contention, off-cpu profiling,
   metrics validation) by scaling down workload durations and using lighter
   system-wide defaults.
2. Fixes for test flakiness in branch stack sampling, BPF counters on hybrid
   systems, Python JIT dump profiling, and trace record/replay.
3. A new robust retry helper (perf_record_with_retry) to ensure reliable
   recording of intermittent events in slow or virtualized environments.
4. Support for sub-second durations in noploop and thloop workloads to
   accelerate tests that only require brief sampling windows.
5. Fixes for terminal width truncation during parallel test execution, ensuring
   the progress output does not wrap or corrupt the screen when test names
   exceed the terminal width (including skipped tests).
6. Restrictions on core PMU bypass parsing to correctly enforce the
   --pmu-filter option.

The combined changes drastically reduce the total runtime of the test suite
while improving the stability of hardware-dependent and sampling-based tests.

Ian Rogers (12):
  perf parse-events: Restrict core PMU bypass to --cputype option
  perf test: Truncate test description to fit terminal width
  perf tests workloads: Support sub-second durations in noploop and
    thloop
  perf tests: Add robust record retry helper and use subsecond workloads
  perf tests: Skip metrics validation if system-wide recording lacks
    permission
  perf tests: Fix Python JIT dump profiling test failure
  perf tests: Fix flakiness in trace record and replay test
  perf tests: Fix flakiness in BPF counters test on hybrid systems
  perf tests: Fix flakiness in branch stack sampling tests
  perf tests: Speed up off-cpu profiling tests
  perf tests: Speed up lock contention analysis shell test
  perf tests: Speed up metrics checking shell tests

 tools/perf/builtin-stat.c                     |   2 +
 tools/perf/tests/builtin-test.c               |  95 +++++++---
 tools/perf/tests/parse-events.c               |  11 +-
 tools/perf/tests/pmu-events.c                 |   6 +-
 tools/perf/tests/shell/jitdump-python.sh      |  66 ++++---
 tools/perf/tests/shell/kvm.sh                 |  61 ++++---
 .../tests/shell/lib/perf_metric_validation.py |  11 +-
 tools/perf/tests/shell/lib/perf_record.sh     |  52 ++++++
 tools/perf/tests/shell/lock_contention.sh     |  30 +--
 tools/perf/tests/shell/pipe_test.sh           |   4 +-
 tools/perf/tests/shell/record.sh              | 172 +++++++++---------
 tools/perf/tests/shell/record_lbr.sh          |  50 +++--
 tools/perf/tests/shell/record_offcpu.sh       |  12 +-
 tools/perf/tests/shell/stat_all_metrics.sh    |  65 ++++---
 tools/perf/tests/shell/stat_all_pfm.sh        |   2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |  27 ++-
 tools/perf/tests/shell/stat_metrics_values.sh |   9 +-
 tools/perf/tests/shell/test_brstack.sh        |   6 +-
 tools/perf/tests/shell/trace_record_replay.sh |  18 +-
 tools/perf/tests/workloads/noploop.c          |  15 +-
 tools/perf/tests/workloads/thloop.c           |  14 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  22 ++-
 tools/perf/util/parse-events.h                |  17 +-
 24 files changed, 494 insertions(+), 277 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

-- 
2.54.0.1136.gdb2ca164c4-goog

