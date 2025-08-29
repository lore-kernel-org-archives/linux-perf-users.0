Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878723ABAF
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440702; cv=none; b=GuIYmCYTX9jKpL9pJKSJ21p5RSEu4M2YcPoPhW4788klaspbbmDRwFjqDlLPjAOxvxDsjKNOGxXPQ+d5xfL+BRYvGXyMcaHL40vQhoo3h1bBfHJ93O1F9+/1FOr7yRyJ9Cv9y9F0TQ3GXcTKvEwCdARP7fejj8IO86n13BvUIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440702; c=relaxed/simple;
	bh=G/t4i0AD/wXY46jSWn8fPOGWm9EJPElV8fdpB14Hqqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Nk0SQGZD7OMqunJVJc0EWDWsWqOagLWw2ICTJMhvx1cnv2+AcciQj0/s4zw9GyKS0Mh15w35RW7Ji+RUY7vLBrQAL3+SZa1bKCfB+lh5X3qE7Qu9JQfZOBnIouiJPHiFBoBZF0VEmdUyd+olRL+IwlCslHyr48x+nnwWzPiBkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdOXeAuF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdOXeAuF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246364842e7so34409465ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440700; x=1757045500; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHLltxQv707jyq7uE7p0UrQqauyWghAPg6sL6mEpwW0=;
        b=KdOXeAuFbZeWMjQ0BC8c423t66frHN8IWkEAdcZsnYyqRjR/Q7/vKbARJ+zRbp5Zkj
         enBNGFhqQB517XPHfbY/130sI1qwlJ+aVy+mLGsVpkhOEdUWkNxU93pOyMR4d6hoSsUO
         SrjSHqT3A221u84MXdDqVMkmVGrg35NsNZNR3ti0O3Htd3aekCPOZK3m1hfVeimHDsHM
         GY3CWBAQVTDv0b2jaqTzDqNmaVAdG02pBWsy8QoEAR4txa3CHOpE6AeRwx9QKDUCZkC5
         FptP16bgfEYSgZ/pUH6FWD3xMjO+gZwi6I/bEYnsSpEUP0Q8tCzgnDoVwHA4O3pWKyFI
         PUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440700; x=1757045500;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHLltxQv707jyq7uE7p0UrQqauyWghAPg6sL6mEpwW0=;
        b=LE+DTZO83qse6u2AQ6FL2rCGoxwoJ299Bf3pGyFzCmOdG6i/3doZ6iu3yfe7cGs/1d
         V0wM31ey8n7+XEuysID0mI5tXCEZr61UK14dccMAFleyRLHEBvkGCsrbrbDehb015pWa
         B2bOBk1Q4iiKAOTF+w8JbRJ8W+9fD6vtTXn2s4oL60GfRsX5u22VjIpqKcAPAs0+LneP
         G76KU+qvOUs5U/DEkjAvtE+fdWlF+ferMVZcokPVAlDk6T6DJT+RQwxBQ5paSdxLz6Y5
         To17/TTzQ4+wp9LRQTFzS3HdjOklpDEGeWtOJzNXcWSO38eW+bGjlgjQhU7Q+awehnFJ
         cEwA==
X-Forwarded-Encrypted: i=1; AJvYcCVFRR3+Fl6JOvOSCyeF95aJ5GofdFQ9fPm5JYUc/mMXbDfUTlMgI6YhCVUqGF3yK4A2axQTAWV1MFUFSGRo8cR8@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0QuIx7PR1Qg65r8PuifG9MuueY87YX9GTH8m7RjMmpTg5hxe
	8ZYRgYtcjrVSIe9HLrCUqndL0kTIzfI3kMP3YagvNbPaGjU57h3TjAODkFvj8L/C1swet0mDJsd
	AvCrJSDRb2w==
X-Google-Smtp-Source: AGHT+IFfpTgVoPoMxVch6at38Y2vDYbk+oRvzq0Cy165fE8ad3D5ZjTVH0tIcualVhI+K4bYl/JUesxhYn9O
X-Received: from pju9.prod.google.com ([2002:a17:90a:d49:b0:327:b1f8:7689])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:249:147:95bb
 with SMTP id d9443c01a7336-24901479934mr26325865ad.13.1756440700494; Thu, 28
 Aug 2025 21:11:40 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:47 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-7-irogers@google.com>
Subject: [PATCH v5 06/22] perf jevents: Add tsx metric group for Intel models
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

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1e4790717cec..a353e682df96 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -75,6 +76,54 @@ def Smi() -> MetricGroup:
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
 
@@ -101,6 +150,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.51.0.318.gd7df087d1a-goog

