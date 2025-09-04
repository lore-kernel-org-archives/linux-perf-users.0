Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC223A995
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961223; cv=none; b=JWY9irKNOwhBwJrvJcp1uWyw9jLAX2caixkXAEGNcz+P6mc5hjKs8gZR/MlQO4IVwebLLN+tYS0nTtL/zMQwFRBrJapts/UI9+nAtIgR855Nzs7BK9GX4x91UibxvF6r1nayHBnH9AhV2rDSNuIdvWWtUYYldrS7gWI+cWkxo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961223; c=relaxed/simple;
	bh=Bkq0mEwyXQ6KgmslSqy7aU0tGebrGoz4a1iyDBPBJuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MIjKTfGx8oPvSnID7WfeBZaGnyaf49dRShsF2JR0GAIKRP9XxEjBexxWPysNZTp7EOsWgPkGVH1Aj7+guYlzrAfvrEU7+qlfro4q6RXiLq3nfzZIDsZ4KfBpNl/427NJL3yYNv9Fjo0C8nHiwObW1/xIMOD5D3Gp6Glh4i/rR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaPWGZUE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaPWGZUE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724ff1200eso572545b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961221; x=1757566021; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2MJ+/IfzyDNHViP3eQerYoyIt/1MlYkuZoI1bdvxsA=;
        b=gaPWGZUExL9BQGrRS5iFpRoJNn6EYEnonsF//RA2B6HQxR91MbfLKoxoAmNNX2XD4A
         nU7IRfk80rvceK6pCFTM3Jm8MDbLnBE81rkDsfB0pgPIqyxn2TKXco5u1DN0DBY0Yuz4
         0S8b2hzdQNqzfgHt0ZoqsrdHKtVOg4yFaQtW64ogeVePVD5ob648+MyGtKv1r1X7CXAv
         /w2O3m0ACIR2qXf/huvlljUqlMEVirg7U5cpAsqpKY0bLzgu9sX36jlxxZziVu+EMIsk
         BT2suanySt+Lqcjxbry+aSCuo6ZRsYAUxOWpKkPlr9omRcf1/L+WyHssQNy2EaRT4Psk
         0Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961221; x=1757566021;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2MJ+/IfzyDNHViP3eQerYoyIt/1MlYkuZoI1bdvxsA=;
        b=Nj4wSW2otVMuVMn/MXK87LH2n2Y/BrfHSHRUqutHMmXJQKZERdD/ZkWjEGjDUhQeRo
         CzRmNWfEWQy2OJrQfC6zPWZ9bfC49mXjQv9giwQXvW2qEISCuNiG808GiJT927J9u7gd
         xhK2coDuHEkPTxVYf24yC9YlQf3B7Ab9OEnP8jtXIa0guE5shNdtEiKQFNKWhsqif8sq
         F1VXOmtBH4ZwWjNcKk2qlgPxuPF7WcLyWVPqu9JXPJXqnE1bk2g76B0ViNLNXJXMGBPP
         VDBQXwdsH6/mP+FC4A76ijmobNqisRtIXw5TczDI0qx+R7xwavkm6b69fHG2jCD+2OR4
         vzjA==
X-Forwarded-Encrypted: i=1; AJvYcCV1TklBZG5P/PTsDHHn3wAr4BfOPF3NkhS0dbq0faL0UB7ou/0Nzg/AXHmmgDxHIpOgKWxb7dK2klL5nFJmeUkb@vger.kernel.org
X-Gm-Message-State: AOJu0YxAW2WLgxL4XYzaqUMYIyx+H6n9lB0Pl5zVtnDludoJkVOCOGaJ
	eiOkgNR6CEln4rnVmd9UItHR0wziFfvYbobsgLjhirJoiLJIts8i6kCDHF6ce9SldFkvk/chm0H
	YNSpflG2TIw==
X-Google-Smtp-Source: AGHT+IGm1h1Hef8FmLY8P3Oeo2u6tfpj8k/+uBKI4OWZ3/iy2YSJWyDiB9FlVKWsgXWt9sewhDb6CtA0/pEc
X-Received: from pjss23.prod.google.com ([2002:a17:90a:1c17:b0:329:6cd6:660a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9a:b0:240:356:f06e
 with SMTP id adf61e73a8af0-243d6bca04cmr24044808637.0.1756961220929; Wed, 03
 Sep 2025 21:47:00 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:33 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-3-irogers@google.com>
Subject: [PATCH v6 02/22] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1de3c2b2187e..b6d92e935c59 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -11,6 +12,16 @@ import os
 _args = None
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "lpm_idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor power consumption estimate.
 
@@ -68,6 +79,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog

