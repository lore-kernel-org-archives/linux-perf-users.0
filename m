Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE862E7659
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698075; cv=none; b=l3GmK335DVwAxKXKRKBmXVVb+HGkULLDBucEFXv2q6eqklEec0U3Uq7thQN4GgpgQ0kLpdNDRYeCY1vBBBh+kB/oMMtj1a3UeXJ5qXhiwZWAx9+S3ha9OsUR8jnKLp6LqbLxp2/TWCK5X2MYpYFSMmY+RI0Bm2Ucz+UURDhddRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698075; c=relaxed/simple;
	bh=Hv4UhU6NXENZa+Z1+6L4rRfnL/6waxqGPRgqBzUWSE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VUgQiFvOMbRGebUUT91n8pLXW48qMEEu4Yip3fEW+EYda9bMrMKvwvpdjo3HnPDKOqK4etVP/npaGs15BpM6ZfG1ixSavtNLvAxDhj0LpNnHMBwv59V2mq6xDwXwKaVvZwR/F5RVZUVG7W6CFThYb5ua8c7qwG3zgG6PVzKzq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaobBi28; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaobBi28"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso4533346b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698071; x=1765302871; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6uZvpU1CmHPVZiDBD5+c8ap8dhyWb5RPEdJMn1xJn8=;
        b=LaobBi288U0kEFwCWHvSgASAed02S19dJy0wL+kIvsoNwejy+7Nb7rrJYRvSlESBhT
         lA7HL7eCHPnBI/SEWXfVtxKsnvNNKNuAidvoBYBgnxcOkGaE0UnVYlNqGseIi6dCbD/D
         4iduR2VRTxNr7l4rdjmKvojZQWD4qaFUsS7h/bCQAkXIxTrTsfzBfqFFBAbBMC9/546o
         RTYrea4L/iC9arz5n04VxhvGLDhJhIMVI7Sc1QvSyD7gjDpg0WITwI7RJr26OYgOzrhU
         1KQqY8mepEtg0fC7bCrJOLexTNpirlpDu6lgqb30JuUteNso22GwTEh0M42Klu8s8e4k
         wGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698071; x=1765302871;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6uZvpU1CmHPVZiDBD5+c8ap8dhyWb5RPEdJMn1xJn8=;
        b=WoEtkhgLeIrAFM/lZ+FfIT/GabCiJJ5Coi3FUaBrbN2Xlqlck5FyuJ+L3DKrFUemXD
         wy/53QEy/1H6WSLP3pE4pKqvyIBRtNkd2ZzeVrHrIyb0BIXU0IusgK/8d4ACpclLscmU
         uO1g3FVSMcZScXnzbO+3m1aPVqQPMoJGjn600HXJe17jZ+UyCvNbYlQdcyJAjChsKhiw
         RQ9/GKvSW860Le+wmX6CxWqbzRHz4GIlKRSz08UosbBLUgG2iE/rCZLZHlhDMwDx28GQ
         jGUPPhdkq5cZWEP5ZabaaaXCPd290T2ar/GduIusWiKp6jz8EOLOKnCKGz/Q/9R4nKEf
         HJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVHfu1J//Y6/+f6sDp2PKoC+8EYfYW6jDdUzo33//z+TIgKechjQpyrqQGf3nZWm1CcWs6LJcrRm5OMyZMDN0k/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5x2TnRm+B4+e85W2YpNBm50if9CBdt26tYKd7h3qf8+npw/Va
	NBCF+XcV7rbTXtjj5O63wwDV1hDUsaydqR8t3XN7dbBLNiITuJ3kHezb5NsBxIHQ9q/Is1a2/Er
	xsBY/hCS4VA==
X-Google-Smtp-Source: AGHT+IEQS4yH/MnzCpTnSvSxrkfRl/QtAgjK7RdA6AiWk79tkC6mhXBKHY4vP+R4KKcoA6cLh4RkPsikxUlB
X-Received: from dycqv11.prod.google.com ([2002:a05:7300:df4b:b0:2a4:63df:76a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:660a:b0:11b:a73b:2327
 with SMTP id a92af1059eb24-11cbba52d48mr20931064c88.30.1764698071166; Tue, 02
 Dec 2025 09:54:31 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:38 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-44-irogers@google.com>
Subject: [PATCH v9 43/48] perf jevents: Add local/remote miss latency metrics
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

