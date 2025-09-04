Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3B245014
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960865; cv=none; b=Y2pOxBLCaMuHVYWLR+BV3K35M9DF7ePLBEDywhwQIktIDxoBx2XN6tckLHwR9lyLp6iqcWKQTMp/jNtsvt81lXRxTMXlCSMteVGN3gptrhAd7oCAlyFsEje+B+SKmn83Dy5jwK1Wa/UAOkePE5EHzs1BiyXdspkKJSRBohRRfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960865; c=relaxed/simple;
	bh=++6PoDm8spflnCLP/aUPRnaAUaPBCVJDVGXyyzAtzCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=F6u9dbhTbT8KiM8m4J/qAtDm5ayJARltuyaREcjTU9h7q1SPVUcSjb9yK99OpZuVo+y0JZYWfp7H8+YT+OYGDx7NAlL+tR9x+m4VG3Gqu82tV/bLLw93UCOrThPvXmP9QNGE7Mv83X1ukvYeLtQpxk0WIA3Z1zaqdqZDm23hHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbNWHlhD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbNWHlhD"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24cc4458e89so7396525ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960863; x=1757565663; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJ3ke+EJELLooyu+XGtr5r3EuzwgnJlnRcqHBncduFU=;
        b=BbNWHlhDsAgVeLhNGNfxO9/ULMUmhmXR6e9h5bZV11i/HNTmdjW+igjTXp3wsK+JtU
         4ohLNkQiGPPnqwZr6VqhGJClwP6c7BvPVgFxZMJ0nHfF0LR0ShDbpOKW9BftT2N6m2VO
         dbMr2E2rVHbxWjpfhnYxfwF4uzl9wsfIdPyg/1cLadCcf+nFhfPu35ufncNrsJgF66+O
         6gvSGmHEq60CzFlP313G9YVzGwyWxZKc4FKg3xs7dKH40G3n8UeI5Yd6tO/c8J6kYNha
         pUsFz5u7OEVjVgJ6zPn3e3lnwy5O+BWw5eTWl5mrMg4QSYuWtvwKZx5yuCrXTxpHMPwU
         cIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960863; x=1757565663;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ3ke+EJELLooyu+XGtr5r3EuzwgnJlnRcqHBncduFU=;
        b=M1DSGxtmyw8KO3UvALULBeCYJZMoMJoz8nXr19azmo+rm+sg+OBikQ29RkU6HCgQVw
         TqB/3nBhs1QqCtWk4qKMO7fE6LVNRXJOL3VJKiRS/1N6sspix1RZo31J3T11JLpfeBD9
         lJgjKbHo3y46/9gFSAZY4eXhQbav3HGWzi+rAp5ex6h5eLzrYEmR4FS3SgxGHPp5WNJ/
         +Io02uvn7VkyObthOt5je/QrSWkn+wlyZGPMCBxuZgLfORZMCDiejnfrtXwR5Wk/dFY5
         iMo7iMb/2HzqtNpnQFi1+YlZfmivWoH8/3K31sZbbagb6AjtOEzNTu0CKaPzjfadW03u
         yQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFIC8nZggfVu4ftVwkgE+wS6OkdsQJjBP3taVdwN8Z/h9EriYj3FE0RbTwF0f/yFTyqywlIhbXMBL72+78+vnA@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0V/G4LzmveU4EsPCVp8ODPs1IhbMSHiVw4PD38Pbpr4WYmb3
	j4mAlC2G1U2yPLCy3J2g6tC6y/OyJdHwmetkpvlruWll0R88kWSceVbD2SpDTVRgyoKi2/jzm/k
	0N/HBAhuIOw==
X-Google-Smtp-Source: AGHT+IHn5JLNxU9zXkBw6XYTu1AoKJRQJI6zG3FN30wxvzbJDsNGvywChLnecs0Hc3xq466bb4tb3lMy5McZ
X-Received: from plbcp6.prod.google.com ([2002:a17:902:e786:b0:24c:8f0c:bd97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f787:b0:24b:1f34:a64c
 with SMTP id d9443c01a7336-24b1f34a8famr86358165ad.10.1756960863024; Wed, 03
 Sep 2025 21:41:03 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:39 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-6-irogers@google.com>
Subject: [PATCH v6 05/13] perf jevents: Add software prefetch (swpf) metric
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
index 172f04b38d78..acbb4e962814 100755
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
2.51.0.338.gd7d06c2dae-goog

