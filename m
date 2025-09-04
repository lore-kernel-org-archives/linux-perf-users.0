Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E525291B
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960869; cv=none; b=qewFa3BWTr78Y7XZe3LOMZL1b7BkmB16W/4/ZI3eLMICuw3MbjNFF+iMj4sviwxyAVeRQWgH49Et6uvWQ0HL6mqhx90OEDMqojEXfiOpTjA+HIF0LCgZBrC0SNdTIJW2nAwDJL6jxjvoRspHBYeJVwe3MvKAhWkf0oHucCh90Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960869; c=relaxed/simple;
	bh=n71EwqXEyxFzyBXTXHsi/GYekTFJItMlQdS/XUW3o58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=n6+5B43u33svTcoaa7D2zSORJuldA/55xxS5VFqjBSD0POUVQfju9D4+FjnCLfdos4p92r5PU/wKM6ssQD2yCPLoJ9dvmPYqpYHx6HKVaRUnsPwOWip/xuwCy2wQcGY4Hs99c5KZSIglxwalP9aJvKWwZPDu0tMiwTnZpYjTYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4TG155OZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4TG155OZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso13616945ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960867; x=1757565667; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kECjm07dTbm03ElO9+d/ucpfxsbPWw5fbO2IeYKMCFA=;
        b=4TG155OZErEvaOZ5Aveo37jkixAeFX1ycaEd7f1KxabHs3RcWzKW+AtTC2YeGcmNjj
         jWsbAQwQ7exvAoeaMNZmb1PYBw/tT/xDJSYJEpeTZX8BrLaVWFWRp5L/FckKAuYvzNVI
         z6WBH0YxG8jMFfgHILDz4eYzXQW/dn4AZFhveaPwnCyhP/MSqdgHwYZrMPGcR4k2B0Fk
         4pPdHOpJkdDLrGV7wFYf1oXomdsBi/wfW407mRFjRnXPeaid8Mfux3w9hJnGGiaFZ8xl
         LGLDeb43dVV8xzAy4bGv4lrqzu4r+2H+A/8jBD7fq+l+llVnPiTz1A/bRnpIgdoIqdzd
         5IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960867; x=1757565667;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kECjm07dTbm03ElO9+d/ucpfxsbPWw5fbO2IeYKMCFA=;
        b=YUyxa1NUx3bdqHJ8ewg2vTTCnYLY90l63YVftz6tWTKQUju+ayk55HQjHBDYPpmW+v
         8VAIo8lZcNSWiNhpw6d0zmOOm/IPX0BFY9QLNHH5bkrxaG2RDLpv9JZ9ldv3cnc8z2h+
         PKbgg3yl1AyE6K8biQq7fz7fjZ57hlMKRetII6KyUis+PIlxiP5uyEXK6IlmSDZssN6z
         0eoSlPPsKwdDFsG6PWKOtbgWEBHtbYm6/qAg/RHAh1/TfNeTUu3vvxRxJWQucRrDFfLl
         VAndVf5GHqWBUkLvWDg2wjUpaAeK8ndv859fR8ZHmbK8bChT/7BiW138xZ0E9kKHyrO2
         9LVg==
X-Forwarded-Encrypted: i=1; AJvYcCUnYUfw19c73U7mqQ/gI2l/YqWR4GYVHQj6LlE1ftBvmvpuPGo5zqCZ75N9iimXtMPvA33qXxkecz5ciXR27N88@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8yNT6M+FVWwjLIDpljb6TP002EU2i0u9fTZOSaLZNP/KRWAK
	8G3Uf7RTOkAKMz5LgLRr+b8QlvvzLNCpD5059W2EvqIY/KBqtCSSN+NTXTq/9Uj0YF3OLjzalfM
	94O+QJbzkZQ==
X-Google-Smtp-Source: AGHT+IFRopwXzAbURDRcPYjPfS0BiDYtMflnHslLrKj7Zz1CgEaLsiEdNlyW7xbQjYbywcT5oVy09XaBF3Dd
X-Received: from pjbdy4.prod.google.com ([2002:a17:90b:6c4:b0:32b:8466:a680])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4e:b0:24a:979e:c06a
 with SMTP id d9443c01a7336-24a979ec489mr204013015ad.60.1756960866863; Wed, 03
 Sep 2025 21:41:06 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:41 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-8-irogers@google.com>
Subject: [PATCH v6 07/13] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cecc0a706558..40128903eb7d 100755
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
+    itlb_l1_mg = MetricGroup("lpm_itlb_l1", [
+        Metric("lpm_itlb_l1_hits",
+               "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1h, l1h + l1m), "100%"),
+        Metric("lpm_itlb_l1_miss",
+               "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1m, l1h + l1m), "100%"),
+        Metric("lpm_itlb_l1_reqs",
+               "The number of 32B fetch windows transferred from IC pipe to DE "
+               "instruction decoder per second.", d_ratio(l1r, interval_sec),
+               "windows/sec"),
+    ])
+
+  return MetricGroup("lpm_itlb", [
+      MetricGroup("lpm_itlb_ov", [
+          Metric("lpm_itlb_ov_insn_bt_l1_miss",
+                 "Number of instructions between l1 misses", d_ratio(
+                     ins, l1m), "insns"),
+          Metric("lpm_itlb_ov_insn_bt_l2_miss",
+                 "Number of instructions between l2 misses", d_ratio(
+                     ins, l2m), "insns"),
+      ]),
+      itlb_l1_mg,
+      MetricGroup("lpm_itlb_l2", [
+          Metric("lpm_itlb_l2_hits",
+                 "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2h, l2r), "100%"),
+          Metric("lpm_itlb_l2_miss",
+                 "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2m, l2r), "100%"),
+          Metric("lpm_itlb_l2_reqs", "ITLB accesses per second.",
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
2.51.0.338.gd7d06c2dae-goog

