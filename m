Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB72C21FA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697854; cv=none; b=glwGQ2dUIjBa2q8LZdXGIMMhDQizK3PlBojTAN34znkReipQGHDCOJ1zSHDeEmRxhuikw29C09ik+ElsziKmN7BWXEjoEZckgY61LMWAXOqNtQqUIIsaD5nRxk3HpC8fPw1zUsDhOBNEBlLM1D22N7nhpYmPTa4MqiVbLqV7EgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697854; c=relaxed/simple;
	bh=dELRCkaNtmM9lCsKmbdrwtRV6MXRz1YfGkeCN2D/vhw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KJ5Gh33QKpPeLR0BBAhVh4FmbRrdUaIK+WfKrVIXlYtRc5VMTY5ZdwE3/JDOGInHRYQpkFUtbveongJGbiGBGbSrl70Tap9KpNQQ6fL83hwWfOkKVR5RHwXxca6S2cnXwMEwLupjU1au5gdf5KkPiRR4+OvkRR5uOL3z+F4OlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIT0OJvm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIT0OJvm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso9409929a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697852; x=1765302652; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3FHtyIo78F4dY1ad3bpmsMWw4v5oAwiBQb2fieg19Fk=;
        b=uIT0OJvmUKInXp5s4Pk47jXLsk2t9Li2Dtyj9eoPSQXBSbxn41rKYRs+hh1T2Rbil3
         i5wv32bAIDbDDy5Ygc6Ehx9i5BkTycEQu1gRIbnxZydXvypBPoBfbwaV/oX09yG76W3H
         sQTW7RtFRvifc3otugbD2YQEveH15HtQu4zJ/qXyit/BkJCw3KE+shCM55Sdlb/+j5KQ
         MmbfogxfODd1xeZc3zquo7Ea7XU7iUvrxX1Q1rYB2L6qKY7V9BRPeCCTCPb1kqZ1Ekps
         jQN/fi4e/1+RBEZiOSeRIvopZ5mQigd8EGaqIaNT2Y16OLC6vB0kQvuBDori2cdTjP6F
         taog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697852; x=1765302652;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FHtyIo78F4dY1ad3bpmsMWw4v5oAwiBQb2fieg19Fk=;
        b=uj58dPYEKg4ATgBEP8DYYkvInFAlwGVrs6x8GenZx7rqtL0EirwF5EvWuv409JuGbo
         HzEpYF3QGYgHC43fF4hbJglE6RouRa/w2KKy0cm++zE6XT5raGY5K6ERBY1Af6U3umGt
         7/Me+MPvJpcngI/7QkbEzcNS9bOccId3xloasa0Yo4j6iu2u+cW7Z+u3B7uEbdhf/FtK
         LsgRq+ewWJJkQQAVBF6AvTXM7ZxXJFmk/RAD7Rl2mMC7SsCgXZ7c6RtgqHfPa4XJ0uRG
         SbpXj5+ODLT9PYwAMGP4qd4wSbF4yT41wvE6QT4CWPFdfWx6f/5FjuZvzWh7BEpOXNMs
         oCuw==
X-Forwarded-Encrypted: i=1; AJvYcCVS8fmnOLnb4GSxrzWMvrqIrLx9Zy13ploEJcrxnd3IfvGIQVitTKbf2bTRB/eV7HJcdzfqZPhF31Sul8aau8Sk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/9nfRH7pfa+6yDETvikd+bdIS4w4bXjEpVZfn5r49mu1GkBW
	AWl48i1eJZquCzxrswN9AR20uKykDgSqO3Km7MvSPTBCYwP3jDQ01wrFZDA4q/ruiRi2gX9fgYM
	FDA43WXMlxA==
X-Google-Smtp-Source: AGHT+IGLDTly/nmW0Ld2czynffBkmcIvQjpvP8nV9Eug3srwk0I/lUoMGmDCU4oHzOvgC/KBQm2dwoPUadGZ
X-Received: from dyji29.prod.google.com ([2002:a05:7300:7a1d:b0:2a4:4d2a:a9ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:71a9:b0:2a4:51f8:4a6f
 with SMTP id 5a478bee46e88-2a7192d4c2amr17191572eec.37.1764697851946; Tue, 02
 Dec 2025 09:50:51 -0800 (PST)
Date: Tue,  2 Dec 2025 09:49:55 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-1-irogers@google.com>
Subject: [PATCH v9 00/48] AMD, ARM, Intel metric generation with Python
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

* The first 14 patches introduce infrastructure and fixes for the
  addition of metrics written in python for Arm64, AMD Zen and Intel
  CPUs. The ilist.py and perf python module are fixed to work better
  with metrics on hybrid architectures.

* The next 9 patches generate additional metrics for AMD zen.  Rapl
  and Idle metrics aren't specific to AMD but are placed here for ease
  and convenience. Uncore L3 metrics are added along with the majority
  of core metrics.

* The next 20 patches add additional metrics for Intel. Rapl and Idle
  metrics aren't specific to Intel but are placed here for ease and
  convenience. Smi and tsx metrics are added so they can be dropped
  from the per model json files. There are four uncore sets of metrics
  and eleven core metrics. Add a CheckPmu function to metric to
  simplify detecting the presence of hybrid PMUs in events. Metrics
  with experimental events are flagged as experimental in their
  description.

* The next 2 patches add additional metrics for Arm64, where the
  topdown set decomposes yet further. The metrcs primarily use json
  events, where the json contains architecture standard events. Not
  all events are in the json, such as for a53 where the events are in
  sysfs. Workaround this by adding the sysfs events to the metrics but
  longer-term such events should be added to the json.

* The final patch validates that all events provided to an Event
  object exist in a json file somewhere. This is to avoid mistakes
  like unfortunate typos.

This series has benefitted from the input of Leo Yan
 <leo.yan@arm.com>, Sandipan Das <sandidas@amd.com>, Thomas Falcon
 <thomas.falcon@intel.com> and Perry Taylor <perry.taylor@intel.com>.

v9. Drop (for now) 4 AMD sets of metrics for additional follow up. Add
    reviewed-by tags from Sandipan Das (AMD) and tested-by tags from
    Thomas Falcon (Intel).

v8. Combine the previous 4 series for clarity. Rebase on top of the
    more recent legacy metric and event changes. Make the python more
    pep8 and pylint compliant.

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

Ian Rogers (48):
  perf python: Correct copying of metric_leader in an evsel
  perf ilist: Be tolerant of reading a metric on the wrong CPU
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
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
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
  perf jevents: Validate that all names given an Event

 tools/perf/.gitignore                   |    5 +
 tools/perf/Makefile.perf                |    2 +
 tools/perf/pmu-events/Build             |   51 +-
 tools/perf/pmu-events/amd_metrics.py    |  491 ++++++++++
 tools/perf/pmu-events/arm64_metrics.py  |  187 ++++
 tools/perf/pmu-events/common_metrics.py |   19 +
 tools/perf/pmu-events/intel_metrics.py  | 1129 +++++++++++++++++++++++
 tools/perf/pmu-events/jevents.py        |    7 +-
 tools/perf/pmu-events/metric.py         |  256 ++++-
 tools/perf/pmu-events/metric_test.py    |    4 +
 tools/perf/python/ilist.py              |    8 +-
 tools/perf/util/evsel.c                 |    1 +
 tools/perf/util/python.c                |   82 +-
 13 files changed, 2188 insertions(+), 54 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100644 tools/perf/pmu-events/common_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.52.0.158.g65b55ccf14-goog

