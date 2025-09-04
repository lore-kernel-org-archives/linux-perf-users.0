Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEB259C87
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961234; cv=none; b=CwB40SNDs4yV7stNmxYW5hfG0cCIh9//rsn/ChGndm8NQQQM7wOVitNlRGPILMJ1a0HSCFPn04vCLgSGkJ0wrIExGh8EKXuLG3FbL8zBg06IMZxZFo0x9ZTB/RjP46+ZlLCBy8qgHxkc9z1kwGzki8ZmItZ5An+Y+fm9FY6+BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961234; c=relaxed/simple;
	bh=JjlQaSBT7py0q7gDkb/E4YVFsgpF8smvn6xkGMOw5Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hhN+13ErfvQM0Hm95qWyknq0eaEDT7TaoflD4ICMeznBinIL+6jj7z5WTxtMC1Uyu1AdAKwOtRTkf4MHmH774NCh7G+WDtwgn9rClLosgB1w5seIIVfI0EiAjRvN0TyG68SLx8jo6jRTXnpS4LAVdx++M9ThqTI1wmT8EV32xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0iZQuCoM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0iZQuCoM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24a9de13b7eso8407705ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961233; x=1757566033; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu2m9NwYUYP+oZqOMmXinOl1d0NFMuknff+TFeF8Tok=;
        b=0iZQuCoMOYGVVlH3ZDag8ra/mGobVz0qVgm1J5+xt3FgoOPfStKlfvJu232BM3zmRh
         jQtXqx35m+W9tFs2CFMFMrof9a6S/6LXsNEqdyXOo6LiQbHczzBE7vW7SlaSTybyAjd5
         dR1JG6kX4qBSPDTCZjj/eXVyBx+/+TG2t0ZyifiPOpw4QR/oHvjyDZXOMmAj6inoV7GC
         vaJY5Lidb9OXSsDHce7JWD777kMreO4RuDl4chG+Y2zazfz5RaZWvbdlqEkdKbpFhpwf
         XUupe8/r2uCfo8+cllT2l4/2sIk50Lo/b7HQdPFecrCkVHoPQLpZxUoK4xSkEGWDulaT
         L+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961233; x=1757566033;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu2m9NwYUYP+oZqOMmXinOl1d0NFMuknff+TFeF8Tok=;
        b=SzItbnzi/Nnvd0MdArFyxyRUTOw1TShooBhY0Z71CUc1dM4gFO6i9Z9+Z322Imwk8n
         j6AMx+gGe19ccSU/f/dXZTX9C5Ls2lLTXsTDXFp1D28BpB7xw+9LGBSMccRZKWyC7PTJ
         LLqomlx5LOhdOPbh/GbaerOVG4Q1QUuRvaU5m8A2CoX7fUNtB4VR6jU/85wiSXrmymnn
         FbU8E2N8AVKMpkrAh9TcMyWloXCw+DjY7kNigKzFtEWF9x0x6SrWpJeYE/BzFQAeyQnA
         coHSXcNBci5fLBExDV+UeSEOhTh8RLYpNyZbf4Tsq1Skh4UHp1kg5psRf7J0QKm9gLh0
         ZGCw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZIpNHfQl13csaL2EJebu23zIzHS9/+DqESOWgtM0u54JHboCIAO+Y00YGQLSiLAeZ3gn901kCDChH7JtAKO/@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK2hjgjdr1lZ5WRxalG8VEWx2Km1IgDMR4m+w5UMfPSgLK00b
	cKk0p7oiZ24nzdRTwaAqvlJjYyHmAvKFJHkYJp87fz/nu2UYXd95pu5ZAhQsyR8gwlG9fMesnAq
	Ff97CrxLMNQ==
X-Google-Smtp-Source: AGHT+IHzLCkpxX3Zcx/kL6W/qra9cEEG3LIfm+BCxJr83u1VsSF+iyijelb38kCbkTKGBacQXP6ZT7i5XCat
X-Received: from plhz7.prod.google.com ([2002:a17:902:d9c7:b0:24c:af07:f077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5ca:b0:24b:1eb:857c
 with SMTP id d9443c01a7336-24b01eb87dcmr130196425ad.57.1756961232633; Wed, 03
 Sep 2025 21:47:12 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:39 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-9-irogers@google.com>
Subject: [PATCH v6 08/22] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dfee782596e8..b4ed137c91b3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("lpm_swpf", [
+      MetricGroup("lpm_swpf_totals", [
+          Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("lpm_swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("lpm_swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("lpm_swpf_bkdwn", [
+          MetricGroup("lpm_swpf_bkdwn_nta", [
+              Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t0", [
+              Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+              Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_w", [
+              Metric("lpm_swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -289,6 +353,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog

