Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691C51C3B
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165922; cv=none; b=rwHG+OqaeAa4VIINktnf6abDEFviYp6e5DCZ0IGGhJZ7ygOo+mMnwc94dLETetJUDyHd+1cO9Mz7KGD/YTZZ3xy2kQD1yVz0pcZqFW9l4Z73n6R3w8nhh/Cu5Aof5S2qMtwORdPZI8syL6cpE5fRnWf1DM0ZYUBy11svQAM14Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165922; c=relaxed/simple;
	bh=yjVC8LCNIc1SkJJNK1huvdVoLuihBnJ8/xrqhZCq4ak=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eBNxNGGeld5pOFhE5fREmNnLrOcTNkgenYXEo6soIer3xbFTP8ed1YCEjkLbuxEoLyY570l+LOj7PtLtxceExIbqdB8W3fzNV7B5yvbtRpgm+5RvlKfWU4cwAYwlIuGfnEnd/2TMrf/ZB2mO79Z1Ey8AhAPRKZq+8dOUBkXcJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXbLB6zI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXbLB6zI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092c637278so5459067b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165920; x=1709770720; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KevBgsY4J/pffn7xcpMTC+4LgPUcMPV9xIrPsMU+9Ks=;
        b=TXbLB6zI+0/6+6vGkPpMthp8Vsxif4X0xxUustURUo4Ess3YNY0eTvkuNQgS3r8zrY
         6tlSV5TwfJrVlkb2PNv6N2pmo6e/TfPgtzYAVWl5m5j2odk4t4guhryu4+IbHnSLrj92
         hrFDri20zNOA+nBXBbIMxat0QybrWMIEJBprb6UIarzcJlbERzpMlijNb4tEY68XAR8I
         8Y0vo1TH8e1VI/6Cr7bO2quv70VLeeHdfdzzIugHyLdoblgX6BWnqWhG0mMaOGoicXk+
         16FuSWbkmuopilPWZY2FZiiajN9CaXBAAjN82uasqnF7GQLiYixrnjRl1HCfMF+5xwhq
         nUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165920; x=1709770720;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KevBgsY4J/pffn7xcpMTC+4LgPUcMPV9xIrPsMU+9Ks=;
        b=ET3JilwHzvpleOi0PnJajbHsZ7HnHHAqSN8W78q4F6xg+cfvaiETc/xsuC2ODFqJX3
         B3xSz+KUFFMg58CCQ3q+jwY9N3rDpJVMW+C2kgv1o2yTaiELlhmemvfxFTucttuEgUdI
         C3bBnyYTrwqh98KSemArSF7p8t774/0aR/KPxvEo4KfKzeK479r4YWiAh3BdgsuWVkWt
         /mES1dZedPXsCBTOnhhDrBCQ6XYlWaQW1SfnfN4soiL8y3r5PYVlmt0xzVpfd642QUUg
         jN3WcPQz4dEQRR3P//34KqPJXbZAFUi6mJH7Dh2MLySoWCo0pukgifDbnBIxXrDEZE/k
         Gndw==
X-Forwarded-Encrypted: i=1; AJvYcCX1EF/aqDsBmp/LwTBV6QWwK7pUE5uuMMnijX2X86bg8xJTxyAE6d+iENb3JDldB3K/cWhq6I3zM0DQrOd4/ZG49otkaGxUD181l1NYjp/73g==
X-Gm-Message-State: AOJu0YxMARwyZ7F3nR6UtSUcg4ad/Vs/OyapGgIPiJC0s8JkpgTP13IY
	KCkNuI0rm4KW42j6fBnOtC5HqqkPMoQ0Q5MySCdIINFSXYmmNz2BhZhZDSMo7/nggVizC27Hc0J
	YSO5nVA==
X-Google-Smtp-Source: AGHT+IFlP6eN2j1eRfy7sjBDk7E7RwirfhLDiu6aNv3eb7Zo8EY3zKs948Zt9E48owNMTBeAfysMTufX7A6o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:e90:b0:dc6:b813:5813 with SMTP id
 dg16-20020a0569020e9000b00dc6b8135813mr41854ybb.9.1709165920173; Wed, 28 Feb
 2024 16:18:40 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:52 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 07/20] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f11273e9935c..63d46ee1dca9 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
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
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
@@ -18,6 +19,11 @@ directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model
 LoadEvents(directory)
 
 interval_sec = Event("duration_time")
+core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                    "CPU_CLK_UNHALTED.DISTRIBUTED",
+                    "cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 
 def Idle() -> Metric:
@@ -265,6 +271,28 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                   f"/arch/x86/{args.model}/pipeline.json"))
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
@@ -335,6 +363,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelPorts(),
     IntelSwpf(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

