Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222A2D5A07
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698017; cv=none; b=GMyH0OTCSZnRo2ZEmiStLHBWW4Da8tGfw4Gnb2RJOLuPwWTQVhrveDtTmrxY7mSpN5iVLMtD91DDyTCvXjOCiSfIJidRVf1TbCtqCSV8zPE0Spi5c79hwA2ODEKu0AvDoNg+8xVuTQtLu7Rhq40zUQvFTaCzG3IzPLgq3PUAgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698017; c=relaxed/simple;
	bh=NNOXiWGx3mkUhIhjrOqGTilOSUrSFRozKFaELeAVXuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HfZlDOZsDhOXRnz61XrcWql/BbP1c9H+N9fsotHYtriji2ZfDvT8jSikUUVMrZM5NI+Z0nu4JMJzUmE9yDuiHa2BuusWR4+dd3VjhdueL4IqCJzlrbbjHWv5v9XFwRmzOP9I3DevFZCox5JS1Vb4mongj5EelPrxTqTQ9/G2huM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8kuUsBD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8kuUsBD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so5853625a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698015; x=1765302815; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kagJRUkunuf30Ut0TYFOO2mO5Mf8Y3yJj8xTm5T9Lkc=;
        b=u8kuUsBDfdWiP4xDWIQlNENeiMjBOKwm20+VTpOJbEqjXSkJ3JJQg2oYW7NCCaXQ4O
         3BykdvBCqx6EuWSsRYw7PT4rNbc/nGh4T4q/bt/UrFyC7WhMwAdOvPb+WxW9r7iBxAB8
         mFrWa1Cje3tOvcCPteRgWBi/HqR7gXP8Mpp1yBL2mYUDZV7UK2+8sB1sUE2BaHVcyR7P
         yjaHBOuHIy4iwQ6UcMH4NQ2ynFfq/UxQ8wPS/D4GiG1CM08tmu2yuwpi/H3/belzxTBr
         HuT0D5yDcT3Q7JIAvHZN5e8PfXtDDuNDgQnAYK5KNxPXV1rE2hyMBZf1ifqUT52ARBSe
         XrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698015; x=1765302815;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kagJRUkunuf30Ut0TYFOO2mO5Mf8Y3yJj8xTm5T9Lkc=;
        b=HMtx9ILTre50Zl24El28HdXw0h8DaTlIZtU1iXpD0JJQoLTGpc2iwwx1Jq4iNJviOn
         p7N/JBhJMEleV6ePB46OdP9DjG6K39Aegm4X6psS290CSX8N42abGo9LTEjVHUdLDQqb
         L2ql5PBjTxKFvJ3ors3NKMGOlC+73ZPlbhitS4CMIucxo2sBdsZ2jTiwkcucMoZdAlj/
         U2NtK1V9edqH2mJoEj52ijMvHe7Da6byMJt0Keljy+gL9D1bB/Uc9d47VrgX3LgQUBPk
         9XYD78eBC8cutmBmDo4aBPxOZ3zIBzcODw2sLilqv4mePSK4oEGls3fTK86zzPUwVZY5
         4lzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPeTBZ7UKmvLBO+hS8xXFhj1P3f0FjPDHFeBI+wp6f49H0ySID3TuuOF8Z3hyc6NmUe9LQaPUHnmp8jVPn2HCj@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/zq2S+5lkkmwhcqN3lBm0IBP8YHx76PMJLlpdpuKR+WFGWT8
	AfH1tLnn09VDXWXW6nC/iEYbvC6gTrU5RQ0CHpnJQyGVx/QSMPWqpV/1DMH40wGG68ECPm9hB3F
	GGuUfEsNtjA==
X-Google-Smtp-Source: AGHT+IHKteFVm3tJ6cIW/EiJxB6p25YtXwsAPClDJsG6Uot4gbu+RAEE2cp/sNQKuA69ZsWJcJ9F5ODtFroB
X-Received: from dyer27.prod.google.com ([2002:a05:7300:231b:b0:2a4:6899:e5f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e827:b0:2a4:41c3:3a45
 with SMTP id 5a478bee46e88-2a9415736femr19495183eec.2.1764698015038; Tue, 02
 Dec 2025 09:53:35 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:24 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-30-irogers@google.com>
Subject: [PATCH v9 29/48] perf jevents: Add tsx metric group for Intel models
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

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 94604b1b07d8..05f3d94ec5d5 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,6 +3,7 @@
 import argparse
 import math
 import os
+from typing import Optional
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
                     MetricGroup, MetricRef, Select)
@@ -75,6 +76,54 @@ def Smi() -> MetricGroup:
     ], description='System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+    pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+    cycles = Event('cycles')
+    cycles_in_tx = Event(f'{pmu}/cycles\\-t/')
+    cycles_in_tx_cp = Event(f'{pmu}/cycles\\-ct/')
+    try:
+        # Test if the tsx event is present in the json, prefer the
+        # sysfs version so that we can detect its presence at runtime.
+        transaction_start = Event("RTM_RETIRED.START")
+        transaction_start = Event(f'{pmu}/tx\\-start/')
+    except:
+        return None
+
+    elision_start = None
+    try:
+        # Elision start isn't supported by all models, but we'll not
+        # generate the tsx_cycles_per_elision metric in that
+        # case. Again, prefer the sysfs encoding of the event.
+        elision_start = Event("HLE_RETIRED.START")
+        elision_start = Event(f'{pmu}/el\\-start/')
+    except:
+        pass
+
+    return MetricGroup('transaction', [
+        Metric('tsx_transactional_cycles',
+               'Percentage of cycles within a transaction region.',
+               Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+               '100%'),
+        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+               Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                      has_event(cycles_in_tx),
+                      0),
+               '100%'),
+        Metric('tsx_cycles_per_transaction',
+               'Number of cycles within a transaction divided by the number of transactions.',
+               Select(cycles_in_tx / transaction_start,
+                      has_event(cycles_in_tx),
+                      0),
+               "cycles / transaction"),
+        Metric('tsx_cycles_per_elision',
+               'Number of cycles within a transaction divided by the number of elisions.',
+               Select(cycles_in_tx / elision_start,
+                      has_event(elision_start),
+                      0),
+               "cycles / elision") if elision_start else None,
+    ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
     global _args
 
@@ -103,6 +152,7 @@ def main() -> None:
         Idle(),
         Rapl(),
         Smi(),
+        Tsx(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

