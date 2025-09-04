Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C727279DDA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961258; cv=none; b=k0qmxO7sI6wsmth6tsNX6YJ+jWpOe8W25MSlq46mAqKjZIDrLsHwtauusIhDSjapwiS/KTjixH5BZ8cpc7VUrBMgUoH3T+kr+cmUsLAXT4QXnAFZqYxuJfeTP9HAWYkKA+NpnaeaDc5UuH3rPGSfov+dOzsUkLxC8MmZjOpIj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961258; c=relaxed/simple;
	bh=PhjYGNLvD4zEEZi7oDaQYcv2vT4Zw20WeOE4Vsw+JSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XRvXI2s4pn++u/rCV0lbxxNW9kQZUjEWwbHp+sZbQ72+OJ7dwU74sh/dj89iadg6kGMQdW1DZZ3eT7tWiiG++NCJrqb84c7eqCxWt+yLPqs508PxPAiJ5ybTR2Sgg4EkpvwL37qmrzoORNkSA9ML4DjyjnHsrfVyy3A4RO3uwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbfyk0J6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbfyk0J6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c949fc524so431680a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961256; x=1757566056; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Joaj1dmh69gNOIsDVm4DeSw8c1Ye9sxRKnnkqlDn7P0=;
        b=nbfyk0J6nUTGZ0D1WhoLB1gr4bgNhmbzMcscArQwIj70BFpNMxU7LaI7sQ98DE4Clh
         qXHp7f/R2sNixZmLImjwg+yDomBbBc+jd0iI2Y3BxvX7eWSXGYwXpT7z8+YvQnkEqozH
         J8yRIu7zE6WHY7GlOxZrxgD00w0RpxDRaPJGeIQNP/A+FfYSYonoSnwFVDKMLaA0PaoB
         oIus3QW977rvx9of8CKRklF6/Mud1EglAJo0hUPbtgeP4bokoZWnHI0N/TLyCyv7IKth
         zAcyQssYJ8NeaRhQMC51OA9jAdnFw6R62+hAYNB3VC0TgTDVtiFd2hb3w6kFXEI4CMXk
         Y0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961256; x=1757566056;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Joaj1dmh69gNOIsDVm4DeSw8c1Ye9sxRKnnkqlDn7P0=;
        b=sFVNbW1/yvLam+1tPAW8UvzweEWDxSzfuFi8SXrsliq33q6ZmrjHGAV9HqeqRtv1fd
         1kyf7G2dJUVkWB7F1INpXpzRSv3bBRx28D/swrNKem4XRXe/iQ34u/tC19CdGYsEdWzl
         ZfAFUBd+/hG1t09NCKi7Jeyow9ccO3wqape53GgV0MuYD55x0YdeiYZVtroQb6hb/9sk
         TqbSfC6Yu5JYRnrWvaT/iPD7X4ljby02M9eGL8kwh7orJhuNPweCS4ZraxWSBxLtJqEf
         TbVrwHMzJ2Vkg/N+tyKHkjBKdmm/PHhQ8F0avkjnXxJNnPE/J/IcH/DHl4unS5EOWnng
         4enQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDcaj1/CPVCH+Twq1yBuX7P9loCxLw38ecR4qVGE7sbDtWO7+pM3qCv1EznZpd+rdDxN9vIwB9PbOv/HNP5wty@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVT6eXo00XDnGoGDO2Oa61E4GImmT9whavSnu4aOdFMlBAvl5
	lNg8SIwtMSaZfe+E0HkeF9IkCoVkbw7aszICbJBcRR9BJ4SivZKt+dDTJSouoCHddkwKjV0ohUB
	ME4ApRoI9Ag==
X-Google-Smtp-Source: AGHT+IEmZNfiMVD/3xe+7QRYe6qAfgQJqHO95HuuH8Ysp/rSU+HfIpJ020Jwz/aG5S4Jr1v4s+nCsWJI2Mg/
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:31f:b2f:aeed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d603:b0:311:b413:f5e1
 with SMTP id 98e67ed59e1d1-328156e4731mr21339560a91.32.1756961255792; Wed, 03
 Sep 2025 21:47:35 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:51 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-21-irogers@google.com>
Subject: [PATCH v6 20/22] perf jevents: Add local/remote miss latency metrics
 for Intel
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 68 ++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index befaf0fcd961..47e8f1166870 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,8 +1,9 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
+from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
+                    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
+                    MetricRef, Select)
 import argparse
 import json
 import math
@@ -612,6 +613,66 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMissLat() -> Optional[MetricGroup]:
+  try:
+    ticks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    data_rd_loc_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.MISS_OPCODE")
+    data_rd_loc_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+                            "UNC_C_TOR_INSERTS.MISS_OPCODE")
+    data_rd_rem_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                            "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE")
+    data_rd_rem_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+                            "UNC_CHA_TOR_INSERTS.IA_MISS",
+                            "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+                            "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
+  except:
+    return None
+
+  if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
+      data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_OPCODE"):
+    data_rd = 0x182
+    for e in [data_rd_loc_occ, data_rd_loc_ins, data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += f"/filter_opc={hex(data_rd)}/"
+  elif data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS":
+    # Demand Data Read - Full cache-line read requests from core for
+    # lines to be cached in S or E, typically for data
+    demand_data_rd = 0x202
+    #  LLC Prefetch Data - Uncore will first look up the line in the
+    #  LLC; for a cache hit, the LRU will be updated, on a miss, the
+    #  DRd will be initiated
+    llc_prefetch_data = 0x25a
+    local_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                    f"filter_opc1={hex(llc_prefetch_data)},"
+                    "filter_loc,filter_nm,filter_not_nm/")
+    remote_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                     f"filter_opc1={hex(llc_prefetch_data)},"
+                     "filter_rem,filter_nm,filter_not_nm/")
+    for e in [data_rd_loc_occ, data_rd_loc_ins]:
+      e.name += local_filter
+    for e in [data_rd_rem_occ, data_rd_rem_ins]:
+      e.name += remote_filter
+  else:
+    assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
+
+  ticks_per_cha = ticks / source_count(data_rd_loc_ins)
+  loc_lat = interval_sec * 1e9 * data_rd_loc_occ / (ticks_per_cha * data_rd_loc_ins)
+  ticks_per_cha = ticks / source_count(data_rd_rem_ins)
+  rem_lat = interval_sec * 1e9 * data_rd_rem_occ / (ticks_per_cha * data_rd_rem_ins)
+  return MetricGroup("lpm_miss_lat", [
+      Metric("lpm_miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+             loc_lat, "ns"),
+      Metric("lpm_miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+             rem_lat, "ns"),
+  ])
+
+
 def IntelMlp() -> Optional[Metric]:
   try:
     l1d = Event("L1D_PEND_MISS.PENDING")
@@ -981,6 +1042,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMissLat(),
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
-- 
2.51.0.338.gd7d06c2dae-goog

