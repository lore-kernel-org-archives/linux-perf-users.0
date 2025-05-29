Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45358255F4C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493619; cv=none; b=ZsRnpcWFjt+cELMs/punxxL12BjjrdrvpIv2afuEyTvgm9z2kEbWo72fTJQ6XIYp3ZWHYy3ebY9OmOXaUrYLD4cWOZznd7bwsACprWFw4MtpF7JuU1kNK6XZODUxVkIOU9KXAx2fJh2sW1URqgLswCbIUt7XujTeufo6lHCak98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493619; c=relaxed/simple;
	bh=aFrpFYvlIvXpg1Tj5uNPfPoVYZcvO3tZnJDmRdrhrhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qrTuq+I3V7T3hC+LWVcI9EFxsEcVOxwh8GI3xsAP5HVv8lQgeUsIbyhg+s6ElV+q0guRrfYwz2eRfmAEOtsdAZFLRlCmZ8ae8jv3VzUlvqil4zgDB7eu80oAwZlquXBf8sNkYTJEigQZOZLO7Q4YitS/9nQg92fXGkHcbxuwqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiNn4FRx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiNn4FRx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231d13ac4d4so7625195ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493616; x=1749098416; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=feh/jym2oHEnslKTIjWZYt4DUqSL44jvY+sDg4/IEqI=;
        b=RiNn4FRxpy2hafvwDnqDeQ6180u75ZOp4BVMYobNmrSp05KvjLq0S1vXxSGOAhz0gC
         suI9AFWWJKAYvhhTSsjjF4TXvPT6SxM3Mbf2KqFidpj4caTH0G3on2mq0cY1x3U7Vi+F
         ni5EZXLUa9cz+NTHSDqnCnIIUZGCQTHfHkU6ZdLjfV0QY3dpgF7qXYcdGvHi4QKyfNer
         tLx0Q3LcjeyhdC1Dhwclv6hNWCT7Zc1sBxGVv/4gL1JEiUI4hmzMy9wQHwIZWs9h+6gI
         mRIezA4M5umZ4bK+t1x3TqNsQ9tjD8XsjHAtIYBfXUzi22JohfJBmaUexjx2BBm4e1QO
         BWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493616; x=1749098416;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feh/jym2oHEnslKTIjWZYt4DUqSL44jvY+sDg4/IEqI=;
        b=QnEs/vRQVVvFvSWdI8iqfufUjppZ+0Ro0923c5QZDPX0jHAJKGDV9GkaJWdECibdNU
         8iQJJmmK2zf7RafVUqAWPgZidxdL+zADlR7Io7RzGOYiS5qVmd2fmlXoSTuIpiwqiYbu
         JPu8qH6a1Dh3SzCCQQt6KC/KS+tQ1YUAPSDa0WscB1U/kcBM2wizEC9PslBC6TFCwkvw
         JuzX23gTbQIgV8SxLU/ztPjh4pcLPjg3aMmso6fO9gxxcIRVYFOwusMe0UR+3GZD9lHm
         17BY4PKVF+mDVO1XfJZ1pQPgbT/dM1hqIWBnAMreAkLs/tTvpome6WNFJXljq7GydKLx
         wjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/ZK3alvEWdWK59qLajTh/N+74193I9QoUBMyWFb3xKtA+iP7nM7QHSshUiG3XZdZCsvcWQ7VF0maeLGfTsFB@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUHGBFlsk4hhVhfTued3zjirlGhb/wQfajY+pVBK4Vqfdj7Sh
	EvKlowwP5y2eCG5lr35SWhNauswxiYh2qLrnAzkXDW9zl9MGGD3wx08yluWnESyaRNUY/Seqo0R
	NavqoVwTpJg==
X-Google-Smtp-Source: AGHT+IE9DkeyCY1QVXLsp7GDzh+26VXADc2ciYBErfTOIZpnPA7LP25m8FdDotskiLwaqIffj8WbJo4FuVhZ
X-Received: from pjbnb15.prod.google.com ([2002:a17:90b:35cf:b0:311:f309:e314])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c3:b0:311:cc4e:516f
 with SMTP id 98e67ed59e1d1-311cc4e525amr9797006a91.31.1748493605805; Wed, 28
 May 2025 21:40:05 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-1-irogers@google.com>
Subject: [PATCH v4 00/24] perf: Make code more generic with modern defaults
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series combines:
"perf: Default use of build IDs and improvements"
https://lore.kernel.org/lkml/20250428213409.1417584-1-irogers@google.com/
"Remove global perf_env"
https://lore.kernel.org/lkml/20250527064153.149939-1-irogers@google.com/
"Generic weight struct, use env for sort key and header"
https://lore.kernel.org/lkml/20250521135500.677508-1-irogers@google.com/
This is done as the last 2 series depend on each other and the
cleanups in the 1st have the potential to conflict with them.

"perf: Default use of build IDs and improvements"

Build ID mmap2 events have been available since Linux v5.12 and avoid
certain races. Enable these by default as discussed in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

The dso_id is used to indentify a DSO that may change by being
overwritten. The inode generation isn't present in /proc/pid/maps and
so was already only optionally filled in. With build ID mmap events
the other major, minor and inode varialbes aren't filled in. Change
the dso_id implementation to make optional values explicit, rather
than injecting a dso_id we want to improve it during find operations,
add the buildid to the dso_id for sorting and so that matching fails
when build IDs vary between DSOs.

Mark the callchain for buildids and not just the sample IP, fixing
missing DSOs.

Fix sample__for_each_callchain_node to populate the map even when
symbols aren't computed.

Other minor bits of build_id clean up.

"Remove global perf_env"

The global perf_env is used to hold host information, but it is also
used as a fallback in a number of cases where the information may be
bogus. Restructure the code so that the perf_env of the session is
accessed. When necessary a locally scoped host perf_env is created and
used.

Cleaning up the inconsistency was requested by Kan Liang in:
https://lore.kernel.org/lkml/c56c9e23-cf6e-4040-aee8-da13d5157dcf@linux.intel.com/

"Generic weight struct, use env for sort key and header"

The arch directory is a barrier to cross-platform development as files
and behaviors within it are inherently platform specific. Sample
parsing should be generic but the PERF_SAMPLE_WEIGHT_STRUCT handling
was only present if building for x86 or powerpc. The sort key and
headers should be specific to the session that is being executed and
not to the machine perf is being run upon. These patches clean this
and associated code up.

v4: Shorten to "weight3" histogram and sample variable, but comment
    its use (Namhyung). Fix evsel__env use in `perf trace` where no
    session was present. Assert the session is never passed a NULL
    host_env when there is no data file and its associated env.

Ian Rogers (24):
  perf callchain: Always populate the addr_location map when adding IP
  perf build-id: Reduce size of "size" variable
  perf build-id: Truncate to avoid overflowing the build_id data
  perf build-id: Change sprintf functions to snprintf
  perf build-id: Mark DSO in sample callchains
  perf build-id: Ensure struct build_id is empty before use
  perf dso: Move build_id to dso_id
  perf jitdump: Directly mark the jitdump DSO
  perf record: Make --buildid-mmap the default
  perf session: Add accessor for session->header.env
  perf session: Add an env pointer for the current perf_env
  perf evlist: Change env variable to session
  perf header: Clean up use of perf_env
  perf test: Avoid use perf_env
  perf session: Add host_env argument to perf_session__new
  perf top: Make perf_env locally scoped
  perf bench synthesize: Avoid use of global perf_env
  perf machine: Explicitly pass in host perf_env
  perf auxtrace: Pass perf_env from session through to mmap read
  perf trace: Avoid global perf_env with evsel__env
  perf env: Remove global perf_env
  perf sample: Remove arch notion of sample parsing
  perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
  perf sort: Use perf_env to set arch sort keys and header

 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/event.c          |  60 ------
 tools/perf/arch/x86/include/arch-tests.h      |   1 -
 tools/perf/arch/x86/tests/Build               |   1 -
 tools/perf/arch/x86/tests/arch-tests.c        |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c    | 125 ------------
 tools/perf/arch/x86/util/event.c              |  46 -----
 tools/perf/bench/inject-buildid.c             |   2 +-
 tools/perf/bench/synthesize.c                 |  30 +--
 tools/perf/builtin-annotate.c                 |   6 +-
 tools/perf/builtin-buildid-cache.c            |  22 +--
 tools/perf/builtin-buildid-list.c             |  11 +-
 tools/perf/builtin-c2c.c                      |  69 ++++---
 tools/perf/builtin-diff.c                     |   2 +-
 tools/perf/builtin-inject.c                   |  41 ++--
 tools/perf/builtin-kallsyms.c                 |  21 +-
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-kvm.c                      |   4 +-
 tools/perf/builtin-kwork.c                    |   2 +-
 tools/perf/builtin-lock.c                     |   4 +-
 tools/perf/builtin-mem.c                      |   2 +-
 tools/perf/builtin-record.c                   |  63 +++---
 tools/perf/builtin-report.c                   |  27 ++-
 tools/perf/builtin-sched.c                    |   8 +-
 tools/perf/builtin-script.c                   |  18 +-
 tools/perf/builtin-stat.c                     |  23 +--
 tools/perf/builtin-timechart.c                |   2 +-
 tools/perf/builtin-top.c                      |  58 ++++--
 tools/perf/builtin-trace.c                    |  38 ++--
 tools/perf/include/perf/perf_dlfilter.h       |   2 +-
 tools/perf/perf.c                             |   3 -
 tools/perf/tests/code-reading.c               |   6 +-
 tools/perf/tests/dlfilter-test.c              |  51 ++---
 tools/perf/tests/dwarf-unwind.c               |  10 +-
 tools/perf/tests/hists_cumulate.c             |   8 +-
 tools/perf/tests/hists_filter.c               |   8 +-
 tools/perf/tests/hists_link.c                 |   8 +-
 tools/perf/tests/hists_output.c               |  10 +-
 tools/perf/tests/mmap-thread-lookup.c         |   6 +-
 tools/perf/tests/pe-file-parsing.c            |   2 +-
 tools/perf/tests/sample-parsing.c             |  14 ++
 tools/perf/tests/sdt.c                        |   2 +-
 tools/perf/tests/symbols.c                    |  12 +-
 tools/perf/tests/topology.c                   |  39 ++--
 tools/perf/ui/browser.h                       |   4 +-
 tools/perf/ui/browsers/header.c               |   4 +-
 tools/perf/ui/browsers/hists.c                |   2 +-
 tools/perf/util/amd-sample-raw.c              |   2 +-
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/auxtrace.c                    |  13 +-
 tools/perf/util/auxtrace.h                    |   6 +-
 tools/perf/util/bpf-event.c                   |   2 +-
 tools/perf/util/branch.c                      |   2 +-
 tools/perf/util/build-id.c                    |  63 +++---
 tools/perf/util/build-id.h                    |   8 +-
 tools/perf/util/data-convert-bt.c             |  16 +-
 tools/perf/util/data-convert-json.c           |  36 ++--
 tools/perf/util/debuginfo.c                   |   2 +-
 tools/perf/util/disasm.c                      |   2 +-
 tools/perf/util/dlfilter.c                    |   2 +-
 tools/perf/util/dso.c                         | 111 ++++++-----
 tools/perf/util/dso.h                         |  75 ++++----
 tools/perf/util/dsos.c                        |  20 +-
 tools/perf/util/env.c                         |   3 +-
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/event.c                       |   2 +-
 tools/perf/util/event.h                       |   5 -
 tools/perf/util/evlist.h                      |   2 +-
 tools/perf/util/evsel.c                       |  29 ++-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 182 ++++++++++--------
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/hist.h                        |   3 +-
 tools/perf/util/intel-tpebs.c                 |   4 +-
 tools/perf/util/jitdump.c                     |  21 +-
 tools/perf/util/machine.c                     |  42 ++--
 tools/perf/util/machine.h                     |   4 +-
 tools/perf/util/map.c                         |  15 +-
 tools/perf/util/map.h                         |   5 +-
 tools/perf/util/probe-event.c                 |   8 +-
 tools/perf/util/probe-file.c                  |   4 +-
 tools/perf/util/probe-finder.c                |   3 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/sample-raw.c                  |   7 +-
 tools/perf/util/sample-raw.h                  |   2 +-
 tools/perf/util/sample.h                      |   6 +-
 .../scripting-engines/trace-event-python.c    |   7 +-
 tools/perf/util/session.c                     |  20 +-
 tools/perf/util/session.h                     |   9 +-
 tools/perf/util/sort.c                        |  95 +++++----
 tools/perf/util/sort.h                        |   5 +-
 tools/perf/util/symbol-minimal.c              |   2 +-
 tools/perf/util/symbol.c                      |   7 +-
 tools/perf/util/symbol_conf.h                 |   2 +-
 tools/perf/util/synthetic-events.c            |  54 ++++--
 tools/perf/util/thread.c                      |   8 +-
 tools/perf/util/thread.h                      |   2 +-
 tools/perf/util/tool.c                        |   2 +-
 98 files changed, 919 insertions(+), 894 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/event.c
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

-- 
2.49.0.1204.g71687c7c1d-goog

