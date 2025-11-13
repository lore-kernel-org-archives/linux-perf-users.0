Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924C31D371
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004145; cv=none; b=OHBeqljlYpfgSLqLrtpDmY31GBSagUZTeq5DdCEGlL+2ezbA6V1jAPJktm+dysvOBKQev+pbnvMXjPDXE/9Rx/4wtxfYzmueZlnlfJdwQLyCE1PEH8hYGpsT8RQ7+yhLpu1QgtPzq8xOQXC2MImXYtoX3rgARSDFeLqfQHvzEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004145; c=relaxed/simple;
	bh=kR0Wpo93b/9yAlKTiVxb2htRYYMT4bJcY7/ZDrnuZ68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r64wz85/qr833zFzDyXhabnImkoPuO1Hm3tUFCRLEmvUi4bYGZ69sPkyIRIFdpxQpNHG7ZtD8fDp3HNd8t9TVUWoRQE1X/3S9Vfr1rYtrbY49yKevaEKgf5xDfkaXeHw+H4pI/aM+d1mLNp7sQ004zzqsSOROfzb4taIDEnoi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fe0zSLRR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fe0zSLRR"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297ddb3c707so3240055ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004143; x=1763608943; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cr2E/rZyypVk16f+Wt6vPqyku+fBwmlpS/IKRSeeaw4=;
        b=Fe0zSLRRFmZyH+N3pIEpDFddfvGLAql3BG6TbanDHFdSsYIc4tEtcAzVFX2hP+MuoP
         XPFtsgGGlOMXwAlopAt6J8Zym1hQpW5T8lWB1KG3Fh+n6/WODw8KGj/Uwmzjy5rs4x2v
         DGQDR01KzhguXXthdVchj6qB89SyQXXKcQrny9IoItAmE5lz/fqjE9utiFcGnUAShs2e
         gbi4NXhBu/f4XE5VaNqlflDyNnNR5KycC2vzhO36Q3LJWXLz8Q13jHzYayByak79D6r/
         +jvYgkOBP54tN06UWHyNDE4b2ctxJ53p70TgSRmgq7+i/VT7AELJwSofEEehfBCxTl/C
         7QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004143; x=1763608943;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr2E/rZyypVk16f+Wt6vPqyku+fBwmlpS/IKRSeeaw4=;
        b=O5x+rQtO1Enes7jH7bc92M4sb/HEUmch5LFa6w+890fBZivQ01TJIoAgbNDJzZWHzV
         52sehX4a2FElngwQb6JZ38g09AaZM67H5KHQIKKFaoqWarqoVJ6U/mDJtlodo3S/FKsl
         DAOJmGG8V2rzCSa07EBMKNP+RORK1xWb2r4Za/96JyXzs10baBXOTsADtoT55LpW/j21
         6Tmnu2LGofd626bTD0G4rw+iWZnbT9Qoshm1wfOBJWJtlpkEZKBmTD68+urNJmxucIwc
         mSDBfNxE5PLsx9Izm3wuDGi08YKp/KdX49MXVIGueSz4YKBQYs+jv+FZgUFC3RRi3v88
         mNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8tZ7Kl2t0i9iIiSfZkR90uU2oWj57B8Bnj6a6hf3zIf5XXiTA3mGFiyQe6cXGjwIF9wK+Em2nODTKj1OZGdJd@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsgHVPxgryYp22DNqZysO4dhYvrvgFAhfdHTmw5rdVEu3uZVP
	mWYvWHy5yeybgGu/aqIIhYunCZP2zoVUCl+SwqiaT1FQg/XibYjvh5baVSd86v2/IboVxXHOwCY
	QzmQR3UyHJg==
X-Google-Smtp-Source: AGHT+IE6eVlzja4UQ5/pkJgOkZTTiAGzuIai/Hfr0TKpmjMhTj2VL9yJ26YOe2smGEyiD4kOc55+w++vd0Xw
X-Received: from dybqm12.prod.google.com ([2002:a05:7301:670c:b0:2a4:5ebc:ca00])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120e:b0:298:485d:5571
 with SMTP id d9443c01a7336-2984edee8a0mr62542065ad.54.1763004143292; Wed, 12
 Nov 2025 19:22:23 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:35 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-48-irogers@google.com>
Subject: [PATCH v8 47/52] perf jevents: Add local/remote miss latency metrics
 for Intel
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 70 ++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 118fe0fc05a3..037f9b2ea1b6 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -6,9 +6,10 @@ import math
 import os
 import re
 from typing import Optional
-from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
+from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
+                    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
+                    MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -624,6 +625,68 @@ def IntelL2() -> Optional[MetricGroup]:
     ], description="L2 data cache analysis")
 
 
+def IntelMissLat() -> Optional[MetricGroup]:
+    try:
+        ticks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+        data_rd_loc_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL",
+                                "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                                "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+                                "UNC_C_TOR_OCCUPANCY.MISS_OPCODE")
+        data_rd_loc_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL",
+                                "UNC_CHA_TOR_INSERTS.IA_MISS",
+                                "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+                                "UNC_C_TOR_INSERTS.MISS_OPCODE")
+        data_rd_rem_occ = Event("UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE",
+                                "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+                                "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+                                "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE")
+        data_rd_rem_ins = Event("UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE",
+                                "UNC_CHA_TOR_INSERTS.IA_MISS",
+                                "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+                                "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
+    except:
+        return None
+
+    if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
+            data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_OPCODE"):
+        data_rd = 0x182
+        for e in [data_rd_loc_occ, data_rd_loc_ins, data_rd_rem_occ, data_rd_rem_ins]:
+            e.name += f"/filter_opc={hex(data_rd)}/"
+    elif data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS":
+        # Demand Data Read - Full cache-line read requests from core for
+        # lines to be cached in S or E, typically for data
+        demand_data_rd = 0x202
+        #  LLC Prefetch Data - Uncore will first look up the line in the
+        #  LLC; for a cache hit, the LRU will be updated, on a miss, the
+        #  DRd will be initiated
+        llc_prefetch_data = 0x25a
+        local_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                        f"filter_opc1={hex(llc_prefetch_data)},"
+                        "filter_loc,filter_nm,filter_not_nm/")
+        remote_filter = (f"/filter_opc0={hex(demand_data_rd)},"
+                         f"filter_opc1={hex(llc_prefetch_data)},"
+                         "filter_rem,filter_nm,filter_not_nm/")
+        for e in [data_rd_loc_occ, data_rd_loc_ins]:
+            e.name += local_filter
+        for e in [data_rd_rem_occ, data_rd_rem_ins]:
+            e.name += remote_filter
+    else:
+        assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
+
+    ticks_per_cha = ticks / source_count(data_rd_loc_ins)
+    loc_lat = interval_sec * 1e9 * data_rd_loc_occ / \
+        (ticks_per_cha * data_rd_loc_ins)
+    ticks_per_cha = ticks / source_count(data_rd_rem_ins)
+    rem_lat = interval_sec * 1e9 * data_rd_rem_occ / \
+        (ticks_per_cha * data_rd_rem_ins)
+    return MetricGroup("lpm_miss_lat", [
+        Metric("lpm_miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+               loc_lat, "ns"),
+        Metric("lpm_miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+               rem_lat, "ns"),
+    ])
+
+
 def IntelMlp() -> Optional[Metric]:
     try:
         l1d = Event("L1D_PEND_MISS.PENDING")
@@ -1005,6 +1068,7 @@ def main() -> None:
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
+        IntelMissLat(),
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

