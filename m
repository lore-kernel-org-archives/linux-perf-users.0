Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBAB4C63
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165752; cv=none; b=C0TvqPiUZpJqkTg7gTWYdvC6/QLRFhVR2Sm1jSE4JWYVlcV9f4p8NT+56VXu1JntyHwg76Q5bgJcelqT/n4LXQQey9+9XteZawvPtg/HqTA0ymH0oaq6t3wB7NbD8/qc/IIF2gzxegKcXsNp2PzqUvWsQYpNSDhu+K7N5kurHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165752; c=relaxed/simple;
	bh=yEm8gDDiOp2kaCb7bjt8yDfO5lzyLygQrwL/+bKOLd4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Tdj0xdsUtq0tqlrj6Yx8YPOmsy7aAjVYvJHfpfMMA/ds4SuiE4JAHT1caADXVxXbtS5GJKDLPkeoOoKqLJ9UA3cyrS8bm4vku3xnlOY4RsBzJXJC2dTe+xUaSahyX5jI6zd+4+5vJ5QXxtv4DKW+5wpuRCEXUJRewUIE+UuhZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sh7eK20/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sh7eK20/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so666147276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165750; x=1709770550; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7UsDzYt66DPsayZORzPPicQ8YRzeND3f/RE4XjTOWg=;
        b=Sh7eK20/wFBkujUG6QvGgVXr/rgoGkp1JkNvxePRmf5ZpfTVyLQ7O4g7KCYiuPpSfM
         x72SEs0osdODMzGjvoDa/USFldosOkBKy+tdXRQgDRcfOsxk+024K+73IepFNyU8tSkR
         a5DCxwhT+DJFhSkfg1FDZVHnvUI1xZGpLqT+mYgtvUaEFUEAIDSADXHj239fnlRM7nL/
         n6ULHi+M+LCO+RddZTk3I6Clgy3IxlmizIOmw2/OGhQbBArW/lWOyalv+zqBu7hXMsmE
         FSaiagDkDbAoRBI3DYQpbjQN1RS+rCNl/XvRxTGOuf59L0qUL63n+s22rh73vqw55HaB
         EnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165750; x=1709770550;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7UsDzYt66DPsayZORzPPicQ8YRzeND3f/RE4XjTOWg=;
        b=wQLdwTHhF6+qkVoJk0KKl3ZHpuF0HLgd10v5koVfJ6PwngHBCRopcTUqVfdSrTEp08
         bKx22lXh9xFwtteMxZlLjznQi9YzF3XlYcWeb3+t9GS6DlG5cgDIs41HzhaeZtKn2ncO
         +i2MXLQ17E8gqkgkTD55K2CSrMcfKKlkd1YnkQC9EeJTlWzEUWLDlJpS3wpR5NWtjyRx
         JjlRtMMlSOpe/b6/ElbfdWTu8OECxQBK7OuFEwhcyUEX0PFs2qgExo+Yk8VL5Nj1blGX
         pbEc4sMKGbLsVR9dWwzIfx+/o2JO0Yl+kfI0qFooMM+ircLfF03iKxU+87BMzrNUtL/n
         WDDg==
X-Forwarded-Encrypted: i=1; AJvYcCUFdf7YFd8/RnxNdlEnDoY63NhEiIZlaQckm+5PR4FqqQswd4bVInXyi/a+yoQSqziGMVxMxXvppAiksX8AFnuhjToqfhDDgkFS67droRiiAg==
X-Gm-Message-State: AOJu0Ywgf8s1blCyU8keay+bHHcq725dPmFW6qVb8cMFqTcPIopxcGZ4
	fRATx7MNnkiyYWWAy6NpAUKqAkgLLkAUSw44hWLOieAQbQwAxOsj+XB3ojsYbUq4uBisLwW0hPQ
	ewATnvw==
X-Google-Smtp-Source: AGHT+IFsQ2PuiVEIMIrM7xWD9G4EgM1d6FDQeQk3GgcRovivIO1txb0g8lABgyg3ATEKQ4f1jqgDHjLKQWsN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:723:b0:dc2:1f34:fac4 with SMTP id
 l3-20020a056902072300b00dc21f34fac4mr215253ybt.2.1709165749852; Wed, 28 Feb
 2024 16:15:49 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:27 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 03/13] perf jevents: Add upc metric for uops per cycle for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index fd3095cb5c1d..ce3d1535483a 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 import argparse
 import json
 import math
@@ -16,9 +16,17 @@ args = parser.parse_args()
 directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
 LoadEvents(directory)
 
-all_metrics = MetricGroup("",[])
-
+zen_model = int(args.model[6:])
 interval_sec = Event("duration_time")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+def AmdUpc() -> Metric:
+  ops = Event("ex_ret_ops", "ex_ret_cops")
+  upc = d_ratio(ops, smt_cycles)
+  return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
+                upc, "uops/cycle")
 
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
@@ -50,6 +58,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    AmdUpc(),
     Idle(),
     Rapl(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog

