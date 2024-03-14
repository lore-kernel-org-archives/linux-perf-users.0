Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1314AA9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395938; cv=none; b=oKe8AOx9A9rUWUadjgPc+OESlSRBKCvBlXPqVMBGSkfMDl05zhFy3eXRbdGb+Y7k0JMRcPCqNafhoUBYwwtHldvFyPAFQtOvlD4wEkSJC7RoSj3t0fHqEoeQmwRjOOEzWEBHXPpUTtJIPHV8UGX5nPIePGwsJFjUbpE8Q+DiToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395938; c=relaxed/simple;
	bh=TvRZPjew8/CPgNR1zc4nGB4ze/mcB2Jah94Ua4LIrDA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nkHjrJgBGx1j6XfDE8nuOTTomn8snEVgoQykKVjfCOUuEaFpK2fHFnhW7Dv8TDaZNi+Qg5w4cRuZ21i2n++i2tU+Y4wF0fIs5USzAKSbYFlellhjI81bZnNaFnCbiZqcolPUC55cR5HnRD5mtcNaASSQMe4HD/Qr1+b2XU+v+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eK6XCDbo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eK6XCDbo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a61b31993so11535077b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395936; x=1711000736; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rxi4fggPixiVFuhVXSoHQicrKYgfFvqkEeqWtSPSm6Y=;
        b=eK6XCDbo6nejD30dAtdZoBZ6Wtq5PQZcIhOe24TVQs4Yxhl7C3pHZ9KdAiP6yn39eH
         6cBC6/vh8Q3AuHnVAjgCyYpuwVp8+nmsaXvuEfpMKbiAAYvhXTR8HRf7UssBon2VkYWK
         WRHZdi+AXdZzUp6/9jAAv8H4E1De4i1uCzN7pAwiRda2D7Yvtgw6kmuvBpQz1KRvI95a
         Ud7k75uqhxjeXqASmEE9pmGjbeTUjRIhQN/398Zoyps4C6Z8nbw/eAQYwZYJ9YhHOTh1
         MAI2JNk1z9Wh+MgICyYvYyZ/RARMpqm3diHR5e3dPqlD29UIOBZlxhpl4+V69TIstYmy
         +WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395936; x=1711000736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxi4fggPixiVFuhVXSoHQicrKYgfFvqkEeqWtSPSm6Y=;
        b=lFHEmgH3geTn8+cCCHZvrxkBD8asKTAMqSFIzBwE2sV1MQxdZWP+h2ZxBTolNvRYGG
         Q4BRkMV8W8zoMCkJre6LY2ziWtlq9ZwBO0NqF+0XNexOc//POLRQuJMcZG4PeqzVfUqJ
         SMa00lGj6zrjJrFuYgiEodue/tVZqHyqbzoIkw1W9uvjFXtOn1NMR9JPJo61ksiBpi9T
         aidH7PTaCmjv2SpXuoEfv73GqlQtQ19uo5k8FAQxTulL+srCfJaMeQy8wDowXxFImNdp
         Sl56wM/FIHPk+BL/xwJe0FvRAPsnY9LfeCZQEdKgmzSJFGWw58OytdvOPGWd6NjuaAt7
         aBYw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjtAEA8OMork+Qc0UwIKPxGiX9Yu8zwkRpYb0VIc9Gz0S+/NceXIE59No9h79RpVjusDxTHx5rMjn/l8pRcrTmVng2G1MdplZj2cpSJ1y4g==
X-Gm-Message-State: AOJu0YwLm/iwJdehyKfT6+ZJc7k1b0v+gvGroh1b/Lasqekwvi8S68k1
	99qRBt2py5Zin10sr8O7R/EnLa1iI8+Mk5xwz7V3dmZrdE7gHHhp4r4wDetgpLTpc/9Cy646hEo
	XYt8MZw==
X-Google-Smtp-Source: AGHT+IGPmfRPG1o7K6/hSQPRpIO4pPp4foG2pF0la5o/tucMPboxCnzp1c+2tet24X1PfQJd6ag1r4AFNKcE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:72e:b0:dc6:e8a7:fdba with SMTP id
 l14-20020a056902072e00b00dc6e8a7fdbamr253985ybt.4.1710395936161; Wed, 13 Mar
 2024 22:58:56 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:32 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 05/12] perf jevents: Add software prefetch (swpf) metric
 group for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Add metrics that give the utility of software prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 90545d4862a6..9551b44dbbaf 100755
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
+  overview = MetricGroup("swpf_overview", [
+      Metric("swpf_ov_insn_bt_swpf", "Insn between SWPF", r1, "insns"),
+      Metric("swpf_ov_loads_bt_swpf", "Loads between SWPF", r2, "loads"),
+      Metric("swpf_ov_rate_prefetch_t0_t1_t2", "Rate prefetch TO_T1_T2", r3,
+             "insns/sec"),
+      Metric("swpf_ov_rate_prefetch_w", "Rate prefetch W", r4, "insns/sec"),
+      Metric("swpf_ov_rate_preftech_nta", "Rate prefetch NTA", r5, "insns/sec"),
+  ])
+
+  r1 = d_ratio(swp_mab, all_pf)
+  r2 = d_ratio(req_pend, all_pf)
+  usefulness_bad = MetricGroup("swpf_usefulness_bad", [
+      Metric("swpf_use_bad_hit_l1", "Usefulness bad hit L1", r1, "100%"),
+      Metric("swpf_use_bad_req_pend", "Usefulness bad req pending", r2, "100%"),
+  ])
+
+  r1 = d_ratio(good_pf, all_pf)
+  usefulness_good = MetricGroup("swpf_usefulness_good", [
+      Metric("swpf_use_good_other_src", "Usefulness good other src", r1,
+             "100%"),
+  ])
+
+  usefulness = MetricGroup("swpf_usefulness", [
+      usefulness_bad,
+      usefulness_good,
+  ])
+
+  r1 = d_ratio(swp_l2, good_pf)
+  r2 = d_ratio(swp_lc, good_pf)
+  r3 = d_ratio(swp_lm, good_pf)
+  data_src_local = MetricGroup("swpf_data_src_local", [
+      Metric("swpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("swpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("swpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(swp_rc, good_pf)
+  r2 = d_ratio(swp_rm, good_pf)
+  data_src_remote = MetricGroup("swpf_data_src_remote", [
+      Metric("swpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("swpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("swpf_data_src", [data_src_local, data_src_remote])
+
+  return MetricGroup("swpf", [overview, usefulness, data_src],
+                     description="Sofware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
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
2.44.0.278.ge034bb2e1d-goog

