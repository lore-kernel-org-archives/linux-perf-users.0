Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49C3431E6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633168; cv=none; b=WXFTm3c1A7HJDfWjAT792eF5SX7hZc2XqnKuAvA2JN48qk6yIJ/mgQ5ItW0KQbwPEWG6enlygth4LbCmRvEdCbTsasbL9d0vOdEtdE8P9mAfnj6gYt25yghAWuOVlSNjWy1GjK6FV+aFPySR0w2QoVQxMwX7q4SZZSHfe3/VCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633168; c=relaxed/simple;
	bh=h6TzlL3aRVg32XITJkqLWbQJgnLqRRroyFf6mRgymwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgomizOlYM8RNTorrQCSTOTKWslrv0S22nqnwxx9G5+SKWUHh/qDUSueA9Mo5kTEAJzkVdXAuvWdN/vFczy/6pVkzTE9IWUpvP59zj7+3MByy7QI1AQhz401djds7D5xNcveMUyNBbjNxT3Ve020fpwP8yJZegnhRr4MWQb0n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTO14I1q; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTO14I1q"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12bf921cf49so7284245c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633166; x=1776237966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx0ny8DoQttgKaDosIm0olvf2WotDhqSPWLqt0v+exA=;
        b=VTO14I1q3BdpHzrG+UOH7N4Bf6++IObNyKgK4J6uK3OXOcoFPqOERIDa3gY9JgpFMl
         btmju8TAdaI9ynrqsUYVvWUuHF9WlY8yxNWaP+/cyLEx+2pbh1CqJX8yZ0VZNpT8bIlB
         J6AEdotI7iVgr+nQTe6hmBFS7qv+uCPh79StLKPTwwwqA/dk0l8JDWrfXIm40Hq+oNGB
         h0axQBGo2XxSnoNnFIGMZyS8ZKKpZv4HgsAB/tyr7ppCP9QRn4Zip0K37SVyTxdJYrxf
         AU/kpnwILmkdbZrk5om3820sAaYkURCvMw0QwLxKmBArUkpUZrH/C+B/M+DkpW2r6v8o
         IYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633166; x=1776237966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx0ny8DoQttgKaDosIm0olvf2WotDhqSPWLqt0v+exA=;
        b=Kn5F1+jWwNLqYhjKpwat6RJHVgf0gYAuUAEszm68yQZSzXMcDeeYAhpBuvzuUldKRY
         YGeRcZG+00PNlHjhomc3DjkSUFNtVw6xtWGLNZPa/7VOQk+FcYwkV7cCu9wHzZYbBtWx
         FW2gTZJEnjXRj5XXYO/I0DlsxHmgb6M8o7NrcpdtfvSuLw2ZeZXl+WCdjzwYks6zxnOG
         is8dd6ux8PMkEQMOhE+d6R0+ZVKaEZrc7xTbO/rJpEoI7NZctipveh3yRq+NANRg1VxA
         kI/VS2CqlL3g8azTKkbEWdi4HoKziUZpho6Dg1o+UDnsZoIcqueIKEsVuhHNPSSYsWJe
         f51Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPbhoSPsToIvzQphHqHynh/9c1q2gW8QD43xYW9SLZ+ou+MsyE8ibzg+XO+28F3h9KyHJjC8WLsGMi7FUguw69@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzc0NCy5Jf6999t67+uwyvIKqJ03sUckVjsUTvj5TgmpnRXdNE
	Cljstgc5MbkQ4CINMHhh9HLFoBoqRhCf+vhqTur8nrdJV3D7pE16ztr2fDousIN/KCGmGkaA+5N
	LeU0FaJxR5A==
X-Received: from dlbur1.prod.google.com ([2002:a05:7022:ea41:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:10d:b0:128:d967:4678
 with SMTP id a92af1059eb24-12bfb74427cmr9114728c88.23.1775633165907; Wed, 08
 Apr 2026 00:26:05 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:38 -0700
In-Reply-To: <adPyeCq3rQrTurju@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-1-irogers@google.com>
Subject: [PATCH v7 00/23] perf tool: Add evsel to perf_sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
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

I started the series by adding documentation to struct
perf_sample. Next I fixed missing perf_sample__init/exit largely from
the recent perf inject callchain rewriting work. Then I added the
evsel to struct perf_sample and ensured it is correctly
initialized. These patches were merged from v6.

The next 23 patches avoid passing the evsel along with sample for
different parts of the perf tool, along with some minor tweaks like
constification and not determining the evsel if it is present in the
sample.

v7: Separate out kwork work->name to a strdup into its own patch, now patch 4.

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

Ian Rogers (23):
  perf tool: Remove evsel from tool APIs that pass the sample
  perf kvm: Don't pass evsel with sample
  perf evsel: Refactor evsel tracepoint sample accessors perf_sample
  perf kwork: Duplicate IRQ name in irq_work_init
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
 tools/perf/builtin-inject.c                   |  75 ++++---
 tools/perf/builtin-kmem.c                     |  95 +++++----
 tools/perf/builtin-kvm.c                      |  22 +-
 tools/perf/builtin-kwork.c                    | 104 ++++------
 tools/perf/builtin-lock.c                     | 120 +++++------
 tools/perf/builtin-mem.c                      |   1 -
 tools/perf/builtin-record.c                   |   3 +-
 tools/perf/builtin-report.c                   |  38 ++--
 tools/perf/builtin-sched.c                    | 188 ++++++++----------
 tools/perf/builtin-script.c                   |  22 +-
 tools/perf/builtin-timechart.c                | 151 +++++++-------
 tools/perf/builtin-top.c                      |  19 +-
 tools/perf/builtin-trace.c                    | 120 +++++------
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
 tools/perf/util/evsel.c                       |  86 ++++++--
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
 tools/perf/util/s390-sample-raw.c             |  31 +--
 .../util/scripting-engines/trace-event-perl.c |  23 +--
 .../scripting-engines/trace-event-python.c    |  47 ++---
 tools/perf/util/session.c                     |  38 ++--
 tools/perf/util/synthetic-events.c            |  57 ++++--
 tools/perf/util/synthetic-events.h            |   2 -
 tools/perf/util/tool.c                        |   4 +-
 tools/perf/util/tool.h                        |   4 +-
 tools/perf/util/trace-event-scripting.c       |   5 +-
 tools/perf/util/trace-event.h                 |   3 -
 60 files changed, 809 insertions(+), 849 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

