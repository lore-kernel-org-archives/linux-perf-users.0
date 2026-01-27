Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631073659E5
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539588; cv=none; b=tgr+GzAZY8+OX8/AKetYyt6qkPzjxPAFISbzun0ev29azOWaZZxRfwT6Z5dgigUWm0MCcb6G0fhTIRn6k9IZwkvBts5iRJICPzjqFEB6hc8TXpoFFdCbAdf/NWDr8E1XfKjwjMcrTSfmj2U/TAhK0nKzZXiRria5/4ri9nbpxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539588; c=relaxed/simple;
	bh=w/E20u8/Wao9eymMi66Gt2Oyo3Q+Ckqd/d41pO69OCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TaMmaDayupdUe+CqsAe5Ek76yObe6qUE9YjjOKQKg6QGzwonJr/xTZNhMzM4d/IXFzcTv0rMEvzjm3tdhrbfjoZ4f4gVhf5pcTSuo2TX6oHqE+3IvsuiVM211TO6T2MUD++pWLFYSPw5FvLNJvg4x8+9OSTGroZ7Lgv/fvYRpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSuMD/SH; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSuMD/SH"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12339eea50bso4659347c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539586; x=1770144386; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkrL8HvCBil8dXshWsOcY3GoMPnFAn1ScNAR1TTPj0A=;
        b=TSuMD/SHhCDH2Kl40+pzXUy9B/RqpQJptBTgtyxqYUv1CVlpdzVM92Q+79knv+1suT
         I2h+dBYt3G9PWVOvU+Laaf2Xpj/wOh9zi60sQQ7XduVDX9outLFbPQyFlFvibixtLiJA
         GlIDCZgV5/sC5f7calk/lh/UJUtWMgNX9o1Qh/yJkGQYsiKCJ0h4stOGohqh4uKhV4K9
         eYD9UE97YmZVvDjeBOaVqajfjSIhSlpd2u9ClJkmM6jeyX85Ua18RYLKosjMKzfhlFhw
         3CYfel/tnm52uR3W46CWzqXCRPpVBRUaBAZQBWH+v1Q+fHudNxEjypN8pY0FYx62exSl
         2yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539586; x=1770144386;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkrL8HvCBil8dXshWsOcY3GoMPnFAn1ScNAR1TTPj0A=;
        b=xUCiQ1ENCqQjPhoai5Ts6TNoeRgwn4FcC/vXthKGtx8BomRPS2tUTHsjWg08uITLAU
         /3Q9nLA4EA6jD6eJIBl5YgKZ3MGMVVS74brDkfZcFg9rGUUhkZ4D3S5HY3UQVZxetsB0
         mNhPwiZRO4kVunuWUDGmfsuyk33gG1xrJTwC8UVjsSkT8hMf/qAENRR7YWu3fjjXjZpZ
         JruwoO5UHRa6HS5hFnoBYlFKbveTLhuwWAdSOCIrxivjxdIXp7uzzCyKLG84yWc20PMo
         HXK3VzwU3/+LgsVPxHXPnjG8+WhaHyCZCuT+C0IiqUey3r/QOBdzIex31j9ITY/1tw3G
         1RZw==
X-Forwarded-Encrypted: i=1; AJvYcCWsOpoVGEv9gff6k79qBS/R3INYY9LnFwvLpz+LKgKrPh6+pV7nGehNbDFVH37SJCt3/Wg8Ashz/SaE2+CEoClB@vger.kernel.org
X-Gm-Message-State: AOJu0Yztepd/Oi+S0fSvlRYQa/x0HpKNZj8sCXF6H0ljIdrY6tkkOguP
	NKTIn4cl9NvYg1YV7shTSf/77cmWIXz/m3ka7Ol4rVAPEljbqKdvrqQ8D9ohPG8oLyERW29QmLF
	m8//gV13kJA==
X-Received: from dlbbz1.prod.google.com ([2002:a05:7022:2381:b0:11f:3484:4f15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:786:b0:11d:f440:b758
 with SMTP id a92af1059eb24-124a00f496dmr1951656c88.25.1769539585577; Tue, 27
 Jan 2026 10:46:25 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:02 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-32-irogers@google.com>
Subject: [PATCH v11 31/35] perf jevents: Add local/remote miss latency metrics
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

