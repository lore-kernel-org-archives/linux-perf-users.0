Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923E17BCD
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395941; cv=none; b=kFxSeYEdLaLesqbkCg6urwqFIsnhysTOxYO0GihoByQMgDGXjd5YdthOcCltDi3Bl0o5Vdp+IVyizjgy1u93vxQpQPciof9o+W84pyXJgph/SX1F/0Cc9HddARqvPn9KOLfIBsKTnt9pZpMyLY4zJmyaj3Ksre9deMX4GC2m0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395941; c=relaxed/simple;
	bh=WOWe+5ZwJjFtAMO5LixHT9n3OypFjRwiFMl5aR4Ng6M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lkYv6Z/stI+nXQKoO1oqwJ2G5tZFbIHXdZR3EVMknwPtmmRgiqmi8v/WnpLgg23hytC8uXCBrmt+SK71Z0hTFtHVwbAQAr0CFVqSaelFrA46Fu4Qyy24hQefOqo9FefcDMxh9jNs8K5p+fXQVHAh5ryn/r5SJSVr6kOB1UwHLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCUOzZEI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCUOzZEI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso751562276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395938; x=1711000738; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6qdDgoIQxn8fAzaUEAV7cPE0zy3zkq2eTruom8IDPQ=;
        b=SCUOzZEIdO8gDjkgOpgAJOUpsl1206R4nxH31TmYCH3fL/Xbp7URZAvuZEFzyouVvW
         LKOn4JEZ+hv+yp9iQbNkZmGgIjpcwRT60brAXUVRZcP7+9v8DKxDhsIMRD+9LBm5PPGZ
         5Cr8XDY7/42QqROTJFHsxisFhmcDYBx7WIL7FwYpULwILyBNGjHGpgzSzlYCrwyme5oW
         HHMsz+FwVo0enu9zYl0d6/BUHVvtUci0T+RREjoDJk9sUouL9/vxexO5p6kWRRoFMbQY
         ONhNQjEPno0e0q0TU3K4eXQO6qIpnRJi5GJ+CwogBk0ni0EZzvgviNdFJ7rSDpUGPtYD
         Md8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395938; x=1711000738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6qdDgoIQxn8fAzaUEAV7cPE0zy3zkq2eTruom8IDPQ=;
        b=n4imgvm19JM5Wm66xztEKiBF0RXVvJiJ8Cq5rkUZiJAqlZslsN8zo4hc92p25c4k9O
         xHMchGfV6j7guuVrs5rF6YzuGmhwCmUAgFRJ1vPD6n1nESEkuLb1yuNuIEreihZcPjWb
         OLamJxGvZxoGuJKsj7tzGLoptMXQ0tV8NPAroy9BdtGz/ez9ghKfji+chfeQxZGifCyV
         q0TsciXf70b7r8UZmwz/VsFnLpL1RIUlYQl2bu8/iRqR+t1NBO2J/Lzo/nhv261mVoGz
         wzdv+IZKLzXu706L/6tw8JTHRwmLcnkIGzjkY7s0IX7E/Tyux262yFZs2Hn9+FqnuHxj
         nnVg==
X-Forwarded-Encrypted: i=1; AJvYcCXoLUsZRPQn6ZJYohLCcQ055DUUGtnhrYoJS5ixNH9zGgGldISww9MkV/bhqvaUysQrpcY7LdrAccCy0ZfxwRfDxJe+V0iiOc93UzErV2n4nQ==
X-Gm-Message-State: AOJu0Yxvrm6IXVps9vSuHUiLaijpv5V/rUh1IPdIkL1vGJZcjy7VvZnj
	b3OtZ17o+r6UNdQkVlbRt2Wrb/Xsr7OBsWMF71sDaSGOkcSnLB2fy9pilBkRcahR1Ot8vNj/r0T
	UySwCog==
X-Google-Smtp-Source: AGHT+IFwr9ZZkG4/Fh7fUI8lDx9QV/iU/l1lXRZYsYunk9OLcTNKwFWK1vfmVkvaph3bP0KvJ/sxfqbBwcRZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2603:b0:dcc:54d0:85e0 with SMTP
 id dw3-20020a056902260300b00dcc54d085e0mr256664ybb.11.1710395938388; Wed, 13
 Mar 2024 22:58:58 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:33 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 06/12] perf jevents: Add hardware prefetch (hwpf) metric
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 9551b44dbbaf..5c91e97ae6c4 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,67 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
+      return None
+
+  hwp_ld = Event("ls_dispatch.ld_dispatch")
+  hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                 "ls_hw_pf_dc_fills.lcl_l2",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+  hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                 "ls_hw_pf_dc_fills.int_cache",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+  hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                 "ls_hw_pf_dc_fills.mem_io_local",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+  hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                 "ls_hw_pf_dc_fills.ext_cache_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+  hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                 "ls_hw_pf_dc_fills.mem_io_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  loc_pf = hwp_l2 + hwp_lc + hwp_lm
+  rem_pf = hwp_rc + hwp_rm
+  all_pf = loc_pf + rem_pf
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(hwp_ld, all_pf)
+  r3 = d_ratio(all_pf, interval_sec)
+
+  overview = MetricGroup("hwpf_overview", [
+      Metric("hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+      Metric("hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+      Metric("hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+  ])
+  r1 = d_ratio(hwp_l2, all_pf)
+  r2 = d_ratio(hwp_lc, all_pf)
+  r3 = d_ratio(hwp_lm, all_pf)
+  data_src_local = MetricGroup("hwpf_data_src_local", [
+      Metric("hwpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("hwpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("hwpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(hwp_rc, all_pf)
+  r2 = d_ratio(hwp_rm, all_pf)
+  data_src_remote = MetricGroup("hwpf_data_src_remote", [
+      Metric("hwpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("hwpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("hwpf_data_src", [data_src_local, data_src_remote])
+  return MetricGroup("hwpf", [overview, data_src],
+                     description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
   """Returns a MetricGroup representing AMD software prefetch metrics."""
   global _zen_model
@@ -278,6 +339,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
       Idle(),
-- 
2.44.0.278.ge034bb2e1d-goog

