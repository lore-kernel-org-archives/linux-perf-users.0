Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347F366074
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539557; cv=none; b=E0PFFYPx5b5TO/cUrLEn0MzVTl+81Act07H76daNIhWt/HcO3r4JoILTgqJqw2E9NKQUQ+51pm78cpzXrgIyGetAhcCiPtLKqk7dfccnEWkXkCJLLfel4FKRzGsKX6cE+IZepMXqSUGdEnYvwDzD+nHJHdqxJUwwVg16+HNRUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539557; c=relaxed/simple;
	bh=YxZ/OsA3lmCo6/plyihzmoA72k7p/jAWTQVj1BOnHOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pMwcIkWMA+jeIa+giyG9WKpEFFayAuKJdEKiQMwLrz4h5AP0uqXsOc3xX+SAWN0oSZq4JhLv6jzaulgQJpHt47xDCaGbB1pyfW7nUP3xu1WMtqw/dS6gCHIFkoart47zRtGTq+COR2JxARjtUwMqf9AoZf23IuIeNmwEvIBZxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQyAx5cX; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQyAx5cX"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b799f7a603so1113929eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539555; x=1770144355; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OecttgXJ1EvArNGliMlBZCK1j+fgZte6pz1jbYKv0lI=;
        b=mQyAx5cXZHO2nMklf0R0c5wQXehqmPUXsXaf/EqJcGyq50DecZ1lk/6xYvFCPl6bFm
         1usWfWfaFuQtuJSkcF0T7zbFEK6eG8HuCi/tNFR19ky5Zd9rrYdgant6+RMqXAXZzaJh
         Ov+w+1nkQHXXr3W6eeayDe96+0Vd9IqHeqQarAqNpucOK19wl/+3eXKeNsXzRcQ6Tg6R
         m+VJb79U5PpMyYlOh9q7JYYu3YLZoyAuLksU319Hv9K6aNEq0ADiPSDw5joEyOFWptT+
         9M46dg/jo56ZbHvZHEHBcUsygFHiNzPrq0u8QHPh6t3SG/rZVB+Al1FJU6qiChFs99KH
         rMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539555; x=1770144355;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OecttgXJ1EvArNGliMlBZCK1j+fgZte6pz1jbYKv0lI=;
        b=s9LUJGNEhpqeJEZxHxhz5le50xFmA1YAVTPX9dNy04T8t4e84tXcBFQWXSn3odsJjI
         z2KzxIald4mLy+O1LHSZxSXa4QRpJI1e3A6JJsY5TQmC3aD6tvjl1nhSS8dou7Ih/Z35
         5mVq37Feu/BPbW5Gv0Dt+KowaErX1P7Zkw5OtjALnVvZLs8zGsaHw9MCEpq3w7wozapZ
         tO9Iy6ejnFYrlhA5O9v9r1RyVz/jQE2faHODI9jiFgBj0gpjoo5xjxeJh5ybuH9nxR3C
         yMeeBfqHCQT61npRDyiGOgzNCmQN/aVuaQxLC5RXRPFX+6ATs0/RPZOYY+K6eM7+f8qj
         y4/w==
X-Forwarded-Encrypted: i=1; AJvYcCX6VCoje5ZEloNzkfU8vDAh/j+X489Tt4B7qI+Wby8aZHDa9H3POuPE0jzP+D/62HSVCHvRNTzeU0D/HTukzoOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1RNk69HaogjNaTNfBbMhCQR9K+xpuku4y2i9ebxFdKjYYXUC
	wGFX018DXA0POUDqI86BPg6xasvcHWYxABbfgdT0OhM9kUVGqGg4zTJoglf5TZ0jZWUy2AzOa+Q
	8DyX5T5N02g==
X-Received: from dybkl23.prod.google.com ([2002:a05:7301:d17:b0:2b6:b833:a98d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d02:b0:2a4:61d1:f451
 with SMTP id 5a478bee46e88-2b78d8da0a6mr1537521eec.16.1769539555104; Tue, 27
 Jan 2026 10:45:55 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:46 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-16-irogers@google.com>
Subject: [PATCH v11 15/35] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0cb7a38ad238..94604b1b07d8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,9 +3,9 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -56,6 +56,25 @@ def Rapl() -> MetricGroup:
                        description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    pmu = "<cpu_core or cpu_atom>" if CheckPmu("cpu_core") else "cpu"
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               f'Requires /sys/bus/event_source/devices/{pmu}/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description='System Management Interrupt metrics')
+
+
 def main() -> None:
     global _args
 
@@ -83,6 +102,7 @@ def main() -> None:
     all_metrics = MetricGroup("", [
         Idle(),
         Rapl(),
+        Smi(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

