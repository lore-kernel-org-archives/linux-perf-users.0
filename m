Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84435F612
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625023; cv=none; b=i0PsAqYTB+SYiQ7lUxalmeSv28rUwbwD1X/3D5XKesucKwJHfOxSduwRJpixFBqm049VeptEBw7CSdQD2IO9JUWkup3TQVUulkzQCvfCt8OafYtKFjO/Z3vnUL4I9oG/QZXTppC8WHXJwun1quKkO1CshvIzJkemyCGLU9MxftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625023; c=relaxed/simple;
	bh=wPSwABTV1x3IBZQzdNtE2JLfV28csWXc1cILb7wKVj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YG7BzbeEmbpDPaZHVgury+amsQJadjFhYNVu3HmTKCft4611BcnMMRF/k+i3qDDtrJ3jtyS1mfBcCoXMrNVfcKyGmKw/I1cRMoNZdr7yRLwsIKwQ6MCoWyEfem+0/+mou3yI37cgagA2JBJo/0q+NfZqmWd60IgsyxIX2Jgip4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIKQvLX3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIKQvLX3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d5ad9c32so15806897c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625021; x=1779229821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hYdGfI+DeEsc9K700F//NcckZeZc8MfNIBnOdSXLoA=;
        b=rIKQvLX3VjqjoBd2DSBoOzLDcUAJuuxQp6JQQNJL7C92TxWgV9Bf0BlpkRE9OD/clB
         xDajUz3jC1Go8BiJkB+YS19wCNxEj/lS1Gl84X5gpKK/+b7ISSy2pK1V2lFGQCV+kwF/
         ZnmFiBzPkpyJUtcXAXod6S6utJsSo76mX5V8StEBhKhhmOkAHkKEAgx40FIW0SHZXJRq
         3Lgvv6L0hvDRrEwNHIN/LB33lFWQvZ+ydI6oM8Jj3zv2igsToxadsMCyVtXZKfWZEmjl
         mGmjUAm7cRKTz2fsD/yipEdGV1gqFdMKwnDC96faZV0uswlx1p/BB830/aH2DSgWUI8j
         OExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625021; x=1779229821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hYdGfI+DeEsc9K700F//NcckZeZc8MfNIBnOdSXLoA=;
        b=PH6Qf4HR4vG1Z81W3felVSCgXHobv1kMNbQ7mtE0YRB2ze5RTV+//jPJzcb6vDEBkL
         t5NpKK/LQoF3cnFYVjsJdU8d8IulvwT2+BdqjvSKMvbcxS1lwDkSdE1PyD91uwnrx6r4
         lJszOCPsOyJCxtzVtehklctguM1oHKZstglYbqHAgxTjuJdJxvmT3P0eTNHN5F8+c23b
         oivxa80TPd4cVDmPop86ykfrjvnJMOCRIXLwIWAS8hjT96zPQMXuNo5cre1JUGshCPtr
         9cYta+72+sWlJJ0tX47Q8KtkLygnep5xIS7fSk202WAex+fjdmVvVarlsdx/GJKa6d3o
         Qkcw==
X-Forwarded-Encrypted: i=1; AFNElJ/NTBWOw+v8ZpdYvAPTrKoSuRfKDRnBf2jCmirKxoU5ndjxyoLxVg7Sezm6ZKpW7djun2dPFBdqomL3ZgpUA2Im@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kh8zpT0yAS01pD2Sm/oxRUQpyh35ERq5Pm9ATAQlHzbMLw5q
	YnpzK7h5J46c6qatmWBpAPtur/yhkUsRcI3T/9jptvf69Kx98mui0qlSs84/cEWJB90evL9kpd4
	p66XDBm1GDw==
X-Received: from dlaf19.prod.google.com ([2002:a05:701b:2413:b0:132:8d92:4d78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:10b:b0:12b:f881:d8fb
 with SMTP id a92af1059eb24-1342ee3a2aemr559659c88.3.1778625020840; Tue, 12
 May 2026 15:30:20 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:29 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-1-irogers@google.com>
Subject: [PATCH v13 00/32] perf tool: Add evsel to perf_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Nearly all perf code ends up passing an evsel with the perf_sample,
which is problematic if you want to rewrite the evsel such as with
off-CPU processing - all uses of the evsel need fixing up. Previously
I'd mailed this patch as an RFC with everything combined:
https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
and there was a request to break it up.

v13: Rebase removing patches merged by Namhyung. Namhyung proposed
     changes that are in this series, but we became diverged. Address
     some minor Sashiko issues.

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
 61 files changed, 991 insertions(+), 913 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

