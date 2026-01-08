Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B1336ECE
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899549; cv=none; b=ath4TShND4D7CZDg8Ib4rtovjl+IXymZFDm61mgSZfprMSJNWXvisz112XwL4blaDeVTZlpf5ToqopRpmYzROFCMFWmcaPotVUueVtT+OufcAo/Z6KYEAAHz1K7KVCVqMfMZ0UNduMowtAkjozQpUGGV6zqRsLJlMq/arIdB4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899549; c=relaxed/simple;
	bh=w/E20u8/Wao9eymMi66Gt2Oyo3Q+Ckqd/d41pO69OCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DCMrAlFMxfxrqs8NgHul/NRHSVLP23gKfcVMDxauvsx7COL51oHhs6ew4Y8eO6NeGTlfXT87x70sBn6v47Yb64W+6h1enQ5KPWL0On2offEwztPvO1rQXhH7M7zQFLnO0+EG95oWS0z09HmqYOs40xDsk22GLbVga//KLvd36SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tastYZPf; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tastYZPf"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae32686ed0so271072eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899544; x=1768504344; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkrL8HvCBil8dXshWsOcY3GoMPnFAn1ScNAR1TTPj0A=;
        b=tastYZPfY054mJst4BWTL0ulzI4lN/7ax8hzDPJbtBv6QO9Y+CCUiVq8mJslZ8we7g
         /5GDHu7lN/IDWzCHuT95xNyqD+843ljZDOyncR8KZvOVHAxFuYEJLRFv7ZNIZWH7Vj//
         BaDOn0Poe/po3QyJA4SYsMbw1Gwzh8+HU6rm6/bu1MiRa1Au5bS/T1eiKOv+8ixDQytB
         ZaoAoCnvtNt2KVR9iqsGT5hm1sNzNR5JRn92+LJiQYX5vyM/ns8lbU0iZqLor2BjYWnJ
         9fK9MLx69bl/JQUbrESTYxmfDq/VJ8GiLfvGcdGcHZ6xS+ymhCXrL3bD2eLqkIThwKXd
         Efyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899544; x=1768504344;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkrL8HvCBil8dXshWsOcY3GoMPnFAn1ScNAR1TTPj0A=;
        b=CBrcsGUnGpf+hbjFbsO9MdxL67Ge7JJb0sNc9QSeQ3n8sdHShog0B3VmGDJHH5aJYy
         lVNMPJ5ScWad2i1sliM3f4ffwLJUdtsl1BbW19ikmGITQ+W/vLlZ5iay9T/HRrBRGmTP
         J4KZkLgOrRzEAwr8aBFPgE1lLZTxVmA/f/GIJHC4EUPpCR0JuXEEmnjZdCpQ+G17JKRT
         sYnnobotCJ7Rtf4+LjCI1UmM2gZ9m3aOPIW1Xjbp5+Yz7bUWigMC9SI2w4N+/resUtH3
         p2mfk6L5e9l63dUAcnflChKCzGknLTqxSGjXmAAQb7zRg/AGrsBtRdf48Nl3ab0b57hD
         o/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR8E6S+KwfnnbuqQWwRfxOvftTTbQu+Ke1rYkpSwgcxd0HKwvxdDHqNy+yJbvoZoy0ZFJSeIL3vEW1s2rC0Yvd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbs68PZaM0USluiNbU7mMfMKtZoH3pznoYx4Tv5HhKbWhoIfxX
	o2jw9i9zoiFZY6qtJdy0Seo3AEVsO8jbHM6VTMNvydZDJqxrD2v6Keo9pcWOY+zmT17Z9LeQC2C
	HclE/ZGLvIA==
X-Google-Smtp-Source: AGHT+IHegIoREH++X6aUzl23BbuBO+jS8yBxk/oknWyBIcHEcFfNG6Lhzrq0bId60XFzdVKmKUG0tg37zfxP
X-Received: from dybba30.prod.google.com ([2002:a05:7300:5b9e:b0:2b0:7818:6477])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6790:b0:2b0:59da:f798
 with SMTP id 5a478bee46e88-2b17d294b83mr7897975eec.21.1767899544207; Thu, 08
 Jan 2026 11:12:24 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:01 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-32-irogers@google.com>
Subject: [PATCH v10 31/35] perf jevents: Add local/remote miss latency metrics
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

