Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FE18AE3
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935037; cv=none; b=akmyOv6dhqf++C4qWTZ14Y7VBG7PrhBxEGDvaQVCH3PPKhUSSU9nYlo4KvxcwYdv2wqzDD2v7yMiDcWWKVBvaohkqq1mrMh/nWCIkWLE+2Rd5MMXVpM9dzujiIAD2Spdoit+LVLzdyVwg8wtN4hc1+folkPCO7up7+a1f1gCERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935037; c=relaxed/simple;
	bh=e95ABJxRpAYptHM8PhimT/mnQs3M8VpVz8lA9wMMMm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZ4Ew1WeI/Jhm5T5WyQ5x0PMo1D22TgvmxqtAy0o/sztKmqJsKcgGCmUNA2LTjdHXNWyEFi89sndRvFVFNwk+mietsE5LezhzuebLrCYb1bWJqpMxNicHE9i6q3pKsxglC30ilSmCQ/blYLTq7XCAtae3XMOyU08p4SMkURhVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTdomZ0X; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTdomZ0X"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so6356223eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935035; x=1776539835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/PwmdAueN5OMyxsaWW3+4eV+mkjUHqsyurz2brwt1o=;
        b=dTdomZ0XSrupLREBC+znesTsI9JVZBJso+ZaLj+gGyz4U50LFYV27tsYhDPb0aur0D
         6tlxJyx0lD8EQLUnPWOFEMGRj0y1W42O2iS3fm7S/v7x4QD3Rf2EmsJ/inBHge9YrDvk
         GDo5gG70BcMItHkHRCKWNd+jeyF7Fe7SB4eMrDEOG+wBq81Gc4OPESAfSnaBiK1MZCuX
         b1PC3wiopHZxwR/EBFkiQxorRqSQ51Bzl8RhHQU6eZ78hAaBuR/fqylcp05kkM31sbAb
         gvfwRg2m4zH+nWME3QnqyKjCRbNJerjCJ03de1V6PF0YkTQyBBd2MRJ1Ox0nMQ0qS6Bx
         nBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935035; x=1776539835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/PwmdAueN5OMyxsaWW3+4eV+mkjUHqsyurz2brwt1o=;
        b=n869dN2QjN7mlJJbFIHtVpPQsI6K/HN+a2/XL1m0JjtLnuVe5W+rGnAnDSoKIrPdzW
         tDyc04VEFLaOYpv0gg9/9ATFM5WeaSIsbqEHyzqbI/Tf/U+OFs9Oscc+RQJDuZ9nGBTX
         l430OmcWF1QN+onWDn/xjxE5xv3H9HtrVK9k6WKQnrmEJ+JwrIi3magZkUjIgypabjzE
         0aZ8fbRc/coxmHQgF5nMDsFgc4XJHCxRYYdNVxbKCYaCUZxEGc8Hw4AHCtWZgCwJD9h2
         Gkg1Aa/vfjcPoLTVj8o+N2K6YtWQ2vFVTjJLStJE7UcdF8O1N0YmTn0HrFpeCNr8Qz9Z
         LfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHDdnCkyD2CSOQi2ooiac3X1VunSiriNJ4er71X2oRu7sP5ieKPhgd8ZrFRDPrnyJPD6R2ZULoi753SEANgioC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MBlbgXtMcaidRFp9dgeRFIloakhPONx5Un26Iv82lrUZD9uc
	8e5EDkDwXx9jY2EDeV0WI1jJCzv/73GsVeNRNsvfGeH4eQ4JwrWchCG3UD9l5aQQxaPxVRM/cxG
	ISQUdVWeZ7g==
X-Received: from dlbqq7.prod.google.com ([2002:a05:7022:ed07:b0:12a:7182:6cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd01:b0:12c:8b9:7200
 with SMTP id a92af1059eb24-12c34eeca8amr5051625c88.17.1775935034996; Sat, 11
 Apr 2026 12:17:14 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:41 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-1-irogers@google.com>
Subject: [PATCH v9 00/29] perf tool: Add evsel to perf_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Nearly all perf code ends up passing an evsel with the perf_sample,
which is problematic if you want to rewrite the evsel such as with
off-CPU processing - all uses of the evsel need fixing up. Previously
I'd mailed this patch as an RFC with everything combined:
https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
and there was a request to break it up.

v9: Clean up some error path nits caught by Sashiko and simple bound
    checks Sashiko recommended.

v8: Fix address sanitizer issues with kwork and move patches, along
    with bound check additions, to end of series.
https://lore.kernel.org/linux-perf-users/20260411065718.372240-1-irogers@google.com/

v7: Separate out kwork work->name to a strdup into its own patch, now patch 4.
https://lore.kernel.org/linux-perf-users/20260408072601.210837-1-irogers@google.com/

v6: Address more Sashiko feedback.
https://lore.kernel.org/lkml/20260404034325.3172592-1-irogers@google.com/

v5: Address feedback from Sashiko and Namhyung.
https://lore.kernel.org/lkml/20260403204017.2919994-1-irogers@google.com/

v4: Fix more sashiko issues: bounds checks, memory safety, making
    refactors better, inconsistent evsels, mmap2 buildid injection
    choice of evsel, mismatched function arguments.
https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google.com
https://lore.kernel.org/lkml/20260320192627.368357-1-irogers@google.com/

v3: Fix various sashiko review comments particularly about unintended
    behavior changes.
https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com/

v2: Add review feedback on the first 2 patches from Namhyung, fix a
    missed evsel assignment running event2evsel in builtin-inject.
https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.com/

Ian Rogers (29):
  perf sample: Fix documentation typo
  perf tool: Remove evsel from tool APIs that pass the sample
  perf kvm: Don't pass evsel with sample
  perf evsel: Refactor evsel tracepoint sample accessors perf_sample
  perf trace: Don't pass evsel with sample
  perf callchain: Don't pass evsel and sample
  perf lock: Only pass sample to handlers
  perf lock: Constify trace_lock_handler variables
  perf hist: Remove evsel parameter from inc samples functions
  perf db-export: Remove evsel from struct export_sample
  perf hist: Remove evsel from struct hist_entry_iter
  perf report: Directly use sample->evsel to avoid computing from
    sample->id
  perf annotate: Don't pass evsel to add_sample
  perf inject: Don't pass evsel with sample
  perf kmem: Don't pass evsel with sample
  perf kwork: Don't pass evsel with sample
  perf sched: Don't pass evsel with sample
  perf timechart: Don't pass evsel with sample
  perf trace: Don't pass evsel with sample
  perf evlist: Try to avoid computing evsel from sample
  perf script: Don't pass evsel with sample
  perf s390-sample-raw: Don't pass evsel or its PMU with sample
  perf evsel: Don't pass evsel with sample
  perf kmem: Add bounds checks to tracepoint read values
  perf sched: Bounds check CPU in sched switch events
  perf timechart: Bounds check CPU
  perf evsel: Add bounds checking to trace point raw data accessors
  perf kwork: Fix address sanitizer issues
  perf kwork: Fix memory management of kwork_work

 tools/perf/builtin-annotate.c                 |  28 +-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-inject.c                   |  75 +++---
 tools/perf/builtin-kmem.c                     |  95 ++++---
 tools/perf/builtin-kvm.c                      |  22 +-
 tools/perf/builtin-kwork.c                    | 253 +++++++++++-------
 tools/perf/builtin-lock.c                     | 121 ++++-----
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++-
 tools/perf/builtin-sched.c                    | 188 ++++++-------
 tools/perf/builtin-script.c                   |  22 +-
 tools/perf/builtin-timechart.c                | 165 +++++++-----
 tools/perf/builtin-top.c                      |  19 +-
 tools/perf/builtin-trace.c                    | 121 +++++----
 tools/perf/tests/hists_cumulate.c             |   1 -
 tools/perf/tests/hists_filter.c               |   1 -
 tools/perf/tests/hists_output.c               |   1 -
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
 tools/perf/tests/switch-tracking.c            |   9 +-
 tools/perf/util/annotate.c                    |  19 +-
 tools/perf/util/annotate.h                    |   6 +-
 tools/perf/util/bpf_kwork.c                   |  14 +-
 tools/perf/util/build-id.c                    |   3 +-
 tools/perf/util/build-id.h                    |   7 +-
 tools/perf/util/callchain.c                   |   8 +-
 tools/perf/util/callchain.h                   |   6 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evsel.c                       |  86 ++++--
 tools/perf/util/evsel.h                       |  12 +-
 tools/perf/util/hist.c                        |  26 +-
 tools/perf/util/hist.h                        |   3 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/intel-tpebs.c                 |   3 +-
 tools/perf/util/jitdump.c                     |   2 +-
 .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
 .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 ++---
 tools/perf/util/kvm-stat.c                    |  19 +-
 tools/perf/util/kvm-stat.h                    |  18 +-
 tools/perf/util/kwork.h                       |  11 +-
 tools/perf/util/machine.c                     |  14 +-
 tools/perf/util/machine.h                     |   3 -
 tools/perf/util/s390-sample-raw.c             |  31 ++-
 tools/perf/util/sample.h                      |   2 +-
 .../util/scripting-engines/trace-event-perl.c |  23 +-
 .../scripting-engines/trace-event-python.c    |  47 ++--
 tools/perf/util/session.c                     |  38 +--
 tools/perf/util/synthetic-events.c            |  68 +++--
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 62 files changed, 962 insertions(+), 890 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

