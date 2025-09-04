Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF526E6EA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961245; cv=none; b=nWJOI7BM6xoxFCh/6BNMXclnu/9W4UaTBk5lyTHmQRpd8xJmn2HsyrzKDUmpaRuHazz8HTAoBkeo5dZZzEiMTdV8Onku41Wddf01WpB0BseireUxdKlQTSKDkIlCfIfan8QGz4/SU4DZhcB+vdSY+QHZsN2boBdwHGZULN+SiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961245; c=relaxed/simple;
	bh=n60h9NP/Hf9OHyJ+k5SWltRJwvKYO3C/A9l2sIoJhk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BtoJcMdQHGDe/eVkBbeLCoRXoesxvgzNbffraRzqitnzqSaHp2xNCYUIXa9NVID/wEr89HnUnu1rVNQYcVANIVZ3nsm0qa56xhGrJsY++pX8iVpuimOhnDZsqoyhPrNzAcVKUpX/qim+Mme16R7EUt84BJCUR2g1mLWNKRDBkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQDy2Cur; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQDy2Cur"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24456ebed7bso9350415ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961243; x=1757566043; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVC36WXuz5x1uegL05XJgfKX8Djs0fungha3CnK4B2U=;
        b=UQDy2CurJRIuC/BfgbMsTPDSNPm+a+M/I7UGvkiUnEdjlfCHKJawlKpe5xfA8+MqnG
         D61W9YqRlTJ+2//AasB8Rc3538uIzla6whNgKdHazf7n+WIqYO1OLzb8IxpbuEZgNm77
         2BLpT7eF45RudbJ0QMslNLNN+R3N1ACWfoWtQGuJypm+8YONbkrT0CIDQI2W3jyR7Egk
         +1KP42/B8QJtmAy7k1+F3gPJ17LF2hl0LSOBpT0ZsiwnlAk6ICj/a9QlaXK5DvwSgT0X
         aPis8M4nMgampNBqss4RI7HYYsLS5VsuHmxDKHj256FXJEhDbAUz0uO9EjYD21e5Ikft
         ZPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961243; x=1757566043;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVC36WXuz5x1uegL05XJgfKX8Djs0fungha3CnK4B2U=;
        b=QwpLR7ELs2X6H2BurRh1J9mERX5QKnYGC3dFVUzmS4U26VX6MpRQvDsY7dZoHx3+6S
         zFUG728AAMYNSvBD/4J035ia1sWBpiXqCqhphesz7BhW7yuR11GKQUKo4+dnGK1MAD7Q
         PhwNjU5oKbjOr6Bp4jkNnRstBjaC+Y64bIVrL2yNoNOvdcovMH60Z1U8L/tgrszPCM9Y
         vkF6lprqpDKD1xoAmQ1956bbFcXBw2p7S0YnOkSCSS5z+aYeuISO3w76n7I+wsrDC/EP
         xq4lxRvffnxWOGE1+K4lf8x3aqqfWqnnGua23hvAaWLPgD8q95nvquQ/dojCToyVx5tP
         nv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFoPPW36Wz4FYLuZvo6B07Lxh33JwsAG40DxyWbXrVXYjYi10eWz59PG28bHWOF5MD3bjp6CpoaINiQGyad64b@vger.kernel.org
X-Gm-Message-State: AOJu0YyK84RGsKh2YsK5uQuDfICdvO2vM4229Uwm1+BpOn3+I9lhKlXv
	bXoLjKERmRZGGlLkofzqsqBvWNbic9QsjIMlq88aLWEXw8jxA3QrdyRi3vBCCbDkiLD5pXxwV4m
	b2/duZmn/rQ==
X-Google-Smtp-Source: AGHT+IEWpTo6R6F5xNv8E2FSFVaz9D3lER1KgG8Sj9jbaMMlUKwpr1OXoalmoMzFPjtamkej/hn6F80lbWjo
X-Received: from plrr1.prod.google.com ([2002:a17:902:c601:b0:248:882d:5788])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18c1:b0:24b:1b5f:1c0a
 with SMTP id d9443c01a7336-24b1b5f1f2cmr59640035ad.21.1756961243179; Wed, 03
 Sep 2025 21:47:23 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:44 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-14-irogers@google.com>
Subject: [PATCH v6 13/22] perf jevents: Add context switch metrics for Intel
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
index ba3983920fb3..4f8dc054ad98 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+  cs = Event("context\\-switches")
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
2.51.0.338.gd7d06c2dae-goog

