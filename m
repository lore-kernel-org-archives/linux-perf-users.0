Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAA3DB305
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590451; cv=none; b=twiCuuV/2I6Zcmtr4ppakO97/ka59z0A2mJlhdkZ6ZkfKuVyX85ZqwT4v8a3qFucYHLhuZDyh2XA12XeICSnIDD56gThilSdUPbnbL8SqVjRPa4c1MsOFQvcc+TuN2+zhsOe/JX6Q7F8PV7uW9rEcgIKB76bRbhUf4s0uUHuVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590451; c=relaxed/simple;
	bh=3rRJCI54XopmE72TQR5+ixaSuJboE27x4CSBX3T7Yos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjUMljtSLFQsR3RGIQz9r4OxzFxztWxnK86SHYPyH74zq9XqY0xbo0ur94UVECuo4CZy2omZ0fGv0dOIH0WJRvLkygs2A1hO8xKzudTPFy3114LuXcMsm777QIUjS0H3Mif7C6USETqYZhIyFeVsxKo7Gbimy0JQ7rp9QR0Ws5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwrD7lX+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwrD7lX+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso4939419eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590449; x=1782195249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPWNGGURl1Q4sTQfa+qVak1oms1dm/1xrKK9t3dEFMA=;
        b=pwrD7lX+ucFW7ahQH/5ZkIRj76QnrcbM25oS8HOa5Dh5gDaAx8sifDJ+pPtdqK9Kej
         oURbRjwT9Jfz8OwgxqaGK38UkHfhVp1EdLmOikE6XFUpcTtdqYsHT4UY9jUr62NLHmAg
         xbpkafh7frE9nAmM2cBMqd6IAW3/kNT7TVhqLy2UxGq22VpeZ2iR6n0V2acSZYDvLA9w
         6ObcgMaBeCREZ9QcDcSjlPPUGLY3crTIk+FqG5XHZxtFVa+ia7I6FYflXSGNiUS6pYZQ
         DLcCqRZHkTH2DnJKBEwSFc5LdrM4IFpfdT2Rz5hNRpljE26Oo5WLA8WnIJ2G4QzthN7o
         +YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590449; x=1782195249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPWNGGURl1Q4sTQfa+qVak1oms1dm/1xrKK9t3dEFMA=;
        b=s1OAl9/wPPyfUnPWiNN5BI8q1OJV2OgFfkQwFRZtOnTeAcIHTEkM02CTHF/akdWqvE
         tVzXtr+CTX3v3sABeVqbk7MkGC88m0KWK2IRUW6zaEMPWTzl9yA0Eq6lrpb2oFWYo6g7
         75ouucw4XM4jJCToLq+7MtU9onGGPfizUfwXsxuqBFGyiS+sB/eza1YCycvssLiUZ02K
         R2x6j4qFJ2aVKyEOziq/csAP0nXw+iC7tBs00sho7nWfOu+FW5m9JIfivCPy6Grn+hgb
         dphzP1p1LEKZeDQCAAvhB7yQGvgo6NZpsTB4bHUU5IE3JDcupSz6DTMYoHLhAVah6hRb
         ZjUw==
X-Forwarded-Encrypted: i=1; AFNElJ+ikPvc+nXYBXTUwvxT+24cI5L7Z0ySdQKOqE83UxkxLhHDC3VkpkrNiKfx4A4nuXXD1NOgD43Yn8OMAzTWqIuY@vger.kernel.org
X-Gm-Message-State: AOJu0YzoY83iMuhibaDYNzPFFM0E2t8LTc3+f/U5bbjk6SrgtYK3rcvt
	HKJQFA7usBVP5wM/YZ3UwE8kymelzp3rnR1YY10s+adcFU5H/lG+Qu48Hqul5f/66DA/Bg5s9Wz
	7Bt63XOG9NA==
X-Received: from dycmj7.prod.google.com ([2002:a05:7301:607:b0:2f0:f8f7:8376])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4791:b0:304:d75b:f5df
 with SMTP id 5a478bee46e88-30ba5f18955mr1262508eec.19.1781590448480; Mon, 15
 Jun 2026 23:14:08 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:13:52 -0700
In-Reply-To: <20260616012744.4049193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-1-irogers@google.com>
Subject: [PATCH v2 00/12] perf tests: Enhance robustness, speed up execution,
 and fix flakiness
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
  system-wide background profiling.
- Significantly speeds up test execution across multiple scripts (such as
  kvm, record, trace, off-cpu, and lock contention) by supporting
  sub-second durations in the `noploop` and `thloop` workloads, reducing
  unnecessary wait times.
- Fixes flakiness in the BPF counters hybrid test by parsing `taskset` to
  determine valid CPUs rather than relying on `shuf`, which can fail under
  cgroups or missing binaries.
- Fixes JIT dump file leaks by actively recording the injected Python PID
  to guarantee cleanup when zero samples are generated.
- Decouples format alignments in `builtin-test.c` to gracefully truncate
  test descriptions without losing alignment or failing under non-TTY
  environments.
- Restricts uncore PMU bypass in event parsing strictly to `--cputype` to
  prevent unintended metric evaluation impacts.

v2 changes:
- Plumbed `bool cputype_filter` in metric parsing (patch 1) to explicitly
  restrict the uncore bypass to `--cputype`.
- Fixed output truncation on file redirection in `builtin-test.c` (patch 2)
  by guarding `get_term_dimensions()` with `isatty(1)`, and decoupled the
  format minimum padding from maximum precision limits to avoid hard-truncating
  long descriptions unnecessarily. Restored the 35-character headroom comment.
- Clamped `ualarm()` microseconds calculation to `> 0 ? usecs : 1` (patch 3)
  to prevent an infinite loop DoS if the float parses to 0.
- Hardened `perf_record.sh` (patch 4): used secure `mktemp` pathing, replaced
  unsafe `rm -f ${perfdata}` with `.old` rotation, and fixed bash globbing
  in the cleanup trap.
- Handled the JIT dump Python PID leak (patch 6) by injecting `os.getpid()`
  output to a `${PERF_DATA}.pid` tracker file so the trap can robustly clean
  it up even if `perf report` is empty.
- Avoided 32-bit `expr` math overflow in `stat_bpf_counters.sh` (patch 8)
  by ensuring division occurs before multiplication (`x / 20 * 3`).
- Lowered off-cpu `sleep 0.1` thresholds (patch 10) to 50ms (above) and
  500ms (below) for much higher robustness against jitter.
- Fixed a severe performance regression in `stat_all_metrics.sh` (patch 5)
  caught by the sashiko reviewer, where missing structural events
  ("Cannot resolve IDs", "<not supported>") were unconditionally retrying
  with a 0.1s penalty. The script now correctly parses these errors and skips
  before the retry.

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

 tools/perf/builtin-script.c                   |   1 +
 tools/perf/builtin-stat.c                     |  12 +-
 tools/perf/tests/builtin-test.c               | 110 ++++++++---
 tools/perf/tests/expand-cgroup.c              |   2 +-
 tools/perf/tests/parse-events.c               |  11 +-
 tools/perf/tests/parse-metric.c               |   2 +-
 tools/perf/tests/pmu-events.c                 |   8 +-
 tools/perf/tests/shell/jitdump-python.sh      |  76 +++++---
 tools/perf/tests/shell/kvm.sh                 |  61 ++++---
 .../tests/shell/lib/perf_metric_validation.py |  11 +-
 tools/perf/tests/shell/lib/perf_record.sh     |  52 ++++++
 tools/perf/tests/shell/lock_contention.sh     |  30 +--
 tools/perf/tests/shell/pipe_test.sh           |   4 +-
 tools/perf/tests/shell/record.sh              | 172 +++++++++---------
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
 tools/perf/util/metricgroup.c                 |  23 ++-
 tools/perf/util/metricgroup.h                 |   4 +-
 tools/perf/util/parse-events.c                |  22 ++-
 tools/perf/util/parse-events.h                |  17 +-
 tools/perf/util/python.c                      |   2 +-
 29 files changed, 560 insertions(+), 295 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh

-- 
2.54.0.1136.gdb2ca164c4-goog

