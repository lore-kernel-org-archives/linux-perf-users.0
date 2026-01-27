Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE9366833
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539560; cv=none; b=Jsg6YyfC/vmb7+54OvDfw4ZdZb+pk59br1HCRLStDOif5ANJjGOZZCUPBSKzPwUKPQvJbRG0nTeqGUx5EtyymCmyJd9u1Zs5S9qzZlp7Vhlli8Zo9/oBTOaUxM3yKZr6i0NW0v0H0hteyp1Gph1VTavpFfg3Lhl2BKG+1LV4AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539560; c=relaxed/simple;
	bh=e5HCiCuPrRhKQ5C7WVfdNlfmfEV5F34Gu+L6jhwfY7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RTlU6WeswhT13/mqTDKxoF9B9M7oXkxNEHd3OPxspttDf3ws4ISZVvqooYbGP6N9z8GjF6C18KE0fn/WhrE3CHA6UlCy6a1bCUWtC4BgHPnKZNiFipgP7YstwycJQgtm9GGt4hutGrsDZ4mQrDRMHcsN5Y7O302twwEpBULuJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyWNnWy8; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyWNnWy8"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124743cf760so5121202c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539559; x=1770144359; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xk6S0HgVzRXTxY7M8qgn9fyMiMtdB0df3ARIvh/RRkI=;
        b=iyWNnWy8qctDii97Ydrn813G+YM3mMrucrxEeTnP7Fs0E84t17nu+ML+hHQcXijbHl
         XvhP+1lPZhebDyMgbhf58vLz4FvQQZ0AA9SM71pN73cbwyQbM5yNh6izCj7Vg+6NN+Ka
         5eYbkscCoecSa0xPIgYUQ/r7kTry1+GH60WBsEHGMoUYrUlhE8oWJ9namcfluHklxWnK
         PSCcN44ri8LfdbKND/utCTRG3uu7EYXAqdiM1w2M3xcDSZgH2RBFi+u7oFfI82zH3qNz
         kjjIDhhRfWf4wMm6/Zv+o6cMELiow/JNI807Lbst04otvAB1gSVn3dC5egVTXkTPhBJR
         Yuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539559; x=1770144359;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xk6S0HgVzRXTxY7M8qgn9fyMiMtdB0df3ARIvh/RRkI=;
        b=B9+n30LEkcEFXySxkOUA0yrfHEadB8UzP4Dn0xfG36G3FtulP6shE8CwxbiAO11O5l
         ao2GXlgGkJ22JX3Aihi/GBe/luEzBBwIgqS2JiNLE/Ms0m5GNEELjhtaz7w9m0iX8vte
         6OfZtjqNy2GqotccTowTlxiv5cvRJkB1AXHK4Pm4LJYcTXSFj4Q1ymtjMEA5dVGlBqJ9
         Qr4LWeKgdmbiLqxrBbCWDFUMzwb/YhnLzAEiceY7mo6XyIDrTyJgGzlwBM0qXunLaeJ3
         zaS2Y5WLsVXawHdVOLkJ90OUSYEkRo8m605ezEA+no9jUhSS0+S9JjnZaBu3Ug4Que1R
         UbVA==
X-Forwarded-Encrypted: i=1; AJvYcCWu7JPsLGK3xLlQvx88M8VQ1WP+AAvdyQ3APvj4l/vBWYVFwV2YO4NYE2eIp4A2QnKlBa6ZoiP5WmCFKQFbadDI@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8VVjQj3bd9miOjAY98WefAdnU5Ya2cmVNB4EOmyqaESZTw3q
	QJOY/mygEn459wdib+pgH2Z3B1MmDHISMNlEABYZ829s7phrPbeQnvtTTXywKuhdlT1ltRZSIaC
	J9gSf8U62rg==
X-Received: from dlbvv5.prod.google.com ([2002:a05:7022:5f05:b0:124:a551:3498])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670c:b0:119:e56b:c752
 with SMTP id a92af1059eb24-124a00c6f30mr1509152c88.23.1769539558630; Tue, 27
 Jan 2026 10:45:58 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:48 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-18-irogers@google.com>
Subject: [PATCH v11 17/35] perf jevents: Add tsx metric group for Intel models
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

