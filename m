Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB823B618
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960874; cv=none; b=mRO7Dl6p32S8WBWH2EfTIqfN2/PF7F4B4ik7WppAzlWXomC+kPMaKhQG1VKFq1fbl3GB0qhIWeDDujcv5xO212uUEBeS7AM03Q2LfyPi6njOGOezGKVrHcLKulM87NQiVPGinEEVCjtOOc+nX66r2SMngTPfUKo4R14lQNNrItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960874; c=relaxed/simple;
	bh=GlfVb0tTgh4Kr9oHNiyN6/t/Yw4eCXwoHo+nViTamAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nwUQtgzDKTdBQQLaXIa0+rlvP5pMU8LCDUcdUd0HEnEDTU9PcIqviFmYo013JH/vQ6u8puxRF5W939expftyrgXIhKd/WLt0m3M6rRjrDyHmJjHR5eLl8u+DD9DTdFpnVtp2HI5YZKoTAt6tf9N8H0yl1lEz/imI/hio7EILygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0wMh7hsz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0wMh7hsz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7f1so462286a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960872; x=1757565672; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMIqUXAIYl7DIRpfwY3oGkA6JiIqK6X6yjZi5j0w/YE=;
        b=0wMh7hszoZ7LLYXs7iE53mBGJZAly0zJiFM23x6meklCzXd1xjAQGZK50rkJL2qUhT
         /4EAfbLj2Ti1WV70FD8HHad1fGaYMwCMw0ZXMh96L59L/GNEc+gRNZ2fjtcpLoxfGk7/
         IdVbIFWeUvdy8S1tBNsvpLe8jX+TdY5sthozjVwUKmZyflZbKIYDrWWIGb1kEm5dUnMB
         Y56vUGOS18MifxqUucNnBT9HFWvaX9e9bsNM74gbmXErzyD3WVjzQFlLECo9tS8+q9if
         9Wvf9xRsL5zZyyTI5zCjBX+Ha8AgHJRAhjlmrDZJ1480V6PxcbpqmB2hzbK3AiMoQzTv
         77RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960872; x=1757565672;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMIqUXAIYl7DIRpfwY3oGkA6JiIqK6X6yjZi5j0w/YE=;
        b=TX7WxiarsmSnwcba+Vwqd6gs1Jd625pEjWPjh/ZnPCgqN++9REeHJnP1SmTipsgqLs
         p0P5WixzIx/TRT1hw05X98vNWQYqGV1pobfa+94cc4p4A/iejsREvqneWzrQ0ogpFNYh
         K9gf9rmEfP5VN0cgAetN/zPsmGpX0IUgNlQGsAS5tiQWCvV4DJRGpCJ2fVJlEba49nyR
         Y2m8omgdIMiYnEnqbJ8smgq+I2VS/l0n4CDb+djkIZ7s6OowhEWaD800livaOmsLVymN
         UnPYMcHvBvIBWgyx/4azh0Ay04evxivYyisCjviWj+Ys73Jca+TIIxVsH272qlZZjzgv
         2uNA==
X-Forwarded-Encrypted: i=1; AJvYcCVVc5mNihH9SASy9tZZbVLaKF2AtbDx1oETCbSNDzFrIFLcCGeFMrp2bsCuf8KvEKK4zVm25fUstCeUjCaceKC/@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXB24ZWQXB/OjGJca2q1folH6G2uijSUBfSqVVBvndguDqb+8
	csrdYYd3r/ADT/grAC455vff3kZcSyhtqSDWjGjea/XLqaEUUaqMNm3OWqLCPT+1is1vm6ucbvv
	yaAbmL2DJsQ==
X-Google-Smtp-Source: AGHT+IHpVMLeNU44c8dRYnQrOdxwEbcRATfiT0dGZDqawLHZq01w3H8wZqIRP/kFPiEg7jthpWZXYS0e6/ui
X-Received: from pjbli2.prod.google.com ([2002:a17:90b:48c2:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cb:b0:327:c9c1:4f2a
 with SMTP id 98e67ed59e1d1-328156cca13mr24155359a91.27.1756960872100; Wed, 03
 Sep 2025 21:41:12 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:44 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-11-irogers@google.com>
Subject: [PATCH v6 10/13] perf jevents: Add load store breakdown metrics ldst
 for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index a2d1b642b62e..20dcab5b856d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -275,6 +275,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("lpm_ldst", [
+      MetricGroup("lpm_ldst_total", [
+          Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("lpm_ldst_percent_insn", [
+          Metric("lpm_ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("lpm_ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "lpm_ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_insn_bt", [
+          Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -512,6 +586,7 @@ def main() -> None:
       AmdBr(),
       AmdDtlb(),
       AmdItlb(),
+      AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.51.0.338.gd7d06c2dae-goog

