Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CE35CBC4
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994120; cv=none; b=uTZEOSWgHmY9v2hyowfAGjsacPUARJK8XVe8mNVkrIA4bbAPjw/Rs/98KykVfgMBEb7ksZpTBxnkFnE5S2lI3yvpod89+4alkkPFRn3pS7uK3g8Pn19GS1LO0PmRFobhAcA1V9eAyYktvoVr49Eawd4w+HXfOprNNcpgVr6E/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994120; c=relaxed/simple;
	bh=DZTG3OmFy81hw6pv+Af8LY2ebvEVIhBEscBUtPiEcxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CwPGEv6RXImDJJK4GndsG2xmTNA3wu9CnCrLsZ77M3XXD/EhcSVsv/Jr6koIS2pzw6nXIcRO5cx3/738FH/xfY26coatJhkJLgXn75fmmwLFtJpny7PjhHWuAillUEv4LuaBNSJDu489L5fE+oBpnG8BbMt5g8zSkoC2pxbtZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7oFpyK5; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7oFpyK5"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1450618eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994118; x=1774598918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcJ2/XO6PKiNLJDkn1s4iALr8QicIGLhEqh3WDQj5vo=;
        b=H7oFpyK5DEuhW9KpJH+KTxhrD7+z1vkOF4Tj4QIsNgV9fP3PFC+4q1eb2W8vFDrO2b
         QlSSmrRk6ngNhshienv9NuByjsTqLQcH1PnhrffJSx2LXG8FhhUphklRXzmgBynkc+4o
         pPSpBK2nWSBUP0xB9Am8BThDYPxC+KAALkgV9+yTE2ab/sCXJmkP8U0dYiv0Sh2cuFpj
         DORU5kO3QRh5shOW1h4WCcWtoT8wtrBGmmSYiez8ZT3nvkhuJA0SznC3nK7s+3r5s9Qa
         tCC7ZX7n6kBK1h1v8Lx4Ze5WHeNGddJizaQ4roGVOleTieWN4FMPeWWpNHNbU6C3RnGi
         f58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994118; x=1774598918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcJ2/XO6PKiNLJDkn1s4iALr8QicIGLhEqh3WDQj5vo=;
        b=P9PeI5hJKmBhSEuFulEz1FadFxQbLezBJZg3xPpxO9LW/h8YInf0s7ay70gMZQyVm1
         GbgnHI7VQvR2V2B+f1LBoL4pdSVwOdX3+7OOp1jV8lJso1nQbaIK5NJTgtK8+dyWuYjr
         ujgb1LDqJKAFOWoSkLlCqOchzXerDdftWLfFStCE/ntuoBcvY/BNGJr0GOzqStfFTs9u
         GRPZXPlUZpIx0jbvt8S6C0KTbE3Le2QgwgGuDsc+AgYfa5Ai5N61Hlc6XY0icUPqwBjJ
         X98cclG7eZMdAmLQ8zN2xG+rx9LPYB0O4IQeROsj8D8V9b2qWotAP3TFHYT27Z0XVR5+
         MBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWv0Guhsb6MdDP6DECGQwFe9AWPtyV+Q3gJw2NjJLOrDnwjuWzc0HSNlET0hGJqRlsj9K6sdXhfWOdK/6cI6JoO@vger.kernel.org
X-Gm-Message-State: AOJu0YydBomNoIjyn/QK2Igg8cB2aug3kZM6NsthjxLco+a6dg7nTvca
	W7SnOvgSul6KIvyVaNyK3tLA2I72+r2t2sjM6k/DBz2cKjfSHPYmv6Z+F0A7Z9mgraB6oJ2qEO+
	uTvmMtBNVgg==
X-Received: from dybqr11.prod.google.com ([2002:a05:7301:608b:b0:2c0:ff82:5859])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:caca:b0:2c0:cb34:7d54
 with SMTP id 5a478bee46e88-2c1097a78b5mr1038496eec.28.1773994117877; Fri, 20
 Mar 2026 01:08:37 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:09 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-1-irogers@google.com>
Subject: [PATCH v3 00/25] perf tool: Add evsel to perf_sample
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

v3: Fix various sashiko review comments particularly about unintended
    behavior changes.

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
  perf s390-sample-raw: Don't pass evsel with sample
  perf evsel: Don't pass evsel with sample

 tools/perf/builtin-annotate.c                 |  28 ++-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-diff.c                     |   5 +-
 tools/perf/builtin-inject.c                   |  83 ++++----
 tools/perf/builtin-kmem.c                     |  69 ++++---
 tools/perf/builtin-kvm.c                      |  22 +-
 tools/perf/builtin-kwork.c                    | 104 ++++------
 tools/perf/builtin-lock.c                     | 117 +++++------
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++--
 tools/perf/builtin-sched.c                    | 188 ++++++++----------
 tools/perf/builtin-script.c                   |  26 ++-
 tools/perf/builtin-timechart.c                | 129 ++++++------
 tools/perf/builtin-top.c                      |  19 +-
 tools/perf/builtin-trace.c                    | 103 +++++-----
 tools/perf/tests/hists_cumulate.c             |   3 +-
 tools/perf/tests/hists_filter.c               |   2 +-
 tools/perf/tests/hists_output.c               |   3 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
 tools/perf/tests/switch-tracking.c            |   9 +-
 tools/perf/util/annotate.c                    |  19 +-
 tools/perf/util/annotate.h                    |   6 +-
 tools/perf/util/build-id.c                    |   3 +-
 tools/perf/util/build-id.h                    |   7 +-
 tools/perf/util/callchain.c                   |   9 +-
 tools/perf/util/callchain.h                   |   5 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evlist.c                      |   5 +-
 tools/perf/util/evsel.c                       |  72 ++++---
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
 tools/perf/util/s390-sample-raw.c             |  15 +-
 tools/perf/util/sample.c                      |  11 +-
 tools/perf/util/sample.h                      | 119 ++++++++++-
 .../util/scripting-engines/trace-event-perl.c |  23 +--
 .../scripting-engines/trace-event-python.c    |  47 ++---
 tools/perf/util/session.c                     |  74 ++++---
 tools/perf/util/synthetic-events.c            |   9 +-
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 64 files changed, 861 insertions(+), 849 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

