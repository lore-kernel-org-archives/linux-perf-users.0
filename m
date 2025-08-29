Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468F253B58
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440715; cv=none; b=YHEBBTLcanvB7yJXV4mvLfAzra1JXNkQJ6+OIMPnOvws4hZ33zNqpjV7g4/fbPSG3x8mzheqCjgUlwLm6Hyre2CYONQVVL89wtAv2R4BfgXQwk16f1sW2p00XlxNP2aXx8cDWQHxHbtqQ5bkwT1Kk7MjNlktXajFDq7Z6vaKCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440715; c=relaxed/simple;
	bh=lan6OtYMxNeS1SjsmHeeU/NzNOqeBRB9k+2kHx/JzGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SHbXL7NC/lsg57vyxT8mPgDqn5uVbYIUtB6vlgh4MQcSZWMj/qZ3gmxZ/TVnCk6zkVgjN1u6qQkPUiuUoSkl3z5K3QegUpvTh1RThxlAAvHU+DU6n6F+KWHZMr2XtXhxU8WvVoZNQelVvU1FNiizmSJjSCpGix8KhFxHfQ/bkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PStj15HK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PStj15HK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3276af4de80so2430235a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440713; x=1757045513; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS0ggSa3B78eXuzRtpBd8eGQQtYmBLlFFRtUxftkvfY=;
        b=PStj15HKSSuE4sEHRWNbMwpzUBSVF6t+m6GY7oAlRWi8mQibYofwOFwOvNrYBWaIRV
         9tjIbvEmf2vmgwfs/b8qkX2wmSeZneO30kzMSBg0FXEuQi+lPceY7086Rt7WvZP/uQbY
         eB7tR/34DbGSHXCjf3Bvnvsh2krrsiswC5yBZSnDzn6RdmGWLtbCNbb4tyh+8SP/d3Q4
         zXvSAqkuXJhTeq+u10wrfThvv4uSnreDCVhQpGDp8Ra1M8S/FZLdUbVwyEUbRLH/iYW2
         HLQCSm6xFaIUETvQP5xXTymfJMjfJr9t4qj5hCo32qmfzWtIc/l0SOTRQ+r2oP7pWTqI
         2KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440713; x=1757045513;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gS0ggSa3B78eXuzRtpBd8eGQQtYmBLlFFRtUxftkvfY=;
        b=TIrGMIrbCxB/29LkQt7yXV2/ELXqgTS+XCAVhNM70FWKVVgXqGaKU6IH4a8JRVc2l5
         7nu4dhvvnI0FjWBh8PDiZf1fVKoUcYu5oaJFD74eyfQzIgd170k/+5T4wVvhqmNWfd/A
         e/cuvJJCMRKUPCtfykviT19kKbY2EOtxZhUVzbucfLyNQk32GPx+YfRREZi3hsdI/ldP
         T6spLHTELLSNsXS8DarcAYu9vxkED8uSY8zxL31CousDPCz4MpITdAbqRo5eKfr3czLs
         TXutYpowwd5qWP301DqzkG6vYY1GHaHlelOCPR1eCu1tTPgqQhVYHd+SeF0Zf+bExiSL
         8NoA==
X-Forwarded-Encrypted: i=1; AJvYcCWJpjJPT/RY2eo4efVgYTAhIg3YceP0M6x9mVBTwUgsBIVUvYKhAhGJQAAzbp6P6PU0kZlqs2ZPLX4udHpwGqW+@vger.kernel.org
X-Gm-Message-State: AOJu0YyDb0FyAs6sJ/bthvrTQqlCb9mHpc/kuaJsPGwc2VpCZahSvn/A
	04hphsEPxSOyDTHCqSoIKclTaczILgepjA1QuAnBSi+ZpZDf6CV+BOmEbTGz/+5csBt0Fmd9Dca
	ZhEuj5jlkQA==
X-Google-Smtp-Source: AGHT+IHF3tfh1i3hXHmRmKdBVtbaz8DNMGNPO1B9d929xEINzZyfq597XDPtc+crdVx3L9yl7+eLf9OQ0Q5u
X-Received: from pjbdb14.prod.google.com ([2002:a17:90a:d64e:b0:31f:b2f:aeed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:564f:b0:325:211b:da6e
 with SMTP id 98e67ed59e1d1-325211bdcb3mr31761618a91.32.1756440713558; Thu, 28
 Aug 2025 21:11:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:54 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-14-irogers@google.com>
Subject: [PATCH v5 13/22] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index df0e1dce041c..31ef0373d982 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("lpm_cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+    metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+    metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+  except:
+    pass
+
+  try:
+    l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                 Event("L2_RQSTS.RFO_MISS") +
+                 Event("L2_RQSTS.CODE_RD_MISS"))
+    try:
+      l2_misses += Event("L2_RQSTS.HWPF_MISS", "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+    except:
+      pass
+
+    metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
+                          d_ratio(l2_misses, cs), "l2_misses/cs"))
+  except:
+    pass
+
+  return MetricGroup("lpm_cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -671,6 +725,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelCtxSw(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.51.0.318.gd7df087d1a-goog

