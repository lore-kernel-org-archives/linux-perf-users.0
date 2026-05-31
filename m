Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7572F3C3D
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215771; cv=none; b=a3MZrulbKuThaIWA0jjBlrK5LM4b/tzJwjKo2+gCCoxLA7amTNabG/LbBqJQXhKQ+Pm2femKTjzfjwNosTQJwUU76ZWtowncbVfTmGgyLnbWftXSVsOWSt1FmGuLzdTj1texoD2yhq6Vl7ZDKsuw6SZX3X9W5SKTtFd1rPpiSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215771; c=relaxed/simple;
	bh=GNRnC+RLQskZVZHWSJ1GGjvl1rqw+S6vl48iG3/GUD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tadWOjo8AV6JEKe/khVcmf89IXF8eoIgMhcPyKTZhjFi030RSQDec4H4bQewDo3XifUwqqNQHrvPBvsfgblOrXuxjnFGRqMMeYgGenR9tCwJcD5qHM7QLlN0CCrEyYbBn0n6/zhJrFYjHTJpWpB9jwO8ZtqLhYtVT0GsEZ10F54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxZf/6aH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxZf/6aH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1370417c0bfso4893048c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215768; x=1780820568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Iw5BaLCmUp/iRhMNOGeTqy70Vt3wjszO5cpfChLKc=;
        b=jxZf/6aHwtAYV74I/FLDnQ8S1ft5yyePhSQ8Q2OpNognkT84FW8xej4vI1BMTHeH15
         CHlYAA3fSRBe3ujUEZj3PtVRpuZTLFkJtFT+88rIkmObcH6C/bhx8T3pqFrOPUHoPg13
         TdGTKlEeI4pTcvNd9K9o0ckG9Nm9adTzbWPjFM4vOznn6D2xceZIg2bueAzENNIpLNf7
         ibymd7D+HX76CydUwPzEf5Kmp5oblnegO6bSrZAQG5XhJTCa914WPr/BECHYHNXMkE1M
         +MuSoKFsl3+IHa6TIinFW7Xlt/abK0St86rWnq6Ge9n4QFldBjBinjxFNIot703VTRdw
         19Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215768; x=1780820568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Iw5BaLCmUp/iRhMNOGeTqy70Vt3wjszO5cpfChLKc=;
        b=lc4hsmXorWUcb+Q4r9sZTEttUU2jVcGsP9Xo/NdLp7b/SFqZ/M9RniCW937pk2HP+Z
         PBwkaxuCv67xkeMqGAlK/rVZWSJI5u2bP2ZBcbvIs5ZlMqXYEGTwJb9K3G0Hjo/ijZFV
         k7h7OeXqMtKhXq7W2sJX8D5nOW08TekFkHR0HUegi5NKQl961zO8OnAKpYA8cSjUq6Vw
         t/0nFXtMC6nqEzxToPlXL0xbeVMufvqU4QnjVpO9Ta4tr5q5nPBqj4FVzQHVrqAUTSCA
         SMPx8xjyEbvB+67gacB4D5TbxTtWxoEEQI3uzsi2oEuE0G3kq+SbI64npIE0SLDaDcHx
         d//w==
X-Forwarded-Encrypted: i=1; AFNElJ9TZ/nhFzfpBrnsJAkGmwet7iVPKFVHMm6Buu5RE80bsUW6gk1uBnwPS1DWFFB5SywPbueHkaMb2XxyOZnc2XAX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CRRFSdu3pv112OLlWACaiDJhUBa13vR23wX3Pk1Bp+D2jdIb
	PjMMOil1kV5AbvdorWvnuweu4H3dupK+8rRizba9ifmqYc1NgFn/fSH0veFrNXMC2me+pjOKyWL
	5amNwcuXITA==
X-Received: from dldnz9.prod.google.com ([2002:a05:701a:ca09:b0:136:420:2090])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eaca:b0:132:1e00:f6e8
 with SMTP id a92af1059eb24-137ae85944fmr3624783c88.14.1780215767582; Sun, 31
 May 2026 01:22:47 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:20 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-1-irogers@google.com>
Subject: [PATCH v4 00/15] perf test: Accelerate parallel test harness and add
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

Changes from v3 to v4:
  - Extracted libsubcmd robust fallback and existence checks into a dedicated
    prerequisite patch in the series.
  - Added robust string null-terminations to readlink() and fortified append_script()
    against stack overflows in tests-scripts.c.
  - Eliminated superfluous unsigned char and if (!err) signal abort blocks, maintaining
    clean test failure execution summaries across Ctrl+C interrupts.
  - Permanently removed line_contains() at the root inside the commit introducing it.

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

 tools/lib/subcmd/run-command.c                |   50 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8823 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  849 +-
 tools/perf/pmu-events/pmu-events.h            |    4 +
 tools/perf/tests/builtin-test.c               |  633 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   81 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  188 +
 tools/perf/util/jitdump.h                     |    3 +-
 14 files changed, 7335 insertions(+), 3708 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.823.g6e5bcc1fc9-goog

