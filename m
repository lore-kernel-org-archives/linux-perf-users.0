Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD231A545
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899492; cv=none; b=RNY5LsO9ihgz1BjSFzmq7o9gPNMxtTazHTJ/ZYE47eKuy0o09bBv7Te3IRytlPvGqYM8y+sBeFLOLE8VU/o5xyCqpuLwhTNzNvNJn8PC5PO7cpjZv9ncK62FFiwB9KGDaj11QCho8tudjEoisM4yA4bFyCUN2dPFpA3LFCdpo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899492; c=relaxed/simple;
	bh=G/JB9j/yYCSUzB144eRGqJpTAe5bFSDu1WPbAp7DSMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QSZiX1/+cSSyxRE4ASbPi9JcLyU/5FupMsY7ABR8pQ4sA0lUjNroGjWw1w6VjU5ewxLU+74ARLjq/m2aQc/LJYrAETgdyWHcd4y4p3Iv3Tkay4wvnndVLoDT0943azXBat7RIvyTaoH0s0/8AmGHtGmkCivin+nWuFEFr7tP/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5ha7cUP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5ha7cUP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae51ce0642so2720237eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899490; x=1768504290; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOFJbV3DF8K93zyoG7zhHHoKjCsogbKqWaH2d7uXc50=;
        b=t5ha7cUPKYT42U6bgR63JuIMSA7a28UocmD3a4Rs1VwSNGfrcq5AqqpJjgjE/Lqxig
         x7lgUBrLqhxQ0z09WCc4ywFUg2AvrSlRvcAYfbPYa0wox517aJ0Jp6urO3nKDH15RlsJ
         ZYmJd8G2SWcm5Ez4M0XbWjLpnaiNPBhnE3hcmu19EC7FOXPL0VY8OafBwknoNEuZ3tPR
         TjcyXdQgIAx5ELm8TlpAFbC25LwdyKvmnVR2MsfQMtYnAUTiltnYYNQC+GmJ2TbKxMc/
         ereuLxDY9ERaCaci6H5i50tDs2R4utqqC9rv8qlcDXnI+Y6aj8qQHuW5epCiTNOBg2ED
         IP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899490; x=1768504290;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOFJbV3DF8K93zyoG7zhHHoKjCsogbKqWaH2d7uXc50=;
        b=JSvxgpbwMSXJyeI4p4jPGWTQI4CfwcVR9yuCqJxIPv3VLCevBYMscsoAdGSxSKrOVZ
         Qay5cfmUwGUDQiFHgnve1P1foJ1599BL42DBKJRRyHpUDdQy4DJfJo52LmQ1b044YEFC
         Z8bXhMMjQZy4iT8xVN7kDFcO/pRfJrPIqaLmQBmjvdgIvReLZW6ZHsRjhhDryFaPGhl4
         PoaZYuqC0Nc9HZthKqQEtaHxEwVt7qBsFs9O4f4QOlBqoHauZ17HEpGXASHtaSgUE7iz
         plmlMsPZ9H2APws6nTkbME5Tq9/b3LwKFMCSLrK7q1ckmd3N22QUQFIgwBJGWO6muJ7r
         wcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtToIRYb4GX+mHPs6SytCMTqasHkv4DBDfKxjGzefShgR2FXxaLPRQp+/uOV0NnL4yG4eC8JOYnHDpBGqN1rWj@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqZqhRD1oDPs339CSt9US9nsw3TdmKI9gTkHLNt0oIwPo8REY
	jQR+D5Btp1Uk7Ha0FdlJkCNCa/U5zhDaHz5IENRHo83PB41dxv6/0bZ5LQxjLxtusE/EFYPX2QL
	YvSOzs3ac1w==
X-Google-Smtp-Source: AGHT+IGx/I1EkXmT0pCXtNVnN8DwePd5SYUczq8/6YLBpar/J4jmt6UKlmBjXm3ZdYi1KmcYvWAteb3OOSb3
X-Received: from dycpr5.prod.google.com ([2002:a05:7301:fd85:b0:2ae:5736:c985])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2411:b0:2ac:2bed:163a
 with SMTP id 5a478bee46e88-2b17d264cb3mr3850358eec.14.1767899489967; Thu, 08
 Jan 2026 11:11:29 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:32 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-3-irogers@google.com>
Subject: [PATCH v10 02/35] perf jevents: Add load event json to verify and
 allow fallbacks
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

Add a LoadEvents function that loads all event json files in a
directory. In the Event constructor ensure all events are defined in
the event json except for legacy events like "cycles". If the initial
event isn't found then legacy_event1 is used, and if that isn't found
legacy_event2 is used. This allows a single Event to have multiple
event names as models will often rename the same event over time. If
the event doesn't exist an exception is raised.

So that references to metrics can be added, add the MetricRef
class. This doesn't validate as an event name and so provides an
escape hatch for metrics to refer to each other.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build            | 12 ++--
 tools/perf/pmu-events/amd_metrics.py   |  7 ++-
 tools/perf/pmu-events/arm64_metrics.py |  7 ++-
 tools/perf/pmu-events/intel_metrics.py |  7 ++-
 tools/perf/pmu-events/metric.py        | 83 +++++++++++++++++++++++++-
 5 files changed, 101 insertions(+), 15 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c9df78ee003c..f7d67d03d055 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -53,11 +53,11 @@ ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
 
 $(ZEN_METRICS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) pmu-events/arch > $@
 
 $(ZEN_METRICGROUPS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
 
 # Generate ARM Json
 ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
@@ -66,11 +66,11 @@ ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
 
 $(ARM_METRICS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) pmu-events/arch > $@
 
 $(ARM_METRICGROUPS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) pmu-events/arch > $@
 
 # Generate Intel Json
 INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
@@ -79,11 +79,11 @@ INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json
 
 $(INTEL_METRICS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) pmu-events/arch > $@
 
 $(INTEL_METRICGROUPS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
 
 GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
             $(LEGACY_CACHE_JSON) \
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 5f44687d8d20..bc91d9c120fa 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from metric import (
-    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 
 # Global command line arguments.
 _args = None
@@ -30,6 +30,9 @@ def main() -> None:
     )
     _args = parser.parse_args()
 
+    directory = f"{_args.events_path}/x86/{_args.model}/"
+    LoadEvents(directory)
+
     all_metrics = MetricGroup("", [])
 
     if _args.metricgroups:
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 204b3b08c680..ac717ca3513a 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from metric import (
-    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 
 # Global command line arguments.
 _args = None
@@ -31,6 +31,9 @@ def main() -> None:
     )
     _args = parser.parse_args()
 
+    directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
+    LoadEvents(directory)
+
     all_metrics = MetricGroup("", [])
 
     if _args.metricgroups:
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 65ada006d05a..b287ef115193 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from metric import (
-    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 
 # Global command line arguments.
 _args = None
@@ -30,6 +30,9 @@ def main() -> None:
     )
     _args = parser.parse_args()
 
+    directory = f"{_args.events_path}/x86/{_args.model}/"
+    LoadEvents(directory)
+
     all_metrics = MetricGroup("", [])
 
     if _args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index dd8fd06940e6..e33e163b2815 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -3,10 +3,56 @@
 import ast
 import decimal
 import json
+import os
 import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_events = set()
+
+def LoadEvents(directory: str) -> None:
+  """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_events
+  all_events = {
+      "context\\-switches",
+      "cpu\\-cycles",
+      "cycles",
+      "duration_time",
+      "instructions",
+      "l2_itlb_misses",
+  }
+  for file in os.listdir(os.fsencode(directory)):
+    filename = os.fsdecode(file)
+    if filename.endswith(".json"):
+      try:
+        for x in json.load(open(f"{directory}/{filename}")):
+          if "EventName" in x:
+            all_events.add(x["EventName"])
+          elif "ArchStdEvent" in x:
+            all_events.add(x["ArchStdEvent"])
+      except json.decoder.JSONDecodeError:
+        # The generated directory may be the same as the input, which
+        # causes partial json files. Ignore errors.
+        pass
+
+
+def CheckEvent(name: str) -> bool:
+  """Check the event name exists in the set of all loaded events"""
+  global all_events
+  if len(all_events) == 0:
+    # No events loaded so assume any event is good.
+    return True
+
+  if ':' in name:
+    # Remove trailing modifier.
+    name = name[:name.find(':')]
+  elif '/' in name:
+    # Name could begin with a PMU or an event, for now assume it is good.
+    return True
+
+  return name in all_events
+
+
 class MetricConstraint(Enum):
   GROUPED_EVENTS = 0
   NO_GROUP_EVENTS = 1
@@ -317,9 +363,18 @@ def _FixEscapes(s: str) -> str:
 class Event(Expression):
   """An event in an expression."""
 
-  def __init__(self, name: str, legacy_name: str = ''):
-    self.name = _FixEscapes(name)
-    self.legacy_name = _FixEscapes(legacy_name)
+  def __init__(self, *args: str):
+    error = ""
+    for name in args:
+      if CheckEvent(name):
+        self.name = _FixEscapes(name)
+        return
+      if error:
+        error += " or " + name
+      else:
+        error = name
+    global all_events
+    raise Exception(f"No event {error} in:\n{all_events}")
 
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
@@ -338,6 +393,28 @@ class Event(Expression):
     return self
 
 
+class MetricRef(Expression):
+  """A metric reference in an expression."""
+
+  def __init__(self, name: str):
+    self.name = _FixEscapes(name)
+
+  def ToPerfJson(self):
+    return self.name
+
+  def ToPython(self):
+    return f'MetricRef(r"{self.name}")'
+
+  def Simplify(self) -> Expression:
+    return self
+
+  def Equals(self, other: Expression) -> bool:
+    return isinstance(other, MetricRef) and self.name == other.name
+
+  def Substitute(self, name: str, expression: Expression) -> Expression:
+    return self
+
+
 class Constant(Expression):
   """A constant within the expression tree."""
 
-- 
2.52.0.457.g6b5491de43-goog

