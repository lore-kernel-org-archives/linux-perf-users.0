Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025144D014
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628508; cv=none; b=Y6PiAjgEx2andOKq6fJJP5QtdUQalKounEhhV8kZJwq+01dXgaSmrfFsCFnFUugv7h3UlLK0YTRwPbWZyCiNsUUPaqXK240NBbfD7MxCVnJTJGToJL7G/BRKoJe+WD6vrjrac055uIUbKUVEs/xYYpnuRraOQQmGdur4yeqmRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628508; c=relaxed/simple;
	bh=PDX4vkzhzH1yeStHaXMvouPB/WuMpR5t910hPuMM7/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YbkIb6wwvxz/e8EjWCuPaIwXXmTsmZmaRPau+cMVKE9UxHUYVtdzsg9k+k9FOsq5L8DRSKC67WrCyPqbiy0H4PNveb4A82BMBxdGkEBhHDXVMv4wCKgQj7gU7KHtdThn7ccsJq5oVJ8DsLqVaRh8mXTZhjwgShFD21FTQu0BE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFaF8FXQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFaF8FXQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-308004a2c49so2945362eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628505; x=1782233305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUY0w9N6M9ISuL5Zzman1/q32u2Y8M4loacZqOJtcYA=;
        b=pFaF8FXQIuTL1TYZ9cG/rrf8k/+xQI1rxj4AhPxUy+St4liuknsXfRPWJSrrL4BlZL
         JzwPyCDomPiDI/fsMfjKaLul26lYN6/FJj2igQTglF8CWb+u9sdrcgrCVOWmdvym0BbI
         YGLA0RfARydbsOdDXO9gOendhVcYZa7Lf/zyUgv7oYET06EbapuU/j+MG1Sq4FcJmcHH
         +NyJYtgjekaz0HpK+Dv/BvPRmDgAOCzYZQZhAEigLUnLEGFf6jvTySl06rDdR/3jZ6VK
         E8wPxlIvwxavSqBPsIWxSq7EoVJeLW+cU3v+zhIhbxkgS9v7aIhl2q1IOcWlDyoqvll2
         JDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628505; x=1782233305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUY0w9N6M9ISuL5Zzman1/q32u2Y8M4loacZqOJtcYA=;
        b=LN6EWxYcP83ffr+GoaBdBhtS2abKuMDiCrqqroJ6qzhi91CK4PlPNZUxLT3E0tQ3l+
         RyF5ot9bBM6sNWpHgO1dSX09Sxy0wA/VPE0Tlt1KRwAoIxvR8N1s0METf+ZlO0Zwnxh5
         U/CdFXZMtafn6omFYHnwVc/Zq4XF0Hb3SmPFlSLrgwW1qqK4M8vss4lrnHuKOwtjvCDG
         UW1EZUpg8Qp1Z3m234D132RoF5VW0c2ZIHyrkt3mblg4vgHUdTqxmPQuBCEn2sHZtEWn
         R4VMK/6AI8/mV0vuJjpKUKnbQvqThBAbYR2n1n3AUf8OhU1YgL70uLnUNt2yQv9U+eN8
         myfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OjppVtiYnmx4GvztTLBCPBgL1PJSIPhdyoPB58jVGWQaf+zsS6ZGxoUh2nyBdmu6FJ9DPxPLHXkS2qIbK/TFA@vger.kernel.org
X-Gm-Message-State: AOJu0YxXU+hhcV1xYDobOHmVEplH/nYdVnubLnKdosyjG6a7fg0iDACt
	h/dtg7NBcQftWKqI8gCPCtIvgT1BdpnMxeZqU+xYxy5gi5tlHqFs/FWqll5bEW1XxWCKCbbM3Er
	15+wrfxmQXw==
X-Received: from dyju27.prod.google.com ([2002:a05:7300:7a9b:b0:304:cffc:fdf7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:100b:b0:304:6ee5:634a
 with SMTP id 5a478bee46e88-30bc99774c2mr89147eec.1.1781628504703; Tue, 16 Jun
 2026 09:48:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:05 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-1-irogers@google.com>
Subject: [PATCH v3 00/13] perf tests: Robustness and performance improvements
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

This patch series introduces several robustness and performance improvements
to the perf test suite, alongside fixes for long-standing flakiness.

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

Changes in v3:
- Fix line length warnings in checkpatch.pl.
- Fix wrap commit descriptions in checkpatch.pl.
- Re-aligned parse_events_state struct initializations.
- Added explanatory comment for the 10000 magic number in get_term_width().
- Added inline comments (e.g. /*cputype_filter=*/false) to boolean literal arguments.
- Fixed patch 4 to securely read from PERF_RECORD_LOGS array instead of unsafe wildcard cleanup.
- Fixed patch 6 TOCTOU vulnerability via mktemp -d staging directory.
- Implemented patch 13 to inject trace output into JUnit XML <skipped> blocks for debugging.
- Add Assisted-by tags to all commits.

Changes in v2:
- Drop the sleep 0 patch from v1.
- Introduce 'perf_record_with_retry' helper to encapsulate the retry logic
  and cleanly output error messages (patch 4).
- Fix issue with `perf record` lacking sufficient permissions on some setups
  (patch 5).
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
 tools/perf/tests/builtin-test.c               | 140 ++++++++++----
 tools/perf/tests/expand-cgroup.c              |   3 +-
 tools/perf/tests/parse-events.c               |  11 +-
 tools/perf/tests/parse-metric.c               |   3 +-
 tools/perf/tests/pmu-events.c                 |  10 +-
 tools/perf/tests/shell/jitdump-python.sh      |  79 +++++---
 tools/perf/tests/shell/kvm.sh                 |  64 ++++---
 .../tests/shell/lib/perf_metric_validation.py |  11 +-
 tools/perf/tests/shell/lib/perf_record.sh     |  58 ++++++
 tools/perf/tests/shell/lock_contention.sh     |  32 ++--
 tools/perf/tests/shell/pipe_test.sh           |   4 +-
 tools/perf/tests/shell/record.sh              | 173 +++++++++---------
 tools/perf/tests/shell/record_lbr.sh          |  50 +++--
 tools/perf/tests/shell/record_offcpu.sh       |  12 +-
 tools/perf/tests/shell/stat_all_metrics.sh    |  77 +++++---
 tools/perf/tests/shell/stat_all_pfm.sh        |   2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |  28 ++-
 tools/perf/tests/shell/stat_metrics_values.sh |   9 +-
 tools/perf/tests/shell/test_brstack.sh        |   6 +-
 tools/perf/tests/shell/trace_record_replay.sh |  18 +-
 tools/perf/tests/workloads/noploop.c          |  17 +-
 tools/perf/tests/workloads/thloop.c           |  16 +-
 tools/perf/util/metricgroup.c                 |  26 ++-
 tools/perf/util/metricgroup.h                 |   4 +-
 tools/perf/util/parse-events.c                |  30 +--
 tools/perf/util/parse-events.h                |  17 +-
 tools/perf/util/python.c                      |   3 +-
 29 files changed, 615 insertions(+), 309 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

-- 
2.54.0.1189.g8c84645362-goog

