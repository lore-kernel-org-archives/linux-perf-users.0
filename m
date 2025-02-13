Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0A20C029
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437714; cv=none; b=WAml+CCP8JRBVhY55J8H+I6TSn8Fu2JpO7VnxK8kibzhB1n7cBxUdc47eFPM/Hekg88zO/fE1tmKvzY9ivt6vKuMBa/az+MgiIDD1eUWfFqBm7YACG53YscYhxkU0RuaSwJISgBLh6bOmOGMFaBGLMhE1WkqExAya8bp3x28KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437714; c=relaxed/simple;
	bh=ScTVU/MQJB7IkiEU4cB1inpPWCkD4EJVVuZEp7l1f5M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fXgYa53HVn83E74QppHXhGMYjx/DfRak800Jf+bCxSDHpzsUUCuZhy7mP/aPR9v+6ZJ1cesQ/WrPNjyR9NY4grezOaQBrqd3eTuMqWAXOzV3sR2o47Xae9N49Zovjr2abSFE+PleAUB7SgpZzV61hMY/pWFMA2eAqg/ywpxjBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYJ8uRZu; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYJ8uRZu"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab39f65dc10so79914666b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437710; x=1740042510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lwq1U/9dmqMgTloqyJjS+/Baoe2IW32eAKGxqeymvb4=;
        b=RYJ8uRZuEsW1GBqFdterOcGRmJAFREAsEqnF13nCNMV4gj9hxYyKe5rfbeSxGqbS8C
         Ei8WH59rvd2RYled6wYCbFFxQ3f7iWz4TZQjXGD8j9auWhdCGn1eiN6wyDO62AI3glDk
         Ke9mVXvSFrr3tXbVwkwFOf2Fg7lVmioM6FCnyT8RGLPHpZYgdMFZlegAtzKTfnQWAvGB
         Sr7dc+EjsRZ/Q2F++YXr8+6+U1UvXHTc/7a7inInyb91LYxIo9n+ggZDPKyzwb0HWZu4
         GZSerU2wd2HavEdXIntNLJvkpDvHAY58aejVCi9PJeGDDPThvp/orPTdmOLyHLuJzzFK
         UdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437710; x=1740042510;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwq1U/9dmqMgTloqyJjS+/Baoe2IW32eAKGxqeymvb4=;
        b=e4defT84kMccEpwhyJAHlL8xK0QlXHRE+FheY80dbSffubXLv6FmVqCBLiXZOJazJP
         XztQyEOn4nIM/4bXwdNDadNPnq7TCLpLU4hrI74Aby8v3q+H9G2JUaGe5kao/DhyAdCr
         ha4nWZbMmtf6KIyKX6T3ry5IaQnJLtb+avr1vK8MQexVuPIrDA+Z8zlksTioJeJnPcv0
         yWo5i0/GkrWYV4Nu7ffprxvG2AwMuYejwH0nFFfSIEZZs9ZNCs+y87g+B2s3aZnL6aoT
         PZu1uhWs7KJG317TREfLFhTOSKvQDz9QwcaPCxAmjqrPNp7jxEPDOhZIxY6oLi0DrdHe
         VSkA==
X-Gm-Message-State: AOJu0YzjfHAXaAy0wYSasN5/YVnBZsgR8UZ2mu4eHEIE51SRV9bf+0SG
	hAv7h/uX2QpKSlzh1QwBSwfIk7Rr4GmP25gf+CBqq/b+c1TW28RYL/2JxZwphgHctj5hsxN160P
	vcudhbw==
X-Google-Smtp-Source: AGHT+IGMQmMxtKN+kCWbG03liPyhiTe9RyjrrEbIb/9J2qaN+xdNDJm1mjpBtXp1gEA+vk6720DdFOl7ER0I
X-Received: from ejcff15.prod.google.com ([2002:a17:906:9c0f:b0:ab7:c9e3:1bc6])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1c08:b0:ab7:6d4c:a280
 with SMTP id a640c23a62f3a-aba4eb88da1mr194377066b.12.1739437710757; Thu, 13
 Feb 2025 01:08:30 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <cover.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 0/9] perf report: Add latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
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

Changes in v7:
 - add comment perf_hpp__init() re was_taken logic
 - add tips.txt example with time/time-quantum
 - rebased to perf-tools-next HEAD

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
 .../cpu-and-latency-overheads.txt             |  85 +++++++++++++
 tools/perf/Documentation/perf-record.txt      |   4 +
 tools/perf/Documentation/perf-report.txt      |  54 +++++---
 tools/perf/Documentation/tips.txt             |   4 +
 tools/perf/builtin-record.c                   |  20 +++
 tools/perf/builtin-report.c                   |  39 ++++++
 tools/perf/tests/shell/base_report/setup.sh   |  18 ++-
 .../tests/shell/base_report/test_basic.sh     |  52 ++++++++
 tools/perf/ui/browsers/hists.c                |  27 ++--
 tools/perf/ui/hist.c                          | 117 ++++++++++++------
 tools/perf/util/addr_location.c               |   1 +
 tools/perf/util/addr_location.h               |   7 +-
 tools/perf/util/event.c                       |  11 ++
 tools/perf/util/events_stats.h                |   2 +
 tools/perf/util/hist.c                        |  90 +++++++++++---
 tools/perf/util/hist.h                        |  32 ++++-
 tools/perf/util/machine.c                     |   7 ++
 tools/perf/util/machine.h                     |   6 +
 tools/perf/util/sample.h                      |   2 +-
 tools/perf/util/session.c                     |  12 ++
 tools/perf/util/session.h                     |   1 +
 tools/perf/util/sort.c                        |  69 ++++++++++-
 tools/perf/util/sort.h                        |   3 +-
 tools/perf/util/symbol.c                      |  34 +++++
 tools/perf/util/symbol_conf.h                 |   8 +-
 26 files changed, 614 insertions(+), 96 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt


base-commit: ee8aef2d232142e5fdfed9c16132815969a0bf81
-- 
2.48.1.502.g6dc24dfdaf-goog

