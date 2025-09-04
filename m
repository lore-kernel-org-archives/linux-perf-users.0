Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA921A420
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961227; cv=none; b=ICgO9TBgylNqvGzrMdpcEN5QTzm5nUvuFYPcNXrUSFaZwqIHpFhydrPpooOvf/DPuzbvl/bVq1Rm5PNk1CNMkID9reS6/Xm3uGYtQ7qL0dxjBfASxgfPHcGEZYU0x3+gb6Kl/oD6W/EAZ77PCGnpbf2Q8t/Wgh7M8jfQWQmnS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961227; c=relaxed/simple;
	bh=DnCBmE4xK87Sv3hyk5xLp4ZbiKYtBCPdhaJpNRobkAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WMSf3xmp6Lko0lgqwu0k0xMa1UUnw1x8osn3fyrwnoOfn3C6qkOeh3yUXj6GdARhZ6smhI9QvuGdA1RewhPuXmeWosn0Bv93gG3vaHreHeN+HmuLfUcvshSsIAbrn/vb7AEjw7ynUQRfI5+Q+61yVC2dBqYx0zFPhSA1HnKWnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok3HM2uH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok3HM2uH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c9e2213f8so8638855ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961225; x=1757566025; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3G8zcYg9JGKOxRo4IqvzwI2DTd0mcQtugg6AtT15mRc=;
        b=Ok3HM2uHWvJM/vMKpX8zN+FZAhh+fKSC0L88TN9zq01HFF1aZgLKPj4+Hho4CV3Rt9
         DtSY4ur3kW8uzqeGgouVk3cHKh5P4KT77S4cttkJbcMeeyuScyaUWru00kmwajDaLTiq
         79+wz/5SbQ6XB2ExD0dgDtJTBDzx2jEY7JXzWrstSx2u0HX3yIyMaIWrUyE0bLw9MvHs
         s8E4rQ2ZDvsqyn4V83LHdTFqR8ON3goBkRKCjAI9er5D3XA4vHscDWyYQOc5O8CHFrZp
         W+XYcKljsnGfDLS+6FMg4B4jH6trZQyik3sBhAEYWkJDSHgtmXUFi683rZ8ayXwlb8D9
         eakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961225; x=1757566025;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3G8zcYg9JGKOxRo4IqvzwI2DTd0mcQtugg6AtT15mRc=;
        b=NEB5m5msqQKayv8o8s5jlOMusboxBUBg8fkzmm67EGDV5M5Yh8E2SLXcAu4IfOy25C
         y8tqiFEWX1FXpxzDu+CbWVCdeTMK9fLb5z5WIlqePlDI0bxQAFKc/vROCFCA7PRVwUG9
         mDhP3CGha+d5IWY4kcY5UmN8SYEUk+xwyOWDAZ/AkL98sz2ZwMXT+V0LXOgiX7HwmQ2S
         DS0rE0iOGacYVeDSmxYHg4Eih7LB/oEvYsgRPHO4Jj2HFxboid86bTTuCjBjo8a8Ly/s
         dpsMqzrBuTJB+5ygAme7T5m6n9v2LNAfzotQ+EBSWpGDozDy/Q3jpjcI8YbVmdayapQz
         wisg==
X-Forwarded-Encrypted: i=1; AJvYcCUcNeM8IF6kk165jWID+FeGTx1uzUCabjXRdi3vDRC4Zwaicvfd6i/q/7GHJXsGcjvANMidAzame+nxb6VzJKaj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2phkXefO7SwFCQGVXC0W0Yad39u4Xi5iLaW9rOL+f+OPAdTy
	dfQETDXxvA/5CnIvtjcv/jtnUBN2fH8ZbwV7M77iyVNdTzizeGtKbtwDkY3z7BvhnjkeMOAhSZK
	bzBCfPTh7Dg==
X-Google-Smtp-Source: AGHT+IHpgcJVMNlEzLD5ocJ7Nx7ZlktfJkvFI1S/iIp2hbQTjXIwkBte/hjR6eWcD5TA6JOydPV14ik/5xjn
X-Received: from plap20.prod.google.com ([2002:a17:902:f094:b0:24c:8b76:4f4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cf:b0:248:bae3:ecfb
 with SMTP id d9443c01a7336-24944b2940emr225476855ad.59.1756961224961; Wed, 03
 Sep 2025 21:47:04 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:35 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-5-irogers@google.com>
Subject: [PATCH v6 04/22] perf jevents: Add smi metric group for Intel models
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b6d92e935c59..7d1c4c21a786 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
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
+    ], description = 'System Management Interrupt metrics')
+
+
 def main() -> None:
   global _args
 
@@ -81,6 +100,7 @@ def main() -> None:
   all_metrics = MetricGroup("", [
       Idle(),
       Rapl(),
+      Smi(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog

