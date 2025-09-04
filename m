Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413D279789
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961256; cv=none; b=Xf3kSAnmwlEdckRaivEQHtoa+lffEZx448ACD6O7ohkSMNF9IhRVKjkLJxY5tQ/d7ZHMKKv/x4IiHVdmLbi2wKEDR5dcfq5YwQCL4KMsNmhWW+xfGPYo9Bybhcz7SlfI3GJaOZm37lAZfiIf1qUSnRznQuwOuBe0ZcJF68olPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961256; c=relaxed/simple;
	bh=k/LoRE9LKJb9pgXdFQrX4Vgw4BybtXTPIpuakLBhaK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pwMk51y10+ibGjzNrsTARjs7vF9rw/zLfBGALLv5gwMbGQhlZh1pd183xLB9JNKih5vvZTiI2NVpE2Dbe4BXvlsOqUOrgAuZwb1PFI1a0xoXbTi8LQl1LCgmiEJ5KhiL7P+wgfdpuTIAaJ1MR8gd8cJ97z8IuAo0cfnql2oiVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfn2ymuF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfn2ymuF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24868b07b5bso15164795ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961254; x=1757566054; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/I9QWCdSsiagbzi91mQV5Lxu5w6XmpsGaYWx/t/qFo=;
        b=dfn2ymuFCJXp++Yww2SK+BUbXtSa/BKmbIBwxWaG7/tzrbqRG//tdnhL42+uMmtPpV
         PNQCi19F4xEQOyYah864wNNcBtP0NYuHf46q/hDFmqPhF+3ETI3N4gKzcezP/HHt+zoz
         5Y6oGdnFEmQfO3ErrZhIcLKkJyuPQxEuTMCRaiHtNCyhPI+6eVu+9FRFaUEDPhXAT5Vj
         oi6AaSwsXYmd4+UxpwbsV3Flstb7cL/VTU9gnimVKW2QEaENOcb3OO9Ov3nAOrnPN3xD
         2zB9XjHpyR0nwsjtMh6KtDUiqUzUY3El0kP94VuJHZvESRhIaXNJXgsSOBpjiEs2aqcC
         2Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961254; x=1757566054;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/I9QWCdSsiagbzi91mQV5Lxu5w6XmpsGaYWx/t/qFo=;
        b=mTXu9Sn/m7jFWGEhbHsYdK+18tj97/h1JRvUuZxWZQgm+1CO3RqyxSTkNl8fyYl3QR
         Nt9/B89W5Ft9IbnQg+09+6h7ybq89JckR5vyBVWc5ave8pFNWTlhPQMG1wEKEe4DQpj6
         AmD0KXT7AaxV/i5FrjUK8OfoOv2c7MNqsmU1YAOSdfM21ev2xJu6dE7YneNG/ipPVBmi
         AnQHU9sVCcZjkL2U93/m6+VuqERy04CXg55Mp6YcBAx7jpckDBVQb/CFx/9BzpzoqzcO
         THDreKLMlT9Uh2ZVwJicqAimlq9+rPuuolQ6jRSBs5FPo05zyR+EssdtQS5zFqtTQ3/m
         2e6g==
X-Forwarded-Encrypted: i=1; AJvYcCUMrHSwK1PhraXpwks9U+fpeRiO92yn6zIBCduKtgNVLnGD8LKU0J1VC880lODXWXuo8WoRB3Cjf/CJKoBAlomJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUmYy//0jD+WkHKqLsLkdI5C+EnMJ5WgnkaSzO1IxgX6pXJsH
	3kAGw5RiJHOOW05oIA+19S6Y5mQgXQHuXUx+TjKKXv5P9Yg/v/rhQoUtKTLgqqSbS3grRHXRp7B
	vNyGD2UryIA==
X-Google-Smtp-Source: AGHT+IE/N6MAKEsx+XK77LYz++Lo9hdGu6bLFSU5sb1Lb2ne7u2hi/FDM1GhURNwOObmL2M/3v+fFsv7zKmk
X-Received: from plbh15.prod.google.com ([2002:a17:902:eecf:b0:24c:c013:50b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94d:b0:246:bce2:e837
 with SMTP id d9443c01a7336-24944b55120mr261214965ad.49.1756961254122; Wed, 03
 Sep 2025 21:47:34 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:50 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-20-irogers@google.com>
Subject: [PATCH v6 19/22] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 669b5668a753..befaf0fcd961 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("lpm_cstate", [
+      Metric("lpm_cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -958,6 +984,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.51.0.338.gd7d06c2dae-goog

