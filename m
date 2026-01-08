Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962B32BF2E
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899510; cv=none; b=tX8tkPMS8YKKkQTNXlIOtFfsgxMOTv0XgEvP9MWPCzBoVY27vAnYMpOamPxxlF5MIFIg9O5bvQWNX3ZRFy1uRTH0zdTUXwu1B3zCwdXQ3bXKRDD0NEA1eObeG7RjdLLx97YauzjqvQwhBjYWq77t3EI+DAZedntTHtW+s8jAr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899510; c=relaxed/simple;
	bh=cIu6eR1sR5Z5vTDJWp5UW5V0wvKX6WEDplqiXQUSFGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E+Qg6UIpYcxpHHFSj/iMd2oUgunH2oPb9nNdXqkPWvA5w9A9zr2BTlRoYPf9RezBi4zTfrBssxwVPye3I5MMg8cV91GIVbc5g0m3jUNOssE5kDCUreW27k4hPTOnSkzsZgAmexyFFQC9ZzonbitViUBIP/PLW9XrTy0bYCtRwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/nBym/p; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/nBym/p"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso4131990c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899505; x=1768504305; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79FcYdK/0zuRLjptxWds6JuhoHGCloD1d2+DIKaDNX0=;
        b=t/nBym/pUC2u9hJmKGEcBvvtLlvwdjjhSFCfPrkahHN2tbbSR0OoRcDGyOkD9ziorA
         yW2bvqa6anjVEanANosJZ9hMK7MKo280sZZDQFGDo3a8uS6T6s0HtoLcfWuqshNxB7V9
         2X5UV18esEb5hCw7mSun2YmXUqcvTrStsnMVF97RStgClw3k1b1Il2FmBewg7uI4KOM0
         LN1N8KO1s8C258FQSqnatRFirwonJqbhhHKtUNCmhGSwzffJh8MQBPrvLeMl3aW2RnQ3
         SUcqxIMGjamzenvSCj40pK0SkMyUUTKyqynwjJ73Ymb6X8JGybLKjBzTa8O8jiHoa2Ts
         Icdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899505; x=1768504305;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79FcYdK/0zuRLjptxWds6JuhoHGCloD1d2+DIKaDNX0=;
        b=nHfHMAwv7TkdFgQS76Q1K1cIkSPW4knJNLvouLPpm48ceA2dyXMuIhlSwbpalzVAK3
         kpyR8v2gV/7DVyFdej7d2MPNLX+MTLXjKUn22pVcXPuw+Xl4+riZBgYD5zRr8ZSEoxnN
         /MrKdGJQGP+o6DjUezXPT7RNudyvVSJvAIUCeKs0iUv33YOmXi+JmZ3abvQLlVMJ9QgN
         uSvior14gfFnfNuTzK/yMmY68lY8xwTlnUdAA4aQuV53Ptiaop1wzJzRyOge6zUyYFnb
         qbrYs1zW8ZCHpNr2QMAgPPlMdNLzfuQOxjx+34FrLITo15J//mWZxcZjYKm3Y2oa2BK1
         qCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd3OKtfMDMxs8rwKg6Nhza1Gi/gpO1jOYWvNkVf+6xWhaNYS84W9wGDftQLEiKWbWsFOE34nqOx9Ulv0sae62V@vger.kernel.org
X-Gm-Message-State: AOJu0YymNIGsGxIpctOzEl/6AV9fz+vekw6ikDI7cYr8XbRJruz6w3D0
	3sQXiP+vrDRQkOEwbGIA2wpZdDfky7OaAtCavCZy8vhH7BBzYUqGnWGXJKj/+/omH/R6n85DIyj
	heUlaaXms/A==
X-Google-Smtp-Source: AGHT+IE6VKLLaGUFz82YP64T0QE0Qf/kXni+8DbStAK7aoMAja1rMhXb+FIhl81QCTLejTQNfQwPA1yTli+E
X-Received: from dlnn11.prod.google.com ([2002:a05:7022:618b:b0:11a:36df:95a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:326:b0:119:e56c:18a6
 with SMTP id a92af1059eb24-121f8b1433dmr5623224c88.14.1767899504718; Thu, 08
 Jan 2026 11:11:44 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:40 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-11-irogers@google.com>
Subject: [PATCH v10 10/35] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index d71997177239..b3de74babe40 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -280,6 +280,80 @@ def AmdItlb():
     ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+    ldst_ld = Event("ls_dispatch.pure_ld", "ls_dispatch.ld_dispatch")
+    ldst_st = Event("ls_dispatch.pure_st", "ls_dispatch.store_dispatch")
+    ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+    ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+    ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+    ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+    ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+    ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+    ldst_cyc = Event("ls_not_halted_cyc")
+
+    ld_rate = d_ratio(ldst_ld, interval_sec)
+    st_rate = d_ratio(ldst_st, interval_sec)
+
+    ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+    ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+    ld_v3 = ldst_ldc3
+
+    st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+    st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+    st_v3 = ldst_stc3
+
+    return MetricGroup("lpm_ldst", [
+        MetricGroup("lpm_ldst_total", [
+            Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                   ld_rate, "insns/sec"),
+            Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                   st_rate, "insns/sec"),
+        ]),
+        MetricGroup("lpm_ldst_percent_insn", [
+            Metric("lpm_ldst_percent_insn_ld",
+                   "Load instructions as a percentage of all instructions.",
+                   d_ratio(ldst_ld, ins), "100%"),
+            Metric("lpm_ldst_percent_insn_st",
+                   "Store instructions as a percentage of all instructions.",
+                   d_ratio(ldst_st, ins), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_1",
+                "Load instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_2",
+                "Load instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_3",
+                "Load instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_1",
+                "Store instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_2",
+                "Store instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_3",
+                "Store instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_insn_bt", [
+            Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                   d_ratio(ins, ldst_ld), "insns"),
+            Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                   d_ratio(ins, ldst_st), "insns"),
+        ])
+    ], description="Breakdown of load/store instructions")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -366,6 +440,7 @@ def main() -> None:
         AmdBr(),
         AmdDtlb(),
         AmdItlb(),
+        AmdLdSt(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.457.g6b5491de43-goog

