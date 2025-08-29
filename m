Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7C257854
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436875; cv=none; b=B3EaCpHUivbczWLAqUQH0J+N6jRYii54xrvHzch5fQ4Tx7SzKI2CtLKqXZzKTEiCd3feeLRVNr5fMMgorlebk8cUBfiTg4xGFG1TQNCWoUIfCmuYpHofnWZYFeMHXZDX4edMkttowyUw/fCHNrSuovuO16pvRGFoNi30CnkOaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436875; c=relaxed/simple;
	bh=FFx1dYPXVKqYdN8RYVwUXuaau5b/R/0LjxqzhH83O44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r8hvMnFvi2Q3flbvTVsNWT+elC3XLLTVvKNmRn3vN+IULXe4WLyGypB929cYTUKrVvNZaFLuS9hO7mSZIffiSQbPNPMxQsNLZRrWcq9974K0n0MFG/HSsfkozcIA/zF/gcU/ccztRINsGVHI2JaG4JnodyWM+1I/sZq/Qhdvji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGO7nDtu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGO7nDtu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248f86a01ceso6667785ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436873; x=1757041673; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDIf8MPVJpA1DiHojusqqVZbsBmk5aBglPDni0Vbkyc=;
        b=HGO7nDtu1MmwPoPPvL7gzonEuH+mWfK+nWqFPjSt/8GzmtNrrsVwszivKQdL8Y9oig
         ZzH1VpdtR/C9+cuGBQ/C3lF8KIMkLHZglkkl33hkn+YGLokwDxiL6wPsrv377leISM7O
         FoBXF3VDlyLZOTrUo2SAyXyai+DicVTa82WnPzdh5Vgw9OCxJktoyUSKqfOOJdb3t8YF
         MicR2JR3pAXrgl/4dBG7FBrxqJ7vJxUt2LKLyObcv++2zyPfRaizqdAM2kqNQ0xnWQSl
         0NBjiqmgNEcd/qQCGxyQ4xqwtRlRkZb9+dlP9aUoHD1IgxbGnklZqnrPbRNXl1MV98E3
         rLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436873; x=1757041673;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDIf8MPVJpA1DiHojusqqVZbsBmk5aBglPDni0Vbkyc=;
        b=UwJIMLsC3uAyrjFJrGv368tpMcPJyw3+BtoGugl+XE/eBOpw2cQ7A6MVl2FKIwBeFM
         IBYZNfkTywQC7OJ8BBJJn0PZXO1tZ192RX8dQ8WUK9t+cNKuRpHlX2QAouMB8+trd5te
         Iap4tEEDCQmrg9JC7eGamr/Y1Rk57LFFm6wzWQxgXyzuEfKPqjb+DjaEhwo3b2TA8FTj
         O2ivqQUdp+2M/lqeoVUmNMdp4UuhLUgKexuSK731vGj0BNslA8TQmhCoUJ3eMCa0FqfK
         MtJic9RhLIB9rZ8f/kYm2p7lbbMcwESSGlq5rhw2avDmOTwJMSpnk0vmxibSQwrs3o2W
         YGEg==
X-Forwarded-Encrypted: i=1; AJvYcCVWXYRIIRNipklWI2TOn+IoSDrJjgmbDsPyGVl9uZLzyMk0bHhVu1y7Q8v6SXk1itMPNpWcAijeLS/kUOhwTEzy@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKxqsawAQ04K4v9ZGXwF+7NPcfVI+8fnXB+z7inVsP1ywXhJT
	Iy/AjzrW7OjzL2LAspqylYXBHmAGkyC+ka+HiXm7ozmG6WT9i8ode00WOC/zy1cQ4M7NcbU5HYF
	FpUTxc2pWOg==
X-Google-Smtp-Source: AGHT+IH8FnFgYYKVktzxwkDqQbB6t7WoEXR/RYmo4JCj3a6rKZy7DWGgk3scoWAxW4dRpT5jWFRwWTNsnZ2c
X-Received: from plpe3.prod.google.com ([2002:a17:903:3c23:b0:246:222a:4ddf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2285:b0:246:b5a3:134
 with SMTP id d9443c01a7336-248753a2949mr149310595ad.14.1756436873303; Thu, 28
 Aug 2025 20:07:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:26 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-13-irogers@google.com>
Subject: [PATCH v5 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
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
	Benjamin Gray <bgray@linux.ibm.com>
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build            | 12 ++--
 tools/perf/pmu-events/amd_metrics.py   |  6 +-
 tools/perf/pmu-events/arm64_metrics.py |  6 +-
 tools/perf/pmu-events/intel_metrics.py |  6 +-
 tools/perf/pmu-events/metric.py        | 82 +++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 162d5f74cbe8..366cd720659a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -52,11 +52,11 @@ ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
 
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
@@ -65,11 +65,11 @@ ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
 
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
@@ -78,11 +78,11 @@ INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json
 
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
index 7ab2ee4fdb17..4f728e7aae4a 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,6 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
 import os
@@ -27,6 +28,9 @@ def main() -> None:
   )
   _args = parser.parse_args()
 
+  directory = f"{_args.events_path}/x86/{_args.model}/"
+  LoadEvents(directory)
+
   all_metrics = MetricGroup("",[])
 
   if _args.metricgroups:
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index a9f0e6bc751b..c9aa2d827a82 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,6 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
 import os
@@ -30,6 +31,9 @@ def main() -> None:
 
   all_metrics = MetricGroup("",[])
 
+  directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
+  LoadEvents(directory)
+
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
   else:
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f004c27640d2..04a19d05c6c1 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,6 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
 import os
@@ -27,6 +28,9 @@ def main() -> None:
   )
   _args = parser.parse_args()
 
+  directory = f"{_args.events_path}/x86/{_args.model}/"
+  LoadEvents(directory)
+
   all_metrics = MetricGroup("",[])
 
   if _args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index dd8fd06940e6..36e9cb3acf6a 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -3,10 +3,55 @@
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
+      "context\-switches",
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
@@ -317,9 +362,18 @@ def _FixEscapes(s: str) -> str:
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
@@ -338,6 +392,28 @@ class Event(Expression):
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
2.51.0.318.gd7df087d1a-goog

