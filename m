Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4630DD1D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004094; cv=none; b=u//TXID5fWUhbqP2w8dUBwLmlXHfDMDa1sFXB5/neMn9tGgi+yKefzT30uIP0L0PuwdAvL07fkl7L+GHrfuOZCyzH4sy/xtWDIaji3xGVCF4IO93sRyL0uIOM/18qzNq5jnGbVBKQCZUtFIEYkP2v7c/QTNcmOhd+iP1ZN2AJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004094; c=relaxed/simple;
	bh=0GZ4eaaoyx/Cs7YZ3MmrTxLV+H7R0IF5moR2NJsLj7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KSaBXFz09HSPBbaKDHZ9+F4olggFarKPt67SDYmOytLYzq3BEQ2/OlCOMJ9UvUdznD7Qqj3VWMhBQxvNv4ZzrhbB8z/wEuDBkKiBzgG+MB3xbXMfWw8RTD7+4Qe50thDEOOmZnailM+WYTczlc0RVAdZFgXjm/OqqxNZgQLYaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mw0UKVp8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mw0UKVp8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295595cd102so8434155ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004092; x=1763608892; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JntwDFAW5ojRTBXp19gyFuJkjXeDbElRUQSnnbCyNR4=;
        b=mw0UKVp8B1SOeNGe5qcRjSCyDijlOHdVuH0v9l0zZ285c8xv4UYpcQh+K6CyrQT+d+
         VUqC91EniYxrJnffU6DkJSwnVQ5JI8Lx5t3InTP4O0SHrmwOGs9NPkzF49d41ZjiDoUM
         QBxl6xwVlHlo1jijGsXED+zX/uBFBxZXk/3YB3GjZZf0adGosp8qrQ6jSM2LYVO0nRmL
         ErJs4RQwIRU2vOtyA40Vr6S+Ufij1a3dZjQn62h23ViNwC5b6vK4uQmXN61BodK40xsI
         xFqO1t+kwbv0+VTqZ9CjAT/y3sGTqTUa349XUb4AAhdGKaFhms6lJC9g4I0Pi4enDZHK
         zWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004092; x=1763608892;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JntwDFAW5ojRTBXp19gyFuJkjXeDbElRUQSnnbCyNR4=;
        b=faP1iaxIVCRJcA7t76HV3OLddUH5RBDFKEzMHO0LXl9fgov5DBUBatKe/tYMZdyRFC
         ErXz/vZ6mwLeyaog7TcoSrvX2nZKcNxyIQhOosYnHLBSzglw34lqHY9o6MmSpf0CMm0r
         THaND0veGV84WqdDTPan/C+wP0wYZoOwBfn1oWWZfVVgfqLu6nIs3Pa9j+fQiN8TqU9n
         8Q9e/IYvCT4Ox68EKpP05f1iQukhmHLkAu4B+vZmHRh2AJsbktFP37qsDjIftysZxYKb
         FlZAO4hvv3VH21CtnwDBL6GNPDTM3gELhW2B6kPKTNiik0TeGQ7OUK5dcnc38q26PT+J
         S+BA==
X-Forwarded-Encrypted: i=1; AJvYcCU5tTmhrjBPIl79RDQCkbpJBg1oqebTWNzV37Eoy9YenBQXYrrKHACxs0N3sg/Kn/q4Z2n4zE6Ik41NSN+9+CGl@vger.kernel.org
X-Gm-Message-State: AOJu0YyysJanS9UYSe2jjoGtp9Dq3uuOKl29sepjCfjyyCPRbnUssVjF
	qewUcU7U7XNLdeCC9BerRwQBv8bR+FkApou9Yp0Tw4skq2Wvubxwlz1k7SAqTNkE9y152ZZoo6j
	tDa+1oEuxbQ==
X-Google-Smtp-Source: AGHT+IG+PMkJFwGCD8b9KXtrpctx9O4ZJ9v2uOQqccKIXI5+yo88BAFu6n3qfTql4mTrOvxgk3exezobjIx3
X-Received: from dlbvp3.prod.google.com ([2002:a05:7022:ff43:b0:11a:126f:ee80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6f:b0:295:8662:6a4e
 with SMTP id d9443c01a7336-2984ee0b628mr60738665ad.47.1763004092438; Wed, 12
 Nov 2025 19:21:32 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:08 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-21-irogers@google.com>
Subject: [PATCH v8 20/52] perf jevents: Add hardware prefetch (hwpf) metric
 group for AMD
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 64 ++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 06cb56cbd617..be27a4947e45 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,69 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+    """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+    global _zen_model
+    if _zen_model <= 1:
+        return None
+
+    hwp_ld = Event("ls_dispatch.ld_dispatch")
+    hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                   "ls_hw_pf_dc_fills.lcl_l2",
+                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+    hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                   "ls_hw_pf_dc_fills.int_cache",
+                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+    hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                   "ls_hw_pf_dc_fills.mem_io_local",
+                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+    hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                   "ls_hw_pf_dc_fills.ext_cache_remote",
+                   "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+    hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                   "ls_hw_pf_dc_fills.mem_io_remote",
+                   "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+    loc_pf = hwp_l2 + hwp_lc + hwp_lm
+    rem_pf = hwp_rc + hwp_rm
+    all_pf = loc_pf + rem_pf
+
+    r1 = d_ratio(ins, all_pf)
+    r2 = d_ratio(hwp_ld, all_pf)
+    r3 = d_ratio(all_pf, interval_sec)
+
+    overview = MetricGroup("lpm_hwpf_overview", [
+        Metric("lpm_hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+        Metric("lpm_hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+        Metric("lpm_hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+    ])
+    r1 = d_ratio(hwp_l2, all_pf)
+    r2 = d_ratio(hwp_lc, all_pf)
+    r3 = d_ratio(hwp_lm, all_pf)
+    data_src_local = MetricGroup("lpm_hwpf_data_src_local", [
+        Metric("lpm_hwpf_data_src_local_l2",
+               "Data source local l2", r1, "100%"),
+        Metric("lpm_hwpf_data_src_local_ccx_l3_loc_ccx",
+               "Data source local ccx l3 loc ccx", r2, "100%"),
+        Metric("lpm_hwpf_data_src_local_memory_or_io",
+               "Data source local memory or IO", r3, "100%"),
+    ])
+
+    r1 = d_ratio(hwp_rc, all_pf)
+    r2 = d_ratio(hwp_rm, all_pf)
+    data_src_remote = MetricGroup("lpm_hwpf_data_src_remote", [
+        Metric("lpm_hwpf_data_src_remote_cache", "Data source remote cache", r1,
+               "100%"),
+        Metric("lpm_hwpf_data_src_remote_memory_or_io",
+               "Data source remote memory or IO", r2, "100%"),
+    ])
+
+    data_src = MetricGroup("lpm_hwpf_data_src", [
+                           data_src_local, data_src_remote])
+    return MetricGroup("lpm_hwpf", [overview, data_src],
+                       description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
     """Returns a MetricGroup representing AMD software prefetch metrics."""
     global _zen_model
@@ -287,6 +350,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdHwpf(),
         AmdSwpf(),
         AmdUpc(),
         Idle(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

