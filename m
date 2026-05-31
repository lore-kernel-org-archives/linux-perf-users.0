Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB465548EE
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209471; cv=none; b=IMtjOm9wpNTXQn1+96NTa2FTE8g1xUy7S1tDNk9mid6jqRIZ0x9b+r4i12QaWSaqdnWcb4f2gMLuA/jteQlAAbBVetqceT+CziqUH1qiw+2ryrYuXziUAoE9Q215kDI1KNCBa7EA1XyGsUwfte0DxLV9NMhoNi7cG70KSKHp57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209471; c=relaxed/simple;
	bh=UOfcgNU1zyAR7ezao6eX0vyLNnjz+jtEUHHpyKIIcSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNkKxGF+lsTxxDYvo2xkj6mkpwfGqoqshDXD65ExIB3sgLLfJ5fbfE2xsAuRvlN5GxXHsXiJmAWOm3JIF4Pwp+t/8eQQEH6PlRSoSmndWxdop02hxgeAkd9VmeW/JIH3yskoCM3iAMCL3O7LJGpx/Gl0Mx9TOkXPOAAo+t4/35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZ5LhEQw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ5LhEQw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84235f9b91fso399669b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209469; x=1780814269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=As7AfS6LTMYBHS643X2nvZmXmKoX2vXgIl6kKlp8hd8=;
        b=QZ5LhEQwW+W4H27n3MPF/A16gJno+Kiotu7OMiTW8TwQLTbV9nZEqwvcZw1exykGSC
         04JlpO5dOXZeuEnpSaMjRr86TaODj1DbrUdNDhPcrBWuU/mCC63uodePXUsAJeVDqUkl
         Koeyrth3qCctFB+aTQdSX/VEaVwoZkhgvIdlZ+z9esb2YFaKZ/5rB11O4fwh5ONg1hJL
         QftOihC0Af659Ds3JosBXl4SktZqu9Meff/rvdCIgLPQrHr8hugjpC5Zp6yVm5/RdXv1
         r89mW9DDZSc2EOuYmaAFMEvEtz+fAbwu3KWe148sNbEnQOAZfhsZ+p+0e/AhaElVyjym
         BQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209469; x=1780814269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As7AfS6LTMYBHS643X2nvZmXmKoX2vXgIl6kKlp8hd8=;
        b=IzpydP7oYkzOGKk4piel/495i6ByR6xSEGIdMJLLOnj7CFFmrwXsngEQTh1AqH6ovn
         te0hVTJOooT/b9i3WSRtC0fnEEhUcsYBmlNDy16AuSAg9T0zVOMcg3eM1IZOfNRbMRGN
         ikMHUbB6xvxO74rA9S3MXkWSAZVE1YwOr/29WPhIWw6g8ys6Mkvo1QLjU4jkzVGhcoOM
         qahtMb7+GAMMLcyGrmYCEbAHmbceEATAxyK28LLnyY26eDwD0ko8yHJa2H6FwxjuoOu5
         maudW2EoCWOpMTQKDXOYB6ryrSanxKs+K2RpQQBJf0jDH2zg67RaADvwpxuOEWtVjKhQ
         em6w==
X-Forwarded-Encrypted: i=1; AFNElJ8LEuekr1Wd7YNjO6rGPlslAeb63yvM4rQdAlGatGdu+KLj13HJ5NL9rV1vSfwStilp99DRZ8H4tC87Glou//yU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd64YKMO/H2v4ijcVldjA0oIAnQCmSwHvbf7Ehw9Hy5I47FQrB
	u7HiMLamRrBZ1XwYwN0+AE4SZCwidTyvEs1r1PGDqo7EvSU7VG6GOljG1Pwnogx9vJ9JA1c8upx
	Ys5LOhghULg==
X-Received: from pfbgd9.prod.google.com ([2002:a05:6a00:8309:b0:82f:b296:c01b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3903:b0:842:2382:a0ea
 with SMTP id d2e1a72fcca58-8422535fc9bmr5455360b3a.14.1780209468820; Sat, 30
 May 2026 23:37:48 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:22 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-1-irogers@google.com>
Subject: [PATCH v3 00/14] perf test: Accelerate parallel test harness and add
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

Changes from v2 to v3:
  - Unified generated C code `/* clang-format off */` and `/* clang-format on */`
    pragmas within `jevents.py` and `empty-pmu-events.c`.
  - Patched format string vulnerability warnings in `scnprintf` within `tests-scripts.c`.
  - Prevented signal re-entrancy memory leaks and deadlocks during aborted test runs by
    tracking parallel poll arrays within static global variables.
  - Corrected tail-context log picking order and bounds within `print_test_failure_snippet`.
  - Upgraded `xml_escape` and `write_jitdump` pointer and size argument casts to satisfy
    `unsigned char` environment constraints.
  - Implemented deduplication support for metric tables in `jevents.py` output.

Ian Rogers (14):
  perf jevents.py: Make generated C code more kernel style
  perf pmu-events: Add API to get metric table name and iterate tables
  perf test: Drain pipe after child finishes to avoid losing output
  perf test: Support dynamic test suites with setup callback and private
    data
  perf test pmu-events: A sub-test per metric table
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

 tools/lib/subcmd/run-command.c                |   47 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8823 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  849 +-
 tools/perf/pmu-events/pmu-events.h            |    4 +
 tools/perf/tests/builtin-test.c               |  633 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   66 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  188 +
 tools/perf/util/jitdump.h                     |    3 +-
 14 files changed, 7323 insertions(+), 3702 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.823.g6e5bcc1fc9-goog

