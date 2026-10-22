Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707772;
	b=PJutcZM4rDVxI9mn7ymRNpGqGfYrDIFZkN/onh89V5Yqc5Ua5f4WivHQeRE+eliWgOh6
	 eBHGfBD1BFN6SXBnVtWe8zuDEguylCniaoR/FDkWNkz785vfEkF+jkUuwbrJpjiPaaWmE
	 QNRnlzqPc6ckleQgCdG95YKa5ccpx2UGObHHNWoW0OBE5vNweH5jBStgh0XSIeubr/9O/
	 NP56/d9wLbSq1Ju9FxgQQaEQKEHGwikVtcKiDnLRc6V5HDIiVDDexF+mWjO8zyK3uxG+e
	 1PEBr/mcNzdPnbM0Q8Uzazg+oqshp58GhPdUEhG/FaIRQ7FzH6po3A72pPYqaBoobxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=UVxjYxR2Ga4AD1SUiwzSODCyhRYwmhdSecMtJaDvwRE=;
	b=X/7s49Pizzg6eFDE1JQDp1T90uu3sb1totYngE0JsP7Dm8zeQODJUeWT54wOD51SLRqy
	 Xnee59lp1HXTSteV0shJZgMBOu19oMmDLnNRlQHrkhTheX/26iJh5f+51d3RKohoLmwcC
	 q3W4E5HqOPSkH/hZUNUQTeqz7+AYlafConvrFU/2Td0AEmjq0Ic77bqhGLjWcHzbOjJSw
	 1D8I9kIzGBdxPRM1WyFg5Dhd8anN8Tq88rPa7zKULKratY0hNiFlf067+GVIVb6hWtzFw
	 EB6uIwLXjmAexSh04L6RtCf83w3ptlx1wgfly+l/IRMnKhL723ddbaO2FUCzzWCNoCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nujha08u;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EF606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nujha08u
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-18b5ee75447so832014c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792707771; x=1793312571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVxjYxR2Ga4AD1SUiwzSODCyhRYwmhdSecMtJaDvwRE=;
        b=nujha08uBiHV9yNntrjzSxB9TFEnEdtdpbZIFap4x/qc94zp3xb6278/2a75sjiezz
         4ipvrbFLRAA5oICqipsnR0TY263OOlQvINncxfVgszKS7zWARrrbZgBndJXAU7e0kM79
         xKrcSrB+TuIgn2e7aVtRyh2N83z0Ujo22LzV+KvS7U0FMGMJEbx0RWRhMQajmst5YZCo
         /4EOFYoK2eQMhQILzx6leHRH3Nd5igmUcwYot1ZfuKJFJwyQ+Z3XJ+GaLKRWF98pBLQq
         HHDWAov4fWz5iBOXSbsLKiyTRK+8SCbXl9yE94npbHT+Qxlglo/A6EIMR0Ue5alDvEWM
         ltEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707771; x=1793312571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVxjYxR2Ga4AD1SUiwzSODCyhRYwmhdSecMtJaDvwRE=;
        b=Ed3XfTgfl4VQgO7KB68jmx9nZWULlYc4IjLVF2Vzd/wDpTpwhb5QIiGcDqAVXFGhkD
         0JP1j5RYrOT79MqFpYzxZD7fzkYfvz1+ZwNI8ZKB4tQs5E3AwbI7taCjoO33VNg4Srgd
         gJz0u0C34sXwhqqHVSCqtKcpEa6FjBan40pz5KVEPjTGNdM9ESOlynWVtMmEAz7dNv1c
         D4ept5B4jZtxp/Ek+GvoMTWH66QQAvPWox9H7GMuEosnUnWime9/n4sVnI48jkwX6eLT
         U9lfVnV4YkqWM04Ot1XNOA8kNC2v5SjGUZNXhUeyoYNqnHqmi2bujqakMrBC74dVvzBb
         k+8w==
X-Forwarded-Encrypted: i=1; AKwUvBxuUp7jBUaL9xi907KcMjgxI3aVBX8XMTqiiRMfXZXXqF2MUJJwwyX0GC4npYoOp5cPGQOlP/LrQ1J0pI+CN/H8@vger.kernel.org
X-Gm-Message-State: AFq9FYIrNydwQxxlWr2nEYTn2jgyoRwbs8AC2cnW9KhGDAp4bxzN9XM2
	2xJYTVGQn9o+skCQ6w23nsLTIsdGMvLlvgZcbDb2g153tNiJs7GEHF/NBKSFzbB2E1bAkCg/tG4
	+0e5NEQbi5Q==
X-Received: from dldnz14.prod.google.com ([2002:a05:701a:ca0e:b0:183:f9d:1eaa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea51:b0:14f:505d:813
 with SMTP id a92af1059eb24-195c3654b31mr670501c88.41.1792707770695; Thu, 22
 Oct 2026 15:22:50 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:22:42 -0700
In-Reply-To: <20261022210753.1851597-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210753.1851597-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022222245.2064964-1-irogers@google.com>
Subject: [PATCH v6 0/3] perf test: Per-test timeouts and JUnit XML schema compliance
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This series adds per-test timeout support to 'perf test', improves JUnit
XML output to validate against strict JUnit schemas, and ensures time
spent waiting for the shared mlock budget does not count towards a
test's timeout or reported duration:

1. Add a per-test timeout (default 120s, configurable via '-t'/'--timeout',
   0 to disable, disabled with '-F'/'--dont-fork'). Forked tests run in
   their own process groups and the existing polling loops in
   finish_test() and finish_tests_parallel() check elapsed runtimes,
   sending SIGTERM on timeout and escalating to SIGKILL after 1 second.
   Timed out tests are reported as 'TIMEOUT!', listed in the summary,
   and recorded as '<error message="TIMEOUT" type="timeout">' in JUnit
   XML output.

2. Update 'perf test -j' output to validate cleanly against both the
   Apache Ant/Windy Road JUnit schema (JUnit.xsd) and the Jenkins
   xUnit/Maven Surefire schema (junit-10.xsd), including required
   '<testsuite>' attributes, '<properties>' from uname, '<system-out/>'
   and '<system-err/>', self-closing tags, apostrophe escaping, and
   UTF-8/XML 1.0 codepoint validation.

3. Record each mlock-serialized test's start time in the shared
   mlock_budget mapping when it acquires mlock_budget->lock in
   run_test_case_mlocked(), so tests waiting for the mlock budget do not
   time out while waiting in line and their reported elapsed time
   reflects actual execution time.

v6:
 - Reap finished child tests (invoking kill_timed_out_group()) before
   draining process.err in finish_test() and finish_tests_parallel(),
   and skip draining in handle_child_pipe_activity() once a timed out
   test has finished, so a noisy surviving subprocess cannot block the
   pipe drain loop before the process group is killed.

v5:
 - Rebase onto tmp.perf-tools-next (patch 3 of v4 was applied upstream)
   and add Namhyung's Acked-by to patches 1 and 2.
 - Add patch 3 so tests waiting on mlock_budget->lock don't time out
   while waiting.
 - Increase the default per-test timeout from 60s to 120s. When running
   the full suite as root (where CAP_IPC_LOCK lifts the mlock limit and
   mlock_budget is unused), all ~180 non-exclusive tests start
   simultaneously at t=0 and contend heavily on CPUs, /proc scanning,
   and vmlinux/DWARF symbol resolution. On a 28-CPU hybrid machine, a
   60s timeout resulted in 33 timeouts across the parallel burst and
   large sequential suites; increasing the default to 120s allowed
   longer tests ('kernel lock contention analysis test' at 115.3s,
   'task-analyzer python test' at 94.7s, 'perf data type profiling
   tests' at 92.6s, 'perf metrics value validation' at 91.2s, 'perf
   record tests' at 79.0s, and 'python profiling with jitdump' at 62.7s)
   to complete, reducing timeouts from 33 to 2 ('perf record LBR tests'
   and 'perftool-testsuite_report') and overall suite wall-clock time
   from 503.5s to 363.9s.

v4:
 - Drop the ITIMER_REAL timer and SIGALRM handler in patch 1, relying on
   the existing 10ms/100ms polling loops in finish_test() and
   finish_tests_parallel() to detect timeouts.
 - Only fall back to kill(pid, sig) when kill(-pid, sig) fails, and
   ignore SIGTERM/SIGINT while waiting for subprocesses in
   run_test_child().
 - Add patch 3 to avoid stack trace noise in verbose=1 failure snippets.

v3:
 - Block SIGINT/SIGTERM while a test process may be reaped and until its
   pid is cleared, and skip already reaped tests in the signal path.

v2:
 - Reset SIGALRM to SIG_DFL in the forked test child.
 - Replace the blocking waitpid(-1) loop with a bounded, non-blocking
   wait that only runs when interrupted by SIGTERM/SIGINT.
 - Ensure the SIGKILL escalation reaches the whole process group before
   the zombie is reaped.
 - Factor out timespec_diff_secs() and TEST_KILL_GRACE_SECS.

Assisted-by: Antigravity:gemini-3.1-pro

Ian Rogers (3):
  perf test: Add per-test timeout support
  perf test: Improve JUnit XML schema compliance and completeness
  perf test: Don't count mlock budget wait time towards test timeout

 tools/perf/Documentation/perf-test.txt |  12 +-
 tools/perf/tests/builtin-test.c        | 662 +++++++++++++++++++------
 tools/perf/tests/tests.h               |   7 +-
 3 files changed, 535 insertions(+), 146 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

