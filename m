Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21777306B33
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004083; cv=none; b=Bmc0IPI3LQMfAsEpEO3XzfEAWoln/WrzDFaa+23GSwPHRA0wXvoIoLeFRwSaOlm6tJcUPNaEzz+7lVgTAMQ5+V+ApJAwytFjAkpQCgYubZmK/OMXB8EYdo4WYY7kL/DliuQpdC29GmU+97i5/Zf7369iz0i8fMO5CkO6lPVVwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004083; c=relaxed/simple;
	bh=mugHELPcNnkPEsOWzMwpAbRwOxX71MGXDtzzWHnyVww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MD3r2h6fSRw/G/HJtldVMXwMrZql6bvF3d5msX4ORq7qsQhJ+HSOVuHdHLjE3Kl9zfetqEpdXDMhLWJ/ZaoJhZRJCrf9wD5Wh1fRCC8z4u7J6JE0iV8ej6eIPGMwCq7KAJurwN/IWSR56nmMLlKdJ30IQ5uu9aaPsL5DPMm80Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdsqlUFn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdsqlUFn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so902374a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004081; x=1763608881; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IzU/LLG4PCQCev+2/waDGv979JbQDw2dJFOYSyWZqM=;
        b=WdsqlUFnw/6z5qFUWa9yPpxv5IvNkRACcgxwqcqZfKgeaksnnJC7unaalxjfRPsDrU
         H9Qo01aR232ZIaEdYwpo+dHoNfQbxNXdUtkWByAuwbDv48w6sIWsayJGnjVNsKvWjeUP
         A6/YlAL5PmqIJVPgbglca3gNeeMuhQNb8Qnku88xx6MqLtnSlYVLiC5g2euADUFhHiXX
         tRLwlR9patjmU0DHFXpaEN4Z/7YcPQaq/IVoBOooX8AdE5h2Pl2D/6ae+mna9DUacHYB
         GGgCJuylMyhyiNgiPaJsoVkL2pDXe2z8nOM8YzaTl3+RjymslGzqOceOYoHxLNwRZhjn
         KTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004081; x=1763608881;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IzU/LLG4PCQCev+2/waDGv979JbQDw2dJFOYSyWZqM=;
        b=BJCEdr7jU3/4m4CE+7h3INQPW9QnMoJ4aHREJAnk4v6GnuO0yb2YE0WcFF4hJA9L6d
         eemOtBG2NfIQZNBLlkSYhfRaEQdNovXwReKcoOMTuwi4h/8wiCR7Ta5OaK77ShVLAhux
         oR8sBOtzTwogDphsJQs1R8xEg3Vo8d7PvElfaMnZ0BOTxMsM/dz3tvOEuOipQm5JTRgn
         gBir1c8lvqH2+nDqpVKV/FiD5qwtsM0DKe7PIsMre71CCw7k1TYHwjENGoOfBhlUbLaS
         kjD8NoiNs2e5qLV2U3JkzzzBLnAUTKxPwjKvYKuw2F5oE8DqcA/VwL1KdTMy5w+YR+/g
         QDtg==
X-Forwarded-Encrypted: i=1; AJvYcCWg0a70aqLxV1obUztnsnx9Bxl0Y063N7i92T8L0inlisBtH8K0q+oJhWelXfQIc6+un+D8vdylHOAO/i7ClVpP@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYAsVgj1OHSMba3ThC1GwbxQ2iBoOTgAceOcszx/BhIReK4yX
	5e0AeGivgEZD+uSTdeRZwcJvvijItNS3/U5kYU1j+vh3tCY2YzzX9wBlBgzrbAPTSq6l3Z/9rpE
	+ZHN2aIfS0Q==
X-Google-Smtp-Source: AGHT+IHJNtjFjt48nXPSEtVTq3sM+jWaWamdD6ls29Yp4dYWPbvQH4C2sg7x686wzyEtBJdwaizhHH4Enk6U
X-Received: from dlbbk12.prod.google.com ([2002:a05:7022:428c:b0:119:49ca:6ba4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d510:b0:297:dad8:f265
 with SMTP id d9443c01a7336-2984ed7a19cmr77545365ad.3.1763004081397; Wed, 12
 Nov 2025 19:21:21 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:02 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-15-irogers@google.com>
Subject: [PATCH v8 14/52] perf jevents: Add load event json to verify and
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
2.51.2.1041.gc1ab5b90ca-goog

