Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693FB244664
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438328; cv=none; b=PkZG4yVd0ndTBSDU4FmNWqFkT0w0e0zuAMn1CfdZZ2ip5H3BNZSNZJ9wiA6soMeW3k4+MbiFuvr/ylJNj4bxQXeJbli/3716aZ2vx2S7Icf/69+ZaPqLuD0bp5u0Hl6VzGDNY+dnhfcIG5H1dbTBSCVZC9A3nK6/db0USNFRCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438328; c=relaxed/simple;
	bh=9Hbibjw3LzGMRwYGwD6kAO14AeY+5/BV94P2rvvO/1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QPOa5HujtmQOx19HHTYcGrWioJvl7q44Il2f1eJ1YR0B6sS9Kg+VY6XSLY08niveMGV+POSoogA9qV+BFi3ArXLPUn9EUj/zPY0p6Q0eR/pxn9JC8c8BHhGrmg5xqisww0wpKnb6JMc/Wirz0V1zHhl74S+Uy8v1mJ0IHBgWl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHFPYQzh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHFPYQzh"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e9707d6d19eso1668100276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438325; x=1757043125; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KO2wQ/2lz2oBZIqRX2yZ/AaUoKZSlBZGjqjdjPcsVhQ=;
        b=tHFPYQzhKbVLP6a6wvn7xHwGH+CifuASB6VpHTp5hCX9LNfiOAn6q0tGAlEcoeYiXJ
         SQiYT48jptiMr8DcdEd0U7OD92U1PnYdB+/yfK24eKxV8KJYesMjqYUyRxTKUrobP3ds
         /5BWwZEEQL/VImnxj/NqYD07A8JyIVvltNXCkffj2GFQWl6Zd3AU3xz9Mzg4BCIQIc4L
         v+P6frgOZcK6fjghBL6EhVp5KNFLEoCfoqiEQy3qFGtb80NQe96hpRnDLp+2pjyfGXNo
         HxQSDhNgxSgFHUGtJqnAwRUlAIGB8Uo+ZHMRRw6q+Jgnrwussz/TqlvVUIiNmOOM8akb
         n6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438325; x=1757043125;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KO2wQ/2lz2oBZIqRX2yZ/AaUoKZSlBZGjqjdjPcsVhQ=;
        b=ighcPe6Hl2V8fjPqjbrIasNNwTcw7myaO5PZ/emkBA8zBqvULF+xGEzUGI2GHIUGgg
         5C1o5s4+e8X6UEX5WgGOLB3xKoV9ekeHFGYfCLQnE+LLknoaOYfzMYOxOjMjOLqho478
         O0ESx79rXkkKt5ZR99FC9gnVb4F2F3IxRolNQbq5VAH9bqmEVFSu/TqEbyBVt8C7v3b4
         17qc+V0DXVaMK8YaYcjUog/d3Ddp0WkIpkCmLsjTCTGflcU5cLG+tBioypmjav4BTZtH
         ZRfvWnCp1Smv4XVqc4vQpDoh0RVHilvzCw9Ij3lQhJYiwaq4IfIVgs6mpqtuFpW2I98u
         VGrg==
X-Forwarded-Encrypted: i=1; AJvYcCUUh6PhAebbcFNqSfxkhOjn8ityiCNapTFW2f+l5Ce7QIctm5V90Scx1kd1ucNfUXx81kjLorgmsoVA8EP2DeC/@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0pHbg04yMCQdcFsRmhJo1gOqytAJ7F84iIGpssZsKKe1czPC
	/WwwyY4EpBM45pwoXIwDPihB59kdV9/u5VJiV2gFsITAx3Vu1z5aEl6Q5ojPaSnI0xcdfpFYUEG
	raDGn+qZGpA==
X-Google-Smtp-Source: AGHT+IG84a7uVj/ZZ8zj/2yLFbZqkS6K3onxgn4Jw9R/Zjn7lRWUDPPoBmRmi3bbthNElPNuUaVXuBR5LHiS
X-Received: from ybas10.prod.google.com ([2002:a05:6902:680a:b0:e98:95a8:b6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:2b87:b0:e97:258:a126
 with SMTP id 3f1490d57ef6-e970258a636mr5092153276.46.1756438325187; Thu, 28
 Aug 2025 20:32:05 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:35 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-11-irogers@google.com>
Subject: [PATCH v5 10/13] perf jevents: Add load store breakdown metrics ldst
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
index 71500ea2204f..13bf3eaf498f 100755
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
2.51.0.318.gd7df087d1a-goog

