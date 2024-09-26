Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA02175568
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372484; cv=none; b=DeUqui9tl7Bk2MjTdqLGd/a2IhVusMYzPYoMappZQke7bqG5DSSyLNfyXg34ELcmN/vp42GTNfQytutWtUmXQevp/8ZIOxpmPfbanxo7G5ZCn9XKB3Iovg7cWdqz7Zj4aji3zT2T8fuddEhplvrmNFxMl4D8dt4d6jZ5K1AGl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372484; c=relaxed/simple;
	bh=+VRBgRT69d+Qz350t15WqpSydFsMjPehsFkjDdpJVoM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RN2MAdQ43h7MQyVJJr8yxfXnpm5tMf/NFTb9NNdo7Y7jnW6ktM6a1h+249+7Q/xz5PyQMuO+5+KFxp2G5el1fVnHii6+MFV/RouNJ7jctj2AmkH3LjOuDFuyx+l2G6RIP9Vn7R8B4e1yOq+KOGU1y9qtwEXymFjLdVn+ssdxrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQGvxX4Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQGvxX4Z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e1fbe2a9a2so22994837b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372482; x=1727977282; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4AgLiud2lBb7srFRQdT6f87/XQGMLXdDZk6CThtgIs=;
        b=eQGvxX4ZswJOW0HYfzdgTxNzyVV7bfonFJtfo3D+Y66OrxRWc0HenAsZIjtCQhKAJS
         qR4a04hjgLDdhwi66ZwUmy2LdylG6O1YRZyC6AEHkY7+EVSx1M5LgCY6gERrQGVYVm6B
         g23VPtMYupw+hazFDGCTcA+ssdqZagW+8NZDhzKkjxy5KU6LUAvD3TZe56OokTwz0CDM
         Ql3zUPvz9LUN6S0JfElAcNL/L6BA9P3m6liOjkv19VZ8HHb4p+RRKnmQxfXRfyckZtrs
         JZXwh6N7DFHk4v42uKe1FZYRJs5q8x9FB7OdcbbT7kyMFjfZQdAt2jR6vBB/X/DqzOuH
         Dvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372482; x=1727977282;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4AgLiud2lBb7srFRQdT6f87/XQGMLXdDZk6CThtgIs=;
        b=F0XeLINKDiG/OPxr/GI2icxZ2TW15k5PhGlyIE7xuR8bM0skng59VzyTeRsYSCi5Yt
         kK3K0fxk2JojKN05LWrJ8bP8HDpphU79Hn2r6n3HANrixfp+9KqXNKb0laZR/ANp3BFI
         IB81yWrgDKV5yUOC2DoxhxZErAp4TJIwyGfm8UxaJz1x+lgojFvIqOVmoOSi6AEOYxMX
         0yQHAQZDvGFNWc/HpgDxYLSMSKJC/EmQMZ67r8TVnYuKr/8xd/yp8obMu7S7sQfQqP94
         qcxe/sNb0hIHvxWCDLJfLLYecMexcMEr/JSbNxElOO1KQ1Sl/HFx7D1zba99JoqGtEhO
         3cTA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPNMISnQLBdsla7HNk8jf6X1HncoMTkWeHKqUlLrDXIhGRN2u+K6JqHzv5mwFpoNBJAFn5nho6E5174bpNz6y@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAgJ8XHBRtCv5wW3s8X4GekP1rV1NGDuZdgRJOKTuf4ywyN+o
	8xcrA0fzcOcYJhFszciT28dH5Y0YifVRBskYWcx80BZaatllcdcOEqtlQLRuoZ2qxaldwi2Vnk/
	qLW1how==
X-Google-Smtp-Source: AGHT+IG930UTidYZ09u+dCrEZNNAl3ej8MLumYzhnhb5NYAHUFjZIBVWzzo6+Oguj2jFcBdDN8glkejbjLcL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:aa4f:0:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e2604b792damr154276.7.1727372482276; Thu, 26 Sep 2024 10:41:22
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:55 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 06/12] perf jevents: Add hardware prefetch (hwpf) metric
 group for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 05a16e748d2e..2d1fc8411d61 100755
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
2.46.1.824.gd892dcdcdd-goog

