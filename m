Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943C17DFFE
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373060; cv=none; b=gxQh68ixXANQoyK0ZXEswMoPXh5/OMnKBMctsCxNNgY5Hghbq1P/mTXreNfl9eFLGckyCzbzB/fiPSAtofepASBlONpqebYLltNTTrO48BIKci0XfOrxDkDNqHIWcGcU3UdnzQjx6HyVXzSbrS0eTtj6aCLsKuCIFg86pIVoYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373060; c=relaxed/simple;
	bh=URHp/eVr0IFpLIfbP+qP759oBFQfHvW0X/+lRmQPJ70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g1wQObIf19ZT2a80aTyAWSnkoiQpbtDr264F5XeL1y2nF+dz0g8o99f0y+i4Hw2CrKXNuXZKj2QxWgp5bsJyvivJV1P272M6L0OKFYOVhBKeoOtqTocumgrJ8yEdpnaUmlzxcbz2VqWWZMplSnclIdB0qV5e2Pshu/UDZ9Ke2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pgAXbHG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pgAXbHG"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso21531787b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373057; x=1727977857; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa0UU65XkvI3xLAuaBWW48yjVonj7PnPiZA6S98A0a0=;
        b=4pgAXbHGTaxA05xkwfXfYb/OKez9daD1FrlT9sBHSCF616PWI+C1FEx+T6W+2NxrLa
         TOiW3a2QhiQRdKP9j++lOjOu7R80GNepH60W1AkN/lFIKCUnylTZVIx8xoySfwtBM9Ch
         MD4GnWq1Vn6BjwtN98Pa8weBHKCXkBiF8sRu2KFFPbK44nu6CmAQvRj2YWBsUsGSH7M5
         6J+yMjKX3cCJYMm2q5GJi4B2JjuMieUv+6s5pdnLd0OUE9KdmifQxPtOKSIU3CQRI5Mq
         dXdh5iYXFvXCldBh4MCgRjO5/VjV7DV+48gAGAjn7tNlvOPaFGVj2NyZp/CXcC2uRY+Q
         XFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373057; x=1727977857;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa0UU65XkvI3xLAuaBWW48yjVonj7PnPiZA6S98A0a0=;
        b=RF6bD+4Mvt3O18XagN6JvySkKcy1Pc4EaJmMMmLPsL82zIhWvsalII3xvbm7Xj3Ay1
         VZj3AhtrzPmi+t15ecbQgFs4p607wMbxKPfslvk/HU4ZwU6BDJru6YfBsLdm+2xiJ54r
         xV6o7e/ZP4N/r0UIDVqQ7ZAFS/wGd+ZwvLzjtNDbLuBW81di1zDFFmejCv0+71LEb+/0
         LNBweEddobC8GPNSP3hc7PP16BYJyoJ+jbSBEzNqq+Ok5Qb/2jBDJNlzGdnbEMOnoZs7
         VwM11bBbOY/YBQ6fUNJdd1QzJI5PGsbVOuAFZvy8scJQ3uDTKvOlelOuPBMn2YzC1nBL
         w+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkaem34L3rD1YLR+xHgoIfX0bkc7aqgxKR4YPkNGk39OEPOePTiQ58WAO8DHUIXOrxqbYVVwEUPLJf2z7e2eYk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4hyNeAd9Dnmt4v1066Bnx0zvea95f1X1a6vucVIhsylgunKK
	DbXLlkliHs2Xjzkl/SQYRUIyCBx1LxgIwV9Ir3Vtu1bAZc8zbYj/HNrA16RAbTkjcP2pYf0Eagt
	ojCtowA==
X-Google-Smtp-Source: AGHT+IGcz5TtaF6GZtWTpew/CQQp//GrncLvgAcSgMmxC++oh/oBgRb905x9SowNglc8qt16hYxFE4dsxfCB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:b19b:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e2604b2b0f1mr155276.4.1727373057093; Thu, 26 Sep 2024 10:50:57
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:19 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 06/22] perf jevents: Add tsx metric group for Intel models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
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
2.46.1.824.gd892dcdcdd-goog

