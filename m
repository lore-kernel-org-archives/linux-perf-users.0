Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE688328B71
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539532; cv=none; b=X6fE9puEVoau+it0CjXW0QwNuEuSreVLNfTEcA+Npq86FSMyi8F/xQg6iXk50U6TSk96jKZiB6fIa/BbuFgwC7EZ0JD6QoSwYueiycv1JK/Sutst7HS7AxCKJqv+luUVRm2drbVgoI7UgkPFFfqY9N615EarcG2j8/FBBiMA8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539532; c=relaxed/simple;
	bh=1vZESDUQIUEjDxJVh7J4k16LRLOQkyT8gAwiI0WIf9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eyZ/Odk6PyDHkKQ6ml+GEAmA1yIo5JXGTwj1QobqNgorhg2KC5A3DpF3481nwKR8Hb/aE+zVLKGUA5sIhpInSIg4HN9Rf5K3TY3z5hn9sY3KXYxiQ4X6hgerZ7f+mYBfZJJoUuw6sfHujL0XuQBviT/TsIdqyNudNWWk4D99Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbLRp1AS; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbLRp1AS"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1233b91de6bso10241517c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539530; x=1770144330; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nf5yOpaWFgwkL2L53uXTvwWf0qlTtHzBTCtpqyJsvQ=;
        b=dbLRp1AS44R9LBN8JGvLDVKt6MUBJQnEzsGaVZRsrE6sg3WGShHVniNZbOY1qzDmgu
         Prq58DQ1icoZdXLu6Ge5V7Mc29M0jApjLsuM0VwxTbbKeeNYYhwn0F3WAeJWJbI1kI3Q
         o9xZQrztLoaIMW+6W5XT9jyKhLQMKterjK4zip9tNAVQrqoNbYtZKm9hb8iXm1d8lV0u
         ZIU18W/QKszEtvjyKkVQXU2TdhJiWdkJzzJD86y152uK8KRpHNQCPY7a1zqfB8+zOJIt
         PWc5lnpxh9Yt29DLcIfceYQZi72QVhrgjriVPE3H8DzISy7vfxYZQnI77AifptWycF0g
         KuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539530; x=1770144330;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nf5yOpaWFgwkL2L53uXTvwWf0qlTtHzBTCtpqyJsvQ=;
        b=LWIUlxHNG1WVHV+cfqoPD7fPmjl1BYaOm2bWuTTsr/xCCxKXm5f1RIGtcinemg7edv
         bnsGpk6NUsxz1I2o5FSVHklnNCxr947U2dAdMdhTIctOqIjg47w9O6U7Pu+GyMpUbarX
         GnEc8S/riIy8MK3ttTlnSQn6VKD1nXmy2gg57JOq71iEIHYC27C4WF8NcpvNiz3G44/u
         gojLJzjeyDgHdLo/4Ca7tMY5BM445R9rm0vSSglTZmKTWTQf+rQqvNxRCXyNc8xPJUwG
         bWrl90l62L6jmuWfLFCQ8fIQbY4Uu+6kgLLevGoRb9tF5eFlVJZ+xeFiq1yftw1W3Eda
         ZqHg==
X-Forwarded-Encrypted: i=1; AJvYcCWs64qdm7nu9pBA5UWCLVdHSJE72XTBbVrYwWs8f1snCmQlBKdeLmS9pwhByr5++R3uIDOemgXUa+kJSIHZGEQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrQGSr2oJ6Cx4i/iBWBUrfCWRNQJqVRwoNeRh7hz0jLj+uifA
	bMEWtqJAzluHwSu/szbbUTSJuXGIq/DTAFaAymML4cy1rcNdrY6ZSqVTPxBkXLKsJxm6lwlyild
	9KitkxL3CeQ==
X-Received: from dlii13.prod.google.com ([2002:a05:7022:418d:b0:121:7afb:490])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b94:b0:123:3488:8969
 with SMTP id a92af1059eb24-124a00e576bmr1587671c88.45.1769539529822; Tue, 27
 Jan 2026 10:45:29 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:33 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-3-irogers@google.com>
Subject: [PATCH v11 02/35] perf jevents: Add load event json to verify and
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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
index 3f2b26e5c6d5..4878d922a732 100644
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
 ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
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

