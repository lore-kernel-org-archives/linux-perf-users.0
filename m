Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A01185628
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373066; cv=none; b=GP610olQzMPowfb7LC5mb9c0h4HiMGUFJXDCt/eE7SDJRAeGqR4PGq56aafAf325cAHj+InNtXtfGrUchLHsyRHp285cf0yfmL6sn7mhLx7pCjT/XuNni7Rs/V+A0z2pe+xYoIM1B8KrmMwy1aY89yR61eM9cfFjlCvn356ShkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373066; c=relaxed/simple;
	bh=hAqjOE9fp1rQtl23ZWK4iSTnmzGmv+G1FolxnETIgtc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZBmK7Wqvk3moT73hNEa66YC2i2ekiFEF0UJ66tF3/oqDa3wINUFWEByHxEscXRLa/M158m2Cpbk75HKQVLJ5N7W3EPjUCDHVyTb8itOS0+7KayMYnjJiACf+eMZS9WdHWQmWMbggphoySTcgYi/FoT0Zq594NZoeIcUZ8mJXsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Hot7qag; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Hot7qag"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d10fde51cso2111981276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373064; x=1727977864; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PriJ3iDjrb1t84/uD8+PU7R2OVSzSS6eZhq1WFLdxrk=;
        b=1Hot7qagEud5mR+y1ZrnnIMU3UWO3iAgOsnppjl3OPl9OBTF9e6vC+ZT9zxY7AVuMS
         /JURgR8FXoZyEhFemTuLuAmHpcfR5Kce2GYwV9+TD+7Wx7CEyjkzqmavFLh6toA+21WC
         Kmoas3UQJ/skX0xmVhZWNHSjv29/YHgE0fzw/10LZcxjsqQctuTkWTpJzeminxvJaIpk
         +IRwYhEGPCH3vvgScS18SdwWx8b7HVAHGHPDCiG1Fw0hXa+yRaqLCwmyk+hClihkuQFH
         azWwS77+Rom9t4ch9mcQCn3a199udrYbkhYbq5Bd23McwYpFHH5+VK4qip/xuPLe+5hc
         ERrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373064; x=1727977864;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PriJ3iDjrb1t84/uD8+PU7R2OVSzSS6eZhq1WFLdxrk=;
        b=WTxVTwiRKcxMMrHoZX6Dk9H/JBUzCjioJHeD3ARgW6FftgnKoHmuumCuQtsP9hRIoA
         v4GsGFLkapQV70Lvip9BxVlMde55Dzbn7Cx4SssonHkolVRmbgcN6VjC10i3bOEyirp9
         QGfAU5YassgF8TjvmT7oNhlcEjHucxzBl8Y21so3pZwO4Ih7CMflwOzc5Khqs0RZoinp
         g9RMe7ZIQfk7R0PxqNFGcMfBavUM3Groqn73ptjM0RBEERzwMHVQ3sZWos2K0jce+h8W
         JYAqQwp94NDg7c+EOk1e3zP5babwzaeyDsxEAXE/cWj/WFMPIHtB+WFtAXYZDphdb3Rc
         9+eA==
X-Forwarded-Encrypted: i=1; AJvYcCWXofgtDuQ04uGqKaic0ZNx3mkGYpQpu4BdQ6UwptCajHGDnn2kjcgLF1hnRJsz4jSKJEpxchD3S0WS5Fwaej7s@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQWDmzY1tzia0ohWO9mUgcffugiOawHvsZFF/YY8s+E8iVIIs
	OVm6tAzx628HeDjBZjXkiJNgDw5vzlBK3GZx9D+jAu2owM7lA7SVXOTEH1IRQUVGgNas90K/lmq
	XJN6+qg==
X-Google-Smtp-Source: AGHT+IH1UoCPcntcxKzFTLtNyoMoMgupg2AvFuCO5KDj2u2ml5VTxvE+NPilqqp4dhs2PjPWORTGnL0lp5Pp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:6902:504:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e2604c8fd7emr174276.11.1727373064233; Thu, 26 Sep 2024 10:51:04
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:22 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f4707e964f75..3ef4eb868580 100755
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
@@ -260,6 +261,33 @@ def IntelBr():
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
@@ -352,6 +380,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog

