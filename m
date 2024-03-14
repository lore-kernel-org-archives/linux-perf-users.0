Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333239AF5
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395990; cv=none; b=Oannjn0+9wYP/p8AfvNBrEu2QtmIx3It8NnKw8T+jFYmC66azFWt5hUfg1JnydCOljQWYWb/xBAbRyhxVE8o5KPItHkzqOnfiKAvAnT+VE6Be1/NQ4LsEuhpXjTmenGo6EKM6yW6/VSAH5DfeGLOJIdIuxtJ0IFu+HJudmP+gZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395990; c=relaxed/simple;
	bh=ezts1SNNXZNxj9LhQuYH/wsj+Q9nYnkcvRFPOrQH5NU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VRbbQpLjXE4QsQRmVXSH1YVhZcPrBDW48zm4c/MFUkqnmQAA+iCPY6CE91vqKsXAOuADGVLhJjLxOw2jsTJS5PpeajU3h6ewiO/3mk0vZXJb0V1YSO6EYO+CcbO3hshBmPEG2C6VrVnaxLXPtgxAgLFcTmDuz3BTsckfz4bwiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ijfrqof; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ijfrqof"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so763851276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395988; x=1711000788; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc6YXjrCOCpyJhvEJp6tDQdGSaY//cGMnlBPtpOLWG8=;
        b=4IjfrqofBkyItL+StkrOLepM6fJXlYqAi/Gcv68JYrW+QIGLigm7hYjcKBkcyrkXuT
         Pw3PIowx1U9NykU6KnvFbrBnjOllxxa4TByuVt0kDUt5qEjL3DWB7L9tLYICspx1CcL1
         0uDCtNuAYlEize0osqOZ5hQUmkhfDv7pluqpJPoLv3zXCnaEHTrD0+0NJGMGRc/HfenA
         J1SLh5mz9mw9iAHyrJgfjN5SPQq9JGBixt6vKwV4ElOPV/N6Ekcfg5bJXUwDUdUoTRXI
         7Hi2sag6sNciQwMllKbAOtt5MZlv9coJvOROYawXhWQpDQ0RWeaASxkt3x9/2uwGCwbJ
         w1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395988; x=1711000788;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc6YXjrCOCpyJhvEJp6tDQdGSaY//cGMnlBPtpOLWG8=;
        b=mSrYM6gZN2Fxh0M6yoU23B1JnA5wwIWFMlTeai2z4+xEd3o0aNB/WJdbowlY3akN/L
         TZUIyD9jXK9vY2SX4psiCXt4F7UxosPRKINVGsK+T5lRQh/tQcSWfafRjnhd9kK0D5tm
         6BXOz4EHsiODNUIgZ7NNWL3mKZ85nomUI/VPcyi1AA+uzjPqmKMnQFBi8FwfEoy96ENU
         UWdjH9Z5Xjbn5IEVJK7Ah+pym1LEUitoqiIh/nzK9sSZY8hAQcB00rDRWXk1Ms2PJCsl
         5jHoVf8fsBqbyereEBHu+qMG32/mIRE3O/Yycf5PP6fJW+qjlQ4zHHGvzYu98OTbnmZr
         lrWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrDtHnbMAyD4E7YKBYBgEq8vvCekIcMbyuE6i3SaUYddq2qffPNQGQlKEekH8tLsaWou+95NOMGT3jJE1WK0ZZtLOwo3QEft32N4od0SHH+Q==
X-Gm-Message-State: AOJu0YwtVad8PQDZDzDmRxjMHjFvxv5bomEaH+7Mgja72lovCC8E8Jwu
	7HWbJqc4hhUW+WUprP+9ovzD4/cxgaLiDQX2nPu/7JhLzfGJYBbWrh0wLKQhe1W469W7o1MCgjx
	oYgt3rw==
X-Google-Smtp-Source: AGHT+IEOxKPeWAIPaad3vDYh4PJ0xM4XujFoN/8aPaMrp250cr+Ezt/hXSmH49NAvHShMRe7EKsrv+g3X0FM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2301:b0:dc7:865b:22c6 with SMTP
 id do1-20020a056902230100b00dc7865b22c6mr34277ybb.8.1710395987985; Wed, 13
 Mar 2024 22:59:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:04 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 05/20] perf jevents: Add tsx metric group for Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f34b4230a4ee..58e243695f0a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
                     MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
     ], description = 'System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+  cycles = Event('cycles')
+  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
+  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
+  try:
+    # Test if the tsx event is present in the json, prefer the
+    # sysfs version so that we can detect its presence at runtime.
+    transaction_start = Event("RTM_RETIRED.START")
+    transaction_start = Event(f'{pmu}/tx\-start/')
+  except:
+    return None
+
+  elision_start = None
+  try:
+    # Elision start isn't supported by all models, but we'll not
+    # generate the tsx_cycles_per_elision metric in that
+    # case. Again, prefer the sysfs encoding of the event.
+    elision_start = Event("HLE_RETIRED.START")
+    elision_start = Event(f'{pmu}/el\-start/')
+  except:
+    pass
+
+  return MetricGroup('transaction', [
+      Metric('tsx_transactional_cycles',
+             'Percentage of cycles within a transaction region.',
+             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+             '100%'),
+      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                    has_event(cycles_in_tx),
+                    0),
+             '100%'),
+      Metric('tsx_cycles_per_transaction',
+             'Number of cycles within a transaction divided by the number of transactions.',
+             Select(cycles_in_tx / transaction_start,
+                    has_event(cycles_in_tx),
+                    0),
+             "cycles / transaction"),
+      Metric('tsx_cycles_per_elision',
+             'Number of cycles within a transaction divided by the number of elisions.',
+             Select(cycles_in_tx / elision_start,
+                    has_event(elision_start),
+                    0),
+             "cycles / elision") if elision_start else None,
+  ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
   global _args
 
@@ -100,6 +149,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

