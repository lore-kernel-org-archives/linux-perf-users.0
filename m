Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C363A1CD
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539528; cv=none; b=mtziZKVAR9NrIcB8jMt6d85e6hqtDRquB12SSFbH78peTYYuIQ9HmW0u6n6eT9rwSnIRHohbWxHxKLyD3ZryBY6Cs1UkMeFsb/4igYjmJat+DEGuSaxvhduQQ1ejpK0fYca/KlJLWcJr5SRs0pZTurA7a0tTVfuSFa2c3DW5UCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539528; c=relaxed/simple;
	bh=0x/wntHXWW8zpNbT0fvUYjQV8X0/X7uKcB7h7TW4+04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WdwoEXIJkY62Zjnm7MoZLPofuzdE7ptdkNxlLDJACzimoiSMbtJhLOE9VXvKLIEGTLoE2fTCOCjnS9AEBGwW4oKbDKDm22ubA14SHNpRWAQ2VrePbwHFYOB9/j/jMoqxs058O1/DmyqJl+fiTfR9lwaAg6IMFaK9hccD0WmTKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1or8g5v; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1or8g5v"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b708fa4093so14173275eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539526; x=1770144326; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IBUuuo+bFTF7DG7537tZaq6dyQE93FmNw2+CzpACDXc=;
        b=i1or8g5vLqxoXFb9cQ4SZ2MiModffVs/+wQMEDGNtaS3huxFn9HqKGGERUu8p13vca
         5vEwG3tFDNXbdbA0sJZbTICALFA18dUejg3mUCn4NpODwdFPQ/XbM4fIszCX/f0rdRtI
         Fxq2yFqXqxHtRZQdzowXIAyT6vEzvAs2H6x6sB9Heo8ojUpY77HH5IYWRSqQU6VJobiV
         AtCy1Wu5B6Omdq7eM/dBICJZegNtsxmi35sGXhNkVZme+sJv7JpPSRDeRDV4P16I7aVJ
         dMykxuFj6mE30U6sHBGRcBZntR1gu6ICqtCaaZMXXqWjfwiYU0jsi97bWxDiT04Op5SL
         Dk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539526; x=1770144326;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBUuuo+bFTF7DG7537tZaq6dyQE93FmNw2+CzpACDXc=;
        b=ieknTpNXdfQ2ja1vm2IX8l3P2vGNPhQxZ4tqZlBFudfDuNitRXAj2irFAH0QG/Pw5n
         CPpzTC+TRyOdHe2v+Sbpemrw8BtUC7lrztRkex4oF7zUUQ6on4UnX9+HgDOSzWfdjHEb
         oouiFF1G4JRceXCJzpYsUegVli9aD8jegDfGPuw8vRhYiDgB/leP/D3AHZ/ejsBxq2Si
         0TV+Cp5iq1p/FoiFnYhn2TAEJ7nF+J24xtnmUYAAJoGAatzmL+haPm2BeIC1VO8EHbeA
         id5BAflUDrwKx5C5dgnviSlqOQ1WgiN2o+tcPx6XsD/24SRDtHHs1Bfb5EvJsqKVPPyW
         IbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMdrZv6+NHlHaLFwjJE34HRPlbpp/GcUDVxZrytiZDpmHXQw/ztG04O87zECDlf4f9P4QE/uj63IRxrE3h8Eck@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMRZ7C/p4Ses0p3rCeIFiOfbzqVVM2qG3JPQ8Mre6OM4iHk54
	PrrPE0aulK4icimpb7QKFpjhSs6a3vdxhs69nsyhTkp5mp9dGKg0bweZRsEes/otBU34paeQC94
	h2+sBv8m8Ag==
X-Received: from dybme39.prod.google.com ([2002:a05:7301:18a7:b0:2b0:5541:d643])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:641c:b0:2b7:20c6:36cb
 with SMTP id 5a478bee46e88-2b78da2a7f9mr1688765eec.34.1769539526124; Tue, 27
 Jan 2026 10:45:26 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-1-irogers@google.com>
Subject: [PATCH v11 00/35] AMD and Intel metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

v11. Rebase and add fix so that cmn isn't considered an ARM model.

v10. Drop already merged non-vendor patches (Namhyung). Drop "Add
     collection of topdown like metrics for arm64" as requested by
     James Clark. Update AMD metrics for changes to AMD Zen6 event
     names from the series:
     https://lore.kernel.org/lkml/cover.1767858676.git.sandipan.das@amd.com/
     https://lore.kernel.org/lkml/20260108191105.695131-1-irogers@google.com/

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

