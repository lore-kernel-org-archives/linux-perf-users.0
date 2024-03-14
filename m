Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B063D38C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395997; cv=none; b=ObgzWqdnngBOZiEWxJzH885WNFcTg17B/QtM4sI4aepD47lsZiGHP2Y/VQfVJbcKXmWhz27g3pVQVj+tKsuJ7QEJqOOJ6NV4ae8TL+ltuWsDb7RSk6fqelqIxsD+P7stH+xkoJ1Xe6r6JcSdLHmPfWuw8ltAXUvlXOO65LLhswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395997; c=relaxed/simple;
	bh=1Qr2GggjPi/6cKOviasaXOdwphBzKolEl5/0BUkGD1s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oA+Zbm4UDPbDNEFzL8v83gJY8fs4mAPg2g3pjw3pTn0E+y68v5XJyeRBoNCKeBPuWZm/Byxjdgdaa32DDMjHiBWrjiehmutDZIYHgpmjCls2P5/dzMRg43TEmD1Nr8eBk6Iuwg7pUnP7120z+DWB+RgVE2+L+Ob8v997HvmsF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSNs9+tY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSNs9+tY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso14099267b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395994; x=1711000794; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE3dX9dz2CABEFOsw5CuUFowasd8wR4u7GmklzSvWhM=;
        b=JSNs9+tY95CCkU3pejcP26dgu4kBgxLsz5vQ+G9c9nc0wXvYTvugDRscn2gshQSYCe
         SlBm53EN2T8vQlBHUg3Wlh1vh3Bbmea7j3YpfUjir3xliH3cyb2Myy9llo6to64/NvFA
         CIOG3qVPcRi3QbLIUCqySzOmpyOByhYsdh0NFlkLqLN/Fp762kJFq8WPG8xQSRcwXFK7
         6Z9kg/R0DQeMxxhS7Yu5/Y4CusJnqQXCysO4FhRdNJObie+5PuTg+tO14E0Gl/lpfLVy
         cUGL2l3Owgos6rUeu2l6e3RYA6YS4n5DIuxyZaHhtgu7FD+aw7fFoCYwSueztwQ5Lvjj
         fBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395994; x=1711000794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE3dX9dz2CABEFOsw5CuUFowasd8wR4u7GmklzSvWhM=;
        b=RCAk4bzkyvxjFrBdvqW1wqunBqr1ohxUSplML67PmYL2ixmEgX+BFpWgPyzmJqpS/S
         VaGeQZp9urrFNuu7lW0f60Nu5MlyphIkVWxAKW9T1zuQ1EweM2eq8e38SGpK9fifyRAO
         X7zr2c1INIg+fOMyexNeQG9S8UOMxbIvX3qz44NuzAN/ir81YE8+/qbNygHTBSv0MyUJ
         0rMfSevAlyxQG2zZhvUHXV0SdkUwJvKakAS73gkLLhU7JBYGEmbPnbfnbwLpJIhNedsr
         BWwisGBuYJLyezbPddurz1WXCaxBQt50E6fi0OJGXjv2r+AoDkXw5a9bvbrKo/JSxSSU
         M+eg==
X-Forwarded-Encrypted: i=1; AJvYcCWQVEdvcc+R+TJbUYlpvAYIKHxddXy+SxuyZWHp5LG9cRiFMei/aZUbSzyTaYuzg+zWk1ow7TtHAr1WumHOjI7QAgBKPZ32L6hJDFtyHRQXew==
X-Gm-Message-State: AOJu0Yw7aNi/bQzb/49HlQjwKG9k6f6tupxR/cQ0MH0MB95/4o2p/4ob
	/rzUhJ76p3Xj81gQ1wDeCZTRzHKI9G2JYeh/frHl84noSn5JQ+u2Y8+3AAcS2UNGiTOwijNl8zB
	Z8xGEPg==
X-Google-Smtp-Source: AGHT+IGL9I2AEtU9Gouc8KiH//2cnv3aSfUatRw9lJIZ+fLfFOIe54VbJ81T1fFUWjOlzTPpwFpI/IZ7Fpmt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:247:b0:dcc:6065:2b3d with SMTP id
 k7-20020a056902024700b00dcc60652b3dmr211350ybs.8.1710395993876; Wed, 13 Mar
 2024 22:59:53 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:07 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 08/20] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b02d0c0c3793..b181574c9486 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,17 +1,23 @@
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
 _args = None
 interval_sec = Event("duration_time")
+core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                    "CPU_CLK_UNHALTED.DISTRIBUTED",
+                    "cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -260,6 +266,27 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
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
+      metrics.append(Metric(port, f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -352,6 +379,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

