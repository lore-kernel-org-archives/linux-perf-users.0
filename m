Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DB30DD1D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004096; cv=none; b=FMy9bm+qx042ldsGtP7VPl881NXDqt6F/YOw9cTrB/w3jUSdXVXbuGP/vd55IuKgot/VGhCvgCcYHSRtHApCGf2GjwgkqSuroQyQY9vCcONDgFiYqTNiEc2ucQ89h0LuDQ2YVS5vUKtlLO2206GYpL038HC+9OSM1Jjb+Pi6yD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004096; c=relaxed/simple;
	bh=vVf1zggOS+cbysH1e1f3vAJed1lJ5J4Qc02uFoFTyaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=naFfkkFMEYtU1FjBuiouuW2fXKJbxwvdfrlCSQZzVFWr62eSxLStBWqqcHIRpRjFpaCFYDBDk/vrqF9s9XHl3uXD64jKQxyDGuG0opcKLhoeus2MxFPxrqSye4RWcHlN89ZiDsakfSXYpb4gQFBwD0UlSbbKN9eenY9dsvdNJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klDcIh/5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klDcIh/5"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce25bea3eso359882a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004094; x=1763608894; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEEB3yyqtAo5Qxm1rwxLoJUAtOyPomalYOsJIghAkIk=;
        b=klDcIh/5XAp7nsttFkXwQbM6lPm7xKQ/i8SBhsRSMfFLQ4sSrTys/sjSxy56syT8lv
         EcN1+j2TJo9eZV8FCRHFLDEdL4TG/EGQNpmhSOvtNaLrom3C/7AcdsmwLTCanFWT6GXd
         F+WfREshj1BoxmWuZu6ldxscp+JNSgcf1UyTnsP2Vrj1HvBjEKJ6mT6MfrWk8Qu2c+5K
         fq0vEScQwoO7aziGZa8n4CT4al31Xxrqx/ZIbcOQVdTLEhv2XwLao5S4uMz/sfFlVB/f
         TpkJGpuaREwVrm+61ZsNyBJysBjER2Msdr/HEsK3MtLLsuqGPn4LaJYM7cTRSdCLtkBz
         mpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004094; x=1763608894;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEEB3yyqtAo5Qxm1rwxLoJUAtOyPomalYOsJIghAkIk=;
        b=QuklMn7gAWkmFYT3tmvN1fQvkjD5PTZHa2D2hHNSDvb0tQFaO4+ALOeMGsaBEiNKSa
         VJviJn6y7Azz05BLFysoL9ZYQlrzUvDRvWz6gauJvGGVoL982x3b+lD4zRYjTPVYeEJp
         sfi68vn+wSXoAF1m+rkqHL+G6asq1sx+ODz2XDEE0taZXwzV3UZ8RH9xqqKS5/QosCFw
         2+L1zu1MgBBjK0pdE7/Cvlz4ZLY3hOHdJVIV89kb0S1MUrUZ5XBDlpzH+FgxdWCEAMQ5
         nEPoE7xuPRPf2eLtAtWmmuKJTWeNcOLmaiO9x0D+GbjyCMlVTEvtnvJqU9OBJ+wkC/uq
         hWtg==
X-Forwarded-Encrypted: i=1; AJvYcCXXuP1IZYOUytHiqXOVGMwMzYZBwxRAUsRatCUkRI2UD47+vAdR1RWdegGIOBQbRLFe6wPV7LUPzI/12zLuZOV0@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsQOIXNMgEsKO0fjSPiRNqoVN14viAs0dxsjS6/uVxSq+XVEd
	GuVKESCsKYTjshS1dhkM6ne5b5ZnwjpaEX0yGg3dTr/FJh85F0mlqdARQ+vsbpAGn1aBMNNOhwv
	Wi9zvXefaBw==
X-Google-Smtp-Source: AGHT+IGUz3F16Agc4RAbW/D2wPHIL7padu48afgt8r6+R526ENldbnLOQuTELkamEGtmJn58t9Ko7urqGG4Z
X-Received: from dlbbk16.prod.google.com ([2002:a05:7022:4290:b0:11b:13:9d43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:295:32ea:4cf6
 with SMTP id d9443c01a7336-2984ed27f0emr67149315ad.5.1763004094319; Wed, 12
 Nov 2025 19:21:34 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:09 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-22-irogers@google.com>
Subject: [PATCH v8 21/52] perf jevents: Add itlb metric group for AMD
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
---
 tools/perf/pmu-events/amd_metrics.py | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index be27a4947e45..60f4ecedae6c 100755
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
 def AmdHwpf():
     """Returns a MetricGroup representing AMD hardware prefetch metrics."""
     global _zen_model
@@ -350,6 +398,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdItlb(),
         AmdHwpf(),
         AmdSwpf(),
         AmdUpc(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

