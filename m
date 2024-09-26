Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED9188715
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373093; cv=none; b=CgO8MUxe+Y7NLcDkce/+v28OQgRROFX7l4uQ74RFOsTi8C3Y7+3rqrNEqj8E1W7Yv+eUjW46V0TrVOEjpwtfb6NdGMBw4ZlkxctNTy4quBbH8nx83kzCBAlXFOJiCGNImMmnBWNf9dy2/m15UZiaCvmF8dLIP9R9YmjBjBuUNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373093; c=relaxed/simple;
	bh=TdgIoX+mclD1RsEh5HHj7mCOS3p4nxQ6BgpvpW8TB9I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GM8rQRtS5vAkb7LknQAHUb7fN1X3F3sRK2zkggSnL6eJQujwfXgXzVF26H5YLfW2S9ZArf/azTaAYqikxHFsm1C0cHr8Eo6b5MMapW2AlTKH3jIwjUTni9y1K4A281FhAFKsBNGT4ujCUevN9fId+t0YGHfjmTVDDmKT9RFkAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XREX/0QU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XREX/0QU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cfc1c8e3so1555568276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373091; x=1727977891; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDmfeuhUs+w0zbEMP5oo/Bj4+2I/gcwl4PctOwi4l/A=;
        b=XREX/0QUL0YnXqXsgc7wPT1zbE3k3uijLVZdFEE37hepuueFqInj/aMoquEWLPAx34
         keNIababWi4S2oT1540MRWEGklHpiN1Hic2QCYnQw7MpAisnwXvZClGuYb/mtmcyyKU7
         AQ6eYnim8hSPv5/NH0tUMAdDs2u4T9YJB49riiniBJnbKLDLlNLfSHteM/PInN0Totzf
         oV0Mrpn6ENZdLyDFcuTFaiAnd3jNzSRQWUzzAT2UjnfUPAtORJhGFYtqlpXuH61vo8Fq
         sVMMcgM9NRanElwJLuYOg8lkPlcf196fwoqjStflYyBH7jTnrm/yc3etz6iKczIRGavL
         lH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373091; x=1727977891;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDmfeuhUs+w0zbEMP5oo/Bj4+2I/gcwl4PctOwi4l/A=;
        b=NjJpSFInMLgPWy10ONYKnwxuMntF8E1aYTxN1c+PiyGMP5r5KC7Bj4HAGK3Br/9sHR
         UeKTelCSYsLufDq6PSLTrQ+JdkiOdMClo2UdL6dXS45l9KNDP2a+Q35JmnGrfvBf+H3a
         lHUGr5w/f2A67UzFzwjk9YhxGuW9/xg2QQnpT4uwnnopXK48Mn830okFObhzeAyJEKVU
         elKOXrGk4FM/N+YxruVtXdjplMiBg05v3Izkc5HPvs6z0pIQjL3kbM1eI55bIruR13Rd
         OX3uJsarwekwlxC/9q+HvZBxwBVn3FOa3UXONCwrOYst8zbIXS2P1C7MIVPyPw+3qRFx
         wh3A==
X-Forwarded-Encrypted: i=1; AJvYcCWghpA2GifE7r42fGtPgMZgEb6rwCsBxXC9pMRwY4e0lQIu0oAhhb40+eLaVjM2LJWb1mLxcjwAjH2CwjiQGDLf@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6uCJgNC8fSBu/+4YQHGUyWA9E/UACQYMGp4maV16/cEpV8O6
	kka0dkgIhQJY5VTuvt8G8aDnUzgEnssbsZtRP5gCASBJXGqX1JpOUG3lTEBaweH6G7NzmA8fOGp
	+miMVMg==
X-Google-Smtp-Source: AGHT+IGhd78K6NN4cholK2I6CdkjRSk+Q909BDg89X5nK1wEb5KlYMvJqNUVMdFCozK7j5qlriLLjHt/x7z0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:dc88:0:b0:e25:caa3:9c2e with SMTP id
 3f1490d57ef6-e2604cc277cmr233276.11.1727373091215; Thu, 26 Sep 2024 10:51:31
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:33 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 20/22] perf jevents: Add local/remote miss latency metrics
 for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 68 ++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 5668128273b3..ec15653e2cb6 100755
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
@@ -593,6 +594,66 @@ def IntelL2() -> Optional[MetricGroup]:
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
+  return MetricGroup("miss_lat", [
+      Metric("miss_lat_loc", "Local to a socket miss latency in nanoseconds",
+             loc_lat, "ns"),
+      Metric("miss_lat_rem", "Remote to a socket miss latency in nanoseconds",
+             rem_lat, "ns"),
+  ])
+
+
 def IntelMlp() -> Optional[Metric]:
   try:
     l1d = Event("L1D_PEND_MISS.PENDING")
@@ -962,6 +1023,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMissLat(),
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
-- 
2.46.1.824.gd892dcdcdd-goog

