Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF5C3B199
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319382; cv=none; b=fKFirw9GRpe63iZfh+yJ8M6Ao881MKy+8FbYpkL4i64pHoaoYPQu8O1a+Hzwj1uDWEn9mIM8TTYgCKpzxArhVA121qGi1uvjZSudMusmhk1pq2dLZaG8SHanMJLH2IqS9y8kiF235G9z/T3UD5nVjMwoupeDvvcHFU0WsyCRGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319382; c=relaxed/simple;
	bh=8oHWhZlncmxDfpV4axl6yS7DtQzS0saV/qldweLxMzo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WBm2EoM7JGPlXJvs+uXdnTpwS8xhSnwAJf1dvbGdcvGcvGL6LHfqyPVQm9esui81oPGbQegnSYrX8NicOOd2pC+jHJAKxWo/h50CZWJxSXn99wuw+5CV8T7xG95pz34dfjv2hAs4frnGN6O2y6BxOhW9j0j9XIZSdyibiR+746M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12dW9lnK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12dW9lnK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso5062865276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319380; x=1709924180; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK+fLoseEVnt8AotaCi+y9ZDN/WJ8lwPCKN8c7HO7+s=;
        b=12dW9lnKkgDoBGQjOHPeh+9G6SQr8fVUDHqSyoSTIddpRuQxRxtCA24wQl8+LGcxQ6
         NE8hKTKrwTZQqXr8yubxvKRZzZ/P4n1TW2B/Fgzr15bSMu25nQslO8PD6Hauya+YT6mE
         TIH0VQ56QfEi8EwOTPqSgAjZJ8O5eFj29VwhENAyOwyluMYY0u18qFBPc3yz3uVt8aN7
         okdwnRNxGBDxPyMdqmo1RnTxfvcHwJBLdC3x1wPt8tFzn7dE7C0jng7/me/rkkP9tP5d
         kNwib/h3N/ZTsQIOzlITB1TK3s9kli3+9CR0lG2Ds1InbUFjuSfxM/OU4uCRg4BxW+dt
         9b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319380; x=1709924180;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK+fLoseEVnt8AotaCi+y9ZDN/WJ8lwPCKN8c7HO7+s=;
        b=eR+vrjZ9VgNwyBUrCD67l0aYybsGRgrYZnkmc99ktkbNGaVy5U90ajQkCRMigNvKIF
         WFNylnvHJ6snT0UEwAePViv4pQZH+LXltL2YqCyzNgim61HCA7dZ9uTps1kJcHa5crYd
         B3SOZIeOo+YNmwNEeP5Js4Cj3pFEB9gF4JviaVPtMymcrOYn48T5gj9fVwErXKBMfD4N
         jp5GNN/mpZGrjf8pBRWDrn/ZLblQ8cDhEsULNVLWskg+xpBmgpzvQnrn6PhfIdxHJqyJ
         eDQmOUgq2hMWcKq0FG53RvUEHxWIedIywHICyCSz845JowkN+bb+ii0I3T+CNsg3CzL1
         XBUg==
X-Forwarded-Encrypted: i=1; AJvYcCUjD10OFpbfnD/X1JC5Qq/JANqHQMkJtX6EJHjwYDY6u3bpL/ruBQjBTAf1viGE3SoN0LluyXu/G+xMfKhIPBA7DDR54zu5bUlp6/iQq9Hggg==
X-Gm-Message-State: AOJu0YyhHr6mo82WJx9yxephU94rpnB5NnnMqRiu8sxlRBE2xVtxwSWk
	3EklAij4+MklrjsZktma5jDL1cCl6Et2mjAHlkZtZVDkO1oGX+qpAX+P+Radjl8zqQ1z/i0/zc0
	2G4+O7w==
X-Google-Smtp-Source: AGHT+IHCc0kh+X6efbw5NDafcaFuhbYBF2KtHDUK+A5x2nachpEw69wy7QXYLBwTSQquIn96WORrAauZre3t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dc6:cd85:bcd7 with SMTP
 id w13-20020a056902100d00b00dc6cd85bcd7mr572697ybt.3.1709319380436; Fri, 01
 Mar 2024 10:56:20 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:42 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 03/20] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 2622d4e5ff54..81879e68da96 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -62,9 +62,28 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
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
+               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
+    Smi(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

