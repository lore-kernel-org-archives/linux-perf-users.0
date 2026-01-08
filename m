Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C432E6A3
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899519; cv=none; b=K7aBMo1NkjaUpj593W0f+GIthS9yAykoLbM1pALagvk0BD04RDV80XE9AjklUQjh3LcNnD9fXc8LI1T+1aQ9aklQwNIQFqn/p7jKJRlnuTeK2IsbLDv9St0BKxGndf9B9uHQKwrNq+4QWeSAL0YYQ9yZRzuXt3nN/8bCwlhzZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899519; c=relaxed/simple;
	bh=YxZ/OsA3lmCo6/plyihzmoA72k7p/jAWTQVj1BOnHOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m/qb90gJapEnhyybIrgFQe6EMF1mkB3c2Tmft1wtTBPB/l9Kc0E8z+Zh4JmpRKj+oJ0erMGQ3eCz95VwqysIdKbAi3JHOBxUD3UaYpsj/9WkFdSUT2sSi4Mz7tapoXrah1QKBjYjIsP2BbIYdUIEQXAIbw6NuJMBMReEpJs3//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZ/cAJ7j; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZ/cAJ7j"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-121b1cb8377so4582727c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899515; x=1768504315; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OecttgXJ1EvArNGliMlBZCK1j+fgZte6pz1jbYKv0lI=;
        b=TZ/cAJ7j659Bl62t/lWGrXZozVeKS4D/rRWMNVyFMMkKKSCLz61c+C8LB+CrPT63Dv
         26jVmvvil6Z6Xe+qjlW02R2FvxlnVvPoHi/YapnWJQ+rME2J+ap7uOKeYdpmuXIHC6dV
         hLnpctkFosNEJL9DsA8ZG2V15DQtKwAO7CYZouZBWfbr8lpYspJnRR8r1JJGOBjC4wWD
         bkY7u/PR198707QH7ssB+oBig9NZ3wWAzyvUNUaiyo4MuXv8f5+V7EgpGu6uw5p51DH1
         5QNh51VAgxEZSPgyexmqaAv9VHHOzEZA6MvYaUIWvlWurqMUFwDHRiqMCRhujsXlAp9e
         GAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899515; x=1768504315;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OecttgXJ1EvArNGliMlBZCK1j+fgZte6pz1jbYKv0lI=;
        b=L3sjRMGGlMlevFhWivs6KVJZ8jEYfXhFcM4MRFx9TQHvkHzwZnIFcOtJQEh5dyMHDo
         BnQEH6yYUt4IK9MdONmgOkIgUNXR/xbmZthrwahfRIALPTLBdkvquLvaLYC5lIx4XVt5
         QwAiVBczCbxfq2ARK0Ubzss3+/Qzpmq3jReWCPVnej3ZH7QGrdTLxz2cxm5vay6PdkIO
         T0fjV002k8l/mp3GXIdL3TZ+EbFAC57Foy0vpnHbPD6gnMPBOvsWlSzjeziKjiciFzo3
         sx9ugb6H2iqExRveTaxGobJCYT+QNP46T4xjeWWSPvSu3ruiQFKXdKe1Q8dq0WjJOyyJ
         Bg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVexC/RfFl/FfQs5o3AyE8bfvVuQmD3Z2oY1A619fAvugtKBDCDgzAeLjxd9obQfs69CurlIZ957SEiucEfZX8g@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKgHbs0SXpHLnYC128GlI0uBdNmTse9zLHELgLCKOdXN/ujHo
	CqJqbdeOAw+B2MZeccdyCHGJSrBNkTSZlNznYsZGmglYONc1zBpt+PH1Mkyi2xUvrUFOCbJ2jZQ
	5t+zX/23QyQ==
X-Google-Smtp-Source: AGHT+IGd2kQf665nloazUkG63CJWxUv5NRwbj0g4dCCQG5Lc6YRA5wiulJJUPQnFlit081KbV48IVNnl6LsC
X-Received: from dlbdd40.prod.google.com ([2002:a05:7022:aa8:b0:11f:36a2:78d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:425:b0:11b:c0db:a5ea
 with SMTP id a92af1059eb24-121f8b7abbdmr6160878c88.26.1767899515006; Thu, 08
 Jan 2026 11:11:55 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:45 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-16-irogers@google.com>
Subject: [PATCH v10 15/35] perf jevents: Add smi metric group for Intel models
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

