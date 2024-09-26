Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700917C9A9
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372488; cv=none; b=JitygCL3bVoJBPdD+zj0GQAs6OBdl9OZod2jJ7F6ZGMVs86x6k/RQFsptAmzzxPg9XoUp1St2XPjMXcZ93yQvCL0MjgiqeNaapPx/95wiCNo4MnsqxNDliSx3miPReoL/Eug22Epag9aAsp2wDVsvlJwJHJRt5bT2Ry8qghuxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372488; c=relaxed/simple;
	bh=rg5ezyJFAkzWSfg08Rvh2gEDG9pTNmzJKazVnGte+rg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LW43FGXpeg1yLt/rSTUzyx7MlBsQUhoTVjNXAshOgFlOTV79HrvM1sL1yHakFEjHsBEGRro/KRpwfjw1mucr267GzUX+H+PvkfCIHSabkKZ5kW0SqtfJRQhoYfaRPSh179ajTr37PwWNFjsfTzdDXa9NSUgy8rUAVpZs8Xr/V2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXbXm81M; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXbXm81M"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so2083834276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372485; x=1727977285; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBQh7q9Q+heMUpRTaOshWJy6/kGxiS0tpmcGA4ieOPA=;
        b=jXbXm81MnvqlbH5D0MqXkn1OSjOA+vjkuL0B80SwL6QJ6/iW9PpNtM2lcNi99Lf0RW
         VFMrdx2VFISDccHCDG/GgLrSX97I89UHU0GVTqoIlCJ9UQpRxEx9W1vNJyIm9VEMfRlX
         ErxmtA/w5JCERBhIr8v1scW8OxIBSTw0arLM+qGAhJ+5U9GYzT8D3mz1Hqq/SLW59C6r
         sao5SfeRQ4O73cbARpUBUsB+K581FDlmD5MRsLEmTJo6hVb3B+TuZN/PK21kxllSC7yB
         GFptrqulczwOf9kyUeP9YfzKt6Y9qAD18ltLlCKyd70THM4tbXI92m58mMj7UNY+w+W0
         jR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372485; x=1727977285;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBQh7q9Q+heMUpRTaOshWJy6/kGxiS0tpmcGA4ieOPA=;
        b=uJrtPFRzIAYbpcA5VthTid89RTOSNrcHv29nkJeFUIR4yJmVNamMWBnq6dPTyb+GK3
         SqZ0ReHNh/hijkEn6lAEXowCQMCGb4+uFp7ftFd4Al1a3g6cCSMGcyhw0oXPjSzAUvta
         tT/Mo5/RXehCB296X8n1vo4ahpMWvv42VNM/G6i3j80eEwJ+WPU8swigNTXth2vTXjiz
         zT7e4Rle8zZKThyCfF3PAwHL68C7P59WpRbiBCYr53TZCFYkqYj5w3teY8eHka4/b5R4
         CzAF4zFASFBulO3O0r0ckaXe6s3YhkeRuyhRYwilP4YfE6UsCTbWt0CqPFbA+siRvmxu
         O9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXnIOEYXPkpSHsmDtg4hYDcZY+XZ9OFOSK+udeZ9jOYwferOTuvP7fdjRHSpjatEt9LRnfk07Lo/zMcTNaugo3m@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMfjlP8usqbFW1otGp+SKLC39CATd8J/qwakx2chLIGPAZO5t
	AxMIDqylyszntxOFEmfNDLZnWZFwnkJ411HfYSCIWiIGGW6kCIzlgkwskwRZsUrwsTAldepmMkP
	e63aKwA==
X-Google-Smtp-Source: AGHT+IF45sRhr+HI6eb9XpqRYzCOztX22OF2yIyFzPgu5lw+7WK6t0TbOn0jypLhY4V9OlhLqrpc1lpOzaLy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:d045:0:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e2604b828c6mr125276.9.1727372484800; Thu, 26 Sep 2024 10:41:24
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:56 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 07/12] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2d1fc8411d61..bfed478f508b 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,53 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+  global _zen_model
+  l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+  l2m = Event("l2_itlb_misses")
+  l2r = l2h + l2m
+
+  itlb_l1_mg = None
+  l1m = l2r
+  if _zen_model <= 3:
+    l1r = Event("ic_fw32")
+    l1h = max(l1r - l1m, 0)
+    itlb_l1_mg = MetricGroup("itlb_l1", [
+        Metric("itlb_l1_hits",
+               "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1h, l1h + l1m), "100%"),
+        Metric("itlb_l1_miss",
+               "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1m, l1h + l1m), "100%"),
+        Metric("itlb_l1_reqs",
+               "The number of 32B fetch windows transferred from IC pipe to DE "
+               "instruction decoder per second.", d_ratio(l1r, interval_sec),
+               "windows/sec"),
+    ])
+
+  return MetricGroup("itlb", [
+      MetricGroup("itlb_ov", [
+          Metric("itlb_ov_insn_bt_l1_miss",
+                 "Number of instructions between l1 misses", d_ratio(
+                     ins, l1m), "insns"),
+          Metric("itlb_ov_insn_bt_l2_miss",
+                 "Number of instructions between l2 misses", d_ratio(
+                     ins, l2m), "insns"),
+      ]),
+      itlb_l1_mg,
+      MetricGroup("itlb_l2", [
+          Metric("itlb_l2_hits",
+                 "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2h, l2r), "100%"),
+          Metric("itlb_l2_miss",
+                 "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2m, l2r), "100%"),
+          Metric("itlb_l2_reqs", "ITLB accesses per second.",
+                 d_ratio(l2r, interval_sec), "accesses/sec"),
+      ]),
+  ], description="Instruction TLB breakdown")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -339,6 +386,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.46.1.824.gd892dcdcdd-goog

