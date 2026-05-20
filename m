Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A129ACC5
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303945; cv=none; b=Ae10388BI8IpZ1LzcfjEjmS9xu2EaMQSMKmGfA9UJKSMKliI7z0BIepmuMVfljxE1q5gNqj2xVMBHWQ/61mJIYX8bNMKajmCOHEmIdLRWi3eZb28hPGFpNPxCs902p14YbO4xT/LDoSLJUG0uTu6mRP9d2Vdgtmp4p8CEZItRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303945; c=relaxed/simple;
	bh=yFLp7OkD8qybCjZ/mz35/8xkE7X7XG2e83t1oyk3NJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dvUBJgX1ljmsgIj516vo77lR7ehiedn8t1D9GKy2CVA4f2I5n9BcWg+5IdW7LYF6743o9q9+PyZmQ7lD95PYtzEuJ1dHPq9lr7WLx5/Gpi+pfXwuWwmoDH0OcJnle+PxtQhBshws1MZBOtPQkkLdAkkLm8sD15pHRELGs5TjpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyrfHbjU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyrfHbjU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so24954813eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303943; x=1779908743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbuwTTpbTAwc6bD3PJul+LcfHorJYQhpkz2OkION4H8=;
        b=vyrfHbjUB5I0htbhvbNEshTGZEa6KTUWmUuP3YoHl5xkhMn4GCH1oqQrBFCGa83rDC
         ktm+w0phMj/um3At5lN5BB6eFqi52LuXKDtl97zl4aFqQdM0FYvZOZWEPqQ1FCFxTfUv
         GRBP1DjqjLgy2TDaQihY1qfrxNZfSavlVeD1lFjz4bhAMzrNI4SxvfKKJ/RRPPFwWpJJ
         j0e5oYF8/z2LRzGRbTdUMeIKrOA9RsmlaPI+8UH2kep2Dp5LeBCIC5Y7vN8HXgraqH4Q
         PbcBcrSt+hKx1YELeU9/LSH9jF1vWZy1hVSnQe/v2LvoOnNIEmOsz6STnoL8W0jByXAz
         Ko+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303943; x=1779908743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbuwTTpbTAwc6bD3PJul+LcfHorJYQhpkz2OkION4H8=;
        b=i4caPBInw2eKC0JanbOo7elkreAAYOW+ds5gUWAHkc3LyqOZk8zzo2fm/9mez1JxO8
         jrRjaJ+W11urf2qufn8+vd6PlNAsXG/sSVPtM/9FcLTOVP/9lHXjUuK+cuBLt9F8tYp0
         ZewqpA9BgrQ1S5A3EbKpTtlHv/kxtKrRczZ+QFjHJp7ChsnAmumPG3kF1qWoTHBmJrs8
         g6PKFoit9IJJUjN7xm+yj5U2xU0OWURT6qsZqtEktiuQi639KO+sjDwoPh+zPO4SNqip
         oL/gX7bn56omtdUpXX+4LNzHavqftWxdF2VotNJB2lhvD7YTR/Ckw1szBslYwFLHnkC/
         jX2A==
X-Forwarded-Encrypted: i=1; AFNElJ9TbkjSMJo3nk1Pf2wv7l6GXKa1xwr87GxTH7gYa0yAFOeXsaprAfYoSbI20xlyBCXp8UqNrU0Kv1Eim0pi3PlN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35h8xG7TjoSC/dePYJaUqVGOHpFhtoDN8YqryUxGurdDU+jqX
	a3IfNzPs7przcvsRG8i0kGu5aGk4TRkLhgHnhC9uGX7oK+CaYc10eYSLkhE9AfnGcV2NVW9tofN
	g9cfPypQ8Nw==
X-Received: from dybic41.prod.google.com ([2002:a05:7300:c729:b0:303:9bd4:479a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e28b:b0:2ed:6f94:9d9f
 with SMTP id 5a478bee46e88-30398170710mr13308022eec.11.1779303943258; Wed, 20
 May 2026 12:05:43 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:06 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-1-irogers@google.com>
Subject: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
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
which is problematic if you want to rewrite the evsel (such as with
off-CPU processing) because all uses of the evsel need to be fixed
up. Since the perf_sample now carries its own resolved evsel pointer,
passing evsel separately is redundant and error-prone (allowing
parameter divergence bugs).

This series cleans up the redundant evsel parameter across all perf
tool subcommands and APIs, ensuring that tools uniformly retrieve
event attributes directly from the sample itself. This simplifies
function signatures and improves API consistency.

Additionally, this series incorporates subsequent memory safety
improvements, robust bounds checking, and memory leak corrections
prompted by address sanitizers and Sashiko code reviews.

The original combined RFC patch:
https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
was split up per reviewer requests.

v14:
 - Incorporate Acked-by tags from Namhyung Kim.
 - Re-polish and expand commit descriptions to provide thorough explanations
   of the changes and their rationale.

v13: Rebase removing patches merged by Namhyung. Namhyung proposed
     changes that are in this series, but we became diverged. Address
     some minor Sashiko issues.
     https://lore.kernel.org/linux-perf-users/20260512223001.2952848-1-irogers@google.com/

v12: Add missing byteswap for tracepoint rawptr for dynamic
     offsets. Avoid some unsigned <0 compiler warnings.
     https://lore.kernel.org/linux-perf-users/20260413041143.1736055-1-irogers@google.com/

v11: Separate any remaining error path or other fixes out of
     refactoring the evsel into sample. Incorporate Sashiko
     feedback. Improve bounds checking for tracepoint data in
     samples. Incorporate changes from Namhyung.
     https://lore.kernel.org/lkml/20260413012227.1089445-1-irogers@google.com/

v10: Changes to some of the bounds checks as prompted by Sashiko.
     https://lore.kernel.org/linux-perf-users/20260412020833.641177-1-irogers@google.com/

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


Ian Rogers (32):
  perf tool: Remove evsel from tool APIs that pass the sample
  perf kvm: Don't pass evsel with sample
  perf evsel: Refactor evsel tracepoint sample accessors perf_sample
  perf trace: Don't pass evsel with sample
  perf callchain: Don't pass evsel and sample
  perf lock: Only pass sample to handlers
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
  perf lock: Constify trace_lock_handler variables
  perf lock: Avoid segv if event is missing a callchain
  perf timechart: Fix memory leaks
  perf kmem: Fix memory leaks on error path and when skipping
  perf synthetic-events: Bound check when synthesizing mmap2 and
    build_id events
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
 tools/perf/builtin-kwork.c                    | 249 +++++++++++-------
 tools/perf/builtin-lock.c                     | 128 +++++----
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++-
 tools/perf/builtin-sched.c                    | 198 +++++++-------
 tools/perf/builtin-script.c                   |  22 +-
 tools/perf/builtin-timechart.c                | 164 +++++++-----
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
 tools/perf/util/bpf_kwork.c                   |  22 +-
 tools/perf/util/build-id.c                    |   3 +-
 tools/perf/util/build-id.h                    |   7 +-
 tools/perf/util/callchain.c                   |   8 +-
 tools/perf/util/callchain.h                   |   6 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evsel.c                       | 137 +++++++---
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
 .../util/scripting-engines/trace-event-perl.c |  23 +-
 .../scripting-engines/trace-event-python.c    |  47 ++--
 tools/perf/util/session.c                     |  38 +--
 tools/perf/util/synthetic-events.c            |  49 ++--
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 61 files changed, 991 insertions(+), 911 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog

