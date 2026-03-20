Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6173F0750
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034883; cv=none; b=ndBjCuDOhWhb7neXdwYbSilE+ZWmSKc0VFhSA2AimXJs2tuwV3IseHYZo5QWL9vx3vKa6h3qAw3NurHgcoI9lw4wTawn/4Q3osnff9JOr6Dt0bk6P7/xhmKgHKpzQo0WBDJAA91XyA4LGFEI22BwKYWnRgBFnk3RAQ/GGHu680c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034883; c=relaxed/simple;
	bh=/d4vwDuvMS4zULAteVw+kHoOWi4NZ54E1g0osajsIYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HCDG2lPHp1syaUnLVKVRTxMROi/goDl5RnMHPGloFrVH95PJgrRyEKRDHwAeO8xSxupFy9rxMFxCvSMOyQ0ycg/Iogfie+PXop/KQV8Lft6ZAFAFCUY9geElWYp7oAsXUnjADMO1aANjRyWWJb33vOPUUxqTFBbilIU5/lQrZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMOcntXH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMOcntXH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128edc72e5bso14094400c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034879; x=1774639679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsAZDZzDqBXQOfSTsHLqzkN2utZr7SjlP0HAniLjSdU=;
        b=RMOcntXHxZiDrHxeJzdxiSQqgl5Pg4DuhRtGdHKTjCKcYO0fzqOKDvnHCxfAa0Hge8
         c3U5Ddj6c+AEIK/jeQB99KZFnHUNMErYtfxjZcxXeyTbdJh0wLjfOTfN4RkcHZsYzXUd
         JPisFabZEy8tXpxJjRHNgAjCiO133BUNYxk/Vs6OD3S6wm7QYoStEsNU4JQqUfk6aLFx
         an6pzjMSpTwh39PuxC8WbTxGe5AVzHNRrLUhfW+cXLU7R13cBX9Dqa1S1PYkNF5r5UW/
         TNKwz6Nmy4p28AKNIYgHcecPIc/+l+PyjJXtW605OVPosPXNIgrVdCoUQc5pUJG2Cb96
         Ktqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034879; x=1774639679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsAZDZzDqBXQOfSTsHLqzkN2utZr7SjlP0HAniLjSdU=;
        b=jAJMcRKeCs29Rnvp94AL2OGqnQbmA2LPe9sO0Kud/JEdQNzCB3vr4MJDk4J1LfJ1jD
         NWJorp6LUnikfj6UgMGsJ2ZWJ6HjSU3BnwHe9vx262j5fZ/vvbUzXmrwbPzhZtJNrm6Q
         NAizhi516WC9bz8FkjFVimJle7qs1O03uS5Xq8w+nFXQdTeBwqwY6m9/k1S0YPs2xzCl
         kOoijgr1bbVmINXZ6cdMek7RxaJs+JtpzcipFOv+GIxtYYSRoGpLbJy6Y3Rc0JQHZAW0
         oS6EPXb461NZ2wFZ31DtMcjyhrXYk2NUXGb/sXEXo8NyZUPUrGXWc9DCjXfEn7aEbB+9
         iO7A==
X-Forwarded-Encrypted: i=1; AJvYcCUDXwG+jMOviY1iULfPamPrAYTV0RoKGafOk0H6+Q5xxJPtoIaEEFcIBASeBpkJJvPImQ1HZzjBesBF+kXdwhk+@vger.kernel.org
X-Gm-Message-State: AOJu0YyidbK4CbKX+s1u1B7vItFYajLpb6v2Oe+VJ4X+O/ynGmDWK36R
	CDEswzomHKxzUVgdv+OFSD1iCZZoi/Ur5QspFlcRpnYEvyhKKNnapd6hIgOTGfMeqTpbQztPUe6
	vaFiMDBz7Ag==
X-Received: from dlea10-n1.prod.google.com ([2002:a05:701b:420a:10b0:128:cf1e:df72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62a9:b0:128:d714:3ca1
 with SMTP id a92af1059eb24-12a7266cd77mr1857460c88.5.1774034879090; Fri, 20
 Mar 2026 12:27:59 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:02 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-1-irogers@google.com>
Subject: [PATCH v4 00/25] perf tool: Add evsel to perf_sample
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

I've started the series by adding documentation to struct
perf_sample. Next I fixed missing perf_sample__init/exit largely from
the recent perf inject callchain rewriting work. The 3rd patch adds
the evsel to struct perf_sample and ensures it is correctly
initialized. The next 22 patches avoid passing the evsel along with
sample for different parts of the perf tool, along with some minor
tweaks like constification and not determining the evsel if it is
present in the sample.

v4: Fix more sashiko issues: bounds checks, memory safety, making
    refactors better, inconsistent evsels, mmap2 buildid injection
    choice of evsel, mismatched function arguments.
https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40google.com

v3: Fix various sashiko review comments particularly about unintended
    behavior changes.
https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google.com/

v2: Add review feedback on the first 2 patches from Namhyung, fix a
    missed evsel assignment running event2evsel in builtin-inject.
https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.com/

Ian Rogers (25):
  perf sample: Document struct perf_sample
  perf sample: Make sure perf_sample__init/exit are used
  perf sample: Add evsel to struct perf_sample
  perf tool: Remove evsel from tool APIs that pass the sample
  perf kvm: Don't pass evsel with sample
  perf evsel: Refactor evsel__intval to perf_sample__intval
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

 tools/perf/builtin-annotate.c                 |  28 ++-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-inject.c                   |  87 ++++----
 tools/perf/builtin-kmem.c                     |  85 ++++----
 tools/perf/builtin-kvm.c                      |  22 +-
 tools/perf/builtin-kwork.c                    | 104 ++++------
 tools/perf/builtin-lock.c                     | 117 +++++------
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++--
 tools/perf/builtin-sched.c                    | 188 ++++++++----------
 tools/perf/builtin-script.c                   |  26 ++-
 tools/perf/builtin-timechart.c                | 145 +++++++-------
 tools/perf/builtin-top.c                      |  19 +-
 tools/perf/builtin-trace.c                    | 120 +++++------
 tools/perf/tests/hists_cumulate.c             |   3 +-
 tools/perf/tests/hists_filter.c               |   2 +-
 tools/perf/tests/hists_output.c               |   3 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
 tools/perf/tests/perf-record.c                |   1 +
 tools/perf/tests/switch-tracking.c            |  11 +-
 tools/perf/util/annotate.c                    |  19 +-
 tools/perf/util/annotate.h                    |   6 +-
 tools/perf/util/build-id.c                    |   3 +-
 tools/perf/util/build-id.h                    |   7 +-
 tools/perf/util/callchain.c                   |  18 +-
 tools/perf/util/callchain.h                   |   5 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evlist.c                      |   5 +-
 tools/perf/util/evsel.c                       | 101 +++++++---
 tools/perf/util/evsel.h                       |  12 +-
 tools/perf/util/hist.c                        |  26 +--
 tools/perf/util/hist.h                        |   3 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/intel-tpebs.c                 |   3 +-
 tools/perf/util/jitdump.c                     |   2 +-
 .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  19 +-
 .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  17 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  17 +-
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  17 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-s390.c |  20 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  70 +++----
 tools/perf/util/kvm-stat.c                    |  19 +-
 tools/perf/util/kvm-stat.h                    |  18 +-
 tools/perf/util/kwork.h                       |   9 +-
 tools/perf/util/machine.c                     |  14 +-
 tools/perf/util/machine.h                     |   3 -
 tools/perf/util/powerpc-vpadtl.c              |  10 +-
 tools/perf/util/s390-sample-raw.c             |  31 +--
 tools/perf/util/sample.c                      |  11 +-
 tools/perf/util/sample.h                      | 119 ++++++++++-
 .../util/scripting-engines/trace-event-perl.c |  23 +--
 .../scripting-engines/trace-event-python.c    |  47 ++---
 tools/perf/util/session.c                     |  74 ++++---
 tools/perf/util/synthetic-events.c            |  45 +++--
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 65 files changed, 973 insertions(+), 883 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

