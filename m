Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37F315769
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004119; cv=none; b=HR9eBJbyCXY2MFfDiSDhZC1oQZYtFceQvVysTzcZJ1PEGBAngo9wgwtFp8op+ruZG67jMfMko3QeWxUP/A4noXY61oJMi7eyhdwAjJvOHCiPYxjjN9+V0qrElbq6SIc3oc7Vxgf7nW1agNakJVYd4229Bqd3V63uYCaWAa/zvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004119; c=relaxed/simple;
	bh=LsyKcinNr3CPTX48GcFwcCHhWozpCKc5nBdCv3vLTew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XPp7RyjJ0N2ROsQZzl6D+juGeVT9nlfwA+M/BvbJ91MgVMgMStfbW2Tgn4u+jAmqlSQW7ofOwR2eaXHjZ+a+u0EUrKVSs+q/yMiwHRn48ZgBEjcJjqRJAJn1b4KZukLZyNhlldyiQd8SQExOWqtHDduQO/IHaoqs/HcHdXuuI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I88IU/Kh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I88IU/Kh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2982b47ce35so3994105ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004117; x=1763608917; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNV1+CYAP59mMY84k0p51lR2XkbcJc2V/Ohr57nRnzk=;
        b=I88IU/Khfnv2a4sAYh+9ro7eYUXlVv3q9fyoxFREnojK4BQZP1C9xkDEMBOIs13CX2
         s3pm4YWJ1S20ANgqKEqWA3tdj6SHxkoz/ctgjl6elnWQtwr61RYgEej7fj7Hz1V5SPIL
         9UnV0CrGKVH9+dc9yh/JqguMx2ogfDUm1RGOQGIKPplo4Y0CjCQEMCIaJ8aWo6uyQnsK
         p0aCNtkz1kAS+HU+gZ1nlTE35EFxdniBMzEK3UGRhJ2xPkasIyVy+L8fPxH6yY3NJmYK
         eJTOhbuFeJLE74f0xtBxCWHXyM5qDFXiiBVLVGh19C7v5193t3QKZH5YZhRHMbVZgFXH
         ISgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004117; x=1763608917;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNV1+CYAP59mMY84k0p51lR2XkbcJc2V/Ohr57nRnzk=;
        b=aTIxXrOiC/+thyS0HTcG3VedSWZDYNUF8QUPgf1HbCVLbir1mK64AlF3lsTzmKuluQ
         KGLIuZNul44gs+EqJWNLjIeb7Wia02tHswhSvn03ZqYt3B45g4/bRi3Zr+xtz+1h2Ft4
         ssfEfI6jJMdI/9bwo9rILzRtfIXR0QueZvuJqi3jDYCsjioKwb7MVuiUigRLfvnXMPjU
         6Rz9GzMwpnldrClY8/cz7GUsHiCUgVXS1L1QtkysbmeNrN5lCNxqg2eETOMjxekW/dbQ
         IN4NFjUVgwSf/1JsWBOv94QT54826+jQdbiBvizGegDwRLOiiti45KelhliXzSKei/WF
         rXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWsIqFdhuy5OJWm2N9BkF+gj1Z2MD4ADZB4nEvmjPFbcMGfApREkdQAI83BTwDuhRBfYaQv2aKTAb9sjFKbrNXl@vger.kernel.org
X-Gm-Message-State: AOJu0YyCotqZd1aT1P7/pk/t9X76PJuOIrhlDwcYXRJ1fpkficTf5uJ4
	W8H368oZl0Ie3r3ugC28B9RPvbYdJLSNAslsmW53m2VnJtpoJJd8zyb2uBiRCw5BwLBjQQbbeDH
	1HtKE2TY13Q==
X-Google-Smtp-Source: AGHT+IGA+Oqea8iVXOKqwkrhs9I9SGNm1GeMFGhgWmNebLYA/jXIr5+hkhGFbTjsFBUqXw5DiMYhNbZSyyJG
X-Received: from dlqq42.prod.google.com ([2002:a05:7022:63aa:b0:119:c6ec:cc42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244a:b0:295:105:c87d
 with SMTP id d9443c01a7336-2984eda98ecmr62240625ad.32.1763004117305; Wed, 12
 Nov 2025 19:21:57 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:21 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-34-irogers@google.com>
Subject: [PATCH v8 33/52] perf jevents: Add tsx metric group for Intel models
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
2.51.2.1041.gc1ab5b90ca-goog

