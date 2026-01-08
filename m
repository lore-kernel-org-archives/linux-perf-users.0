Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B56330311
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899525; cv=none; b=cE5LL9ECSVvMBmbWve/jqgj1FJA7YZq2pKzk0GAlM3GWMOYQnq8nWlvC4P6AVDTX4T0MG547Qjkr/MODqGQaSVcd/d5JF4Cd1U48NZAn+F6HvyGA4ILzHmyEM/92LTH9MPsTkAh4dK/XRk0K2gkB2ljYExc5DUVXwxUD6IH9qDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899525; c=relaxed/simple;
	bh=CtVMYcUIf02+ZMTzUrQLC0XZE4+iMH9mNrvHBr7BiZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oyp/RyMDvT8sJSJC03bXzr1JN42AAm1Fe8DvKM+NTseTTvcbHz7BMneMqdKh6Pk/AhiJYZhUJsrYGewU+FDp0ZMk/8U0XbQKqJ+Ata5/zg+mbdu3Rc/ngc+tq7fziG2JJVJailv7LlYtYp1wT/UiMe+nHK3TK+cy2QvSd7aej5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEewTSJ4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEewTSJ4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ba92341f38so3531102b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899522; x=1768504322; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK0zyNurabiFsImDIZqSBtyLaLOCoRSnfPTqeYDaNRE=;
        b=gEewTSJ489OABQ4Bh6HhdLIuI+yG4DgbThfGbUJPisIOtx6YNhQtGfosT9vXnXQO+q
         iBTRe/3/YyEBHiFBwh9Qw0PTV6tSVxtua/fZbZKhDUVc/cFRaTbv3RWh60pUdtxnrMFe
         CelrrcCbzTyl7vnDObuRB8+7UgRnvhbm5q9TSu7e7qrvqF7AwzYcuqUehaUux19Kznjy
         X5aN8z5RVWYStAiLwK4fYnCBrTFIjtKeoiS6kL4Q1EFj33y9VnmA8EEX460/mXs9lSaM
         7xSwylf9Dk8w1xUnW2C9Ny+ausBeVKA68/JfKcVRl0ApWq9TUoVd/xWD+KSG77gjy2XR
         w0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899522; x=1768504322;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK0zyNurabiFsImDIZqSBtyLaLOCoRSnfPTqeYDaNRE=;
        b=VoiWT8w+Y/GHJ5YKpLxf8ugF6njR05QEILklXrW1kGkhU2n9JFBbTLVrT8LXQti2GE
         wq8yceOR4QJ4E475C7vSBXoYZN7aK5c0HJUqvLRhNouen6QnhEgPSiFNHMbITLj9XnFs
         8X7vdjbbOmeBnPOb1cJ6vaqhQC9IZ7MxveB1LErtjdsowUuEub5PEZh+mddn89wTRu+4
         FdvaWj1EypxqiJ12nZ8yegJ/NGbCPJwSx3qCKc6+NofQI+8LbJ6x4ADCYINwkqcbHUDb
         7YvsvuRVHqL9ns5oA+ABb9Ivf/1Mqr/oXZE/fz5BUpAkVczstO20zHeKTC5mVpqvQiTm
         84qw==
X-Forwarded-Encrypted: i=1; AJvYcCUZzyimAD7G3Ws5fVOvc/mN62UW5aYYrLQBLH/m/yXfVmtlX+MJBxepVpLDEI8ukH17xSX48h/GkVbB4lenlu/G@vger.kernel.org
X-Gm-Message-State: AOJu0YzG//kvFEc2lUT5fP8JM9sr6MDXpW5lJkulw+IWk1ZovNY/hVfh
	hbwGBxXRoqiYXRGrXv4yqg3eFTkszT3zKZ68jyYvQscIMIZwnFWAuPW5x3t452ITNol/vFNpiS+
	piXaZbS45NA==
X-Google-Smtp-Source: AGHT+IFTc+BgQ0D4hs3g+bbfj9CZmqDjMMQ8iQXxj21BJt3Nqjm9xkl90KmEADwSGpvwlIkkVl3K0mPY9QXn
X-Received: from pfbhx24.prod.google.com ([2002:a05:6a00:8998:b0:7dd:8bba:63ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4ac2:b0:7e8:43f5:bd40
 with SMTP id d2e1a72fcca58-81b7f6e70fdmr5793025b3a.44.1767899522297; Thu, 08
 Jan 2026 11:12:02 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:49 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-20-irogers@google.com>
Subject: [PATCH v10 19/35] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e1944d821248..919a058c343a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,71 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+    ins = Event("instructions")
+    try:
+        s_ld = Event("MEM_INST_RETIRED.ALL_LOADS",
+                     "MEM_UOPS_RETIRED.ALL_LOADS")
+        s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+        s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+        s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+        s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+    except:
+        return None
+
+    all_sw = s_nta + s_t0 + s_t1 + s_w
+    swp_r = d_ratio(all_sw, interval_sec)
+    ins_r = d_ratio(ins, all_sw)
+    ld_r = d_ratio(s_ld, all_sw)
+
+    return MetricGroup("lpm_swpf", [
+        MetricGroup("lpm_swpf_totals", [
+            Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                   swp_r, "swpf/s"),
+            Metric("lpm_swpf_totals_insn_per_pf",
+                   "Average number of instructions between software prefetches",
+                   ins_r, "insn/swpf"),
+            Metric("lpm_swpf_totals_loads_per_pf",
+                   "Average number of loads between software prefetches",
+                   ld_r, "loads/swpf"),
+        ]),
+        MetricGroup("lpm_swpf_bkdwn", [
+            MetricGroup("lpm_swpf_bkdwn_nta", [
+                Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                       "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                       d_ratio(s_nta, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_nta_rate",
+                       "Software prefetch NTA instructions per second",
+                       d_ratio(s_nta, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t0", [
+                Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                       "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t0, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t0_rate",
+                       "Software prefetch T0 instructions per second",
+                       d_ratio(s_t0, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+                Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                       "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t1, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                       "Software prefetch T1 or T2 instructions per second",
+                       d_ratio(s_t1, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_w", [
+                Metric("lpm_swpf_bkdwn_w_per_swpf",
+                       "Software prefetch W instructions as a percent of all prefetch instructions",
+                       d_ratio(s_w, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_w_rate",
+                       "Software prefetch W instructions per second",
+                       d_ratio(s_w, interval_sec), "insn/s"),
+            ]),
+        ]),
+    ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
     global _args
 
@@ -291,6 +356,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelSwpf(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

