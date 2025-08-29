Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A42234964
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438318; cv=none; b=ldNQ7QNP7iezhNbk9VRMTLDxOuq2H43vXWoSJ+7+7C/SBBHo+UyK6wBgqA5sMaXvI7UziR4RscxLqnTJ00g0971OnSQBmwy9O931lVCgYY3ZvSmPQ1My5n4/3BgreDFpgPVYrYP0VMj0/Q58ifcf+Nyq742g0LQwLTzIcdX3w6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438318; c=relaxed/simple;
	bh=NTEta9CDl4/pZtDUETmRfUb72kP1/XXoaXSchlZvbQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dst/wwW3r4fMzFPcV4pCYQJSpt1g9d50kSB9OVjpqVdioCceT39L8+B04zbPw7uwBaApTscth32KTMNeKag7GOfEp6R+YEIzeRgHPKoVkR7xh78EtA5remiWdCnWOqv8QLLQRigNxfY/qPYd2QuoB+JipucanjoM/n6OU7g4kQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5fLKlQB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5fLKlQB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so18015885ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438316; x=1757043116; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whnG4Rb09JN6lb0BqM80HVTDUfySh66UmBX7PaHYxzs=;
        b=i5fLKlQB4p0rYFg1nSOVjILIcKvvKcRj3n3u5jDhUWRD369I/Xgqew/x5BMtppBff4
         ivUJAsR9rU3Tzm2z45TP9xPRCXh3B3uy8vCM9oYf+QMPqGRCE2OxR0z4B8ZDxIfgmvvE
         hdi7hRjlf0WMLxH4q8PWmglyEtZdsTN3eJPt+gTngnBiYgq7BFQsm4MDKMz+DM7G5Cr+
         tkR/xVpNh9MJbWIR1RfzkjOYmKCSYA3kUC3ORbpsXJAgu53AvifM1X5e4kRJnG/wwoKs
         ek1TkbBgV6Ol+/R9GHb3y9qPz0+0OCQtfk4fwItkK/E6RYwevPgOMQq5XytfFt8uVnrJ
         6xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438316; x=1757043116;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whnG4Rb09JN6lb0BqM80HVTDUfySh66UmBX7PaHYxzs=;
        b=HwIFGv9kcrq/OlMjWgsENHti02Mpx12RNuhY5NslgQa3N7AJXIgd1eGs4m6DDo6Oqp
         eIyL4l1bhrfY/d98cCAPnMDZSNx7VUCMKiQ508UVDlyGnYYB5pxHlhtwgvLZKjvoX9Tp
         iDTmz3h2mjD8mCaXhVPAJkrsBgyjwbUkYROtKirh3gheAfVvL1z9D7fNIiZZUn9OLvz3
         oSHkL5cq0IRoWDwaQZONu7ZkmG2vTOyc4+ybXj5+WV4WtRbKluqDbEKdeD7prGKf5ZMW
         MZsUyF3Pvj+8fF2clharvpqL8FPKRWOPXwObWktSpQZtxTewlaHy9pdSh6L8vYoZc5Dp
         t1bw==
X-Forwarded-Encrypted: i=1; AJvYcCV4w8rbzapbMTGYE70mgLLbBXkFWA/0ZW+RKSCiqeZWRQ/YBv9qs/96tDoLkEpYIn5Yz2w5pHKOd4oA7GwdO0aN@vger.kernel.org
X-Gm-Message-State: AOJu0YzZo+URI6QRp0kXWyg84XtowKFKMDukaG0e8EpotXpSa94m8pH7
	K5gvOmu4FlB0A1ugQr0SX8v0b7Bsquo2Jv/fcxgxFLFK3t54KZvZIi/3MdWKcDj1W2hj0vQy3m8
	qQZnDq5K7Yg==
X-Google-Smtp-Source: AGHT+IGyx49fHN7mtpVJ7uspFCCYJHfCYKNwLcq0NjwswPYI3Vhst5S0Vo5cUomtJ/mSsBJpQwPVtZ3k6T23
X-Received: from plmd12.prod.google.com ([2002:a17:903:ecc:b0:248:c91f:34f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230f:b0:246:eb4d:80c8
 with SMTP id d9443c01a7336-246eb4d83d5mr212920015ad.34.1756438315990; Thu, 28
 Aug 2025 20:31:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:30 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-6-irogers@google.com>
Subject: [PATCH v5 05/13] perf jevents: Add software prefetch (swpf) metric
 group for AMD
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

Add metrics that give the utility of software prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 9171d23039cc..cc5dea81e5bc 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,101 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdSwpf() -> Optional[MetricGroup]:
+  """Returns a MetricGroup representing AMD software prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
+      return None
+
+  swp_ld = Event("ls_dispatch.ld_dispatch")
+  swp_t0 = Event("ls_pref_instr_disp.prefetch")
+  swp_w = Event("ls_pref_instr_disp.prefetch_w") # Missing on Zen1
+  swp_nt = Event("ls_pref_instr_disp.prefetch_nta")
+  swp_mab = Event("ls_inef_sw_pref.mab_mch_cnt")
+  swp_l2 = Event("ls_sw_pf_dc_fills.local_l2",
+                 "ls_sw_pf_dc_fills.lcl_l2",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2")
+  swp_lc = Event("ls_sw_pf_dc_fills.local_ccx",
+                 "ls_sw_pf_dc_fills.int_cache",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache")
+  swp_lm = Event("ls_sw_pf_dc_fills.dram_io_near",
+                 "ls_sw_pf_dc_fills.mem_io_local",
+                 "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram")
+  swp_rc = Event("ls_sw_pf_dc_fills.far_cache",
+                 "ls_sw_pf_dc_fills.ext_cache_remote",
+                 "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache")
+  swp_rm = Event("ls_sw_pf_dc_fills.dram_io_far",
+                 "ls_sw_pf_dc_fills.mem_io_remote",
+                 "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  # All the swpf that were satisfied beyond L1D are good.
+  all_pf = swp_t0 + swp_w + swp_nt
+  good_pf = swp_l2 + swp_lc + swp_lm + swp_rc + swp_rm
+  bad_pf = max(all_pf - good_pf, 0)
+
+  loc_pf = swp_l2 + swp_lc + swp_lm
+  rem_pf = swp_rc + swp_rm
+
+  req_pend = max(0, bad_pf - swp_mab)
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(swp_ld, all_pf)
+  r3 = d_ratio(swp_t0, interval_sec)
+  r4 = d_ratio(swp_w, interval_sec)
+  r5 = d_ratio(swp_nt, interval_sec)
+  overview = MetricGroup("lpm_swpf_overview", [
+      Metric("lpm_swpf_ov_insn_bt_swpf", "Insn between SWPF", r1, "insns"),
+      Metric("lpm_swpf_ov_loads_bt_swpf", "Loads between SWPF", r2, "loads"),
+      Metric("lpm_swpf_ov_rate_prefetch_t0_t1_t2", "Rate prefetch TO_T1_T2", r3,
+             "insns/sec"),
+      Metric("lpm_swpf_ov_rate_prefetch_w", "Rate prefetch W", r4, "insns/sec"),
+      Metric("lpm_swpf_ov_rate_preftech_nta", "Rate prefetch NTA", r5, "insns/sec"),
+  ])
+
+  r1 = d_ratio(swp_mab, all_pf)
+  r2 = d_ratio(req_pend, all_pf)
+  usefulness_bad = MetricGroup("lpm_swpf_usefulness_bad", [
+      Metric("lpm_swpf_use_bad_hit_l1", "Usefulness bad hit L1", r1, "100%"),
+      Metric("lpm_swpf_use_bad_req_pend", "Usefulness bad req pending", r2, "100%"),
+  ])
+
+  r1 = d_ratio(good_pf, all_pf)
+  usefulness_good = MetricGroup("lpm_swpf_usefulness_good", [
+      Metric("lpm_swpf_use_good_other_src", "Usefulness good other src", r1,
+             "100%"),
+  ])
+
+  usefulness = MetricGroup("lpm_swpf_usefulness", [
+      usefulness_bad,
+      usefulness_good,
+  ])
+
+  r1 = d_ratio(swp_l2, good_pf)
+  r2 = d_ratio(swp_lc, good_pf)
+  r3 = d_ratio(swp_lm, good_pf)
+  data_src_local = MetricGroup("lpm_swpf_data_src_local", [
+      Metric("lpm_swpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("lpm_swpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("lpm_swpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(swp_rc, good_pf)
+  r2 = d_ratio(swp_rm, good_pf)
+  data_src_remote = MetricGroup("lpm_swpf_data_src_remote", [
+      Metric("lpm_swpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("lpm_swpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("lpm_swpf_data_src", [data_src_local, data_src_remote])
+
+  return MetricGroup("lpm_swpf", [overview, usefulness, data_src],
+                     description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -183,6 +278,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdSwpf(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.318.gd7df087d1a-goog

