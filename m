Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790556B86
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165927; cv=none; b=APDdpS37ho+mMleXaKR1DiyrIQNnYMb8YXRpaOXB1gBfME7tAGMS+BlE4lSMO4EFwd62JsKF0NZGfSCpJlKXWRFN7ir+ZuxPxEX9zGibj7/j08FjFpFNf86bLBJtuEk9k0UeKEEK9LGlZj0ifNZwCqe2WS5QqPZYxXXKJAaoL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165927; c=relaxed/simple;
	bh=UjJzZnr6R5qqlP0DPOq4yMkAe+ITwoRcLwikAmtf/Vw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mflPjHg7I1dol5iy0SfrinEk29AuM1OzMjUTru4/HiSvpaOquFZIrEASZdWBsv7dPNzxC3u0GFq9338bswOM7TfUV8XvIshm8TkT85t50oKdGf4OsxbpxSo2aC2VemQdxQAoftDm/bDHgeFTmyYB62A1tG74BycrpBTUjSxu+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RR0zNOB8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR0zNOB8"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607a628209eso6406717b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165924; x=1709770724; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvXKnLjoS9aTofIk7NbrGOXPtcvKKSLx7CVRKwsuqGc=;
        b=RR0zNOB8QeKKDr9zT4ymzlehbUTq4Ui15grlGIksHGrCfIyyjAOYOiJOt4DcJh6ajy
         c6XTjZVtqxJrmvEs6J5P1xYa+Brie3id9EWJhH6Xan+7DjDFe6gkOz4RdPJnsXIXF+YG
         SpNn25aecQvBbZKxdv9/kbSGDYI/2mYDHzVz0a/CitmuVtZG6ZgOiRstDx9hY+7B4fzE
         2A9ufSdW2NwyB9YQyEKK0l/iJm/lOl0uQgZOEwaJrueL0U+0LkBGeL385WQw3/+WqHS3
         kc2iK5c0Kqk7Zp/d1gfLPaFRtyJFTn+Zg0XCV+J0ikkDTJK6oF7tLaMM9XrYwGo7s5i0
         Cbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165924; x=1709770724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvXKnLjoS9aTofIk7NbrGOXPtcvKKSLx7CVRKwsuqGc=;
        b=Q/1w9fG40NOIMoW3alO4xS7g/SI3MsgBIyWB5xetohFvyExnaecfcm2Ph/Bo0A6gJR
         RS40lNuIvHWiUrAhUxZvwnrBGWh3UFXbfTfa9/7JfrY/F3vKysF2HuL0oJP464vx0+O7
         Ch7g2ZDeSB+JkqZxa6RPRoAehotPNX8Itz2pWLKR7dp4FOLhBeNZ8YlvRRfm1oVbN5j/
         nmJODff6kIPaznysZEEK/jhch+g1W+V5m36gk38l2/uefU3qISnXa7JYmCMmgduuxPId
         4BU8IWeq5hBenQE/9FJj/bxBAfEDgIPteIsNCe0R4aN9c8jSbmsmQR7UDJ3Q0RUGjn9f
         4+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUWgYgHSJdss+5pe+q+gSTX8lQQEFNT5dKYE4PNugVcitwxIKnfjl0H7o4IKlYYF4PI0uA1D6IXOkI994fftWJFDQ6KJWvTcyixQKMyqNnTbg==
X-Gm-Message-State: AOJu0YzPbNt7CllOjYNR2/WL3khbpO9QfAdxdhrk0e8CsalznLjsUbMH
	EIMWbq4k+y2zmjWSEJvON9gMIac9OP/RQG9d7DvtjbWKJKf8oVmq6ZprtARu76IdL+X3o0W3n1q
	YlUWn3g==
X-Google-Smtp-Source: AGHT+IHYr6WkwPgg9sJvpDhjWJ1lpa1m4OebDRaKpMedQ9jCo9mk+RuOjnH0XKFGykdp5f9bpoPx0dL8kxKL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:a90:b0:609:185:67da with SMTP id
 ci16-20020a05690c0a9000b00609018567damr155415ywb.10.1709165924681; Wed, 28
 Feb 2024 16:18:44 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:54 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/20] perf jevents: Add load store breakdown metrics ldst
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d22a1abca8d9..0035e2441d6b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricGroup, MetricRef, Select)
+                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -514,6 +514,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Sofware prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+  if args.model in [
+      "bonnell",
+      "nehalemep",
+      "nehalemex",
+      "westmereep-dp",
+      "westmereep-sp",
+      "westmereex",
+  ]:
+    return None
+  LDST_LD = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+  LDST_ST = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+  LDST_LDC1 = Event(f"{LDST_LD.name}/cmask=1/")
+  LDST_STC1 = Event(f"{LDST_ST.name}/cmask=1/")
+  LDST_LDC2 = Event(f"{LDST_LD.name}/cmask=2/")
+  LDST_STC2 = Event(f"{LDST_ST.name}/cmask=2/")
+  LDST_LDC3 = Event(f"{LDST_LD.name}/cmask=3/")
+  LDST_STC3 = Event(f"{LDST_ST.name}/cmask=3/")
+  ins = Event("instructions")
+  LDST_CYC = Event("CPU_CLK_UNHALTED.THREAD",
+                   "CPU_CLK_UNHALTED.CORE_P",
+                   "CPU_CLK_UNHALTED.THREAD_P")
+  LDST_PRE = None
+  try:
+    LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
+  except:
+    pass
+  LDST_AT = None
+  try:
+    LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
+  except:
+    pass
+  cyc  = LDST_CYC
+
+  ld_rate = d_ratio(LDST_LD, interval_sec)
+  st_rate = d_ratio(LDST_ST, interval_sec)
+  pf_rate = d_ratio(LDST_PRE, interval_sec) if LDST_PRE else None
+  at_rate = d_ratio(LDST_AT, interval_sec) if LDST_AT else None
+
+  ldst_ret_constraint = MetricConstraint.GROUPED_EVENTS
+  if LDST_LD.name == "MEM_UOPS_RETIRED.ALL_LOADS":
+    ldst_ret_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_loads", "Load/store instructions total loads",
+                 ld_rate, "loads"),
+          Metric("ldst_total_stores", "Load/store instructions total stores",
+                 st_rate, "stores"),
+      ]),
+      MetricGroup("ldst_prcnt", [
+          Metric("ldst_prcnt_loads", "Percent of all instructions that are loads",
+                 d_ratio(LDST_LD, ins), "100%"),
+          Metric("ldst_prcnt_stores", "Percent of all instructions that are stores",
+                 d_ratio(LDST_ST, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_lds", [
+          Metric("ldst_ret_lds_1", "Retired loads in 1 cycle",
+                 d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_2", "Retired loads in 2 cycles",
+                 d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                 d_ratio(LDST_LDC3, cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_sts", [
+          Metric("ldst_ret_sts_1", "Retired stores in 1 cycle",
+                 d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_2", "Retired stores in 2 cycles",
+                 d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                 d_ratio(LDST_STC3, cyc), "100%"),
+      ]),
+      Metric("ldst_ld_hit_swpf", "Load hit software prefetches per second",
+             pf_rate, "swpf/s") if pf_rate else None,
+      Metric("ldst_atomic_lds", "Atomic loads per second",
+             at_rate, "loads/s") if at_rate else None,
+  ], description = "Breakdown of load/store instructions")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
@@ -521,6 +604,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelL2(),
+    IntelLdSt(),
     IntelPorts(),
     IntelSwpf(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog

