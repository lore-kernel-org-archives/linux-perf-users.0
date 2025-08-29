Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B723C507
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440704; cv=none; b=Tvi7WscB00CuWOzpDp4XuO1e3qpHjUwmVJepj4X/gvMgrX3LS1j1SWEE3LzKU33laMdQQ9MwTj/C0MzS590zT5Nhs1g0mEGQygE25j1YZmLZArFoq9KRBRbBxO7d2XUzjGuX+FmpyJqsgc7mLdlfN+oPnr/kIG/qaQdDS73THrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440704; c=relaxed/simple;
	bh=I5+OKq7qSksLoa9NxJiPDaTGBoDHLGP1QKRZKrM7N08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OHWNCNjyIu2in4+lXKEnPxWUl9vsD1U6OxmSkNbTPoC/THvFTdf9y22y0erY1LJx0ge3M7glJVgGea7wAg1mRdEXTVJO2uCpnwG+VlQVABoQ5Bhfem/rHN1m4kgmcr4BQPcLDJLNjiLl54dvEu8fmVEMnFpAKuMgIaoHAankTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NasL4Fuv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NasL4Fuv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458274406so32005755ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440702; x=1757045502; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQzzxVRb28+WKh4KU7BgWk34NSL03IvXJbHJ+fplBFM=;
        b=NasL4Fuv4W2uibJBIHFxSEHZkCjhmdqnyMEw+veUvS4a/1GaNldE+5dMFLRmsXfmCr
         vOsScAMVt74LMc9tgAn4dUMIoYuVPHM16GEFD73eilwG2KP8APfq1llxbL8WbdQX+UB1
         sqcijUea6mLgeq7zsH9DQQw36xLGugNm37sxURATA61l1DR9Uh2fOhtm9liSyH1e/z1Y
         Fxn0QVmvM86z6vT12soWOx/osVEyQgiZyfOal10jco58AtHVLIXexTnU+cMOtdt8h29M
         vz9CxcUgUc+TSmZcGkKA6LLaTC4UMmvSy4c+2ykdSzk44HcscHPDAQl/adjbf46oBFlh
         qdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440702; x=1757045502;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQzzxVRb28+WKh4KU7BgWk34NSL03IvXJbHJ+fplBFM=;
        b=Yj+miYGEHcvRUmklPvMPn5NeYDXamYhRBD1aO66REFtSPo9Mwl/Ml1q6v27bObGNOv
         d2u2po6vQOogkH54xi7Ar4Ztt03KlvIIGgT6IrDL8UJe1dV1KgF5nsgCYC6CDOeOlr/P
         yZvV2R1hfuJFdsY6khMU4SFORlmF2nS7BLPFiyiH5BchaQEgzixp4PJuFN+52Fv3nfU/
         FYM2Omw9evnePkpQfySR9pPq4RpIQ/EquS1q0d+nhDDPQdDjOEm8lUTfG+tCkC+XJfvS
         qUxfufh+o9NcYHTQMRCawvL6qajXDBVWez+IkIwvTahfwqnCMt5zCBUyCaCUAjAVYDGI
         q0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBUxYafv/a7msn1cvC+epKfIIeswBHNtCmXAFJquQ9ROYukAXXB4AKGa33LMdKl+50X1WYsLcnEaOhSIo+yrZe@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3FjeZDanTiqtFCtq8V5o8mxAwf0z1vP2bsynIstc96Fjp3EF
	nuX4DGL3C08W32kOblpgfNl5ZFAFpoHVS6rfSW7SX1np4fEtsidk33V/QlZKq9ajJHXgrRKQtoP
	ZUUcF6jTj7g==
X-Google-Smtp-Source: AGHT+IGo665Ew+lDhjsYx4+ikVjCW3asVY4ETWxT3+Qseq7vels4sVkpbO2ooqh/IMHXavmdP8kgSA0KOmA1
X-Received: from plmd12.prod.google.com ([2002:a17:903:ecc:b0:248:c91f:34f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e945:b0:246:b157:5e01
 with SMTP id d9443c01a7336-246b157697dmr224023085ad.61.1756440702262; Thu, 28
 Aug 2025 21:11:42 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:48 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-8-irogers@google.com>
Subject: [PATCH v5 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index a353e682df96..53b9606ef1a2 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -124,6 +124,143 @@ def Tsx() -> Optional[MetricGroup]:
   ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+  ins = Event("instructions")
+
+  def Total() -> MetricGroup:
+    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                     "BR_INST_RETIRED.MISPRED",
+                     "BR_MISP_EXEC.ANY")
+    br_clr = None
+    try:
+      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+    except:
+      pass
+
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_all, br_all)
+    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
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
+               "The number of resync branches per second.", clr_r, "req/s"
+               ) if clr_r else None
+    ])
+
+  def Taken() -> MetricGroup:
+    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_tk = None
+    try:
+      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                      "BR_MISP_RETIRED.TAKEN_JCC",
+                      "BR_INST_RETIRED.MISPRED_TAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+    return MetricGroup("lpm_br_taken", [
+        Metric("lpm_br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%") if misp_r else None,
+        Metric(
+            "lpm_br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    try:
+      br_cond = Event("BR_INST_RETIRED.COND",
+                      "BR_INST_RETIRED.CONDITIONAL",
+                      "BR_INST_RETIRED.TAKEN_JCC")
+      br_m_cond = Event("BR_MISP_RETIRED.COND",
+                        "BR_MISP_RETIRED.CONDITIONAL",
+                        "BR_MISP_RETIRED.TAKEN_JCC")
+    except:
+      return None
+
+    br_cond_nt = None
+    br_m_cond_nt = None
+    try:
+      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_cond, interval_sec)
+    ins_r = d_ratio(ins, br_cond)
+    misp_r = d_ratio(br_m_cond, br_cond)
+    taken_metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+        Metric("lpm_br_cond_mispred",
+               "Retired conditional branch instructions mispredicted as a "
+               "percentage of all conditional branches.", misp_r, "100%"),
+    ]
+    if not br_m_cond_nt:
+      return MetricGroup("lpm_br_cond", taken_metrics)
+
+    br_r = d_ratio(br_cond_nt, interval_sec)
+    ins_r = d_ratio(ins, br_cond_nt)
+    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+    not_taken_metrics = [
+        Metric("lpm_br_cond_retired", "Retired conditional not taken branch instructions.",
+               br_r, "insn/s"),
+        Metric("lpm_br_cond_insn_between_branches",
+               "The number of instructions divided by the number of not taken conditional "
+               "branches.", ins_r, "insn"),
+        Metric("lpm_br_cond_mispred",
+               "Retired not taken conditional branch instructions mispredicted as a "
+               "percentage of all not taken conditional branches.", misp_r, "100%"),
+    ]
+    return MetricGroup("lpm_br_cond", [
+        MetricGroup("lpm_br_cond_nt", not_taken_metrics),
+        MetricGroup("lpm_br_cond_tkn", taken_metrics),
+    ])
+
+  def Far() -> Optional[MetricGroup]:
+    try:
+      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+    except:
+      return None
+
+    br_r = d_ratio(br_far, interval_sec)
+    ins_r = d_ratio(ins, br_far)
+    return MetricGroup("lpm_br_far", [
+        Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "lpm_br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def main() -> None:
   global _args
 
@@ -151,6 +288,7 @@ def main() -> None:
       Rapl(),
       Smi(),
       Tsx(),
+      IntelBr(),
   ])
 
 
-- 
2.51.0.318.gd7df087d1a-goog

