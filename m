Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07F36167F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178085; cv=none; b=jEOZv2NLEdh3ZRcKMh4fLi6hlKvgwEvmQVk5ZbXAs10HmtDPePCMN2izsBfeDBC6/zyNRbIqwTZOMyeH6w4tWKLJNmi4siiE2QcdmrGGuvRQlwQkZwRKtY67K6UE0LRGak1DaJ3Yx0/2k+qULwIux/1ZJKuX/wT6D+smFG6mfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178085; c=relaxed/simple;
	bh=0DxRhN+yRRPCjN/msoK59O4dRCivwIeRm7wjkR04iH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OUilFGblQrHxaX+6/m2CwGAlYwP8/oLc+ZjnHNISnuWI6ahwW48RlhL6lPdv2IvwcYXK2xZbFYWLWdrvbUBYl3LOxOq1JVTj62vbqSNWwVOhmsr9X9zy+rdu3wz685tl8RbrZs3u1oySMwUxmiSYeoQzO9dpll3l8J7GCJ/14EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBh7BDY9; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBh7BDY9"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1384427c3efso5800159c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178083; x=1782782883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XHVtKHnE9q4om0yenyBJnuykHAvCt/ZrNWPbJ67Nec=;
        b=rBh7BDY9r6Bu6MUk1ovuPBx/ByYdhwubOymAZm7VIz2RzJKrE77FOx5tWeQxg+kigE
         gMvAW9soBUd1cAb/r6yhWmiZH9RIFTTau2HlwIc7TK7NXQGt8jVusN7pAVzQaFRxn3T0
         1DZmKJh6do5HswxwFbKyy04KCIRN/ZHrK5A2zLEqzPtLlZAA0jc4APxLWnwmHyzqcp4S
         W0z2D3phWNCKYulX1Z89thcE/JEZzGfR4an/4uWOoiHPCgxpQ54ymWMheMhTmHeFlPeG
         VXIpeGliSf3RwqsUvSlTQ5C2DEng4hWTQ1bvfoky1R4iIur/sOaNV5apcEEOQcfRF245
         Kh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178083; x=1782782883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XHVtKHnE9q4om0yenyBJnuykHAvCt/ZrNWPbJ67Nec=;
        b=NeHhmUHN1EU0U9fQGx63P0R6pHjZ2KeqKsqsp/ROIZe+a7J5K4KrRDRt1Clj4Ak5P4
         65YuibRQp0xehlCPN/g94XhUwdPSczlNXoDEzX7bsehbOKNjA+v8bgPPSFzeFTPgHycB
         wKaDST0GMbB/1W1i3Ps7yqzM3uhMQFmshv2Ov8b7DBEAurht6LDjhQweUfgLbpO68PRc
         zQPMWJUYK5lXJ64EyK639xB8HAmOmvses+MJYzRgWCpZfzQtwjpUl/1ktTWH5tGBTBHt
         lMktmSkkOO0swUEVOBqYyTODwyTKdYRviovPd974EF6Nx3wGXub4F8uvSbEoXkDDJ8hF
         qHtw==
X-Forwarded-Encrypted: i=1; AFNElJ+aS9wYR3o7lPaHdiQYifFF3ym1fUotuC0YAhnEad/OBmbmkBMmBjFm2YmM5HUJpOCgmfnY7Kq4go9oRz1xswrw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zzNGnJRCRF3Cz7iNYQmY2Qb4zDSTDQN1sNdaz1235fm1IDDo
	6CMuZ2s3MDFJtxajvgaIQyTELG9oze7S4jwYNyZ3u0KmhJhSU1/gxCt0EXZeE9s+zVF96mwsMcK
	PZEUaF4+GJA==
X-Received: from dlbtp2.prod.google.com ([2002:a05:7022:3b82:b0:138:299:dc34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:781:b0:137:6781:7dd7
 with SMTP id a92af1059eb24-139c5dc743dmr573452c88.20.1782178082284; Mon, 22
 Jun 2026 18:28:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:45 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-1-irogers@google.com>
Subject: [PATCH v4 00/13] perf tests: Robustness and performance improvements
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

This patch series introduces several robustness and performance
improvements to the perf test suite, alongside fixes for long-standing
flakiness.

Key changes across the series:
- Introduces robust retry logic (`perf_record_with_retry`) to prevent
  spurious test failures due to transient `EPERM` issues during
  system-wide background profiling, safely extracting error messages from
  the PERF_RECORD_LOGS array.
- Significantly speeds up test execution across multiple scripts (such as
  kvm, record, trace, off-cpu, and lock contention) by supporting
  sub-second durations in the `noploop` and `thloop` workloads, reducing
  unnecessary wait times.
- Fixes flakiness in the BPF counters hybrid test by parsing `taskset` to
  determine valid CPUs rather than relying on `shuf`, which can fail under
  cgroups or missing binaries.
- Fixes JIT dump file leaks and TOCTOU vulnerabilities by securely staging
  with `mktemp -d` to guarantee cleanup.
- Decouples format alignments in `builtin-test.c` to gracefully truncate
  test descriptions without losing alignment or failing under non-TTY
  environments.
- Restricts uncore PMU bypass in event parsing strictly to `--cputype` to
  prevent unintended metric evaluation impacts.
- Injects trace output into JUnit XML `<skipped>` blocks to aid debugging.

Changes in v4:
- Rebased on top of latest `ptn/perf-tools-next` branch.
- Resolved merge conflicts in `util/metricgroup.c`, `util/parse-events.c`,
  and `util/python.c` from upstream `evlist` reference counting changes.
- Fixed a ShellCheck error in `trace_record_replay.sh` where `local` was
  used outside of a function.
- Cleaned up line length warnings from `checkpatch.pl` in
  `test_brstack.sh`.
- Simplified the `perf kvm record` test loop in `kvm.sh` to run `sleep`
  directly as a workload (instead of running in the background and
  killing), using `-e cpu-clock` explicitly to bypass the `perf kvm` option
  handling bug on x86/PowerPC platforms while remaining portable to
  architectures lacking a hardware cycles event (e.g. s390x).

Changes in v3:
- Fix line length warnings in checkpatch.pl.
- Fix wrap commit descriptions in checkpatch.pl.
- Re-aligned parse_events_state struct initializations.
- Added explanatory comment for the 10000 magic number in get_term_width().
- Added inline comments (e.g. /*cputype_filter=*/false) to boolean
  literal arguments.
- Fixed patch 4 to securely read from PERF_RECORD_LOGS array instead of
  unsafe wildcard cleanup.
- Fixed patch 6 TOCTOU vulnerability via mktemp -d staging directory.
- Implemented patch 13 to inject trace output into JUnit XML <skipped>
  blocks for debugging.
- Add Assisted-by tags to all commits.

Changes in v2:
- Drop the sleep 0 patch from v1.
- Introduce 'perf_record_with_retry' helper to encapsulate the retry logic
  and cleanly output error messages (patch 4).
- Fix issue with `perf record` lacking sufficient permissions on some
  setups (patch 5).
- Improve subsecond duration support in noploop/thloop (patch 3).
- Reduce test durations to avoid excessive overall runtimes.

Ian Rogers (13):
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
  perf tests: Include error output for skipped tests in JUnit XML

 tools/perf/builtin-script.c                   |   1 +
 tools/perf/builtin-stat.c                     |  20 +-
 tools/perf/tests/builtin-test.c               | 173 ++++++++++--------
 tools/perf/tests/expand-cgroup.c              |   3 +-
 tools/perf/tests/parse-events.c               |  11 +-
 tools/perf/tests/parse-metric.c               |   3 +-
 tools/perf/tests/pmu-events.c                 |  10 +-
 tools/perf/tests/shell/jitdump-python.sh      |  79 +++++---
 tools/perf/tests/shell/kvm.sh                 |  61 +++---
 .../tests/shell/lib/perf_metric_validation.py |  11 +-
 tools/perf/tests/shell/lib/perf_record.sh     |  58 ++++++
 tools/perf/tests/shell/lock_contention.sh     |  32 ++--
 tools/perf/tests/shell/pipe_test.sh           |   4 +-
 tools/perf/tests/shell/record.sh              | 173 +++++++++---------
 tools/perf/tests/shell/record_lbr.sh          |  50 +++--
 tools/perf/tests/shell/record_offcpu.sh       |  14 +-
 tools/perf/tests/shell/stat_all_metrics.sh    |  77 +++++---
 tools/perf/tests/shell/stat_bpf_counters.sh   |  28 ++-
 tools/perf/tests/shell/stat_metrics_values.sh |   9 +-
 tools/perf/tests/shell/test_brstack.sh        | 107 ++++++-----
 tools/perf/tests/shell/trace_record_replay.sh |  38 +++-
 tools/perf/tests/workloads/noploop.c          |  17 +-
 tools/perf/tests/workloads/thloop.c           |  16 +-
 tools/perf/util/metricgroup.c                 |  26 ++-
 tools/perf/util/metricgroup.h                 |   4 +-
 tools/perf/util/parse-events.c                |  32 ++--
 tools/perf/util/parse-events.h                |  17 +-
 tools/perf/util/python.c                      |   3 +-
 28 files changed, 687 insertions(+), 390 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

-- 
2.55.0.rc0.786.g65d90a0328-goog

