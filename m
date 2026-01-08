Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610932BF2F
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899522; cv=none; b=u6a0sGYqxn2mQI1vGj4V5DyS6KEzfiCfbujcK2WxnOwJFiU8NtZ4KV+YKbqyvfITnAgiJIy+WCcDfjZdqqIIqsGHwECiQm4hvPP94aQZG/P3o6eCcHpbATQV+xLhINwvCIpezxwRyNryEIuhrFh2b6MDDNdy2t2G4bXqkjSi+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899522; c=relaxed/simple;
	bh=e5HCiCuPrRhKQ5C7WVfdNlfmfEV5F34Gu+L6jhwfY7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NB3hzpuJMZ3QFHQxfrqqiBSfTStRa26c1GV39vL8TAf5ykFRnoJiNNUwWaigWYVXiSdxrRejtOopJ45OBWlztevOhsryfwHOF/GHVETh+RWwsV/0wOcm3Ond5KswmAMdUJlVaRs+q8oyq52FiM+g2wiJDlCmdr2k6jIpgCHQx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWRQAuTr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWRQAuTr"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac39bd5501so2530311eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899519; x=1768504319; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xk6S0HgVzRXTxY7M8qgn9fyMiMtdB0df3ARIvh/RRkI=;
        b=kWRQAuTrQI0pOQh0Ll4cL1uEIgMeh9EOrKuOMekNXbDZc8KUKhQjN2KPCb8C42lM/+
         h8r79hImoaviMLQM+xs6y66oxv4nqiNPco5o2zx281V28J8N4xRLDneQ1LrHrlcly7BY
         PuPpSTYzPAj+5bWdaTdh6q0Gk5lbgnLj0X6FdbVSXeginx6OJM152QiuI39j3IaOiOOl
         Fqmn2VqKbI7AdkKOobPOpIwfbyV9XrT7RG8bz4HJMcx5OJGqq/U18vJdCemFDYHDjAI4
         nWQDvv4qy8DQDWwOVcipuv4fsMiXFxi7GOFEmDbpFywajyXo2HjdF1XF/L8UiK1OPLwF
         RSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899519; x=1768504319;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xk6S0HgVzRXTxY7M8qgn9fyMiMtdB0df3ARIvh/RRkI=;
        b=ExIKSjXr+QYS370YBI2Zxim2xUXPfNAZxuF2Mk3vSAVIUCvOIDrT9SKzjX8tba7KmF
         XCm4JhLdhjoAoGMxZb6W6ehdQEESw8HZK32kAuy9Ej4HdX3ar7bBycEpOhpmQda+t9VZ
         EoY3Hx7YnCvqe/oONtqVGnw2Vvpmu58R6Nn2QooJR7tbjNOv124p+YMsLjbyyreYPpTj
         byKPJgxYIUvAokRKWsCAKU34kA/NPvN8w0fMk6uJOTyQ1/AgiEDYU7XSFtkt0/lah5Dc
         izBcbqHOU3RLX61Kv9gvwUZEYVwHsocitKoTod3hC1zkE5Jv8ykrtlW9Txbhk20eA3uA
         1g4w==
X-Forwarded-Encrypted: i=1; AJvYcCWr8IWr7xduCB3Y53dGKwgIWZEaIZufp3QgnBq8xBRXtrQvXy4wBVdFtJUKV5rHJGrm2hrveUch6HW8ZuuJontI@vger.kernel.org
X-Gm-Message-State: AOJu0YydcXTFb9AzsczCbc6/YqsnOjLf0HtxHYdWYgDrENOnprETiWa3
	tb6yUpSOJMOLY8HlGwSVEyibTKCMBKKKP2o2D/KDb7cGH9jSzpx4hj9l1l6OH08YTfwABb+uw4s
	JpMnftBAG4g==
X-Google-Smtp-Source: AGHT+IE0YYVq29C6WQ6XFAWFEiR28SaNnN+3y7gJb4bYD9PO6loo2xXE8EyJOZ5RP0E0T6/QEkZ+ciLweTId
X-Received: from dycrr1.prod.google.com ([2002:a05:693c:2c81:b0:2a2:47b6:b541])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b90d:b0:2b0:4965:8829
 with SMTP id 5a478bee46e88-2b17d325943mr4556597eec.34.1767899518910; Thu, 08
 Jan 2026 11:11:58 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:47 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-18-irogers@google.com>
Subject: [PATCH v10 17/35] perf jevents: Add tsx metric group for Intel models
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

