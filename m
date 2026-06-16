Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7B377563
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573139; cv=none; b=qn8BikE7WXZM/AJYiTQWBtxaZnKRGDeJcLVCZKNP0DwDeVZp0IaWeVah0YEGYiAdO2WaWwjdnmB0vKuT28CnFInaqvPxD1MU/KFlJygE0gHc4YVYiTNab4AZpVJcH9dFXYHkTSvaJGECBjWRGy2CxHSUszXaSC4yq8EF1uRSWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573139; c=relaxed/simple;
	bh=Tiqo9IaW/wwyI484NeDMg+gc4SLAznxpgxGxO/dP7XY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=b32cb7LVyxhInyuphnhfLdzhBP3z7svqy86snKVCL4MLgqFv8rxiyza7C+dkHuGduJHdci9IWh3+gi+Tuk6d6JLdJ671vJCaBXiMnof0pwLz6KBMMHcFnmGIzHjXeMtwdTrBJTpXMSScN+ofxqLzKxMu1bmDBqDzgZl7GyFkdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCm1h9sI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCm1h9sI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f23c55b2so4980769eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573137; x=1782177937; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydpgY4RgnVhCmW55zQPEcy6WxaTHb+YujBSQ2McuqmQ=;
        b=wCm1h9sIXp5QzJ7OsTDkUDftJkM3SNGmAKmL3SFnw4srn/ulHnZS+DuyJn3x8yUc45
         ZzNK7gS3ZQrLcPKZXErFJ+bRzdjcLc6P5DSoaWSb9QGgFvYleHTpPi7uprG/rLkK8cQO
         E67qKHpF6qDsjEvS7PtiH1Xcwg6n76Kitk2cYif3qIJvod7We9dRt05dXeSVyAkyeafS
         MDDFUAiydJ/Lr4rRwnM67x5DjiA9dwcqjTzCBW4uTSahw32UHqFIyoZQM0gRa1HYOHxE
         RpeTbd5+4yUz7By8NQdluywSUXSTFs4NObSRC7ZQWzoYhbrA/K0fLokFM+ZLYev5D3pG
         HbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573137; x=1782177937;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydpgY4RgnVhCmW55zQPEcy6WxaTHb+YujBSQ2McuqmQ=;
        b=l8uTQS6HPjcmd26n4ZylRa7fwoqphAgvd+6JtphwwC3LN5uFeXLafYvdL1lCEgttmP
         5C7kLOHgfwisW8ZxCzAIBUmJDdBmbfa5xlQxfh6U5re+2Lkpcs1E6SODZZCm0uwjIIS/
         29edIqyWscb9KKvlvRHt17rClqy8ELF9WXtEEuszzrGLccKpnop2/7ajoQnPdr30Avoa
         IvQaMBcpHeAu05Z/fHZ8tQLvqXQghjNuYRhwvnu/YTaRZW7lYNhBRs963Rg/H6XFzPRh
         teFMFvI+aC1zkKY+JacyxsXv2WSfv1TAYVQwYnbRRpc9bIGHy2AU9sZ6eKgP+YSSR6vx
         K2Yg==
X-Forwarded-Encrypted: i=1; AFNElJ9+V6wOWU90Of2MT7JdW6k5j9xt4OAcWwsZ3y9q6UVDlkaqwVLiV3xWb+qnliv1N0lcapKPmLFzayNJ6FfEbEZh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUlnv3Be1tJY0ME1H1JQzK5Pwr+gEujymvMUt39IeRTAa21Pe
	gYxdO8vOFHaa0l7leawo8iu245w4zgUV8yqqSrjRDZxE0wvr1voNyjIxQXDc35VrIlp1hEUUcjO
	s6gtCeanm0A==
X-Received: from dybnb15.prod.google.com ([2002:a05:7300:cc8f:b0:304:4f23:4977])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1289:b0:2d8:7302:d3d
 with SMTP id 5a478bee46e88-30ba59bbb9bmr952988eec.8.1781573136389; Mon, 15
 Jun 2026 18:25:36 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-1-irogers@google.com>
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

