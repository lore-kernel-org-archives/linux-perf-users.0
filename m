Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B714AA9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395934; cv=none; b=A6lsLuiPrxyKbseoBnwejpxHwQ9bRmurEfOvJuwdXOvZFHs0ZWIbEG80m/FwUIztP63bTI6kVdWZBARIPEEksVMfM/WsrZmjg9iGgdj+ZS7WUw4mLLZWunPvkCpX3+0p0DPKtKVfZER5LBkSH9DNIX/vRuHBQFZ7oVb/u+i3koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395934; c=relaxed/simple;
	bh=TmZjr1X7q9cH5lQWNtCsYCRCu/YSYQB8OaB2AWUPRcA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rVKyXR0GtxAC3CMHvQwbhM4NmAssDsGCNOfiSCUd9iwDG4MA56IvOMs8EctjDqJ0ulBP1b+XDNm69GXGsNV/h7aHhPhVGGkTmMTP1RhHYzCTa8P/1X9zJeC8gkSlZpPeH7oFvqMWa0v/gGV4qs/jRYG32DSF17nQpiun2FhNrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBhAJVK5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBhAJVK5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc39cb83so3431577b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395932; x=1711000732; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kqjdI3Mz70ShPxJH/La6sSgiKNcz9TbPXqY+nxcV2M=;
        b=EBhAJVK5PnGtR8OPR1NG+3ArmxY6TXNyhiof0bifQGnZB/KXLKCAO42cG+fioTT/R9
         BE1AFSnStU/jgBG6ZNGFjQfnifqukKY+3WV8k8IJuftGERZ+MGofiyJm7jsG9qihoLDj
         sWWmdGxYKucAjs9h4tvsr/SBpNhpUyPbDSE8Wy4tqIZpDiBIfl5Kk0GLJYecnLH/uaxH
         M7CNXFxrNt6GdKJpYKq5z6ogixSHWA/l3fSpvFIGrKetvb+DsImFlzFgHPK9YJQ8iGoO
         lsDvo/FUqGqtRHjj3gIJqh4ug1mEIVg5ICWgIRWvnPUcCkbny9eE/CIja3AwsAHFS8yD
         5JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395932; x=1711000732;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kqjdI3Mz70ShPxJH/La6sSgiKNcz9TbPXqY+nxcV2M=;
        b=FrB0zvkOta/Jekh15G6v3o8PPiy1zF9buxmVy4r6K9JLl7BXjDZGiKrO8kXBlxRSCf
         WVcr6F8/6Ncfro1crJ5dBzx96VkN0260IXKJju6ktCnjcfan+AOMizYzgWYYDCCAb3w7
         9ngD2lrou4twXAjiKlrOjodTMgQTKZxyJstPCs9x6mYuquW0bOhFHrspkP6fenuHo6eh
         O9TnVa3YQOta0E7rwgK0it22NTOk7Zi1JMeALlLChnt4prAI+0KoJs2rQnLBiBh7xKBU
         7im736Dic9u10mWrmqZZ99rGz/WOiyvitsUODe+TDH0ZT08koyaVgBawqhtGRwxoSV8R
         Lp1w==
X-Forwarded-Encrypted: i=1; AJvYcCXY+fwEq9+UC8Ld+P1IfgD1t9ChDNWvqpdIy49GxQEbAG8WfYpfnJFqLMZixdhkS1FF7Ia5FARcD6JCxnxgNIVwe5QgVDbMdAEo0SJb3JCk/g==
X-Gm-Message-State: AOJu0YwUCRdM3ZDmejzm3SMdyFgTI/9MXIeYiQlPa3TGO+xIWAm8rOUu
	FbJlGTphX2kcVaky0SVJyq9jnU0i04jPdJSHEvhhxiZjjUD0bPUPHLWH8r7D4URJ9OYwIdCYl0z
	+04SDCg==
X-Google-Smtp-Source: AGHT+IHnDGcpkrYyy1dIlgPlwKh6DeetOXeGIVDucIy4Xp2XHB5PqzZtCKmDu2XfMYM5K7xn9HL8uoH0G+Bp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr211969ybb.13.1710395932244; Wed, 13
 Mar 2024 22:58:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:30 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/12] perf jevents: Add upc metric for uops per cycle for AMD
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
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index e069b95d6470..c64470d4822e 100755
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
@@ -10,8 +10,17 @@ import os
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
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
@@ -45,6 +54,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
   global _args
+  global _zen_model
 
   def dir_path(path: str) -> str:
     """Validate path is a directory for argparse."""
@@ -65,7 +75,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
+  _zen_model = int(_args.model[6:])
+
   all_metrics = MetricGroup("", [
+      AmdUpc(),
       Idle(),
       Rapl(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog

