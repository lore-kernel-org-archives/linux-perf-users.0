Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1D30EF8C
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899489; cv=none; b=a9dHLrQZNp5JuwCdWLXgVR87H1U034jPnPMzEpI5puHOOiwQP7dEH31q14ElY/S3IrOjWoaxOVisHYopq1C8AI69Ur38gWA7LAORj+uUL4ODIlgPf2TW51GDVrNcF5a7pifL2k4Druo7G7mHCxL9USmkGpoise9qlZNHVCkkivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899489; c=relaxed/simple;
	bh=7DcC61GwEOMyPt/7fHUscu8OWyQjIT9bQg7XO6SNjTI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=XdfR+vdRCfKVQa+hfLGzMMx4vGPQWIHcRlk2wlP33zwQKG0dEEkBMKZZ8uXTtYluNuwA2Al2HZUYkCkP+c7j0fvA8GNOsqoXoh4lLyGNiUML2i2FXOp/tSnOy3d5D6ZQLYM+LQC3y+6WfNOXS3LIlf5irK39ZttbnC6OEtptZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+EWW/F4; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+EWW/F4"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f4500c7ebso4021744c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899487; x=1768504287; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gYRs6uBemq+uBsNaRZkOprEaJVKPNl5N4pPNbfCBuUs=;
        b=t+EWW/F4mvTu/YuRdFnZ72ZOIhNgJa7+NlyTik0psCdCAfNLWZiZ7sbE36uryyxQHw
         paIfvrnHYiK/Nm305lpTuuZgluVC1DIFcZS6MkBcbD6/sOaezjtn394jEQ199wAz1E8O
         1L+YFAzg4o/S8nsgywrFY8C+0KBt4Re28RqysvS3W4lfA69yV5LXpcaurY9OElPZ9Fiv
         ZCg5ZkQvrIbxJ/fgmy5EEI41jUD8h2o1hdfKbDDxIffjuHhVNuX1iHOPYTpbOZk9UN+Q
         4qIRBluUZFlZ5kG/HJibbWE/36t/umLhlGHkTT8yvi5b9VyEFVI7tqnAYFc5pdI/b2ob
         7wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899487; x=1768504287;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYRs6uBemq+uBsNaRZkOprEaJVKPNl5N4pPNbfCBuUs=;
        b=V2wP95vshGbiVf8hFzkJN8kYZBe3Fq31jouyZM+cWjgSAtM25h+RrkGdEp0bOChoTv
         LJCBJ0w+W2g9Ch8QRhOWf4gfAqNCHd1ceymkOiBSuufJH+ANFnqcndTpufVd0NVg5Sir
         JQKU1MmpZgbXGFwjGlm74pJ4Ghv5ksUipXv3pT2rirZ8UXvQa3bHEgITtjSyJLn7oe2L
         Q841/FVny/VErGK/lGkcDTVBxLGN96+h2UVsmc67IhoM8OsPgfdQPDmKK5odOROcakBT
         nn0tokB3L8uWtw1YRv0U450gNeQuZeOY0psBaf7j33rnHjrHU6Qku2YcZjs0ygF5oRTU
         AJAA==
X-Forwarded-Encrypted: i=1; AJvYcCV1trSi2IcmMsYHzmXsc7x4KKmzcohfVjDZkOSwJJKPIVpe68fZ9G3CFQvoSJ39oI4FDHwkuacP0GBMOBqiud0G@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6LgO2700tKOgWt/1lHHY1s1jGAtslFUA9CP4XTIHEjXXYLWz
	iWzWvpIdhPZ2XAn2MrrmjM+d3ARNlj6F0hDVqvV00Hq8EyQ7gHfsHRhDk2FnmYdiQ/+75Qg/2/X
	pz80dzGkMEg==
X-Google-Smtp-Source: AGHT+IF/+uGiq9cKOtgEZBnp66KYvOVBZERN+rzwhweiUZHc+N+0OYeRdMGa0v7yUt5Rjglm+C2u5RhL0xQs
X-Received: from dlbrj5.prod.google.com ([2002:a05:7022:f405:b0:11b:9bdf:e45c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618b:b0:119:e56c:18ae
 with SMTP id a92af1059eb24-121f8b2d9d1mr6080795c88.22.1767899486150; Thu, 08
 Jan 2026 11:11:26 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:30 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-1-irogers@google.com>
Subject: [PATCH v10 00/35] AMD and Intel metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a
model. From the metric python code Event(s) are used, with fallback
events provided, if no event is found then an exception is thrown and
that can either indicate a failure or an unsupported model. To avoid
confusion all the metrics and their metricgroups are prefixed with
'lpm_', where LPM is an abbreviation of Linux Perf Metric. While extra
characters aren't ideal, this separates the metrics from other vendor
provided metrics.

* The first 2 patches introduce infrastructure for the addition of
  metrics written in python for Arm64, AMD Zen and Intel CPUs.

* The next 9 patches generate additional metrics for AMD zen.  Rapl
  and Idle metrics aren't specific to AMD but are placed here for ease
  and convenience. Uncore L3 metrics are added along with the majority
  of core metrics.

* The next 22 patches add additional metrics for Intel. Rapl and Idle
  metrics aren't specific to Intel but are placed here for ease and
  convenience. Smi and tsx metrics are added so they can be dropped
  from the per model json files. There are four uncore sets of metrics
  and eleven core metrics. Add a CheckPmu function to metric to
  simplify detecting the presence of hybrid PMUs in events. Metrics
  with experimental events are flagged as experimental in their
  description.

* The next patch adds a cycles metrics based on perf event modifiers
  for AMD, Intel and Arm64.

* The final patch validates that all events provided to an Event
  object exist in a json file somewhere. This is to avoid mistakes
  like unfortunate typos.

This series has benefitted from the input of Leo Yan
 <leo.yan@arm.com>, Sandipan Das <sandidas@amd.com>, Thomas Falcon
 <thomas.falcon@intel.com> and Perry Taylor <perry.taylor@intel.com>.

v10. Drop already merged non-vendor patches (Namhyung). Drop "Add
     collection of topdown like metrics for arm64" as requested by
     James Clark. Update AMD metrics for changes to AMD Zen6 event
     names from the series:
     https://lore.kernel.org/lkml/cover.1767858676.git.sandipan.das@amd.com/

v9. Drop (for now) 4 AMD sets of metrics for additional follow up. Add
    reviewed-by tags from Sandipan Das (AMD) and tested-by tags from
    Thomas Falcon (Intel).
    https://lore.kernel.org/lkml/20251202175043.623597-1-irogers@google.com/

v8. Combine the previous 4 series for clarity. Rebase on top of the
    more recent legacy metric and event changes. Make the python more
    pep8 and pylint compliant.
    https://lore.kernel.org/lkml/20251113032040.1994090-1-irogers@google.com/

Foundations:
v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.
    https://lore.kernel.org/lkml/20250904043208.995243-1-irogers@google.com/

v5. Rebase on top of legacy hardware/cache changes that now generate
    events using python:
    https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
    the v5 series is:
    https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/

v4. Rebase and small Build/Makefile tweak
    https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/

v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
    https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v2. Fixes two type issues in the python code but no functional or
    output changes.
    https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

AMD:
v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.
    https://lore.kernel.org/lkml/20250904044047.999031-1-irogers@google.com/

v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced.
    https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/

v4. Rebase.
    https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/

Intel:
v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.
    https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@google.com/

v5. Rebase. Fix description for smi metric (Kan). Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced. Kan requested a
    namespace in his review:
    https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com/
    The v5 series is:
    https://lore.kernel.org/lkml/20250829041104.4186320-1-irogers@google.com/

v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
    https://lore.kernel.org/lkml/20240926175035.408668-1-irogers@google.com/

v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
    minor code cleanup changes. Drop reference to merged fix for
    umasks/occ_sel in PCU events and for cstate metrics.
    https://lore.kernel.org/lkml/20240314055919.1979781-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301185559.2661241-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@google.com/

ARM:

v7. Switch a use of cycles to cpu-cycles due to ARM having too many
    cycles events.
    https://lore.kernel.org/lkml/20250904194139.1540230-1-irogers@google.com/

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.
    https://lore.kernel.org/lkml/20250904045253.1007052-1-irogers@google.com/

v5. Rebase. Address review comments from Leo Yan
    <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
    Linux Perf Metric) so that python generated metrics are clearly
    namespaced. Use cpu-cycles rather than cycles legacy event for
    cycles metrics to avoid confusion with ARM PMUs. Add patch that
    checks events to ensure all possible event names are present in at
    least one json file.
    https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.com/

v4. Tweak to build dependencies and rebase.
    https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.com/

v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.
    https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.com/

Ian Rogers (35):
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add context switch metrics for AMD
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add smi metric group for Intel models
  perf jevents: Mark metrics with experimental events as experimental
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel
  perf jevents: Add mesh bandwidth saturation metric for Intel
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
  perf jevents: Validate that all names given an Event

 tools/perf/.gitignore                   |    5 +
 tools/perf/Makefile.perf                |    2 +
 tools/perf/pmu-events/Build             |   51 +-
 tools/perf/pmu-events/amd_metrics.py    |  492 ++++++++++
 tools/perf/pmu-events/arm64_metrics.py  |   49 +
 tools/perf/pmu-events/common_metrics.py |   19 +
 tools/perf/pmu-events/intel_metrics.py  | 1129 +++++++++++++++++++++++
 tools/perf/pmu-events/metric.py         |  171 +++-
 8 files changed, 1914 insertions(+), 4 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100644 tools/perf/pmu-events/common_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.52.0.457.g6b5491de43-goog

