Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C83469F4
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248826; cv=none; b=aEp3pwfuXhOCAVhHnM2nhnQEvfRERDCOogAxB6YyCIMSRuQm2otKt7JK76F29BcoTHyT6XBs387+QGb4X0zH9lEoHZYwzMJxm5Xc2nUsJiMHKI+/vwkYfDO9zRm5aGsa1o27u9LAJffWQ29GnL+9z/FYn+kO7osuZz1LZGJsplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248826; c=relaxed/simple;
	bh=eZ3q72/Lisy3cMdl0smfxfuIQlte1R4O9oMsG457qh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+x0jFsW0XlRLwjszEmbjO0PxsjTzMiImhLvxbltge07ZUkIS1sSo3hitJretx/rBLS6kGu/GeHyLzV7R2EAiDXF6ELCDXdt7MBayM0HWR0HS0va2L6oirWMcn1dwRoavbtaK8xmfG/QdpIrUy9DJAABX1/EssJxsrRFzmT5Tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuY6hd52; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuY6hd52"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127337c8e52so6838138c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248824; x=1775853624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t31q80oLVm+YtqGBUKN9eDTIA/pp7p4fV8bqmagGuXI=;
        b=PuY6hd5211yBgT+s7rxhzARk8Tm99E3A0SZrPuEBCoGGNc8kxjKCvx6fKgPgFNf5n4
         fDaaT307OwE7GNfO4Knj5RIgX3SGFoeO0IBjgMxRVW4a92VYJ/4oe07LFMkaVugVYb3z
         yjK1TFk5PZ0xl9/GRXaitu0Uh6Al7Hzk2sTUkIloQv3rp2GA3V1VccsxwU21a6etxJ7P
         AiBv9iwOlDzeYtd3StGxmd9BuvcHi11X2u6w6mppNWrSwywAku5TO7FRaOFq/ysFJv3u
         5rWQKUGh86RPzvjdFl49mnO+jnsvc0Zhg0r3EjECDCqYWjVezAMDrX1d8iotKKXNErDK
         jQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248824; x=1775853624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t31q80oLVm+YtqGBUKN9eDTIA/pp7p4fV8bqmagGuXI=;
        b=FGFwNO632C3WhuS6H6e1fin+7xN2+VFOpkR6mna1M1mCD5hC2/0a54HXmxXlVcMVhA
         +MNJjYiHb78XZtCy/ErtmhjKvjcvEfL8eS+nvon9nFp+z7hGRxWyB5r1aIMNYEQUnZXr
         Y6Q4dX55wmNxNC1qAqvnnd3+RvZAz1cP5zE0VJjkJXUS248+BrfL5e8U5gFOXkQrpXpT
         F8zoEwhl/GNf7LdWBcdyazXAi5xvUya4xzWsjUkgBmZMfPTAET3oYoLqK6hLa272Ka2F
         jlsEGG/Mdgj3JAdV6hM9b/FlnBkMGRAcRfVyasso6qA1nDvRn8mC0RmL8oY0WvRAaNQl
         b84Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgajPXL/GRVVLay6JzNUekFn74fJqLb4UJJJ66fp3+6NPz/u2tW37byHmFn5Ojtou6FV+8PeX91LLRqvdikAVA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VY2/8EBeUad3zGuqawyRDbCVErdjLoUmIOsuNYLQskBxDhaw
	KF8AabpZO3nLORihAp3EuZeoKBev+hllMF/F3vLaxuO5Qgl2beTDMOa1zNkcZg1g3AciJozbzO1
	480+0e2kOTQ==
X-Received: from dlbts22-n2.prod.google.com ([2002:a05:7022:b056:20b0:12b:dc0c:82a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b81:b0:12a:6fb7:87e3
 with SMTP id a92af1059eb24-12bfb766789mr2184989c88.31.1775248824085; Fri, 03
 Apr 2026 13:40:24 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:39:52 -0700
In-Reply-To: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-1-irogers@google.com>
Subject: [PATCH v5 00/25] perf tool: Add evsel to perf_sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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

I've started the series by adding documentation to struct
perf_sample. Next I fixed missing perf_sample__init/exit largely from
the recent perf inject callchain rewriting work. The 3rd patch adds
the evsel to struct perf_sample and ensures it is correctly
initialized. The next 22 patches avoid passing the evsel along with
sample for different parts of the perf tool, along with some minor
tweaks like constification and not determining the evsel if it is
present in the sample.

v5: Address feedback from Sashiko and Namhyung.

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

 tools/perf/builtin-annotate.c                 |  28 ++-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-inject.c                   | 136 +++++++------
 tools/perf/builtin-kmem.c                     |  95 +++++----
 tools/perf/builtin-kvm.c                      |  22 +-
 tools/perf/builtin-kwork.c                    | 104 ++++------
 tools/perf/builtin-lock.c                     | 120 +++++------
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++--
 tools/perf/builtin-sched.c                    | 188 ++++++++----------
 tools/perf/builtin-script.c                   |  26 ++-
 tools/perf/builtin-timechart.c                | 151 +++++++-------
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
 tools/perf/util/callchain.h                   |   6 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evlist.c                      |   5 +-
 tools/perf/util/evsel.c                       | 115 ++++++++---
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
 tools/perf/util/synthetic-events.c            |  92 ++++++---
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 65 files changed, 1061 insertions(+), 925 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

