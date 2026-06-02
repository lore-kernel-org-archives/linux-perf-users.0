Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE02F8E9E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422099; cv=none; b=j9+vq1QfHreOrNgtASadHWhgnoX6LLpMDDlJjm0rx0QYLpAzljyKzi2roN3zJ4aNRj6rC2elQK9gDAIiCP/Uu4A44z9kWhS1evdz9XBuMarplQNKf2Njh/N5RRANYGwvkU7ka5UoR44WophqrBqQ776Ej2zfdtz8fYtscL+SoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422099; c=relaxed/simple;
	bh=qTRIIy/BBi1No3gsa5oABHwYZgWZ8sCc+3nRLjagYOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksBgHgFXhfN/7wYAS4u+045NUxDafGKNnYnUKIRV+TctNzMhfbb6hlSOLEWKbxQQ3zCVl4ZUVjEqabPpiMj7F9Y0JmTVcYBCSNtJ2u4piMVD75Pdqscs0m3072mtDMlOk8FVBRByzWHt8sYWCRi+3yOCAdf/QQ+SIuoS2yb5DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiW/bfCt; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiW/bfCt"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074797dfa9so784754eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422096; x=1781026896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QblJdW3Nct4UzChbDgOKKNkbXFKcF2fxNZ+hhqwkx4Y=;
        b=JiW/bfCtdisDwuJvkh98Q+JZKWfmpJlPGFIGiVTwbZQpM+3zfY8g7XG281Blw+Qp/f
         MXoY3h3uLhIpmQ69l3+/n9j8f+PhhiigV2GLK1JJDwrDYLBSd//G+DP6r/3rAw9IKoAo
         0KHguHaRTZyRlp/e40s5hhQ6Kfp2Pd2gpr/sGAI70mFehI6AeTWVwapW8UuLiNTuzIQP
         HtSA6YenJfGb/UY79K/ZnqKgXEmzbWWJv/gM7vefCiMQeh4PorZnRDy/04Qbc9CA8Tps
         OKDkF93039N3Ta048CPJDFBMP8QM5/VA31cgyPTQzY1SCYeRacwBr3gIYHvmt16XQm7U
         a7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422096; x=1781026896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QblJdW3Nct4UzChbDgOKKNkbXFKcF2fxNZ+hhqwkx4Y=;
        b=rcoNP1zoPD5KeU5avPFU7U7G6Ac2EhmkPRTUDYZI3KG4Kp1bs2IPgBUVyHz96m6NXE
         p65WSDlvFDKP4dAnnVVclYFFeD9OeGmlMc80mD3sHFTK1ix9jqXHL8WpaSW9sTQbNjGe
         rGIlxdvO9+KidqCM0UdMfPdq2DH6fTk5CRRnWBofbrtKe0IT1LoQSGaYl3d6qGRryHMS
         mPWtkal8RtHHvn5CWJDr7DKvQNVYe82k6tVvObRwPtYk8gDgqFMJJDcEqzpPmbGZxaMN
         dpOC2Jj8Suykpl4coMBrbfsMxEw5kLLBCWKLhsDwYn4vLyxGHgb++7UhYWG7Mkcnt+yD
         KPjA==
X-Forwarded-Encrypted: i=1; AFNElJ9zrlR97bH8wSavIJLO1J0UGi5VkZBPWiHaISK6tVBfS2q8Eh7P1E4zrnhk98JEa+YrALw3MK8TVDoduYw0+81c@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XYWzDkJl9X+IAk9xd1oGYOD+L6czDxNz5A6kedqIPxgmmTeA
	jRZh+q6ohTSJGQlEd6jIcJbWv8/HNBKffC0Ykag2gSVi6+dG5B96JLMo6r5kWLZwGLthcs1GvxF
	4yTxZLCNdcg==
X-Received: from dlec6-n1.prod.google.com ([2002:a05:701b:4286:10b0:134:b6e7:5d22])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b90a:b0:137:edfa:6f34
 with SMTP id a92af1059eb24-137edfa6ff4mr1707248c88.1.1780422096116; Tue, 02
 Jun 2026 10:41:36 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:11 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-1-irogers@google.com>
Subject: [PATCH v8 00/18] perf test: Parallel harness optimizations, summary,
 JUnit XML & PMU fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series dramatically improves the speed, usability, and test
reporting of the Linux perf test suite (`perf test`), and introduces PMU
matching optimizations. It optimizes the parallel execution harness,
introduces automated summary reporting, adds standardized JUnit XML report
generation, removes runtime external C compiler dependencies for continuous
integration environments, and avoids unnecessary PMU scanning.

1. Parallel execution optimizations:
   - When running in parallel verbose mode (-v), the parent test harness
     previously only polled the pipe of the current active test wait-loop,
     blocking other children once they filled their 64KB pipe buffer.
     This series refactors the loop to drain all children's output pipes
     simultaneously, reducing parallel execution times for high-output
     suites (like PMU events) from ~35 seconds down to ~5.9 seconds.
   - Hardens `check_if_command_finished()` and `wait_or_whine()` inside
     `tools/lib/subcmd` to safely handle invalid PIDs, using a robust
     waitpid fallback when procfs limits are hit to prevent zombie leak
     loops and PID reuse hazards.
   - Fixes race conditions and concurrent process reaping hazards inside
     the Intel TPEBS driver (`intel-tpebs.c`).

2. Improved Console Summary and Output Layout:
   - Shows context failure snippets for failed tests in moderate verbose
     mode (-v) without requiring extremely verbose output (-vv).
   - Prints a concise, colored console execution summary showing passed,
     skipped, and failed counts for main tests and individual subtests at
     the absolute tail of the run, together with the indices of all
     failed tests.
   - Dynamically truncates long test descriptions to fit within the
     terminal columns to prevent visual wrapping and duplicate printing
     glitches, while ensuring suite headers are printed without trailing
     padding that causes wrapping.

3. Automated JUnit XML Reports:
   - Adds a `-j/--junit [filename]` option to generate standardized XML
     test reports, capturing execution duration and XML-escaped failure
     logs or skip reasons for each test.
   - Includes a dedicated shell validation test validating XML report
     structure via Python's ElementTree parser.

4. PMU Events & Monolithic Suite Splitting:
   - Generates dynamic sub-tests for each PMU event metric table instead
     of a single monolithic sanity test, enabling fine-grained tracing.
   - Splits the monolithic `util` test suite into independent sub-tests
     for easier failure isolation.

5. CI & Environmental Hardening:
   - Removes runtime dependency on `/usr/bin/cc` inside the Intel PT
     shell test by introducing a built-in `jitdump` C workload that
     generates JIT self-modifying code natively across x86, ARM, RISC-V,
     MIPS, and others.

6. PMU Core Matching Optimization:
   - Treats "default_core" as a core PMU name in `is_pmu_core`, avoiding
     slow and unnecessary scanning of other PMUs which always misses.
   - Documents different types of core PMU matching approaches (x86 cpu,
     s390 cpum_cf, ARM sysfs).

v8 Changes
----------
- Treat "default_core" as a core PMU to avoid slow and unnecessary scanning of
  other PMUs.
- Dynamically truncate long test descriptions to fit within terminal columns
  to prevent visual wrapping.
- Remove unnecessary padding from suite header prints to prevent colon wrapping
  on newlines (resolves visual glitch in `perf test -v`).


Ian Rogers (18):
  perf tpebs: Fix concurrent stop races and PID reuse hazards in
    tpebs_stop
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
  perf pmu: Recognize 'default_core' as a core PMU and document matching
  perf test: Truncate printed test descriptions dynamically to avoid
    terminal wrapping

 tools/lib/subcmd/run-command.c                |   69 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8821 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  847 +-
 tools/perf/pmu-events/pmu-events.h            |    5 +
 tools/perf/tests/builtin-test.c               |  788 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   82 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  210 +
 tools/perf/util/intel-tpebs.c                 |   92 +-
 tools/perf/util/jitdump.h                     |    3 +-
 tools/perf/util/pmu.c                         |   19 +-
 16 files changed, 7619 insertions(+), 3729 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.1013.g208068f2d8-goog

