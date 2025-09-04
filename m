Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A673242D8B
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960863; cv=none; b=niSR9hLtAA3Qfxf4yNZ7Hp16heZnVdgz/4tZdVE+1ykY8KQU2uujnMLJsAnoKVh9JWtkseGeiq2EnnE6CCvys++yUsn+8nCKpfk/gf3tK6tZtJZVxRsNHcYzQAFwRkUvpF5OVoctRv+PM60p/nk90JrFFmDr/vsaQofV3LORMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960863; c=relaxed/simple;
	bh=zFr2nv8Fjk7rbcGASXYLjtJ1UiE5sdbl2aNgdo4hZHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qWcd7AQScjWz6Sh105JzWv4HPib6AecPqZ52uzrF6cI1ZP1JXLuseyIIljk8jkY9IRwJWDxid2NgHLxuwz8aS6+sySSu8TP8iHxKojQJBTlRu14q30oijb69+YEmXM/1nKFktFOeeYezRm6oxk6LTZduHGf0KTa9HmBtyn9JW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX1JkK9s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX1JkK9s"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806b18aso7785745ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960861; x=1757565661; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYpM7OWOMOGPeNU7BYv2IHUucBkQkI8jFRR3km1uhhc=;
        b=aX1JkK9sKW8q2Gj9bHbuMv1VHyXxEiNAXt100TzO6YyT1+VLo3AINa7hRzPAokdAXI
         qCwccOdq6ZodAAjOv4qITQOJSao+CIFnbi7h9ddjkfwospVHVbpiDpEt9l9EsIr5Htak
         rB/U8qcBE1ZrZZj7+TgOgM5RnK6xGSueBRDSftw2tZ9JI4ZuYI9jGhieieXTneKzeWjV
         gmH8hN63JVG7LdHKZQn5TcDxVT/1GrAq41izpUAyg0UbzV17DLJRe8V/9DBj+9N3HtHr
         6u38vKrHIuEaXF4/uT5uX360DXvZH46zjRtzp5XvWbAJLBAK8icPXTkSyZMwnv1SsIsB
         fnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960861; x=1757565661;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYpM7OWOMOGPeNU7BYv2IHUucBkQkI8jFRR3km1uhhc=;
        b=TOXxehfulIQEbXB+9iuavusmNPRY7dALclH4PETnk+PtQtOQIkD3lVWuECO7gJFzkp
         +6nPhz6BVvY72kvQQZ8mX9ovYJwRCqh8pYNnncvoqFnP3Wag7+DXuL8wvQb5jYP4FXby
         +oEgI1bq+0ha5sha+tgFHZy5aSTNy1ERbN/luXSRjh+kCqG/Gw6f0seRqcp9yLjVMXmJ
         hNQ8R/gx1wk05tWOecUHz1/F1hFr13vo6NVhYzxVRhBg8l/NRLzPQxFEP/WAnCOKVP8F
         VVU70hCeAYYY1rd6CyfnljAazgCZxnedDSDW3k/z37vG5FZOOiJ8FqG53HXsOMf8bQ5u
         11uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiXxl/wJo7ShqUWjQ/V4JcYeYFhFej7Ns7oxwHSsMZRmDDoGa2Y7ZMSCyDSeRSavAx27qniK5GOr9qs6VI/gVS@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAnb3fbCXOx0JnUV74HZoJ/HSO14KAlnXzLuUcZUNt3SB2kGR
	frJp+QW5KYA6tB5Qs6ZEN20yskE1ChP8w3GapzALYYnF8ZWXFFkce5bXdWjkMroeImhm95OLsCE
	i/tsuLhydow==
X-Google-Smtp-Source: AGHT+IEg30WeiXtbcVMDc4xcYSGDip751yv48h0kgG/NoL7v1KxogxWrlbpcwkXo+GZ9IQF+LGVLOUNaFj0Z
X-Received: from plhz7.prod.google.com ([2002:a17:902:d9c7:b0:24c:af07:f077])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce07:b0:24c:7b94:2f87
 with SMTP id d9443c01a7336-24c7b943278mr87297645ad.14.1756960861423; Wed, 03
 Sep 2025 21:41:01 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:38 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-5-irogers@google.com>
Subject: [PATCH v6 04/13] perf jevents: Add br metric group for branch
 statistics on AMD
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f734f1127ff3..172f04b38d78 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,15 +7,119 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 _zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
 cycles = Event("cycles")
 # Number of CPU cycles scaled for SMT.
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
+def AmdBr():
+  def Total() -> MetricGroup:
+    br = Event("ex_ret_brn")
+    br_m_all = Event("ex_ret_brn_misp")
+    br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch", "ex_ret_brn_resync")
+
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_all, br)
+    clr_r = d_ratio(br_clr, interval_sec)
+
+    return MetricGroup("lpm_br_total", [
+        Metric("lpm_br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "lpm_br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("lpm_br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("lpm_br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s")
+    ])
+
+  def Taken() -> MetricGroup:
+    br = Event("ex_ret_brn_tkn")
+    br_m_tk = Event("ex_ret_brn_tkn_misp")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_tk, br)
+    return MetricGroup("lpm_br_taken", [
+        Metric("lpm_br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%"),
+        Metric(
+            "lpm_br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    global _zen_model
+    br = Event("ex_ret_cond")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+
+    metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+    ]
+    if _zen_model == 2:
+      br_m_cond = Event("ex_ret_cond_misp")
+      misp_r = d_ratio(br_m_cond, br)
+      metrics += [
+          Metric("lpm_br_cond_mispred",
+                 "Retired conditional branch instructions mispredicted as a "
+                 "percentage of all conditional branches.", misp_r, "100%"),
+      ]
+
+    return MetricGroup("lpm_br_cond", metrics)
+
+  def Fused() -> MetricGroup:
+    br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("lpm_br_cond", [
+        Metric("lpm_br_fused_retired",
+               "Retired fused branch instructions per second.", br_r, "insn/s"),
+        Metric(
+            "lpm_br_fused_insn_between_branches",
+            "The number of instructions divided by the number of fused "
+            "branches.", ins_r, "insn"),
+    ])
+
+  def Far() -> MetricGroup:
+    br = Event("ex_ret_brn_far")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("lpm_br_far", [
+        Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -78,6 +182,7 @@ def main() -> None:
   _zen_model = int(_args.model[6:])
 
   all_metrics = MetricGroup("", [
+      AmdBr(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.338.gd7d06c2dae-goog

