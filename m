Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086B19ADA4
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959718; cv=none; b=WAXnrG3ODXQNPHXIwP3eXNZwZC98WDg5yJ+TY/cO5CT8wdAouSZpiLbCiBLUpp9Q4e6Jyrke893zIvqZzPhTbhCUqGAiWJb3WMHlqDFQzfDYq0mNAW2hfe68b1UswVR4lunJWYoo+VGiuy90CeX8CBx382AIESC/DJNhKL/z9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959718; c=relaxed/simple;
	bh=9uDQCpi4DcOVvAJDJ7Wbqtl9Qp7O1GWYyOMU+RRtjwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vm1WyZaBBhKgKslsNYS/KIar+VoTr+S+5eC0n/P/pbljBmEvErs0Dh6yuARn87MZOQQXxFn6ZG4t0ZpZA/Y7tBAQ+YTld5Pc2XINPgZSD1G9kU5dQ7yqyDGylNVAKHhWW++BLFTha9AukvW2WX2UkzjZ79WsBVgq00wzx3QiJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6zmq6+0; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6zmq6+0"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so285571eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959717; x=1776564517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwv/AsxT8e+y1/cIVbNHf9WIAFVZR7e9Cq8Iq1m+uFM=;
        b=Q6zmq6+0NJfNb7DfxWzcD+pBFxThPLURfTySNs9tuqwI/M3bCc5zSfnvRMl2xHY240
         o92THuyxzNREYULRNLKUZbmetDAOtcgpchXCVW4jMseIZ3YmfqOJGVQMvX3D9pNKjsDq
         0Ohg7E7ogSUtnNfpMtUO92XGiNLShkJRVd+Zz6Vhtm/B6aGjux57kMhpdGNcsi6z62vT
         d4F9NGT+2qw3JR+1Lc0L9wRs+6w59sY3u4trYVOFD3SQnzWU5AXIu3MH9ZMh1pXyWTHE
         4fVtO5VbSbFLLXPCSrsDUnLKksWQfuajlxwlYW9bLTDFzwCexYtEWDoVprtoBr1mQvlG
         c6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959717; x=1776564517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwv/AsxT8e+y1/cIVbNHf9WIAFVZR7e9Cq8Iq1m+uFM=;
        b=nMw+b5FwZ2upvMhJTX6dgYBwMy5Lr4S7+tr0GecFQytRKyQqEksJhitkQqjxyYKMfe
         2s+4uc6YqUHqW5rJc8M9qaftyxJE1XyE/u42XwsHDHA6vhQDKMiwz49A1cCnwe+yNfVP
         uCzJCZ8DZD6jEgKQXV72vkEWIA/1QPMyVvyXTCtSz059qkaMaqKALHJl2KVVeZoNgx/y
         2wEnSB8A/28h1IAMY4wGdlJXAZiICEiiJwFWb3jDLJeFw4blaLIP4UR2kLmNUC0o7nGD
         puOJfW4q9NJxoF+U+O67kmjpkpUkoxwR0Py6tNkS7XXPNKPZA9blKYazAJkEcYeH8HZU
         iBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWL1AiM/ZVU9DvnJsnvu2iM+WtQrviRXvB0cs8LhfJxdHOuAoDaGhvqmEbJu4YC2JN5rLDSdOnNvHMttnaYW92A@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmcg2Zr7LsXXjy6qG4E4BjA11owQIQ864t84jNFvYryu73vnOJ
	i81jt09ftt0x71bhvuGuQld6ADvdRfE9bYtm2Y9OypPLMo6IAV+HX/y99f+qbCGScXJ4Qcpho5v
	96W3eZL8RRg==
X-Received: from dlak10.prod.google.com ([2002:a05:701b:290a:b0:12b:eb82:4c63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6187:b0:11d:e40f:ee69
 with SMTP id a92af1059eb24-12c34f273b7mr5042771c88.36.1775959716083; Sat, 11
 Apr 2026 19:08:36 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:03 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-1-irogers@google.com>
Subject: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

v10: Changes to some of the bounds checks as prompted by Sashiko.

v9: Clean up some error path nits caught by Sashiko and simple bound
    checks Sashiko recommended.
https://lore.kernel.org/linux-perf-users/20260411191710.524998-1-irogers@google.com/

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
 tools/perf/builtin-lock.c                     | 128 +++++----
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++-
 tools/perf/builtin-sched.c                    | 188 ++++++-------
 tools/perf/builtin-script.c                   |  22 +-
 tools/perf/builtin-timechart.c                | 170 +++++++-----
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
 tools/perf/util/evsel.c                       |  94 ++++---
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
 62 files changed, 967 insertions(+), 905 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

