Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A083624B1
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539542; cv=none; b=Tm+XshHKt0Us98CrCuOuTxTdqPV+vO3yr5J0WzlMGFbq6MdsjG0sHYwRX8qX3bcuF3AJs+DL5lijTIEv7suSl85EHjYeLX60mA2WBwOfGhJ6NO+JcZs/ABR1k7f0Y/TG72mzeai2tchgwIQvqvFEmBP3CrUBgW1cDQIei464hek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539542; c=relaxed/simple;
	bh=y7FaKz7L3UAtslgu2x3jUq5vT+1dSABmFKBuMuNMePw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oIqE+Cgyqrp2NFrSfDc1idOUAQ715sucafHF8Ti6iHWAO93TobFW90kWH+84HA9B1lBjSmu2sa2z0tKq6KQwo06CZLlE15Zna8jmJpvQCRNCIFgOwHBTkP5Vnt6EyrMXS2A25aRDuS5pl8wgZrRP+oEgH/6o6nTxufDg6nzBtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTktOvgc; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTktOvgc"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a5098029so2638909c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539540; x=1770144340; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JKS6gPP28FO6KPHugmrB/ENZliUhA7YoQoCZ5CSB0Q=;
        b=QTktOvgcenTrsFeGp/q69q2c9gXenOzDkJ3R8cxZxttQ8b3ICW1sbAfns6ut3HkXUe
         s0ZwgOd9Yg2iCmcgHd0HoCZlBxymVwQ7EU+FcTt423MgSK7+XDeiFEVN1QtGfi3iEURQ
         fhMtz2Jjwy9OWYjOtkI7QFYWiP02HVmlloD4qpGjXJlGxyk9aSxNdDXvCDZzBQeW2orp
         W4Mt8s1U3rP88O+m8Jm7IBVZSWSI8B7+iSjo16Wd+E4knrVHRFlnFeZAAuhI1KWk6IxK
         S2PVcGw4Swed1m0UquXJ2Q53FBVOPi2yVoNjJvy0AdwC0AmFh5s065rqoqnZTmgT34ya
         dbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539540; x=1770144340;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JKS6gPP28FO6KPHugmrB/ENZliUhA7YoQoCZ5CSB0Q=;
        b=XEj0eszhX6p4KgkL1hk97Ctzt0SjA9qgMoOnBp3B/wnzeC3yFNje3Xkjz0BMRplxIh
         a+Xe8PzXt1kieMxmhqP4NWkvTWUn0jyYU8B1rwOeCYNLngUam7uBMWdXPcYVwE6D2kz0
         xkjQrVs/ARwOxd1AfMAjWV2cc+w2ZGAhNcXt4JiWfjZf/ePONVINfGG8UrgStRc47iYv
         Go3HCcWZ860/jS4Lm+R9YYi5ScafLPanj4Y9wmMhChy0jIroWdLZ6P9tObpH8eyVqFm0
         pdmFPv1l3D0NrP/EQAbyrHX43aUisCDjPehFHumA+tNDmkehKd2bJW4mFubdvczc/WKs
         GIGg==
X-Forwarded-Encrypted: i=1; AJvYcCU5SpJOpu/Cu7/ynNmnT2UaPlnjQDviPahjNrh8I3vabZJDxWH/HyTw6Xq04/9AiuHWuYAFA3PIF+HMLJ9Brvkz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt34MXcbroRh8AvDIifDdh9l3pR28DB6esSWu+ELFPjNIF77Sq
	PzhVgc33RVkX+0J8288SCQsIJFb0Q4ilecx0vnpJpyoZJlJjBdsMzt8CiGGIqoNnEc4eFRUL9ko
	MUOV9j3e09A==
X-Received: from dldnz2.prod.google.com ([2002:a05:701a:ca02:b0:11d:fd49:7806])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4194:b0:124:9ae7:b2df
 with SMTP id a92af1059eb24-124a0129de1mr1290403c88.44.1769539539836; Tue, 27
 Jan 2026 10:45:39 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:38 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-8-irogers@google.com>
Subject: [PATCH v11 07/35] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 38948f63cb52..8fb0b55074a2 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -122,6 +122,54 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+    global _zen_model
+    l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+    l2m = Event("l2_itlb_misses")
+    l2r = l2h + l2m
+
+    itlb_l1_mg = None
+    l1m = l2r
+    if _zen_model <= 3:
+        l1r = Event("ic_fw32")
+        l1h = max(l1r - l1m, 0)
+        itlb_l1_mg = MetricGroup("lpm_itlb_l1", [
+            Metric("lpm_itlb_l1_hits",
+                   "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1h, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_miss",
+                   "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1m, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_reqs",
+                   "The number of 32B fetch windows transferred from IC pipe to DE "
+                   "instruction decoder per second.", d_ratio(
+                       l1r, interval_sec),
+                   "windows/sec"),
+        ])
+
+    return MetricGroup("lpm_itlb", [
+        MetricGroup("lpm_itlb_ov", [
+            Metric("lpm_itlb_ov_insn_bt_l1_miss",
+                   "Number of instructions between l1 misses", d_ratio(
+                       ins, l1m), "insns"),
+            Metric("lpm_itlb_ov_insn_bt_l2_miss",
+                   "Number of instructions between l2 misses", d_ratio(
+                       ins, l2m), "insns"),
+        ]),
+        itlb_l1_mg,
+        MetricGroup("lpm_itlb_l2", [
+            Metric("lpm_itlb_l2_hits",
+                   "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2h, l2r), "100%"),
+            Metric("lpm_itlb_l2_miss",
+                   "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2m, l2r), "100%"),
+            Metric("lpm_itlb_l2_reqs", "ITLB accesses per second.",
+                   d_ratio(l2r, interval_sec), "accesses/sec"),
+        ]),
+    ], description="Instruction TLB breakdown")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -188,6 +236,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdItlb(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.457.g6b5491de43-goog

