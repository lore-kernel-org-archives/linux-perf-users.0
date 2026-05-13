Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9E391517
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713508; cv=none; b=cwx52RX5fDoZmfY0+YEKkDYBjtHpnY12WJUW9zamP/Ecvr46/rtETKm7omBngzOE+/hMxT9qvWDnipBmzvECQBVJCpiCDFN6B0OnLb/ceFW1mfAGzjC7fRfbnC83vDvotwkCH0c3b9hLZ6L5GCPVa/uRhOIyLbunTlSUanS6Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713508; c=relaxed/simple;
	bh=GZvFazjDYAH/AT1v4roRbbTZDOWOk70PZGUJC32f6Fc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jEorTGjWrvTT3EmdXzUx0rL67Ugvbt0jXQTV8qYbrRPqT2RoIz60k9GA3bq8THAmxxPOm6tS7Du5IxWo0fjWmROKwcrzact5+kEyBLxZq3I6n1xO4aT58Q6gzyZUgFpnKZEv9mBFIJ6aiHv1GtECR6Yiw+P1X9ccsAICflfDq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZwnRFiL; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZwnRFiL"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132a99125f8so14095903c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713504; x=1779318304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1k9QJTTTdCz9MAZlOHTk1Uo1eShkz+WNRds0QDSNJ2Q=;
        b=hZwnRFiLaFkJGCyg+hhHJ51jROql0Vd/kL1s0nMPFn6AcC5/iLrmeRN9sOFICj+faw
         +fGwEpdlCWvEoXX+NRCn6HFC7dDKIoZ+M7Z4wXhsa0XFoh4qz/ZwVq8DX92+MqljTq1h
         3civSnXAYLyC6VjkSb4RoR2PsgTTz+hof7P/zQj5DbMQH7VQISGOL5D1O2D9NuzI3Uco
         a/8sajQhG+riTBWmNgiluj0DoeO9rdD4e9jNuaILZnEXIJeeCNwk2cUVegRXr9goTgTK
         X+W/f4c01Ai26dyDwEGxgGXlY96782dAZj8oD/pn3JF0hWLA0JQ4bmaisEAyaof3stt5
         ogqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713504; x=1779318304;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k9QJTTTdCz9MAZlOHTk1Uo1eShkz+WNRds0QDSNJ2Q=;
        b=Y3/nbJgSGW6FmGzpHbGivd7z/aUOHQFG5dWBpjoaAqN8XADdiD0kQIDgzFpp4TRy3t
         PABqFmwc4b+oKFzpiFBTRFgaw7DY9apsfTs8S6L1IQR0SwQNSpgd16GAVDAbrusOt01v
         Qi3zy69gPPoG449PQP5L01Xaj+hTuVO6HflmeBZ/0R0TyMEi+91el2/HjoqlWU8JvR4C
         k+/NZz3ZPxuTvnuz9UYcCPdgzPfeDZY6M2xkkGIuoBKwKO1hhn8I+29YZbFG/e+Ib9b9
         sp+0ma0mOmyhE8myKb0VZ4RRKNlfKw28abc/aBF0OqwSWceGunK+LAra4HW67H/ndPxv
         Y6Qw==
X-Forwarded-Encrypted: i=1; AFNElJ/uNauHNePzKkX3VkRxNyH6gTtuXfmRX+hnzen0IuxDCnqcfJar6+cydW42kSZDeaxRJ07YuoWEYGzA0f3w3VPp@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTJYZUEoqsQRUMxx5f7mcW05AD1nQUkHHjRpxiZinhw14eKgx
	IpFKqpyuKGwwsOhxT04fLlf+3Z2iOCZpMR4zx10bzgu65DBlpI5pfafaQXF773yD37rb1ab41Q8
	lac1CME/a+g==
X-Received: from dlbdm5.prod.google.com ([2002:a05:7022:6b85:b0:12d:f5ca:970e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2523:b0:130:ab68:2b6f
 with SMTP id a92af1059eb24-1342ee4217emr3322299c88.9.1778713504124; Wed, 13
 May 2026 16:05:04 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-1-irogers@google.com>
Subject: [PATCH v1 00/14] perf test: Harness improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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

 tools/lib/subcmd/run-command.c                |    4 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8811 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  836 +-
 tools/perf/pmu-events/pmu-events.h            |    4 +
 tools/perf/tests/builtin-test.c               |  587 +-
 tools/perf/tests/pmu-events.c                 |  155 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   63 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  165 +
 tools/perf/util/jitdump.h                     |    3 +-
 14 files changed, 7187 insertions(+), 3697 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.563.g4f69b47b94-goog

