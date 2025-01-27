Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA391FC7F3
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971957; cv=none; b=EME4o8BlyV+lpdJKIEpkSfHDBZpol35/Fsx8JTAEhxV47vonFYrxZuBCm4kH5PMwaz1lVCApY5MZAEtLuzX9PD3JavC+viB0KGaf2cuQhI4bKlIuigeWMCkgCr2ITgNCoh2zBww+w+0ygLxdiKwJfTPpTOWqyMOimve9Kg+/zFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971957; c=relaxed/simple;
	bh=UC2FXzcWcgolBEER15W83gDn+wDGtClwLgk9NU/aE/w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eot/MH3VRwR2KwgmxNcm7VmsN8TXSthDBGDIHfpanttjyVaQsx1dQ9EXwNETNOlTb84mL85dlMlQsEw1Pq5oVq3qfSD/iyCk4nw+J1qBEn7shoJhdw0NzyP1EuA2bjkHRmlvoEd+yV65N7DsMhXY+1M6G5zYVkAQhZyZ+GJ4HUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo4ffk/i; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo4ffk/i"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa68952272bso494791566b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971954; x=1738576754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UkxAk9+lBkQHO0K5ooSsWH+26gvlSdhoYUGXyajZA0A=;
        b=Zo4ffk/ia5U/R2LP7yuQPutOWq4eN/kIl+PKOMVKrahqfgW5vknb+hd2JzdMwkCRkk
         cptFG21PjWX1G6IJsJErR3Q4sWqjAU/ZX67rNOzxNDu3wQNBu19K6tz1x4waQo+a0YB9
         ugQvdHSPqM+ApFaHCzn7weR9b6xOiRyB1XYfUomnl7ShQ+BmF0htfm8a+yy34iAt3bTR
         6tamsSnQJqOM7YvGoCKYnx/N9YHurTGEmFHsD7lmntcnywi1zaNvKrJTQPy+J9jx4sXc
         eLKISnB04sRaMYNVVDFZF0az43h2SfaRJ2lNdroIiZGVxlJrgfr7OESm23fat7URO4dx
         lBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971954; x=1738576754;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkxAk9+lBkQHO0K5ooSsWH+26gvlSdhoYUGXyajZA0A=;
        b=nWgq3v0HKBR3D7cvNF7qDaOEnUuW4jD3Saxx3n0168q4ZtqZpPxd2ZXk+/KOS2TiqU
         ZxpMgFHhtxSwyHkvRUW7MZ03NaLNackfvgZevwb9mjIiWwa/QHaH07O+4A+l8SEDpuiC
         oYzNBCADmeroJ8+3bWW4u1a8k/kp8nA4VS1tbxACEQN7ohiY49+NhrZz7h+8hicDuqdw
         8t6wpOjx9eQwePeGNYzaO7Pjbwfqby71QZIFOWcq+sJRntIJiqNlwhYybRIYsWqwVeyb
         FWNiQoMTrTaUQriMc7JMQSXs/TjjTJtgD0ClwWubz4Hfq+fXCUoIRUd4X13tx2BtsMXF
         dv7Q==
X-Gm-Message-State: AOJu0YyJKH9qbcCtX8boV4jJIvaPXIK5FukU6OmxnG8mmIxo9VGMI0WY
	UcxjcVpSCPK/HK2P23byTQLV32H2uZj0IV5Q8eQMxvNl5fM9QqNYk63fVtW1FNf6ucuz750N4gx
	6lOM7tg==
X-Google-Smtp-Source: AGHT+IFEg39chTS5McLJ9jmrQk89u/wZ/PbfXPm0viwkAh0oOKAGWcCuQyAW6Uc1Lh0xB3XH9NhqSfrrUghf
X-Received: from edah3.prod.google.com ([2002:a05:6402:e83:b0:5cb:85ff:8366])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3489:b0:5d0:e826:f0dc
 with SMTP id 4fb4d7f45d1cf-5db7d2f9c54mr34992120a12.12.1737971953937; Mon, 27
 Jan 2025 01:59:13 -0800 (PST)
Date: Mon, 27 Jan 2025 10:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <cover.1737971364.git.dvyukov@google.com>
Subject: [PATCH v3 0/7] perf report: Add latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
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

Changes in v3:
 - rebase and split into patches
 - rename 'wallclock' to 'latency' everywhere
 - don't enable latency profiling by default,
   instead add record/report --latency flag

Dmitry Vyukov (7):
  perf report: Add machine parallelism
  perf report: Add parallelism sort key
  perf report: Switch filtered from u8 to u16
  perf report: Add parallelism filter
  perf report: Add latency output field
  perf report: Add --latency flag
  perf report: Add latency and parallelism profiling documentation

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

 .../callchain-overhead-calculation.txt        |  5 +-
 .../cpu-and-latency-overheads.txt             | 85 ++++++++++++++++++
 tools/perf/Documentation/perf-report.txt      | 49 ++++++----
 tools/perf/Documentation/tips.txt             |  3 +
 tools/perf/builtin-record.c                   | 20 +++++
 tools/perf/builtin-report.c                   | 39 ++++++++
 tools/perf/ui/browsers/hists.c                | 27 +++---
 tools/perf/ui/hist.c                          | 64 +++++++++----
 tools/perf/util/addr_location.c               |  1 +
 tools/perf/util/addr_location.h               |  7 +-
 tools/perf/util/event.c                       | 11 +++
 tools/perf/util/events_stats.h                |  2 +
 tools/perf/util/hist.c                        | 90 +++++++++++++++----
 tools/perf/util/hist.h                        | 26 +++++-
 tools/perf/util/machine.c                     |  7 ++
 tools/perf/util/machine.h                     |  6 ++
 tools/perf/util/session.c                     | 12 +++
 tools/perf/util/session.h                     |  1 +
 tools/perf/util/sort.c                        | 69 ++++++++++++--
 tools/perf/util/sort.h                        |  3 +-
 tools/perf/util/symbol.c                      | 34 +++++++
 tools/perf/util/symbol_conf.h                 |  8 +-
 22 files changed, 498 insertions(+), 71 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt


base-commit: 91b7747dc70d64b5ec56ffe493310f207e7ffc99
-- 
2.48.1.262.g85cc9f2d1e-goog

