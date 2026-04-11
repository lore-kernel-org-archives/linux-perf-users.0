Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCD2EA468
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890645; cv=none; b=lGZEaOxIJ1at/8X0qGu4LAJmx/DUbgL60WmWxcQdFBTRTX0WIlPylUy0xtA9Z1qgGRCIEVW/g8afRjH5iWQhiNo2lmR8rI/16jcDWFO2cOhOC4IPlQugbxbR4OlubLUrURg2T4FPi1CO4AnaopL5t63JTJSEdHhmXvP9sHH0bWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890645; c=relaxed/simple;
	bh=y+CYJVf/xXExCEvjhS9Sc77dxdb8b8RgD7UguMjiExE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QjPab8FSeaXyq8cwRz8PWeRWyPrkN6th8Ts9BYfpxVsPxbfqhujw+Fes35jc5HtUyFkpLyN8awuXSdt0dBtvvx6M85jMgiaHblWMJPWkXWTB4wdO6M9Ph24PfV+mERS8Y0KIxPs7Q8+OSkAHubVH8eLQSd9DWH0PbR261aBnlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcZnjRMD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcZnjRMD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c21dbc9c1so7240658c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890643; x=1776495443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgx8ZNP43Bre7tFT5zMzC+olmFYSSJzYrMdZEUAKK4o=;
        b=bcZnjRMD/iXeZtr11r8g2SXGaT2pKvAQbqNlgVaHwa2dQHL+hqS121DRkvRSymcKZq
         XsuvdItx+1yDMkJyX/CK8D77RG3CPZCu0d2mEUrzWrGfneCYvPu/tpCmVpZXNU9hK/O7
         C85ans4e83D+WDu3AOmMszo9hBAZKa2Km3PUuemhngUB0TVAXiRWwe3bKYNinzzibZlq
         ZWiAOAz9DnGhl3lT9A62e6pCsn8+wWiaHRE4N2FYqJZ0nk3tpQ0rnG3ivX4GnJXuzPUz
         AEhgtdPwo+u26P4sEL654dk6DdWLLviBIuAYDYNhyfPF0xdFvHVOf7UIIUPKdTtSuvH5
         RC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890643; x=1776495443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgx8ZNP43Bre7tFT5zMzC+olmFYSSJzYrMdZEUAKK4o=;
        b=ko/CsM0hIxrb4ZAEvgDg7At5rqeNPTaXjJ4xDN+xjLkRX/+R/75oM5epXDDiP0xV2J
         vr+u+conRtCm8X3Gow/Z2BQpRzSGINh75FOH/hjnSRvy3GhEvZse452gAcVgyDQ0ae5O
         sFGzf4nKMHcCcEciLnpcf3y4bEafBcRfCpzzNNrhG8S8T/w69e7KjXg9vkJhTKpkEXcK
         D3d8VF/oo0A+I+x6xt7wRL4Nps/K28Pk+mTvPREUYqzbc6RlAQfutyX/mTI6OIpWZ73i
         tk/Ye60q421wjHgL/eEUZG2YEMvJkkT4KOM+CWJqLOVyYTVZOik4ytd2z+l2eD3Ix0/B
         9XvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObely8IvOeoxuZOxfvjZarN8N5QECrUIhCzE+udcDx9Adj41ovQyfNMe0CNh0q+7uQtdmGEFx1Jrhu4/kvc7d@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRnj9nLjsBzDu7T9gZ3C2ZOc86fm2v1u3IBfFsXMwaVmS6Cmg
	KKAnEQjkXhYWEukBVZiCXkU1BrlFiBN5EvhM6vF6htHwm3VKyQWyn7g+y0Pw4T7Ozxlwpw3v5Do
	C104BKBHcBQ==
X-Received: from dybmt4.prod.google.com ([2002:a05:7300:d584:b0:2d1:42ae:a5af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7b86:b0:2c6:7f49:a85d
 with SMTP id 5a478bee46e88-2d5898aa2femr4031303eec.22.1775890642383; Fri, 10
 Apr 2026 23:57:22 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:49 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-1-irogers@google.com>
Subject: [PATCH v8 00/29] perf tool: Add evsel to perf_sample
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

v8: Fix address sanitizer issues with kwork and move patches, along
    with bound check additions, to end of series.

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
 tools/perf/builtin-kwork.c                    | 250 +++++++++++-------
 tools/perf/builtin-lock.c                     | 121 ++++-----
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++-
 tools/perf/builtin-sched.c                    | 188 ++++++-------
 tools/perf/builtin-script.c                   |  22 +-
 tools/perf/builtin-timechart.c                | 151 ++++++-----
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
 tools/perf/util/kwork.h                       |   9 +-
 tools/perf/util/machine.c                     |  14 +-
 tools/perf/util/machine.h                     |   3 -
 tools/perf/util/s390-sample-raw.c             |  31 ++-
 tools/perf/util/sample.h                      |   2 +-
 .../util/scripting-engines/trace-event-perl.c |  23 +-
 .../scripting-engines/trace-event-python.c    |  47 ++--
 tools/perf/util/session.c                     |  38 +--
 tools/perf/util/synthetic-events.c            |  58 +++-
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 61 files changed, 926 insertions(+), 883 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

