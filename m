Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9A3446CE
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294491; cv=none; b=k2EOmXWCgXQtMhcJ9TqAf0vRCFbBA4Dukw/HA894PxccGWwEHCTvepFq3mHt2vLC2iXnY98aoNyWq0MldJ8t6BeepO7i9/1k3JhRXWEAvXOV39iyZfcWB5OsYzL2p4nDeOzRpXVKte6FLXcDCHFk4yEPnrDBzMijb43v5fOkDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294491; c=relaxed/simple;
	bh=xOhy3Zwy9VJeVCgnVoG4a/FKf8Spl/+v2eUdyFndX3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MAYvZWKXonFLD5V/pylxw7vHWpmFxst435LOGfUEOSTmL8F1H3U7XvYPFygDy/yKMi9laQEZNJebZ30lGPJWoadsootlJu9xCwToh9wb23JEUUxG+yepb9hB8ZYMMgDsbpmRKRQAsf95hVG+nsZ7JgkxvV/zyngffwAVDuYK2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gC2N9WP2; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gC2N9WP2"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5171feso1539156c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294489; x=1780899289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=36LSgHAsJdVYAIyq8Y6vVCV7P9YqtI6Wtf8w7yvchMg=;
        b=gC2N9WP2LWJrd60NIjyrZSuhIim+PY43rxE4apYVSkTl8mX1QLPlmfftyvDyThSEXR
         h7Tv44rWd9zet1znXNem599y8DZaSlcvhQKT3snHnZCHJ+Aw5JMy72z4GXJy7Hm206sm
         7rx5/TOu3sACjCkIJ4olcAvOI4FBMXvcIlFZ7vJ30y07aeV+Saw+j9mQLT7xaMhSNxHf
         riHriUTXz98nleRuw2dVqFIYepqHBIgFGCbBxtUwfHba6PjQb0+S1PLOO8ne/I5N5Cq+
         UaChDuVmCZu2UpVGQeBFaKrUaZq6b2Cf3egXY1x4UYqxBBVINvBI3+D44nSRxwlp77+f
         rJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294489; x=1780899289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36LSgHAsJdVYAIyq8Y6vVCV7P9YqtI6Wtf8w7yvchMg=;
        b=fEp08Ng0ZxpRCiACJTTCLlU3SEexrvF06uJonOezNPp3Zbh1mL94jBdjbK277WZXd2
         k+AQn/TwBoRZ3VG3QHJlNv2fCd9CS9PbSATIl+AfmHcmMQ6gFc8BaGg0xP9KAkhnE4BM
         Jfb5oVfezhcHSc2VWRU6tv9BG3JlvytKtxjYvh9hTa/O8TSCPfVzfszTvfzhY1gJjXv5
         NCqdWGnLgwa0AsJPMXMOQqUn1MNu1ry11u/SmZwID/v95xX7P/Z299uKyKRv3F75GefZ
         JtQzwyiSwWZu/Ib3PS+llpI7J3FtVqcG5I4ruGTFQu3LXdB0OF/Oe+3DQtUaevIxUkJR
         8HtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hNfWgfIfuGdtCjY6MltgOuJpAQYAi8lTq2WUX93+psUNGFiiQE/55E5lx1yN1qh6P5sTLlm1820r8EOiJm0Ru@vger.kernel.org
X-Gm-Message-State: AOJu0YwwygRpamBmnG33LLPB5Vk2k21awxejGHGR75O0eRHPOQXay6Ck
	5pPvO5gr4hbZlaifViaM8WkD8/kOITlxl7D2YONF+T78vvkeAhYKRGPFAJEvC4FfsyNn36p11Dc
	kXpE4DlZEOA==
X-Received: from dlaf6.prod.google.com ([2002:a05:701b:2406:b0:136:88ed:65ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa0b:b0:11a:342e:8a98
 with SMTP id a92af1059eb24-137d39c9db0mr3224282c88.0.1780294488511; Sun, 31
 May 2026 23:14:48 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:46 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-1-irogers@google.com>
Subject: [PATCH v6 00/15] perf test: Accelerate parallel test harness and add
 JUnit XML reporting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Motivation & Key Enhancements

1. **Test Harness Acceleration & Parallel Polling**

   Previously, when running tests in parallel mode (`perf test -v`),
   child processes writing massive amounts of logging output to pipes
   (such as Granite Rapids PMU metric parsing) would saturate the 64KB
   pipe buffer and block indefinitely. The parent harness only polled
   the pipe of the "current" sequential test waiting to be printed,
   causing severe execution bottlenecks.

   - Refactored the parallel poll loop to drain output pipes from all
     active children simultaneously into dynamic per-child buffers
     (`struct strbuf`). Reaping occurs asynchronously out of order,
     while final console printing remains strictly sequential.

   - Added explicit pipe draining after child process termination to
     prevent losing trailing log data.

   - **Benchmark**: This drops parallel verbose execution time for the
     PMU events suite from ~35 seconds down to ~5.9 seconds (an ~83%
     reduction in latency).

2. **Dynamic Test Suites & Granular PMU Subtests**

   Monolithic test cases (like "Parsing of PMU event table metrics")
   previously evaluated hundreds of tables in a single sequential run,
   making failures difficult to isolate.

   - Added `setup` callbacks and private data pointers (`void *priv`)
     to `struct test_suite` and `struct test_case`, enabling dynamic
     runtime testcase generation.

   - Split the PMU events metric parsing test into individual subtests
     (one pair of real/fake PMU tests per metric table), allowing them
     to execute concurrently and report granular results.

3. **Advanced Triaging & Automated Summary Reporting**

   Triaging failures in highly verbose automated runs previously
   required scrolling through thousands of lines of console output.

   - Introduced a smart, configurable failure snippet processor
     (`--failure-snippet-lines`) that dynamically extracts root-cause
     context lines matching failure keywords (`error`, `fail`, `segv`,
     `abort`) while preserving outline markers.

   - Implemented an automated global execution summary printed at the
     absolute tail of the test run, presenting clear pass/skip/fail
     totals alongside an explicit list of failed test cases for
     effortless cross-referencing.

   - Fixed subtest status column alignment (`: Ok`) for multi-digit
     test indexes.

   - Updated shell script SPDX header parsing to prevent license
     strings from being incorrectly extracted as test descriptions.

4. **JUnit XML Reporting & CI Integration**

   Added a `-j`/`--junit` command-line option to generate standard
   JUnit XML test reports (`test.xml`).

   - Captures individual test suite and subtest execution latency
     alongside XML-escaped failure logs and skip reasons.

   - Guarantees absolute timing precision and immunity to wall-clock
     jumps by measuring durations using
     `clock_gettime(CLOCK_MONOTONIC)` and harvesting `end_time`
     exactly when child processes exit to insulate latencies from
     out-of-order sequential UI printing delays.

   - Added a standalone shell test script to validate generated JUnit
     XML syntax using Python's `ElementTree` parser.

5. **Elimination of External C Compiler Dependencies**

   The Intel PT shell test (`test_intel_pt.sh`) previously compiled
   external C workloads at runtime using `/usr/bin/cc`, which
   frequently breaks in hermetic or minimal CI environments.

   - Created a built-in self-modifying JIT workload (`perf test -w
     jitdump`) and switched the script to use built-in workloads.

   - To guarantee robust multi-architecture compatibility without
     external C compiler dependencies, the JIT workload immediate
     instruction arrays dynamically encode `CHK_BYTE` into opcodes
     across x86, ARM32, ARM64, RISC-V, PowerPC, MIPS, LoongArch, and
     s390x, with clean `#else` fallbacks for unsupported
     architectures.

Changes from v5 to v6:
  - Addressed advanced signal-safety, race condition, and memory
    allocation edge-cases flagged during LKML review:
    - Guaranteed zero output loss upon signal interruption by securely
      merging and draining all accrued per-child stderr data inside
      the reap recovery block.
    - Switched the test harness from `sigsetjmp`/`siglongjmp` unwind
      operations to a robust, mask-free `volatile sig_atomic_t` and
      `O_NONBLOCK` loop-bail architecture, eliminating all risks of
      process-wide `SIGINT`/`SIGTERM` signal mask leaks.
    - Hardened testsuite shutdown to immediately `kill(SIGTERM)` and
      `waitpid()` reap all active children, eliminating multi-minute
      hanging stalls and double-free hazards.

Ian Rogers (15):
  perf jevents.py: Make generated C code more kernel style
  perf pmu-events: Add API to get metric table name and iterate tables
  perf test: Drain pipe after child finishes to avoid losing output
  perf test: Support dynamic test suites with setup callback and private
    data
  perf test pmu-events: A sub-test per metric table
  tools subcmd: Robust fallback and existence checks for process reaping
  perf test: Refactor parallel poll loop to drain all pipes
    simultaneously
  perf test: Show snippet failure output for verbose=1
  perf test: Add summary reporting
  perf test: Fix subtest status alignment for multi-digit indexes
  perf test: Skip shebang and SPDX comments in shell test descriptions
  perf test: Split monolithic 'util' test suite into sub-tests
  perf test: Add -j/--junit option for JUnit XML test reports
  perf test: Add shell test to validate JUnit XML reporting output
  perf test: Remove /usr/bin/cc dependency from Intel PT shell test

 tools/lib/subcmd/run-command.c                |   51 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8823 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  849 +-
 tools/perf/pmu-events/pmu-events.h            |    4 +
 tools/perf/tests/builtin-test.c               |  685 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   81 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  188 +
 tools/perf/util/jitdump.h                     |    3 +-
 14 files changed, 7389 insertions(+), 3707 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.823.g6e5bcc1fc9-goog

