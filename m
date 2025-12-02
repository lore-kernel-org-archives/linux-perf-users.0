Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191552D8791
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697959; cv=none; b=UQPpGLagEqMkiX9AjM7GI0amb6ItiXj05GSFUNjxZWsiPPn48WZ7OEJSJ4wyFxOjl9yDlaXXRUAwFQSnkXalPSMk6YZvrL259a7TOqPXJPlN4aAcsThPbSqM4rLyXHuLc9qGKWYH6wKc7ngt+BGiyVFlWrCSnRfuBhHExevERFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697959; c=relaxed/simple;
	bh=ze5jnZtbkhH6OYlHfCLGTcVj7KNVPDJCGJWmpSE1Bpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Px1sRNuy+n9WBBYSyysQjr99CkMeZOL2srmUJOnHGYVkXmcZwms5iRIbq4oIfEIDdmHKyk+WeVYe34NS35fiMCAZgCImIAlvKy9xuSHBXYAFu192HvNOWTS5YIJGNAvKQTVRm+XPsp1y+wXdqvqR8XAKfJ+Xmc3/2BdpjeGkZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yo7ANp0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yo7ANp0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-be8c77ecc63so4803882a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697957; x=1765302757; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/hbUPmZ5FMVdDEJCamHYgfhVXRys0g5jFfadrw1lr4=;
        b=0yo7ANp0l+Q2setXtOiYtVRQZOi76qa5uoStrxJgT6ilsmSOstEvE22MhMSvZq9KoP
         BXSQwJuSZeWUg/XscluLHmocwltx9g1SFTb1KpSASwdHo9eyXBZmkgVAudmXdCHyFlRJ
         6J0vTogIMLxeGLfKKeTEntTAspeuAqfTXQlx0ldlPgKxXc6dSBcfKsfnuzk0lCXzbIcL
         AxKosjwM6GoLOHs7Zqse45/atnSv01B5FY2lWP408dl49HiLg3otaPbyz8rcM5MNfCer
         xe4xlfdZ2I48bEquUibGG/PaYnWFmy0mpUXWDaMmOZqubZ6AceP8WdC72HhtoS3aIjq6
         y/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697957; x=1765302757;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/hbUPmZ5FMVdDEJCamHYgfhVXRys0g5jFfadrw1lr4=;
        b=e2huCe/S3+YNF5nAma+MVItMjJ+N4Wv6Gs7U3tYg83hpzSbymMSmi4Ro5naqV3Vl7G
         pDL5xRmZObAW+gS8hfzsSTmFv9wMUkFefTSCUelinE3HZo/Olv+DF8/dED58bpGLyr29
         WDYseQp/wJ+5ZrljYDQuKP3+z2OSUAf3zLG7lM+4xtY1a50gMR68/0e39vLOR4CL1Zty
         7On98jRJdFLHwtmw5HYU+5TmjE/ucPprgF0Robf+fiURjBET/yEgXRwF3R/S/TrbgYQc
         /qAdHE/e3r1llIGZGf8JXAsX+yi42/332xaEfCWtWUQEkAYoZR3O5x/fx2U5BabgmT39
         S96Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDmX1AwNMgT/nm0gJQVeSm1QHQgyVfTUTwMx943UMo7uxcY4ktvDkrqeE9ZlOSrKhC+F+pSwV86ppN9cW0hQbc@vger.kernel.org
X-Gm-Message-State: AOJu0YybGBltGREwN8e8myS3lueEQpsuAI0++pK/23K1XxuFywVdNTfm
	T8wRgTD9YWLx3UMKeuSWAK31UK6QtD2tQbTuXIarmB9RseR82zNuNbDXMGF+2JKZWWIaQYmMIGf
	IsNX0hPtcUw==
X-Google-Smtp-Source: AGHT+IGYHX32N/rzSedA1c1sGGe18VImlT/w0RF+zEf1P2hVbs71K4/9EBvzKUkI3Z91j+ZCRTwk94n80u5F
X-Received: from dycro14.prod.google.com ([2002:a05:693c:2b0e:b0:2a2:454c:f92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1c:b0:2a4:3593:c7c1
 with SMTP id 5a478bee46e88-2ab8fa78c34mr177619eec.1.1764697957460; Tue, 02
 Dec 2025 09:52:37 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:14 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-20-irogers@google.com>
Subject: [PATCH v9 19/48] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1880ccf9c6fc..7a418990a767 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,54 @@ def AmdBr():
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
@@ -187,6 +235,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdItlb(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.158.g65b55ccf14-goog

