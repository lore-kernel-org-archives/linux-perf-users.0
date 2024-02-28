Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6874404
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143028; cv=none; b=XNafocMrjW/Tg0poULCh+K4M6Tk5WIoIRoDMEFcsIPTS0SCzVpUnsHfjbqU3D7u3ZLaHEHcwiy48bBSTInHe6tbXdIYl4DEsJOuum0rT0diYwOd5UATNFmlspikQm3NDLhsEQGGuzwlZfQ760GHptA2+O8gxV1eWF8xZ1xNq73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143028; c=relaxed/simple;
	bh=RFf0SovuHqWJtY0/DKROVO/7jIucJjMLUFN5wMVSl0U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jbt0TN3CcSv3jVGLU5m76YwoG05v3315qUKuPPGL/tp6LX25+K0ItVLtluuhHsR9Klm9mtH5671CA9Y6ZUy3DkQ8E+kw38obYsGN0Q7sJvx7n9CITo4bgkVPcHsjjVOiJsiLUH31tTCCDgoQPN0MZuCsvs9lxt2Odk0P4gLiYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vso+9MMN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vso+9MMN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6095dc68e9cso193667b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143025; x=1709747825; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6NqTe4lQsI2lCeybdcDVIAKYLSVy1HDfTgRobHAwi4=;
        b=vso+9MMNgXr6fayIR2i1LyL62utD/cc1sKvPb0PfhNZwymo1M/gyZW+v3uaSHSdQU7
         T2ov0MIlHn51uINxFF0lREaMCLvvGxnahnFJ3sweFaGaA9XM00ok8T1kWykxjbksnyH+
         DBZuUOmpZnSkiDz0+1vXnj+Xzq2KUP/yQhv0VuZv2G1EsFOCJ6a+3atI5V72W+a+l178
         jzwXs/pTCEx9TKnUYhw/IjmxoUsuZ8Fh+jXZwQoEM7RrkBAGeRmmCrqNOsdV859TX+Ee
         zDTyJcnFzHG8Kgh64AobR9P1sBnBPNaJCL5KWytIbWh1XsJh0wmHkCRscWpA79GDD4Ud
         8P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143025; x=1709747825;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6NqTe4lQsI2lCeybdcDVIAKYLSVy1HDfTgRobHAwi4=;
        b=QT8Cx4IXgvyAifEKtch4w/Wlb+5VgVMqdILQLAvgp5obvsSb4XgUH1LExBC4HGFApk
         nuke76H6e3+d6qzVp9narbrokqnb7Ig6yba0cQq/CNHeq58yveH08kl708YxzJJ9lc6x
         YNYDiZWGZa6MJLe08atk8EhU8h1YipB+3ZzKRBP074NqwZdYCQ0scuk5dejqzCEortuH
         BUD90AZbUWkRMdsb6X0TKyPIw47oB3wB+b5YKHOVGo1nZ5Yxrhcld/2/i7fODQuSFm6c
         ZB66PVXXl1v1amD+XYih98+4Ttke2ov0iKNjLNmh02RWmyXO4omUkIQpIum2EnLu2dWF
         8tSw==
X-Forwarded-Encrypted: i=1; AJvYcCUCnUSGgCGXmsUnvHaWwpg5mDAo6o+EykCSPIbkyH7AQ2VCUax86VKpPvH/IrfnKackz56OGK86T6ONzf0AaZDkEc66EBNFAlhyurG3st0+zQ==
X-Gm-Message-State: AOJu0YwmPtU1f69dCOTcXM3Xfiv3u9O8hMC154IXKmPanbuToR3XCT4v
	iepi6G5zPBt0BglilsWBos93ov2mMPjp1ST0nvPqv2nQGCMleKJ7wWl4vkw2l/ItJX4pB116vlC
	glb4jMg==
X-Google-Smtp-Source: AGHT+IEXq2MY86zbh8qNj0dj6Z5P07UKBCnxR9qEnKybPAvKfXIeSsHZc2tWN3H1cMUiTPnEctFXUrTRqY9Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dcf:b5b8:f825 with SMTP
 id t4-20020a056902124400b00dcfb5b8f825mr11204ybu.0.1709143025258; Wed, 28 Feb
 2024 09:57:05 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:17 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
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
 tools/perf/pmu-events/amd_metrics.py   |  7 ++-
 tools/perf/pmu-events/arm64_metrics.py |  7 ++-
 tools/perf/pmu-events/intel_metrics.py |  7 ++-
 tools/perf/pmu-events/metric.py        | 77 +++++++++++++++++++++++++-
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cb850ab1ed13..227f9b98c016 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. amdzen[123]")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index a54fa8aae2fa..7cd0ebc0bd80 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,8 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="ARM perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -10,6 +12,9 @@ parser.add_argument("vendor", help="e.g. arm")
 parser.add_argument("model", help="e.g. neoverse-n1")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/arm64/{args.vendor}/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8b67b9613ab5..4fbb31c9eccd 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,14 +1,19 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
+                    MetricGroup)
 import argparse
 import json
+import os
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
 parser.add_argument("model", help="e.g. skylakex")
 args = parser.parse_args()
 
+directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
+LoadEvents(directory)
+
 all_metrics = MetricGroup("",[])
 
 if args.metricgroups:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0326050f1e0f..7d445e47ae09 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -3,10 +3,50 @@
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
+      for x in json.load(open(f"{directory}/{filename}")):
+        if "EventName" in x:
+          all_events.add(x["EventName"])
+        elif "ArchStdEvent" in x:
+          all_events.add(x["ArchStdEvent"])
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
@@ -317,9 +357,18 @@ def _FixEscapes(s: str) -> str:
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
@@ -338,6 +387,28 @@ class Event(Expression):
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
2.44.0.278.ge034bb2e1d-goog

