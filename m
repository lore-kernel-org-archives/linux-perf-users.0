Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9442A8C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165759; cv=none; b=QWmohMIKsemNpHtSGzqROXcVQw5V7zrgklOLiBJv+mg/nDN3rZM3wW5UVyMZh7EucBGD5/ChzyxtM6I/5I8bfYRKE1uJjMg3mkPCmGkgnp8pkMxg3HVVoRdgohHVK/oe5yL8iTgDYr2teHqOAPhg57cbZR/omKTeUKpCZ0M8y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165759; c=relaxed/simple;
	bh=5rPQbQbgB4a9rwpPs3GZO8lIicUTIgfjGCJZshFzKwg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NveIGwb3BieWc5m723BocbHXeMKtB4KVj6Ip8D+PhaYAfbxrZA9Vm3IvfO9qQ/pQb/U1jTU3JgkaAWgs6Yl/rFIN6Bl9hgeFGfXGVL9uL0X9TKp47BZyAMaQZAxGbk8v90++qHvXSZuovRSqBGjYhzhiLX8DvqTSgf3/tARL+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDzozVH/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDzozVH/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e4171382so4753287b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165756; x=1709770556; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=YDzozVH/Jah8I1SlVaJCYSs6zJpYfc5oEEdA/gzpxXANV2ChywCMF7cOjKqBlzMns7
         1hdk1Odpgpx0OMsz3sl6Lt2jsIbyCwAX4wKetSO0SoYa7fGwyDL9+GkPnyEylf9K5LfJ
         UH+yxsc6aNSV7hVLIGoXGXEYpYusVIVsMbo8Gf7y8cD4+XkgVHhn8uSoyB8VktNa7xYZ
         d+NmJ/yzt29JdjM2es6xqU8Bgnshijtc0Uo4SjtHYfz2NwLQKL1uB80ObYe/s745A7zd
         zZlcdevzDp2UzRJXZJlF/r2exmY2jJUNp7lpl2MHztoUvSWdPkTUSgxOVbDpIMkZMkxx
         E0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165756; x=1709770556;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbbMwVexzgBT1fsV6th5WqgIzFECec7b7GQZlOqA780=;
        b=QfMTPH8iqzpc4gOfoiyhkj7tCNgch8Xw+tFBeHaBN5LORsnKO+YN92UnFGK32xX7Z/
         9R1yVBbhdpX0LdbMpeiZAq22XkvbWlQa5umqmQm5EDSpkHjYmRDkdhuLg3im9LuTL4DX
         YK8OQYwdydMpuARzDHfEaaTlvQB2jWjjV+ryeLfM8Ds2SaWvNNPSaA74g3sKFZSfAxcC
         7AfJPBdG2wnsQk1z6t7YHCkwVLi2owjiCW9HgeusxNIXyJKrceV/0cXUGV8ZDezbCMbk
         0bYzQbFMU6+timkLQtYCU+iUEsVG5BfQfH9IfFY51d4tkF+f3qREejLimegZ7324xSyp
         LpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqRy5pgn3T3KblHFrF7IAOt+bE1Kx3ZRRE7AL9sCPuEhfEz+SRgfLczS3HXnXoPJKZ3f7KJcuhmNx1j3f4t1zo6Qu/jclIDu4eOhsqFUV/Kw==
X-Gm-Message-State: AOJu0YwljioZlx9ZNCJc4xGMZBLNxhmrKoC47X0dXJi3gH/L9zDhyIxQ
	WQhDI9cen6qKJp2UUiQWp+rImyYnN4z1nvWFxg+99XQjVzrU+L+eSK8OenZrC8JRIKR8HYz8Hjf
	zFdmg3g==
X-Google-Smtp-Source: AGHT+IFpvjWMxldxQybdcKWY/ZYyAAXRj1AiQRCleXUFxDcx5Z0ijU8jsfoj6v5FA4PraFhvXSceJt/nDerq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:3507:b0:608:e67f:4387 with SMTP
 id fq7-20020a05690c350700b00608e67f4387mr136175ywb.7.1709165756654; Wed, 28
 Feb 2024 16:15:56 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:30 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/13] perf jevents: Add hardware prefetch (hwpf) metric
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
 tools/perf/pmu-events/amd_metrics.py | 61 ++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 52451bcb4bbf..dda904998269 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,66 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  if zen_model <= 1:
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
   if zen_model <= 1:
@@ -256,6 +316,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
     Idle(),
-- 
2.44.0.278.ge034bb2e1d-goog

