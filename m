Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A02C327C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697977; cv=none; b=r7GNCrO10hDiRiKRuTyaNyvGu1jXxYQeeGrRD2Sph0uyJQ/NfgV/TEeQGiFHzmFhLobuCf0V1+FVUmV2DAy8JuFHHyIbt+7oFpJfV7YYBMwWSk5y0B177ZLflnZ6ODqre1H5p3TCoQl+/qWaBeqEBGWsnKdWZGTfHKak+mIyq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697977; c=relaxed/simple;
	bh=kTkOlBIJKFVpgDZYQVXbOsVlRCh+YA44NAPEapYMCdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tl08FxzhJqLNqj/wbDJCcNGUZL3pZnNJWhK7Gm0ZvDqSWx+/Lx5+kSChxOt5qVgkys6fae2LWxhELue7bw6urTKGb74nAG5qRhOt7BoBw/77ldmOpmXzIaoJbhKcURbXbhH5ZX72/OsGJvF2ecWP1f0L3YUrkyLZ9uU6xiUB9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zycqXALp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zycqXALp"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-298535ef0ccso63942955ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697975; x=1765302775; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS+Q5DB4gJiG0aFc7TcLfBzsroYZtgDDk57R7SBmbvE=;
        b=zycqXALpcuQ+haMc0F/rq7tiEXxmzzxJVj/2nN1cqlJkdySQJIhiaM2QYc1AAmP4wv
         /3oLbbabNcR5MRhMic4DPvMTiqrJY2ImS5hTg9FUh2wJ/lx6q/Vp/W/YepO6+mcygEEK
         F7b3Foh1PdKj5+uyUdpNhYqxL0uVTBdrA3FpoKpNmCEGf2TdAIAr5eNggxpIfqPJu7IM
         dKf5G5I2XxoN5rO767FXiwoL3dLiA4J+VHWAqcYz+lOzTEHKI4taziSuWfOcuB1OkSmB
         Stwsz2zRsLOFFzvewi2J41N2ztUItsc3AOsMcSBw9jZ7DD4UG/plj1QERPNcHLJ6UXRS
         MM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697975; x=1765302775;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS+Q5DB4gJiG0aFc7TcLfBzsroYZtgDDk57R7SBmbvE=;
        b=h07xx8Q32iEqZW+LlcG8sH7bZUGULimkS0FdmC71iybxJdRlvNYJmUM0T8XUbBpy1q
         OwvOkGf066LkX7LbE+A2ZEV7QhRE7xyU3lIETrp6jZ/W1kdKbpXPbZ1rXmkn9DgnWms6
         IzBu7P6Y3kT2dW/Kj/09PfId9cZq9arw7U1EHaSwCmUyO8AOd3Q75wwAQSK5zkgM2qW+
         biLfIjxURjllCTIsGVJh8M7amej1Yd30UuceuOiMvxaBz3fpoYgbR9kvk/0ugRrv8ENl
         5zNZSTSejuVXCd10IwUkLQvot4Xqe+qjTfQURW5G/p4cpbrdr5sAh77lBEHrG+T7ok6o
         hLXA==
X-Forwarded-Encrypted: i=1; AJvYcCUM9X3yB+A9tU7p+fGXJS9SWER+CwKz/UCpgiUVgeCRulXM75EVLqCB/Lvq6uxLzbEXfSo3Qh+a7hhp6atFM46V@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUihJRcfcpemqBtTuBeV+e6TJ27Ic5qXBmJwCwGs1RrsNUbxD
	2ntT1zCHh9ldhIqsusoK724XqbZsZnRZRMCY1SxPmIQj4pIIo7t4YMWyXyvZq5NPlo6SLtC7f6N
	KlkjLjtQpSg==
X-Google-Smtp-Source: AGHT+IEkHQDnLBjyBIwheHxosvhCSI7hPRmIVCaH15lVvbze6EciB3E3gboKpRgG+yWoAuWtIahfLrpODLo/
X-Received: from plme20.prod.google.com ([2002:a17:903:4914:b0:296:18d:ea19])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11cc:b0:295:223b:cdee
 with SMTP id d9443c01a7336-29baaf9a98dmr325125165ad.14.1764697974923; Tue, 02
 Dec 2025 09:52:54 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:17 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-23-irogers@google.com>
Subject: [PATCH v9 22/48] perf jevents: Add load store breakdown metrics ldst
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

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 6542c334a82b..1611d0e50d03 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -279,6 +279,80 @@ def AmdItlb():
     ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+    ldst_ld = Event("ls_dispatch.ld_dispatch")
+    ldst_st = Event("ls_dispatch.store_dispatch")
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
@@ -365,6 +439,7 @@ def main() -> None:
         AmdBr(),
         AmdDtlb(),
         AmdItlb(),
+        AmdLdSt(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.158.g65b55ccf14-goog

