Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0A1DE2C5
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928475; cv=none; b=OLJGzp9iE+xyoFmD7bL7e9r0nKBEOc/fjIi67egG3qJ3wXmZU1RfjjbTxDALHCGx051i9mkY1VyshIHYeZi/3Xco0WmL//lxe7tJSrgXwRDsLSlCOnLcym+fT2rDQlgCdIdrrS9n4lzt+CBqDOeB8YhW18294+0zCUCSq3qLy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928475; c=relaxed/simple;
	bh=cZSjRJkyOD6TmZ/WS2slPnUyGbACn7ZDTsrX/AZ0pgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SGq7M6RHBjLESr6p0twlQyqk6olsDoA8/KSs1gEVkCCVQithJvVaYuJDys6FPLRY8aMTlNBU4Lwqivk2pN+V7fF7exU5u3ZYTLGo9jpMg3rEmtyc66dqbdwfAjFyKMutWzC2Ls8l5/EJZ0wt/C2U6j/RblCRh4W8b5lBkPq16p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzO/1bPx; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzO/1bPx"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aaf8396f65fso218491566b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928472; x=1739533272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3giu+1JVJz0bWBbpQHM3+1tkJWHyu35NWOLlexwW+8=;
        b=UzO/1bPx28xWfFb0fdv2NN9DvtoRKOABL20lEr9rQveA/cRkOo1plG3MzlmO1HRk7M
         ExtkySbOG5XD8x6qETAagbuak0Ntyx8eEEpQrxa/Rxei5RZiEL8D6AMM7X2G1njZWbgd
         yHBMrVr+osJn3l0GUmSd3o0F/uXdNkQ+lKgztzP/96hM1bWGtn8SNcC7caeu+cczT6iz
         Z12IDr9QKcAkqkt/eciGxHyIwFWEAmudpk5Hrqag2knBn0Zcp4wFstqL0/U4P6Ql4Gyi
         qdy4ph00L12NVKnYEA0EQeyVq5yardgK6Ut3rx6cJGrysY6pCZNQiAT5Co9Z0i0Va8IU
         vIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928472; x=1739533272;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3giu+1JVJz0bWBbpQHM3+1tkJWHyu35NWOLlexwW+8=;
        b=dpjqvd6EUwh02UeOzph7el9QxF3P80AWv57ddCic4WBFftpkTrMHGjdQ6exC6FE1mf
         P6IVREdfMMn77Kb5pxS7jXgh2dI4rur/9csL/AsU5JfqovnxiOqgPUNKn5aF8OP4bdIH
         1qEMfdKV0c+6AdjCZ8cvO+/j6nG1SfChlPbPdNjmMQKP3y/6H90agEhJarxYjn5NgvAi
         TITSYneuJyRV8NO+/whb7lLb0afKoDt5JFfYjMUOiu63U/dUR8lZ7mxLspW4wgf+tgdq
         HuK8rQ1oIaKkunblRiCZYD9ykG3N5b/wGQcDTTK7U2NGGzrmOUbMAXMVYB8SCLPjBVRH
         gJHw==
X-Gm-Message-State: AOJu0YyjYfT/fLA/nCVclK3mpanBWpLe4aqz8TOAM5UaaZ1eie02NuHa
	hMw+cMNR20MnEYVbyjiF3GeHcLpL1LaPakIerZ5BECRe3UKm+83zxLy+1+GmV8ZCk3IOlOXZWQF
	xV1TSjA==
X-Google-Smtp-Source: AGHT+IHz5Jnv25yTFfvgIHShgN+xb7dlGf/juT87t9s1pt/pvBtGaFad96IzoB8SA+tjONOvrxah4H7dwu52
X-Received: from edbfj17.prod.google.com ([2002:a05:6402:2b91:b0:5cf:c230:2ef])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40d5:b0:5dc:db1e:ab4e
 with SMTP id 4fb4d7f45d1cf-5de45072163mr3607619a12.19.1738928472361; Fri, 07
 Feb 2025 03:41:12 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <cover.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 0/9] perf report: Add latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

There are two notions of time: wall-clock time and CPU time.
For a single-threaded program, or a program running on a single-core
machine, these notions are the same. However, for a multi-threaded/
multi-process program running on a multi-core machine, these notions are
significantly different. Each second of wall-clock time we have
number-of-cores seconds of CPU time.

Currently perf only allows to profile CPU time. Perf (and all other
existing profilers to the be best of my knowledge) does not allow to
profile wall-clock time.

Optimizing CPU overhead is useful to improve 'throughput', while
optimizing wall-clock overhead is useful to improve 'latency'.
These profiles are complementary and are not interchangeable.
Examples of where latency profile is needed:
 - optimzing build latency
 - optimizing server request latency
 - optimizing ML training/inference latency
 - optimizing running time of any command line program

CPU profile is useless for these use cases at best (if a user understands
the difference), or misleading at worst (if a user tries to use a wrong
profile for a job).

This series add latency and parallelization profiling.
See the added documentation and flags descriptions for details.

Brief outline of the implementation:
 - add context switch collection during record
 - calculate number of threads running on CPUs (parallelism level)
   during report
 - divide each sample weight by the parallelism level
This effectively models that we were taking 1 sample per unit of
wall-clock time.

We still default to the CPU profile, so it's up to users to learn
about the second profiling mode and use it when appropriate.

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v6:
 - remove latency column in perf_hpp__cancel_latency if
   sort order is specified, but does not include latency
 - add tests
 - rebased to perf-tools-next HEAD

Changes in v5:
 - fixed formatting of latency field in --stdout mode
 - added description of --latency flag in Documentation flags

Changes in v4:
 - added "Shrink struct hist_entry size" commit
 - rebased to perf-tools-next HEAD

Changes in v3:
 - rebase and split into patches
 - rename 'wallclock' to 'latency' everywhere
 - don't enable latency profiling by default,
   instead add record/report --latency flag

Dmitry Vyukov (9):
  perf report: Add machine parallelism
  perf report: Add parallelism sort key
  perf report: Switch filtered from u8 to u16
  perf report: Add parallelism filter
  perf report: Add latency output field
  perf report: Add --latency flag
  perf report: Add latency and parallelism profiling documentation
  perf test: Add tests for latency and parallelism profiling
  perf hist: Shrink struct hist_entry size

 .../callchain-overhead-calculation.txt        |   5 +-
 .../cpu-and-latency-overheads.txt             |  85 ++++++++++++++
 tools/perf/Documentation/perf-record.txt      |   4 +
 tools/perf/Documentation/perf-report.txt      |  54 ++++++---
 tools/perf/Documentation/tips.txt             |   3 +
 tools/perf/builtin-record.c                   |  20 ++++
 tools/perf/builtin-report.c                   |  39 +++++++
 tools/perf/tests/shell/base_report/setup.sh   |  18 ++-
 .../tests/shell/base_report/test_basic.sh     |  52 +++++++++
 tools/perf/ui/browsers/hists.c                |  27 +++--
 tools/perf/ui/hist.c                          | 106 ++++++++++++------
 tools/perf/util/addr_location.c               |   1 +
 tools/perf/util/addr_location.h               |   7 +-
 tools/perf/util/event.c                       |  11 ++
 tools/perf/util/events_stats.h                |   2 +
 tools/perf/util/hist.c                        |  90 ++++++++++++---
 tools/perf/util/hist.h                        |  32 +++++-
 tools/perf/util/machine.c                     |   7 ++
 tools/perf/util/machine.h                     |   6 +
 tools/perf/util/sample.h                      |   2 +-
 tools/perf/util/session.c                     |  12 ++
 tools/perf/util/session.h                     |   1 +
 tools/perf/util/sort.c                        |  69 +++++++++++-
 tools/perf/util/sort.h                        |   3 +-
 tools/perf/util/symbol.c                      |  34 ++++++
 tools/perf/util/symbol_conf.h                 |   8 +-
 26 files changed, 602 insertions(+), 96 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt


base-commit: 9e676a024fa1fa2bd8150c2d2ba85478280353bc
-- 
2.48.1.502.g6dc24dfdaf-goog

