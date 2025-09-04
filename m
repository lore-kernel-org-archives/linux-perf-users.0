Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AF23B627
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961237; cv=none; b=Z8suYHlapSr0e2cMBAtkstfxb1t3TprY8Y9+B7Q+qwRG7GD0MbYHGdGW4BweWQBMUy4Y50jYqlrFp+xiDMYscjABZdFkorZRGWBhr8X8C0ks1yRk5b7eCTnTuPSJSax+rLrKIewZs1sLitDei2zNti5UiJCMWiPqLHBaJDqD2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961237; c=relaxed/simple;
	bh=o+Ieh5f7nEigRVrrQ1oFBbRlimMkO/0u27Jpnxj0Bd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wb08vIRgEzIaw2zMy5/aLtKZSNoh7RJROw2ScOnSUkT51twU22ta8Yat2pqViABiS7qjpI3RrBU06Fs3imQsYIryzmUGHOf7aEMqqz/PW9S6h80Zy6f/P+qFjHPu5kIDz+LJ2vZZjyiXB1cE0von4XIR9MNR6neZR8GRBI/qrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuBnXXSz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuBnXXSz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso11134455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961235; x=1757566035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzi2AtTlZOwesAgn4m+DSLuE/Xk8AxtH2yHfI9nLvQs=;
        b=ZuBnXXSz6/2hBzn1S7dT+NXMOR8UoQcCDwp+qxJAT6O2Gnf/AKbi/0RURTbkjWz1MI
         c97xAguK4K/7pD95l1RLALnzCONWXo9UCFpHH7CF/x4sEgqZaIeL+xzLG6loFNSrN52u
         t+unAp5/N06k01BbdPYbwiR7ypdlEt6q20IrKWMmJhEEjjavMOA4vtSlsALWEJAowc44
         0uoVy27OhEIqssriEEr/KNM5j4TsmtK8fXJArUymsjZEUFFmqfFy/MoABWNzcQD6j5IQ
         84yU63BYP7pQFd3TljJkDxP7WhZUOzpGwLuv6uC2zi5v44vJzp8zByViaFiPiID+m8Ya
         0rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961235; x=1757566035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzi2AtTlZOwesAgn4m+DSLuE/Xk8AxtH2yHfI9nLvQs=;
        b=i8ftMdPFJfZyC2CxZIOPbJn6SnQPdFV5mMgtB9EHPmMjgFJuid4Z4R1U87elYfbWGq
         exfO6ldcDg2Cl2y0au4hhmBpwrWFB+ONbeshjNNoayvZvWTqevQqbIjUaYIQ4iuFnk6B
         gYNQ4HZq39Yhc4eyuym0ubr8h1rAdepkv1omfqyzECysjYHZ5XrBy49NAePhAYU38MX/
         on0GfDvgKjasbZLG8rsiWjc+3ZdZGI2N3C4ZhmDIFaEsd6WngSmZimERc/6QmgzDkxNa
         6zuW0i/ra7qC8izCh2LWNfHwWVUleC3tAfHXq4ppCSgEg9qZ8UuM4nEGxT0naSep9BQ5
         eRKg==
X-Forwarded-Encrypted: i=1; AJvYcCWeDcvnZ3lehZO34ieCeMBLKCSAFwnOwfFoVon3a+2GjcMeWwWT8HFWTPK8/h24bLFUOjctlldaJRRAy/5YkUXX@vger.kernel.org
X-Gm-Message-State: AOJu0YxiINmemr0Q/f2UAHXn2R7glkTCL7/ZtzydBctwD+T2tInCJ6LK
	pkVjBq/mLNOMDPaAoX5EeHVcG9EMvkoludEKcmv6Feu/BBjD/RRv9t0qo6S8OfRrUekOBAY54mS
	s8rV97Q+6fw==
X-Google-Smtp-Source: AGHT+IEGzstwt9UTmaSuMIy+408+KXnAOSGoJNob6WBZfIdKqBTphBoO80XZXmpV3l/Csfez6aMfWBcNbhgk
X-Received: from plbmj15.prod.google.com ([2002:a17:903:2b8f:b0:24c:c58a:c192])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cd:b0:248:a406:c818
 with SMTP id d9443c01a7336-24944b3c3fbmr205372535ad.42.1756961234619; Wed, 03
 Sep 2025 21:47:14 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:40 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-10-irogers@google.com>
Subject: [PATCH v6 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b4ed137c91b3..52c592112c13 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 # Global command line arguments.
@@ -261,6 +262,33 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  # Number of CPU cycles scaled for SMT.
+  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("lpm_ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -353,6 +381,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog

