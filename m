Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF023ABA9
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438322; cv=none; b=s5QZYVbX2yKwoS5wM29NURq+DoXcQlYmkv0HOeUIjKLXEVQvjdR0w7oM9LAeL4yNjYWwnU0R/QYRFYxy5R3rbTSnN91svYkWe91ZpWiB2nQ9MOW60nu7ZRmdbi4R9X132Ea6XYyNVWQ3/bAWHp+KyuD1Ngh0br3MlMtftozd4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438322; c=relaxed/simple;
	bh=lwmduiXMPylmx2p4goBcEcl5mo4b7khmf4uz1YB5Rns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iHqCoTou2Plrxkzb+mpaVBHjIs2OpXwwG7/bra6e6IVpckGAgFmTdBALHzMCbkGHo9VfpMdG6uGHrH5sm3udo3rR39TRHzLLJ2x3u/IU2XDyjUP7s1uUWK9D6PpF0Vw/0wehS5zRU/ev8ykNti/jNtCZybNMXU/hp2rLfP3Yu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSSg8bn3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSSg8bn3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3259ff53c2eso2360381a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438320; x=1757043120; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5JolLGg61q6SOmr3cF75+JHWqY5QYSUqQxMmL2WnA4=;
        b=rSSg8bn3yD5zkeZBOK4orqcLex5QuabU5pRXes0p9iZCguWuLCoy1IeGwraTgw2t+C
         qIks37I/1B7rGxZpOikCZlhrTHZ+kkaJz6J9zuDY8/ILyPEnRKvN8DME7sbcfw8htznZ
         MwQV8wzJaRIUazvkn5CtXED0mkrp1dXOGaNgSC1UkA9mBI0Dw2QTe99DaDx/dhg86IKZ
         fWtXP6ELqoBd9bCiRmuRRAIBz0QiklrPNPIf+SsyJeaRcJ3SWzV/cDdwmOO5wWCbP3fC
         PKW3/RDkcmk9T5JvuZpkPIAc1wvAY2LsnSHVOZ/Nfw7FYurxgfJm0WvgRTSy6dWfCluo
         CjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438320; x=1757043120;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5JolLGg61q6SOmr3cF75+JHWqY5QYSUqQxMmL2WnA4=;
        b=KrFXTC5YtjwayS/p0Fn1RhPpyi+eZdp21I8HzDvOvIeFedSCKqb2YQkgt25b2PEhA+
         0I34AhWyEswnfBUUnPfhLsrC/sVGcm9mNIjLlivY0yBNY8+tz/yqAXqmfKILe4t63drM
         1WzLxjLFVW7zWsaH35RAMF1nhkhYLxAbrhnAuqyhTNomSnCtc1rokojVxGrWOalYcE7h
         iCRwNbU9zy9Zv0zCElBY684Fe4ZT6rOCM9XsB/Ik0hKqNQba8UFPIyGg40miPPSe6uEk
         Qfh5elMrtkCAxoeKl3lBzzrfKCXCjJyIZvyq6BPoAV3CaCn0n9XyrG/N6UDDksJahTft
         1lTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnmvmiIwERw7jTz0yU33vpfMqQc/4Uxir0RRmIB6iAbjwQsVTwDH5BWLZtDAzclKjDCEwPEk0e32YZ/Bi2QZs4@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHqKW6Dfk2We6mJ+geD5OaEVX8KnTQulsk95VRJEiSIId6nYL
	z1V4lJ652FHngZZFYodFUfM7pZo5NGvuwUspGNDqn+Qtp6zWS92Nb0UKnSzchNL6Wz5OqDv4UxZ
	W/5kR5wWRIg==
X-Google-Smtp-Source: AGHT+IEHgqCd5KefCLHmp4SgJFYGz0bXyVdzvcwuFaVTzyXAsyS2sBq8Bx5rhu9Y9X2TldXIiKNNHzQrZGfa
X-Received: from plbmo11.prod.google.com ([2002:a17:903:a8b:b0:23f:cd4f:c45d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:943:b0:242:fb32:a51b
 with SMTP id d9443c01a7336-2462ee5b26fmr370011825ad.19.1756438319879; Thu, 28
 Aug 2025 20:31:59 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:32 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-8-irogers@google.com>
Subject: [PATCH v5 07/13] perf jevents: Add itlb metric group for AMD
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
index 98dfd5e9bd2f..8f7265a732e3 100755
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
2.51.0.318.gd7df087d1a-goog

