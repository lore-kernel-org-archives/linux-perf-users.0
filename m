Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1413FB06C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962642; cv=none; b=r7F0dEm2GDodBKKl8xStZlv+m22LhwjZcJ+YDw/ZrWBmgockWMz5nd3zzed5p+pYpZqNbd8MQ/7SXYQSDacUa60IF1dHUzb7kFq5oQNo6flp81H1mpjPTuk0cT6epDg2Ud42vDbZ32N8OXY1feFfHjyPvYGAlqYBcVjf4UwTthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962642; c=relaxed/simple;
	bh=fyBLBJtFWLrCoT30aL2/hhfXjNw0FtIgx5j18nj7m44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r808j49+larTvqlHQHjXURHBkhDQOb+ewmq/896dQSBFwxd2OVzhGc2Y1XuAiwYfHy1EH/RYkg+RF+cEFyGgd+TA8GunB5ljqU+/vvNgRs5386QTnWMW6D42AX9RDcpGaZPsuLXZlJzkuK0XogVZjvRJBgFfT9csCQTUmZ0H8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h95mwr7L; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h95mwr7L"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1276e71652fso70201c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962639; x=1774567439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMxs+MiOwNOIbq145/xttpf/Gy8y4MNEvWrxQX3EgtY=;
        b=h95mwr7La2YR3Y8BKkRlchMCHSSROyaqV+xycAlULvnrJxK4KHZc7LjbVCgIQrg/7x
         ALIdNYsH4exH5kQ1HKpZAh495AF1Op5nsaoCMzCGkGZaMLDjudjSDVP0plrvGzUL2edH
         Uis1dTv6QEXjD/As7yjqOPNgweZAQrxax1u4EgZ09OtHZBc87OfYOgClYny33rzAmEUV
         dkH7PhhFA/fo/Gwl/SxwMpEG/xGrpVhyU/UA2M43DyOB2FjwXQiCzgetx7GylhHGdhiQ
         x+kh8by/0CAQZTvb/ExMRj63q2Ft3u9nh0u8I9vKEw32itj+iXMJYX5WP1KyEEWgYWzT
         ziOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962639; x=1774567439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMxs+MiOwNOIbq145/xttpf/Gy8y4MNEvWrxQX3EgtY=;
        b=RXGQDfKOTnFB13B+Dmpv3bfOKnr66LF7XJ/L+03WrgQnY1x4YfykznFiNCrjBG9EEU
         VlTfy27MTBAurWM/rgrZSOUUaKQVJjeOaobcwIQTSi17cv/YnBDibdT7WFiP82ztWmxi
         qkllrMnOc15sjSBOPMVVryThCLXDfiTJx6suFbUpbePCOJgsXz4q6gJACc/RuRDDbflI
         UbjoYwWlos7juNmVChWnDTn74NxR6HHWptYQG7i/IE76cjsN/xcyWl1ruHKloceNK7GE
         l7tGaS74+d+sf7r6Cw7nKQctyXwnGATMrdWhSb+qMoz4bzDv72p1tk033JgGYFyba3fJ
         OqlA==
X-Forwarded-Encrypted: i=1; AJvYcCW47mFExnxTrzhSfrCWHhTjHwzlAvAHtN4M+NdMT7feM/MGcyIMfmh5CVwfW0Js7YL4NMbYu92m6HH9Bhf3Wlwb@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrY00vK0KbOw5q3pHHWZNDZtiuhBwsgOPzNO70FgLTofBjYZb
	JkIoX0/npF841nE0eXVlPUg5uAB8uDMZBR4e967vbonSIjApsPtOrEyt9w1kCnpheEzTKlkCYl8
	uyih/VfL0+Q==
X-Received: from dlee11.prod.google.com ([2002:a05:7022:628b:b0:128:cf86:d1c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1b09:b0:12a:6ab7:3f71
 with SMTP id a92af1059eb24-12a7264eb70mr498857c88.7.1773962639024; Thu, 19
 Mar 2026 16:23:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:09 -0700
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-1-irogers@google.com>
Subject: [PATCH v2 00/25] perf tool: Add evsel to perf_sample
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

v1: Add review feedback on the first 2 patches from Namhyung, fix a
    missed evsel assignment running event2evsel in builtin-inject.
https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@google.com/

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
 tools/perf/builtin-inject.c                   |  79 ++++----
 tools/perf/builtin-kmem.c                     |  58 +++---
 tools/perf/builtin-kvm.c                      |  22 +--
 tools/perf/builtin-kwork.c                    | 104 ++++------
 tools/perf/builtin-lock.c                     | 117 +++++------
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++--
 tools/perf/builtin-sched.c                    | 183 ++++++++----------
 tools/perf/builtin-script.c                   |  26 ++-
 tools/perf/builtin-timechart.c                |  76 +++-----
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
 tools/perf/util/callchain.c                   |   8 +-
 tools/perf/util/callchain.h                   |   5 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   5 +-
 tools/perf/util/db-export.c                   |  13 +-
 tools/perf/util/db-export.h                   |   3 +-
 tools/perf/util/evlist.c                      |   5 +-
 tools/perf/util/evsel.c                       |  60 +++---
 tools/perf/util/evsel.h                       |  12 +-
 tools/perf/util/hist.c                        |  26 +--
 tools/perf/util/hist.h                        |   3 +-
 tools/perf/util/intel-pt.c                    |  12 +-
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
 tools/perf/util/s390-sample-raw.c             |  15 +-
 tools/perf/util/sample.c                      |  10 +-
 tools/perf/util/sample.h                      | 113 ++++++++++-
 .../util/scripting-engines/trace-event-perl.c |  23 +--
 .../scripting-engines/trace-event-python.c    |  47 ++---
 tools/perf/util/session.c                     |  74 ++++---
 tools/perf/util/synthetic-events.c            |   9 +-
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 63 files changed, 792 insertions(+), 825 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

