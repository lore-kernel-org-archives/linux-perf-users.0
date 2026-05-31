Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93E2BE033
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205267; cv=none; b=QvcQZ07+kMLR0ds+AoI0dyZDQTqZUiY1/EuY3fuWwB/Qm2svKVKBkcqBriF9E1kbxMUNOYFv6xR+duTVTzkRDSLDbJN+tjIaGHDG374wky5RuuXvEHTUfbNofQEfwDJC04j3e4Ztt5l6aDrmKdFnOHJ72+i4qs65YPRC+TUVVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205267; c=relaxed/simple;
	bh=9BGcmY6VDjIJMTOYIraIkPRa0Ps95nCZsZptlVI/Iek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNu39Dg4pJRrptgbc0TnAldPYtU9XA7kVvBqkFNHpDdQWOy46UOKp+wWuUvlsto3l3afBguZJJ06AvJlVox1CQDzoaBT0buF+6+D2Oh5Pc8UEYm6giydO4UP2qanSkgYlFNIXo/EC4AJs7KUUlEB8jx5kDsrtDWyngxPkekQQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2hGbZJc; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2hGbZJc"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so9515789c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205265; x=1780810065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdtFyxCHwgknB+Pk1VMAOCCEFL0LcAi/7xnFlLEK+gw=;
        b=U2hGbZJcgUUh6pcuzDX9jz3qQiRhFX067dlxA1d0yLTRkFjCBxSLwLt6VIXRwuZMwd
         a1GtLASPbt5k9XVSVfl32Oaib8Zn4WpXHyyA3Fuot3CypKyd0Pk96dHUmCVu4L9mW/2e
         qclBXXVXxw30tG26rilt6FeqZVY9HpLIIj+8k+WD5K2tND7eUPH4xCeMK8XVT7E9Z/8b
         BkVQFDfuCGYtYjizM2n8RxhXi8z8HHgRV4ogGFdUxge5Sxp4zzwpEaMqhCZqsNHg2Q0t
         is6TCfHjgdygcJxmxwBbmkDUzsfcCcy1qCmM3Mw2a5QMCIxJ10KxvOovPREd9m4esm+U
         jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205265; x=1780810065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdtFyxCHwgknB+Pk1VMAOCCEFL0LcAi/7xnFlLEK+gw=;
        b=ovVbXMuXdNS+ovSGEDetDwJ9y9/Bx3iovDZy+wJkplGe31MAy6aq9VM4O8KLgTKsTf
         Qkb1aOJZDbsL8lIzEdcj6wHqJdALuJD3CxBH6nPFyAnukVUG5ZOxmPqcOGY7p++SnhYN
         EL4HZuXwTS2Vwg9FdFKuC/mw2f2PTxpEjY6GZsgiDEU5eG7pBqA9zQpjN21BZR7z6FGc
         A2MS5zmH06gsTFOifCfaLWBlws3AtjTMU5HoOlUfiH5VyhtznZjN3AZFWTDrJKK8mC7x
         27JgI23NJM35CiZ14KAdJbL/iZpQABwBLcGuGS0xAXuUHNCL78YS+paxg85vODiXPrCR
         KRgw==
X-Forwarded-Encrypted: i=1; AFNElJ+4lr+ORSgMchjNsXTJu8Mv3cBdve42HKxHf/WxafsiTlufrSoCJwKZWf0pfZhUZxPwGzj/WH4U2GIk+s2DtT7N@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmxVEaptWrz69LknrQbYmAC0a5YJ+MdBfM+AnQJDAwoVha6P3
	8y6pGE1mXvPoKhvFIw3uhV/EDp7ms19X8VMOPjMo/kWjPyihl69lj45f9NCCj8xsId8GTmOxlqf
	I+f2SYDKyvg==
X-Received: from dlan21-n1.prod.google.com ([2002:a05:7022:eb55:10b0:135:5b92:ee65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50a:b0:136:90d9:f1fe
 with SMTP id a92af1059eb24-137d413a20cmr2605005c88.26.1780205264960; Sat, 30
 May 2026 22:27:44 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:26 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-1-irogers@google.com>
Subject: [PATCH v2 00/14] perf test: Accelerate parallel test harness and add
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

Changes from v1 to v2:
  - Addressed memory stability regressions in dynamic test suite setup
    callbacks by enforcing strict boundary and allocation checks.
  - Mitigated pipe and harness deadlocks under heavy parallel and RLIMIT_NOFILE
    exhaustion loads by integrating robust `kill(pid, 0)` existence checks
    and enforcing immediate close-on-POLLHUP semantics.
  - Eliminated local privilege escalation and symlink-overwriting vulnerabilities
    across JUnit XML and JIT workload file writers using `O_EXCL` and `O_NOFOLLOW`
    configurations for shared writable directories.
  - Upgraded JIT workload multi-platform coherence by omitting hardware-clock
    flags on system-clock architectures and integrating `__builtin___clear_cache()`
    invocations to guarantee Instruction and Data cache synchronization across
    ARM64, RISC-V, and MIPS environments.
  - Improved JUnit XML format compliance for user-skipped and overridden test
    harness requests.
  - Addressed signal re-entrancy deadlocks on heap allocations for user-aborted
    runs.
  - Eliminated literal `"NULL"` string emissions within C source maps generated by
    `jevents.py` for unmapped core metric tables.

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

 tools/lib/subcmd/run-command.c                |   14 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8809 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  835 +-
 tools/perf/pmu-events/pmu-events.h            |    4 +
 tools/perf/tests/builtin-test.c               |  634 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   64 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  191 +
 tools/perf/util/jitdump.h                     |    3 +-
 14 files changed, 7265 insertions(+), 3701 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.823.g6e5bcc1fc9-goog

