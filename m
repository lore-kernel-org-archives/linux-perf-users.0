Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7B1D798E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043353; cv=none; b=lzK7tXYbTSI0/nNHytrV+4/Yo5o5rHUCyeP7eglPQLKRSSw83ldDq+GGpV4AvT8srAWGh344FgSqRMvPFvEMbUUwDusMWcQObigjuOzKstBvkrpopoVkTl5hSO25q4sjPQNTMmHLIm3U57hFINOjsJd9x3H0uQ/TUFPBrNI8nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043353; c=relaxed/simple;
	bh=pchC/U6ASN0WXp4F9HhP6AyUUGDVN7iO3A6cNa8cnTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koDXES0mkpZ/65NtsN1zqCGN6D3/kMftLii1g8+44ZjpOd+BPmmXdWYMwT5Y7G/j5ZUbwrh8f600czIXR2D6UTn1rzwRa1tIEsebxIxVTFj4hTLsImWhXy8quBNAmlLKd2HgAGgID7epuBH3MuhXJaJ+P9P+ydjmT+dxTkfW1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihryUaA4; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihryUaA4"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso9191114eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043350; x=1776648150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjhgGQmjtRsMLq+PPFcxX/dLpVx9veCyjivmzMXW1K8=;
        b=ihryUaA4Zud//8dcjGruSx97nSJFWLQybSgZLf6DiSsbJcVIqhs0en62ej71ikQITd
         LG3IG00HBHg1Zv1Y2mIyvfOrERA+sG8Yn1uDz43ZZ7Rm5s2HTV+MKmduvAfqTe/y0A8H
         +N+sSuV8wth2GvVWE9oc2JJokCW2rx4T6JFI8sZzRE5+6U4myd6l7v5d+G2Aq3QQLVRq
         gr30hrpaU/w6XAb1So2T75Q9vdvu818nwrKYPo+50xgUNn7DiA7WiGeW+JqEvLfsKJjg
         q60J9ECBg40qrUKMR5cK3vu4iQHj97ETAnv6DChfq+VAzojELeMiZ3PiwLnZYA6ueSe1
         ZmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043350; x=1776648150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjhgGQmjtRsMLq+PPFcxX/dLpVx9veCyjivmzMXW1K8=;
        b=Zzq3p4ruiA1FsSwt98CFIkqyfkpeHGLQnqO7FEfGkcHUF0G+n+k34nAWFRZLfA4Vg4
         cT5pqmJ0Jhx0+3sFmKLlXQrh9tsM0tVND1isHeVlVZn3xhDU3LXwq1mHRIfvV5gKdyC1
         K3Hh1/Zro8yXH5N0MjPZWSqYIKtytS7vEfgSwv34++lOmx3qBtT+iFjOJwBYxPEnNf9t
         7B6X4+m+D0prRt3SzijAwIK3hYX5ee2cITmfLjTbGsbREUlP9K84tZdrLQiyVU6LRpsc
         54/B7cdYauHke7ltY+Rrhepo3j76dehW1Y8oh6PNHGafLXoEZu6FMe3dm2dOOD0i2BiW
         +qTA==
X-Forwarded-Encrypted: i=1; AFNElJ8H3GMlKtAemYJmL7/ZANvRZEcSXi4ahIbNe4J4daVOU3YdAXPDRMWO6pRzvEDcpNr/O03VhVMNHurILorO7FQi@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/AypONsKZ5pl0EL5CxKKFtt0eQoJP63kZ/j/3CwpKM+nJ5Oq
	NuuGyeckXLQgWWDK3ZGeZgKlOsK5rB7lbkg0seJ2rDYhIKA1nuipzyVar6yXOE5qC7DXhO/ELRG
	3qM5wR26pHw==
X-Received: from dybtn10.prod.google.com ([2002:a05:7300:f10a:b0:2d7:f6a7:dbdb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4194:b0:2d1:a3ea:d8c5
 with SMTP id 5a478bee46e88-2d5881acd82mr6332821eec.17.1776043349834; Sun, 12
 Apr 2026 18:22:29 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:21:54 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-1-irogers@google.com>
Subject: [PATCH v11 00/33] perf tool: Add evsel to perf_sample
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

v11: Separate any remaining error path or other fixes out of
     refactoring the evsel into sample. Incorporate Sashiko
     feedback. Improve bounds checking for tracepoint data in
     samples. Incorporate changes from Namhyung.

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

Ian Rogers (33):
  perf sample: Fix documentation typo
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
 tools/perf/builtin-kwork.c                    | 253 +++++++++++-------
 tools/perf/builtin-lock.c                     | 128 +++++----
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++-
 tools/perf/builtin-sched.c                    | 198 +++++++-------
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
 tools/perf/util/evsel.c                       | 133 ++++++---
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
 tools/perf/util/synthetic-events.c            |  49 ++--
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 62 files changed, 988 insertions(+), 914 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

