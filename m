Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED873314B7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385504; cv=none; b=Lm/MSsXzjSvwepM3YQQ5qNcfhVZ6Ij3KCpgO3Lm0QManwnlucfax8YvkVvtp5PPuj2LoD8ACIashAOPxsZGbnEyn6gl1rlx28nCzp+6Noi1XXyJkJrcMIzffZIneL7ZcFMq7OWDqJKYGUX5LgwrT1GpgX2ojtllJB6yFL1C3gjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385504; c=relaxed/simple;
	bh=LiECuO4TB3Fy5kXJYL2idpfZ9VAw40n0M0nbNh5kdkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDLtMAUaBn/ZSIphV8xft8ZbSACcf77kdYaWvZfo7XAriVQfbx+bmuF59/s4X6my2qwR5m6wXM8t5JJke6k0/eKeiZzpgAstg85uPlzO5NbOeXJDu0nfMbY6oFchkwqKtEkvKjWeuOFBfsmlD+FNX+ddSDzl5HQ+A+OX4WYIvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDhVZ7pX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDhVZ7pX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ee7d1368so3900839eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385499; x=1780990299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MsEKwJ1Jnl6seXhMY8Ru02M3gLXDV1li4tDHf02eSg=;
        b=rDhVZ7pXDUYK005qBdhovpgxz0MpOM8ug7utCV0hV0U+vrxf+GOrU0e2l46tEx2Qkd
         CwHlzN1chyILbk/ACcFoRXBJzXvfR1EuUhBhws67QgLQtWC2URqBNM8cU2Ef5bryL0Bx
         skmiZO3vTl/9nUd0xwq3NYqvBEQdGNV9PFyVb3VnCDULNQm7Qoy7wG7KD75v6UaQestP
         ikv4liNOXhxVmLzakgxp/4Z9Vru1KI3SX42KowTV2SkCAqTgBhrnSmm0Z8jScddXKVyk
         Y+oxhtMc7ROPEKZC39ErwsZXJGOv7V8mrCcXl8exD6MIjEeVShoe7NM8SpWSthbT+rfb
         Qg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385499; x=1780990299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MsEKwJ1Jnl6seXhMY8Ru02M3gLXDV1li4tDHf02eSg=;
        b=sAXnazK9uJAZVc65Etfbh8t3eMZcQseEt5MWfDt4h0U3hehjm5LTHp/QxyIpkkjrL0
         0rs0wlrR8zuP54sDkVkyo3p9tLSSYaBP64ObU0VuJWjhLm8Va7qpzgtbgYbKZY2ixdVc
         Fh/mc5CjYHJeAXKN7PrXVH0jMGdui47DDFulmp+lbIsa2R6tPFSfG2AR4gCDgthqJvo/
         6hGS3PO6H8OjJVyViTTziHmOt9HjCHyetCG6puf6QRvrZklnuSznbRd4LAmP9gZ3bzDw
         qoB914piI/U23W06Z3OXHfSpSpGLS49KdEEZxw9mJNT/7emeo2+aoI8kQ41R4Xo0LU3t
         HhCw==
X-Forwarded-Encrypted: i=1; AFNElJ8JXJa31bgWpUfAS87l2CBDEsSCaJcnc/77VZ5UNZrkfh90AB+iReIT22TxZ1abhYkz3APmnMp3UCI9ZSVCUQe4@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdGG52IshLllGwc+uZO9aB+et7DjlzQYQIZ8BAMHbYieBzBRi
	djwjQB5fltLzztAd5rg2JswvJo8ObSgMKPy7WzLf2CqpZA9QhLWBVutBuh/pKz2mJ6iXA69kLZY
	pql6ekkyexg==
X-Received: from dychy7.prod.google.com ([2002:a05:7301:85c7:b0:304:e502:fe2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:514a:b0:307:34f9:cc9
 with SMTP id 5a478bee46e88-30734f91430mr779320eec.2.1780385498499; Tue, 02
 Jun 2026 00:31:38 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:15 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-1-irogers@google.com>
Subject: [PATCH v7 00/16] perf test: Parallel harness optimizations, summary &
 JUnit XML
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series dramatically improves the speed, usability, and test
reporting of the Linux perf test suite (`perf test`). It optimizes the
parallel execution harness, introduces automated summary reporting, adds
standardized JUnit XML report generation, and removes runtime external C
compiler dependencies for continuous integration environments.

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

2. Improved Console Summary and Failure Snippets:
   - Shows context failure snippets for failed tests in moderate verbose
     mode (-v) without requiring extremely verbose output (-vv).
   - Prints a concise, colored console execution summary showing passed,
     skipped, and failed counts for main tests and individual subtests at
     the absolute tail of the run, together with the indices of all
     failed tests.

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

Ian Rogers (16):
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

 tools/lib/subcmd/run-command.c                |   69 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 8821 +++++++++++------
 tools/perf/pmu-events/jevents.py              |  847 +-
 tools/perf/pmu-events/pmu-events.h            |    5 +
 tools/perf/tests/builtin-test.c               |  711 +-
 tools/perf/tests/pmu-events.c                 |  156 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  169 +-
 .../tests/shell/test_test_junit_output.sh     |   63 +
 tools/perf/tests/tests-scripts.c              |   82 +-
 tools/perf/tests/tests.h                      |    3 +
 tools/perf/tests/util.c                       |   20 +-
 tools/perf/tests/workloads/Build              |    1 +
 tools/perf/tests/workloads/jitdump.c          |  201 +
 tools/perf/util/intel-tpebs.c                 |    9 +
 tools/perf/util/jitdump.h                     |    3 +-
 15 files changed, 7451 insertions(+), 3709 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/workloads/jitdump.c

-- 
2.54.0.929.g9b7fa37559-goog

