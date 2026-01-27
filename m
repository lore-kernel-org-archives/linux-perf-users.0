Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD9329370
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539565; cv=none; b=oLeQgcbU+VGQCKMOKaMK2MRrTNZOrbtYo2bXCx+P3OJ7e7MG5bcwfBCDFoNJ9vVWKUvAfp0P3cZ8E2BRxGvt7x9KsUR9WRHAa8OO7blHP3dOe7kN/6LdURFYGSIRlwus+bPWUCyrA9cyvQ6AnAXMZKf2Mn6q5k9IGxqQL+bQnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539565; c=relaxed/simple;
	bh=CtVMYcUIf02+ZMTzUrQLC0XZE4+iMH9mNrvHBr7BiZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sVXlnyGy74fF9RUjI2M7azg7tmXyWRnkNdQPL8Z8mubcmuWa+wtL0xhMCDV6kCEQSPUz7mk+weCMUwwbSldol7udemgsV+XvSnKsyA7RZjGF7TTJIOS2zYqKWEAXyfwJyfTKIiFHQk/Nwdw2uT5kH+WS6vER5p1n1hYgTmUc/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vx1G+l96; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vx1G+l96"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b738854780so6598587eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539563; x=1770144363; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK0zyNurabiFsImDIZqSBtyLaLOCoRSnfPTqeYDaNRE=;
        b=vx1G+l96Dvhv8yZslPpp2XFzzZqfBfqUZl7BS0cS9a1hirSKzq0U80I3C9oJebp3PA
         oCXN+rYKmrqNK0vTHavGYvg46I+OWUcrtbTLQAjysfeFYyceb6efo5oujYy0kAZaS+IM
         9X/ttypwUylU6Xarfz+8WruwyK1I+COYBL/55185EYMsjZzpCMX9nGSYHGSqZDkVwYAf
         POfszWMRHYWbjV8ao3mKzAEOgf6g/5kL4kB9NsQIzccTf85BXEGdrHk8OrNMN73COu5p
         00C9mAt3clKK9Mj1lMdG6rQQhYujeN0thQYBpFiYXtE1hSDUHDAA99cHA2KemqoRiMcY
         7JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539563; x=1770144363;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK0zyNurabiFsImDIZqSBtyLaLOCoRSnfPTqeYDaNRE=;
        b=YvKzx3y7EZOkDY+l4293FaIYQlEyckwODKdcGAyv/hwuvkkme61gHbOilz+jrM3xvd
         Ph0ncETY7iegzR4hK+O4GcIEXNRkrYJ5kSkPxtAPJ1Yk7POOpOdJ9Xyo6IrL1hLmbjah
         k2/9jb94ELRq3Q3oMWnn6wZmZ99t9SqGvOXpgZYUQOzcG3pwk5rWAAvsmd+EYC+dctgK
         r4IPXQRQTC09ren/lVahVLrVQfiIAGWAWn/SNqMgcMJFMXJnovSWO6fyJO9VMtKAHLdV
         H8ymOQRbKGSy5Y3qYktO8/t/jZaC+Is+pTDeaRznQj6YGSYyn73ohVBKvmcxK0uAz7aI
         xUGw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Me2Yy/fzxnp/q7xOBaen9fLNUH7KmMBFJ5/zllJRZ+93tQukKAi68KnBV2c7/wFKQN+e6a3jhgdBTabL6y5B@vger.kernel.org
X-Gm-Message-State: AOJu0YwesOhh4ktbUYlbMva92YK6Xx7Z02FofACHbGzbyECxMNLLs5Iy
	9cucNQRLp3G+vTR/Mj0/tNaBEWl10xfH34oGUc6FUX2x2X+KG1j8qSwvNoBQzaGGRbHa2hNpTYi
	OI0BVmz95Ug==
X-Received: from dybpe6.prod.google.com ([2002:a05:7301:4586:b0:2b7:4bcf:315a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ad09:b0:2a4:3593:ddd9
 with SMTP id 5a478bee46e88-2b78d8d38c2mr1529991eec.6.1769539562969; Tue, 27
 Jan 2026 10:46:02 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:50 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-20-irogers@google.com>
Subject: [PATCH v11 19/35] perf jevents: Add software prefetch (swpf) metric
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

