Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F51F0E25
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052264; cv=none; b=FIyTZKN04qpCELGh8m/nVqmF5SEB2ztbVWuZW/fCQ2oQzqLHeXgG9AdPy39EJQ+VN4A23FosjfDrTrB1HZucv7QtDXXloBmZ9X4Zh1W1ASgrxYS/ltvVEUY9YEniXlRrRKb1Qzd0aYwsIOiKFOiZcFaYH58/Z5TWu0f9W/AL4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052264; c=relaxed/simple;
	bh=1n5Valji7I9L0K0Et8PGUCLA/5Vst0Y8bPXSljeNGDU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cUdvydzFqLK8znJeRQFMlCvQHeFBeur7olGnEHYdGnQHaqAZOKd5o5Oxg0WFK7CVi1q+T3vt6Cy9Ao9aC3K90Tk0NH4yMNXZkWVq/HIezb+wU7kAWXyI/kcdxCCCgdLNFBmtxMiRehCbw43GDDntjKEkSi3SwWHC7OZxc/lKh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rGi6XcT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rGi6XcT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3613e6aso130840b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052262; x=1751657062; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZTyroUbddtOyWCKMShKy63ZYO2TaaVJDrbbwXgXCgo=;
        b=0rGi6XcT6tz1NsT0RM5U/dTus/NvNrmqxK9LDQ3RUTI6DqU1dy7XkMIdr3Zkhw5fhH
         Xduleeq9aRJKnt3P8QuOpmCk8WLIbWMfVrPKzPKLEU8Y8dpsFI2zwqTZHiFA7EC8xv2d
         S7u4Iz9pfwzuEIO1VP3Wa6GLQxLyLqt6quf+XipdMmlSmGEwv1xfHTOziHFUCL+DoFYd
         OxB0R+tGGToCMOweYMEl4aJGxVi1FFSEg408CWh9//LBVVNTR81Z/RqSiF0+MDE6xKSm
         bkP207aGnmBQBwZikM9QDlCuD2vJpz3NjonxK/mP0jwbVVEgVuq25ATCAI1g5Zer3RMN
         MzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052262; x=1751657062;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZTyroUbddtOyWCKMShKy63ZYO2TaaVJDrbbwXgXCgo=;
        b=hvmm+5rgMKtTIqbSF7GfswRiL6LLs9quXfstE9yLLg4wPTxbeuFaExifNYOcCppp8r
         BEVDlzKm9a2VdbmnqmGMQG+HRTm6EpahdpjOB4e3LeokAuTFmo6re33g/gsbc8/ULCe5
         376Kh56T61/hgO+i5qlZWgyux9gOWaOtBSunaiZzZkCbUFe7bDsOMMdu0cqASc4FD7ON
         Zst0iRPkqaotwJ21OfhloDnxva4NuFy2kpP5Khg0vT/Obg3BOzyFlr2iuw8bvr23LS2j
         r4/mLPB177Jma2hElaHOHkXg/UCsFbHqBm8n0Iove1i9XTlXFbxb0gv3zwSowSlU2ftt
         admQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTCsV9GjASQCuwmyoEVKb//H2tqMxBvzxzVseogjgkbnYzsMng6pK14TSnfisYkXzob8f6Ke+8uD54FTg15p6A@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqDEoy+jc2aUwKu8EFhx1wQmlFiXhdjHN9RpBTsKP1dthrZTd
	dBPnhWUvbL5VEr6FHYxJGnjZnpG/NVlmNASAZKo18raaZ54lT7B2HyT48XxRO0VvLnIsEXnaTdj
	mY45Rfjqn3w==
X-Google-Smtp-Source: AGHT+IE5vG/CcAarlCvPx2K+m9Sufgv88n0Ov2pi8a1DXgEyvoxcIAWxr+QrPm458Q3Of7LdXNteNW9UB4PU
X-Received: from plbmu14.prod.google.com ([2002:a17:903:b4e:b0:234:ddd7:5c24])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a27:b0:234:eadc:c0b4
 with SMTP id d9443c01a7336-23ac477a8d8mr81555505ad.44.1751052262307; Fri, 27
 Jun 2025 12:24:22 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-1-irogers@google.com>
Subject: [PATCH v1 00/12] CPU mask improvements/fixes particularly for hybrid
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On hybrid systems some PMUs apply to all core types, particularly for
metrics the msr PMU and the tsc event. The metrics often only want the
values of the counter for their specific core type. These patches
allow the cpu term in an event to give a PMU name to take the cpumask
from. For example:

  $ perf stat -e msr/tsc,cpu=cpu_atom/ ...

will aggregate the msr/tsc/ value but only for atom cores. In doing
this problems were identified in how cpumasks are handled by parsing
and event setup when cpumasks are specified along with a task to
profile. The event parsing, cpumask evlist propagation code and perf
stat code are updated accordingly.

The final result of the patch series is to be able to run:
```
$ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
 10.1: Basic parsing test                                            : Ok
 10.2: Parsing without PMU name                                      : Ok
 10.3: Parsing with PMU name                                         : Ok

 Performance counter stats for 'perf test -F 10':

        63,704,975      msr/tsc/
        47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
        16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
```

This has (further) identified a kernel bug for task events around the
enabled time being too large leading to invalid scaling (hence the
 --no-scale in the command line above).

Ian Rogers (12):
  perf parse-events: Warn if a cpu term is unsupported by a CPU
  perf stat: Avoid buffer overflow to the aggregation map
  perf stat: Don't size aggregation ids from user_requested_cpus
  perf parse-events: Allow the cpu term to be a PMU
  perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
  libperf evsel: Rename own_cpus to pmu_cpus
  libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
  perf evsel: Use libperf perf_evsel__exit
  perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
  perf parse-events: Minor __add_event refactoring
  perf evsel: Add evsel__open_per_cpu_and_thread
  perf parse-events: Support user CPUs mixed with threads/processes

 tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
 tools/lib/perf/evsel.c                  |   9 +-
 tools/lib/perf/include/internal/evsel.h |   3 +-
 tools/perf/builtin-stat.c               |   9 +-
 tools/perf/tests/event_update.c         |   4 +-
 tools/perf/util/evlist.c                |  15 +--
 tools/perf/util/evsel.c                 |  55 +++++++++--
 tools/perf/util/evsel.h                 |   5 +
 tools/perf/util/expr.c                  |   2 +-
 tools/perf/util/header.c                |   4 +-
 tools/perf/util/parse-events.c          | 102 ++++++++++++++------
 tools/perf/util/pmus.c                  |  29 +++---
 tools/perf/util/pmus.h                  |   2 +
 tools/perf/util/stat.c                  |   6 +-
 tools/perf/util/synthetic-events.c      |   4 +-
 tools/perf/util/tool_pmu.c              |  56 +++++++++--
 tools/perf/util/tool_pmu.h              |   2 +-
 17 files changed, 297 insertions(+), 128 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

