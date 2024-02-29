Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE15FEE8
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165952; cv=none; b=UW3VwOnMrQGHR3Z1f58Kl3IoPuY0/cxnvMZmRHjJdxo5PFPjnMFOrJkbdPDvuIn1e4vLWVk/Oo4PBEu9VZfidwr4qCj0n7AVoZSW6ui2xG7x9LxvrkusWcfdCsVKhJbyU0MOk+MGTJu+hELPm1qnixnJz1yurSzkte5iwdOHdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165952; c=relaxed/simple;
	bh=HvG8OnmJueim0ZQLofUBNhtsvwoXfQ3M1FY1SvPuynk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J7C+m/T4ca4ORdV1CwKi0+dcAxfybzZRSdcTLwvUjnkbcB8GYJOGEXE9eLRLPy7Qt6xUHtGb1iwFdYm0KN841NwmM4a2Wo+Zv8RNFqejVSjoRRrT/nLE9427snqOw6J98qToxUbJG3Zx14a0xu8Bn06ZcfliO3XPxnIngRnreD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3GFQFwW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3GFQFwW"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so491076276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165948; x=1709770748; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHwxTyOi6lmXZYsarPu6rddsGOcfVBFqWW+pqTf9FsI=;
        b=K3GFQFwWUFhHg/zkvGJJzIun8kqC3Nc0wqzXQcHcj2+t+4ZUiNutdvhw7JGy4cfvD3
         fbPU/21uS8E7WUPOR9npb+qU2HXzQm2BtfjM+6oSTlHzhPpRZDlcaCxQh0Xz/RAWLb6t
         LFmorF+AV9G9Gem6cmdRZx61ELb0oVAMrVbdKrR38ZPX+Bgrj2SysjrIbouZBnh/4Nir
         L6vQRaYhsbMkaFdkUqRxDwgJVMa1is6rm2HaTqtZ52wwUaI9r7CW7pDRb+0+6PZlHrUF
         4tdtdq4WgTLRn5NBfFEbanci4Ye8kngqbwwnoS4NH1qZi62VQVbI0rKeYEAb5cK6bFQ8
         aEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165948; x=1709770748;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHwxTyOi6lmXZYsarPu6rddsGOcfVBFqWW+pqTf9FsI=;
        b=p5GOGfq4h3REhu972mHh3Ob7zcEEGRwST6vdPduWvLUQhfHlXZ/X7C8DK/vN83CdQj
         p8PR3hZKdeJn3DcpGP+sBTzOn1hkBNJuErlucibeiWtbYgXGWdiTeUFT0KnC3LK2a46Q
         b81tWtbHBrLwlJeeZTU+OWnwVcqyVV8BMcDlEPaZGZsnq5pTmA10LB7n9PPm5d/C0k6Z
         JYe32gLuG6EWPMsAx0BT4KY7pkui3lexhKZYgxbIuvoER1iy5O7b/Jr/CmgOsXetX9Td
         5Ht8PGiGB0JMaYcUkRP9MHDjeyao5JeWAUYA0UxhVU63NWxPWVN9/BTnLCMp8mQArpK6
         jFVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUrutCjmdqHiQV33WGYCwmtkZLkUDYYIyovnL/IuzIldhQWmHFHjAN2mMBUjkNKYCUeSvPrY+1X4sOI+OTnHuyYYHJz8rMfojdsIQfd4vRVA==
X-Gm-Message-State: AOJu0Yw2bU7FkcCPWVxTeVzigsaY7FLgkjz2kVu9G5q1xMu7gPBQZk5n
	31NigNt5DzjMhH0KbLAWXk66qE0BaQjAc7hJuhZzzACYlWZSAtNVUnWcMM9USlJXMglA2/21Eym
	/PaiYrA==
X-Google-Smtp-Source: AGHT+IGA9u4F4RCaI4adGFIEbdpQrOjBAp1oseTxb1WUFsbrGJFI3nZyotig/Kf2Y8KNJ828vlGhi7YBkPkE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a5b:441:0:b0:dcc:79ab:e522 with SMTP id
 s1-20020a5b0441000000b00dcc79abe522mr42703ybp.11.1709165948642; Wed, 28 Feb
 2024 16:19:08 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:04 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 19/20] perf jevents: Add local/remote miss latency metrics
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Derive from CBOX/CHA occupancy and inserts the average latency as is
provided in Intel's uncore performance monitoring reference.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1b9f7cd3b789..cdeb58e17c5e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -617,6 +617,64 @@ def IntelL2() -> Optional[MetricGroup]:
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
+  loc_lat = interval_sec * 1e9 * data_rd_loc_occ / (ticks * data_rd_loc_ins)
+  rem_lat = interval_sec * 1e9 * data_rd_rem_occ / (ticks * data_rd_rem_ins)
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
@@ -960,6 +1018,7 @@ all_metrics = MetricGroup("", [
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
+    IntelMissLat(),
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog

