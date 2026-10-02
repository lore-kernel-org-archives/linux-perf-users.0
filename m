Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805B4C14FF
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962751; cv=none; b=F7t564C9UkJDMRgEj8CrIIW9mCoaKPRd8N7v24nJZiHlXff4apcI24WRzrAsBOM+zZddGbl0TmdnOjw991bD9w26IARbWDdHfGriLZBA0IuF3CdQmrxZ6OhOi/7/IoLH6ivbvcrZNSDHZYSHRfA9mrl/r1j2fie3V1Hq4TBvyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962751; c=relaxed/simple;
	bh=Xr7gl1O7tUWeYnYjp3h+rl1DfUUJfD9r7moAd8iHszo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LO9bnx0BbIs+to5xAvRmMC2H37LANNziSe19pxeBcKp+UjAfY6S1cSl2ByaP8PQ8sQUgUo64hvW5iKzkZMN/q5xUHiM7MwYuY1E+rqx8G9a7FXre2s61ZrXIdV14ca4jVU+tA3Ge4e7D0yBQ3hS1IXY3knW/JaJbqYMOFcOdniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXNLTIgZ; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXNLTIgZ"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1466ab2bc8dso12147916c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962739; x=1791567539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmvxgHWxHa98gaRPr2uuWkflJxrVkffEy5ezeMEfDRQ=;
        b=KXNLTIgZcJhdm533OW249tezI0wr2dBzPDPsA6iNVFRKAMBj8balpvb7vodj5ycFPv
         dQdpq1B4Ll14dUisaGCpvAXWu3gFOD7oM25JZr205qo2n0NuwcYIariGa9bMUKz0ckcE
         D99W5XSBpicycjpInGR8oYcsV8EOZ7rl7D0xLJV+q37m+/QEdx/OdA5HPq54PMY6RbyS
         RMEvjKQjbL8eUIVZlJnVGVhdQrSfRok7VSoSZQIYyo7AKPEWCMOQV0Jtte9fkYjNB48J
         yeRb2ZWFKo6oNaTpRmwQTWGlgGD1GMjVrdGlLvqRs4D4IWVD4bi0zbwan1aa4OfNiAG0
         35hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962739; x=1791567539;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmvxgHWxHa98gaRPr2uuWkflJxrVkffEy5ezeMEfDRQ=;
        b=SfTRLbUpdAKIKxkbDzCRrhM5jkmN+lnrOT3GBXxYO6ZRWJHxjTRbUCebE2xTjPbjzb
         2xwhrlUqvLirbJsOwPVHuO3DnUInIpZcmWziqIO8CgtyscP1PwiZtXEynWTBzXk2Dl1m
         ExnHRGrIB78qorYkPNm/sTW6M/jSZcdtYZ8FNZnZ7+SElHiKZS09thsq2XCvb8azUPbt
         CyNQhnhl2dD024uHVYiIbeSNrAqnRAG8VofzWJ+9jvOAdXCa3jTeRasf2cYnikbl5LEG
         FU2d5nPYqs5TnLZYJWNwo0z4TpMXuiTp80AJ+oFlo9rXt3Xr4MwMmBZ9+K9YB2FClz+z
         IUmg==
X-Forwarded-Encrypted: i=1; AKwUvByVfuK1KeyR2+YXbn8Llynjaj2aiSrM4EervkF1ddrqH1VIZO6ou6lICPgqcAn4HSbJ6My9snUAn57BMD0danD5@vger.kernel.org
X-Gm-Message-State: AFuF++lAe2xrY1dfDQINlPu3fAP2+URhIkmMBcemDYxAf0A/uAyfvA8z
	H678fRB83qR0eBauLMgbPYgcg0GH+Rfr3Z/ed4McI37fVJ/wMgrRDc9TKQZL75YlPDt+NvUDyef
	WjVPrW1GkzA==
X-Received: from dlbuj9.prod.google.com ([2002:a05:7022:3d89:b0:145:9130:6444])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e8a:b0:143:298f:33b8
 with SMTP id a92af1059eb24-151c4c11b5amr203004c88.44.1790962738977; Fri, 02
 Oct 2026 10:38:58 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:33 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-1-irogers@google.com>
Subject: [PATCH v2 0/8] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET to the perf_event UAPI and
implements full support across both the kernel and perf tools. It
builds on earlier work making build IDs the default and improving build
ID handling in perf [1].

Background & Motivation:

In order for perf to translate virtual addresses of samples into
symbols a file and offset within the file are needed. During event
synthesis perf will create mmap events to facilitate the translation
of a virtual address to a file and offset by modelling the address
space of a process. By directly recording in a sample the Build ID of
a file and the offset within it, no synthesis is necessary. The Build
ID and offset as a pair are much larger than a virtual address, so
there is a trade-off between synthesis cost and extra size for
samples. These changes facilitate Build ID and offset as a choice for
perf samples so the user can choose to use it when they believe it is
advantageous.

In practice perf still needs to map a build ID to a file, so by
default this change keeps synthesis to allow this. It is expected a
user that knows their build IDs, say through debuginfod, will disable
this option with --synth=no.

The kernel support uses the existing build ID and offset support used
by BPF stack traces (stack_map_get_build_id_offset()). When
attr.defer_callchain is enabled (the default for `perf record
--buildid-offset`), user-space build ID and offset resolution is
deferred to a task_work callback where page faults are permitted, with
resolved entries emitted via PERF_RECORD_CALLCHAIN_DEFERRED.

The Build ID and offset samples inherently don't leak ASLR
information. As with the ASLR remapping work in perf inject, support
is added to migrate virtual addresses to Build ID and offset (`perf
inject --sample-buildids`) for testing and conversion without kernel
support.

v2:
- Addressed review feedback from Namhyung Kim and Sashiko AI on v1 [2]:
  - Extended the deferred callchain unwind infrastructure
    (attr.defer_callchain / PERF_RECORD_CALLCHAIN_DEFERRED) to support
    deferred user-space build ID and offset resolution in task_work
    context where page faults are allowed, avoiding NMI-time page fault
    limitations and per-CPU irq_work contention.
  - Batched in-place user callchain resolution into a single
    stack_map_get_build_id_offset() call and skipped kernel frames.
  - Defined struct perf_build_id and struct perf_sample_build_id_offset
    consistently across UAPI and libperf headers, with a fallback for
    __DECLARE_FLEX_ARRAY.
  - Added reference-counted tracking (nr_build_id_offset_events and
    nr_callchain_build_id_offset_events) and clamped callchain frame
    counts in perf_prepare_sample() and perf_callchain_deferred_output()
    to prevent u16 header.size overflows.
  - Added cross-endian byte-swapping support for
    PERF_SAMPLE_BUILD_ID_OFFSET, PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET,
    and PERF_RECORD_CALLCHAIN_DEFERRED.
  - Fixed perf_record_mmap2 union field preservation when build ID
    synthesis fails, callchain context marker tracking in perf inject,
    and per-event callgraph configuration in `perf record
    --buildid-offset`.

[1] https://lore.kernel.org/lkml/20250424061943.1321025-1-irogers@google.com/
[2] https://lore.kernel.org/lkml/20260807071818.718751-1-irogers@google.com/

Ian Rogers (8):
  perf event: Factor build_id out into its own top-level struct
  perf/core: Add BUILD_ID_OFFSET to UAPI
  perf/core: Implement BUILD_ID_OFFSET sample type
  perf: Refactor thread map and symbol APIs to take perf_sample
  perf tools: Internal support for BUILD_ID_OFFSET
  perf inject: Extend perf inject to support bid_offset conversion
  perf record: Add --buildid-offset option
  perf tests: Add build_id_offset test coverage

 include/linux/bpf.h                           |  14 +
 include/linux/perf_event.h                    |   1 +
 include/uapi/linux/perf_event.h               |  53 +-
 kernel/bpf/stackmap.c                         |   4 +-
 kernel/events/core.c                          | 298 +++++++-
 tools/include/uapi/linux/perf_event.h         |  53 +-
 tools/lib/perf/include/perf/event.h           |  51 +-
 .../arch/powerpc/util/skip-callchain-idx.c    |   4 +-
 tools/perf/builtin-inject.c                   |  75 +-
 tools/perf/builtin-record.c                   |   2 +
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |  56 +-
 tools/perf/builtin-timechart.c                |   5 +-
 tools/perf/builtin-trace.c                    |  10 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/bid-offset.c                 |  60 ++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/code-reading.c               |   4 +-
 tools/perf/tests/mmap-thread-lookup.c         |  51 +-
 tools/perf/tests/sample-parsing.c             |  68 +-
 tools/perf/tests/shell/inject_bid_offset.sh   | 175 +++++
 tools/perf/tests/shell/record.sh              |  69 ++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate-data.c               |   5 +-
 tools/perf/util/aslr.c                        |  16 +-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/callchain.c                   |  93 ++-
 tools/perf/util/capstone.c                    |   4 +-
 tools/perf/util/cs-etm.c                      |   4 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/debug.c                       |   4 +-
 tools/perf/util/dlfilter.c                    |   8 +-
 tools/perf/util/dsos.c                        |  27 +
 tools/perf/util/dsos.h                        |   2 +
 tools/perf/util/event.c                       |  88 ++-
 tools/perf/util/evsel.c                       | 169 ++++-
 tools/perf/util/evsel.h                       |   3 +-
 tools/perf/util/evsel_fprintf.c               |   9 +-
 tools/perf/util/inject_bid_offset.c           | 680 ++++++++++++++++++
 tools/perf/util/inject_bid_offset.h           |  15 +
 tools/perf/util/intel-pt.c                    |  14 +-
 tools/perf/util/machine.c                     | 140 +++-
 tools/perf/util/maps.c                        |  59 ++
 tools/perf/util/maps.h                        |   2 +
 tools/perf/util/perf_event_attr_fprintf.c     |   3 +-
 tools/perf/util/python.c                      |  26 +-
 tools/perf/util/record.h                      |   1 +
 tools/perf/util/sample.c                      |   9 +
 tools/perf/util/sample.h                      |  28 +
 tools/perf/util/session.c                     |  86 ++-
 tools/perf/util/synthetic-events.c            |  64 +-
 tools/perf/util/thread.c                      |  11 +-
 tools/perf/util/thread.h                      |  14 +-
 tools/perf/util/unwind-libdw.c                |   7 +-
 tools/perf/util/unwind-libunwind.c            |   8 +-
 56 files changed, 2418 insertions(+), 250 deletions(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

