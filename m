Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3223D7E2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960861; cv=none; b=cNq7eLqdgRK0eRUjcUl/oA55Vgyzffa1IqiDTe0iMaKg6TEzlF9e3bOWjmVE/jsj2W38xirpTHvwvugpTu32LnboqKz2NMOOlBtYu93FrQjVLo9b77yUkhYD+LuvyQW4H/qVeQYODZL3scM5VBXOOqsM0qVOjja56MLxHR69xBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960861; c=relaxed/simple;
	bh=4pt9FIkHAZ5Xw3Q3jAERRLTnj/Qqp2bLN3zztKZ3NDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HhSkGFwCAjQ9OXDAHVFD/D5wrsg+rYIkI1hccIOW+y2s9HhY2tAhh44UT/KvbSlQXoCFhOdP/0nHos4L2NAs4NAuPeQt9AJcSB54pLphnbXRem+s50b6XzhBi6/EURD5DM71Oftu8nQ389mNBjISbvyh3ZCZ2/6oPXN/yUFSXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBxvYu5E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBxvYu5E"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-249118cb74cso7699745ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960860; x=1757565660; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqdl8vLdPtWOH3bXXSF+6lIx5IOBzCwED92UAgNuVi0=;
        b=BBxvYu5Eo6lITAzwy2NOFQVSjqqG7X1BYKH1ZHg2TX2E1s2/9oIdQHOsWz7+BZyZO1
         QxS6RyCS4ai9sowOsPb865oL6+MGipjI3Dg/D7NiLR/dptFmOM90mNOfnRuOzirpNg8l
         o2d0oAuKDE5spYyW1IQz5ndk8F3kHULBGnstnOLzuyieu9hb9ghl4TwmeBV0P5ZX9AFn
         OkKL9qHxywb2CARBK5K4fGTsuD3X1TDhB43oIhVmgMvaZN69gVVsmfxKw2QTm0HNQDvR
         U4VJc6KtUBkyRLGr5XPCz/ta245ZqWT+uVxc2+ZA2Yebu+asntaCgMeKERalk3wtQ7Vq
         tX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960860; x=1757565660;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqdl8vLdPtWOH3bXXSF+6lIx5IOBzCwED92UAgNuVi0=;
        b=UWoClsjLVAW1cnpXXpEwjvbcDqV10CGeJM3NBlmdya0bGunkvFW31MYUWdy+dKiOiB
         VeZp6tlI1/iokNCwwLMmKqBMQenCueC5C0hYtLJIdLAAK/o1joJJga9zgpoi1DdB/xrC
         ModntOLK4oU6REZQwN631nF9XLgOAJ7r348dQcDZokD/amfP1tLNF3xHDbqaff1RJVrs
         NnhwNBumXrqePPtVZWTDOj93bG4CPdl1tY4prQsPQFjuxtXmX61SasUT5wQ0hDh1/rQz
         m5560MyOqJVHbGYiuBVPNnGv82sumMLTjbx7IcV4ZWmUYdH3VHq+ybYLLZIU3ayqcNSj
         chFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7sFjq9AVRUd/MmC/lB2R7YLCoS8WlnPwHG58Lh8Qx7nvVAh/yQhyNSMXKwOkoO0Y8kV8VG8g5QOC0CsdDIdXh@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoHZB2Z6YtMQstBAsKAWMN4t9IS4j+78+BkO212HwixZ1CiD4
	6xyXjumG3aIajqcwodwjhyZnBclCVM+49uI8swwygWCQ6K0pvLfC5wSFWHS/IFAYFZtESXMFxNg
	XW6DczKQ0KQ==
X-Google-Smtp-Source: AGHT+IHmbbEQKIEE17+d6qgom3CpI4YxAaIwfg9AXhSe/jShxfEf8sr4p6TGGDoIk5OB/pcXTCrszOyHqAOL
X-Received: from pltg8.prod.google.com ([2002:a17:902:6b48:b0:240:1821:d2d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6f:b0:246:a56e:b155
 with SMTP id d9443c01a7336-249449038admr228484985ad.22.1756960859742; Wed, 03
 Sep 2025 21:40:59 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:37 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-4-irogers@google.com>
Subject: [PATCH v6 03/13] perf jevents: Add upc metric for uops per cycle for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 335e8a7e0537..f734f1127ff3 100755
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
+  return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
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
2.51.0.338.gd7d06c2dae-goog

