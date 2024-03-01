Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EC3B797
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319385; cv=none; b=NIv30V2tbxaCcWIJDVjoCZ7bPpkQxsnDNxbu8fwB/NnTyBL80auHSJr6nGuQm94QlhE5YVgTYpTHdah49WV1jlOgemQC1gfjMWsyLsju9hNgaCwwvQPjDVorYRApCJvlZ2aMwKtHMNoEzyLQgWeXXfBEqq+7d0bdGgMfu94OTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319385; c=relaxed/simple;
	bh=zOERgnuO1Bl3NMcQJgmZ4s42PwosJ4JFp5OUJlYIO44=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QLFFLIiDLutf3vVSsoYPaeo9Orzsjvqh9hUvJ0kxlsl8otWUnS8O29VYHRPl6y1ji+1IJiEF/e7pXZ5ZETNYyfgy16FtR47Jqp8Nnd5+a3TmyOOopK9+vUVnBkmUreigdpzNAdYgY5VPsqLdSos08PWMz09ugKpMFYl+WE8XZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQYNPWHT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQYNPWHT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6097409275bso30723737b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319383; x=1709924183; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L68TwYEEJpFcSpLsVXn02dHEJdoYMq6WnWpBdckYRf8=;
        b=WQYNPWHTlGRr0HEaXr2GgwUPHIRvFAEAofaSmp0aG5V9xnj/I2Qu+IN1vDPop3RjdJ
         nXkBg9MMusnsXEV81TESokisplV4q67LjjuTTcBeUI7PJlhrktEaQQBVUhgrNk9tZfum
         HpgVRGSHlREvqzBWhVLlbG34dn4O08jC7jc5ZHVo+hJvsFW2jNCf0pHtXGuo6T0p0kr+
         56o/XXaumo1QmabGpUPZ28Z0abPTO6HUij4ZIC9tc7yHPGTPvs/ISZ5JkrZ5mw8yO5tq
         ckFuc2aDsn2MV9SCt0uEMqJVK7ZB9WMMHn8sYajK1ZFFjZpxwjxQ2K0Tnj+XRgfY3E/K
         b5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319383; x=1709924183;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L68TwYEEJpFcSpLsVXn02dHEJdoYMq6WnWpBdckYRf8=;
        b=cxikghtaFxwFP8DEp9Xx2weLGhNnpWDs//60wnJuD1Wsx6H8c6hSUPUtSF58XQFpwH
         BxaRtIbXRgNUH1mfubh8u0+9AGhNlAZ35nE3r8IzBrJgHNApadQcMFsk9PbQ3J0/uqmf
         ryOHJu43QvNIdh7T+Xm2KONneUpKp0wJHw9HDgEP+FdwbOODzwUgC/w2c8ByALwfTJM6
         1+shclsWWuocL/b9UFHVU6Ng2FuskI3gUY5VOzWImQ2Ubg3b8t/mwgJ0A1nGxKD/xPbv
         oQYYPb/V14u07D6hSnBUj4Jt8N6ugivhEazr0LtqJi/xfkc1avmNh3ku1Yfg2MoOy+ss
         atLA==
X-Forwarded-Encrypted: i=1; AJvYcCU842bqp02nQZ/Tc+eq7qdQRGR1QnNwXVR/BGUvDwxhfK+7uMlL0RMoXDHr2nJGBzRPkRxsv96VMgL27vJl4UmzKZ1nbVeBfxKfuIwLhVUwzw==
X-Gm-Message-State: AOJu0YxIcnYYvzc3gFNMaeUQXXbW1GKlQiteUtQwNo28GxoMlTDbNrRQ
	pJO9kgO5mj1HqQFU7cPGoTP1zTckfwgnamWRF+40/ESDp4OCspeSog+LvDr4zUMJUqcQyoQN9JP
	9G3ru5g==
X-Google-Smtp-Source: AGHT+IHFO0dCF80g8jxIIWcRTBQEcfWIFfew+LmtRMRt88s0hPFXt8spPQ49uPwNb8Onx/ERplYuDrTRSssk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9a05:0:b0:608:2ad5:cd28 with SMTP id
 r5-20020a819a05000000b006082ad5cd28mr464292ywg.4.1709319383012; Fri, 01 Mar
 2024 10:56:23 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:43 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 04/20] perf jevents: Add tsx metric group for Intel models
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 81879e68da96..3d80b555fac9 100755
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
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -80,10 +81,59 @@ def Smi() -> MetricGroup:
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
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
+    Tsx(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

