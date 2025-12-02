Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1B2D640F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697936; cv=none; b=Oo2W6kOn8m0ZyH77IyF3izcLnc8+fv1pPYfd7sMHiCM9YaHODgdqRRCJBqF2fS5yo4D1uDctS6BG8rDJqHvf1wWS+1/wwtOtuHsqNclYPxN724Bnl2Hww6cdqHq5+PCxrOO9gjKV7CX7Ey+qF8ZcQLi3iW0L8yar5Utw6dEmjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697936; c=relaxed/simple;
	bh=ehrs+/F8JrGJwHb6e21kRYPXDhJ9lTQsrrw6hHtxPW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JwYP6V9ZQeb6cjqL+7hS2HufkDiOFMtCV2oRb839/xP+2iH9sBFogR5Tpc+ITKB0cB0WbS2X54a31qB9BEJRpx7kUZYbP1kS0wB7kTOBBquNRijFhPNquxr/jmkanNc9Y+RE7HWpi5ta+Ku9EWwH0LJrS+GnzqG8gwxpLOtfPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SB6AAMlB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SB6AAMlB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so8320758a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697933; x=1765302733; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pz62a7ZgMEb4AWZjPxLI7D/0iC9MdIiBaBDumHgEdfQ=;
        b=SB6AAMlBpmdHWvbS6S2JMC+CWoUW2c2/spLsAWnEMlzYk6sm348M7S6MM30XGPukff
         Em+GwjbpVHTj2YSH4BiWSS3R8iLe+v42PYUJL433CtNXHtRq+U6wAD5GsYG+XXZBzp5w
         jWSS27PWGwx7H8KSr5jiFB8wjT2I0BphIACyTVcXrjpVgHHPVSGUZnVlMSy4wk5ODebt
         a6TVCdp0uToiYJYSjqu5nJk5cSUrtIKqX5z89rZCnuANbn9aWyY/BTLAJy8OfVHNl2S9
         KsTdSncdMLzAHSdJ6G/RF804ddXRTR+NnVet7b265ajFx4wN2mTQ+F+eJX1Qq69WP6tl
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697933; x=1765302733;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz62a7ZgMEb4AWZjPxLI7D/0iC9MdIiBaBDumHgEdfQ=;
        b=HUL6n5cMaGX8U/Hi4AYP1QC3ZhEaMY66BN4JY0P0uH/SsWkmz9eLYoN1IM5ATgTv6n
         RJGLQoaDyacukV90OBrRI0G9BSFZtY0quarRo654dZCtR8+dwsT2FzQMYb4NMi9mbsq+
         z5gpq4YQwlBR0B/KVP65fdFeG8LMMDZAde3cbfC4YLccIkkg9Br7S7CSmgyKtLuKVnwB
         H9QKtf7gg2X0AY1L7ZqEcvSJfRvrDyN4FYMvDY3Sc9ltC5TbsFlJLOQ7iM7ZT9ST3Y7l
         fCBRSmXJZcNOyn4KPFycTwuXbedX0JS5szf1TV34lYGlEHGfUcoOtz3eUA4KELRQG0D9
         AHiw==
X-Forwarded-Encrypted: i=1; AJvYcCWEbMi30OS/QabRJ+RQK+4Wy77eJjzruIxk9bb9ztiJJQqd7L0I4wQWlctFkc/OWx7yeVajr5bC7m8Mt3Xkdaeq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0SWbprt8ji2zOo/AuO5N9OacSNHf/xwhfz8TNPbF+HHfU9gB
	LEVwvmT26vWrSrrZSfgrVve70OUungSdONnIkcEPNjYa73UkXfgUVNCy37m3V+cruXGIeEghmyT
	BUndiYSASzQ==
X-Google-Smtp-Source: AGHT+IFxViD50p4Nqfgo0gNFspfuVjlIbdpCE09Jtj1ilzmBcEem02TWBqOcewhaB+fw7KBNXDn7LLupjMEI
X-Received: from dyctx12.prod.google.com ([2002:a05:7301:5f8c:b0:2a4:7052:5652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e78c:b0:2a4:65b5:9868
 with SMTP id 5a478bee46e88-2ab8fb87b19mr198813eec.38.1764697933303; Tue, 02
 Dec 2025 09:52:13 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:09 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-15-irogers@google.com>
Subject: [PATCH v9 14/48] perf jevents: Add load event json to verify and
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

