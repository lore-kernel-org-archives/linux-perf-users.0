Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD03C464
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318885; cv=none; b=VOfQt1YzKYYPIOZgIIKEVFjMHReJKlGdxBJbXZh4oQKr8iNqNKuwr1RDVAgahtFQDmURDTBChc02K/ILixav8yvsX5/CNluZ+xsCVGijuIiNEYqrPSB4trOwZXbIau7Cb5IhBnoGb65qeYCY45N+O21Ch629TS0WGtIi3Gm38XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318885; c=relaxed/simple;
	bh=Ttu1a53AKHn6jERMdPOWyCk47DSzrYVS6BszAMd1Sa0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QumkMjTJJBC0BHoFW12StUI4TDoQ/NdXKBE0zImk2+PPCV/G+RPESqh6t7XoHngpywkCOWaMsdHQ2RziOcyK8FIknHzQGiz1UUeO6FXICjE4pPT/R/l/ETdTGd4G/AIJL+G7/y2DiLeASRsPk2YoTBBRx4qTG3jZUxdy9rKzRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQWq69kw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQWq69kw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so4654339276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318882; x=1709923682; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=wQWq69kwH3Rxc5XR4IZg6z7sSYSQ+gwrT9+lWcLDFtaT3J0HFpU5lOzMQiRyOGrNWr
         SijFzn+D5oWQOnr/MzG2YI6/vJ5H9zuKV0/8Ktxbpc7bCznfq53NydHiQbdcJgOkgvHC
         Bk1pDH7aqDRvrGNFt7pnC17sTbxbQ684n4NSQ4E1ZjpK4e36Z2Q/MyEDgB0L2UlsIU1a
         PnY6hAl00clcfh0D1J65ckUo5VaIeamURn6IkdZPy4DD6LZOIUm9PjXHtW7YzYPYNyCl
         TfI600VoxtXz2UlSYsTfNrqed9rB1nAYIYpN4vU+sZn/EVUrffNu2yLY6mX8HBeraMpT
         P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318882; x=1709923682;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=Ms5MFyw13+66jI9rfLpqKh8zDARttUaXkfRT13u1gk9Xx4fDJY3/naUSzfsZyimmX9
         qUAzBgRVM33sO/dPYawG8rOjMagZhrGJPUyVmLJjlB4cJ2lEHhxQRLWN3rA20NyV1I5e
         AEQJQ5Tr40JVX4xNuO1+0iT9ntlCpzJ+vZMZHuUkQikHRt9OJD9M7aXiFkBeMX1sHZVK
         eljCXz4zcb47KaVX5Z1KBSZ6//TeIF34Lj8PLnnNYlyrOxc3ekf8S48jpxj7cR/pOgu6
         s/63v0+F7eAKP2Sv6k1dtBgXMUk53ffMQf6DLVzwUgnyugcvOUJgvLlkjR9fTAKi8Di0
         ny/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9PfeWqalhH/5VzwHTt/2o/MdMDSgy4J9v/c4fXTOpiMSWcfKfD5g+iR/xbjZQeTbr6dodldSIcyDFQwL0q0e6iRRcDroI7PdJf8+XX2zc+A==
X-Gm-Message-State: AOJu0YxYuVpxEEfkrySnCaY6Sy0zyfVHmJFm1fVpOQyyYgQQjpvC47L6
	pMvv5nMf9wTgRdsLMl5vB6Ocaz37bq4MaCl9EozCR+FlBb7eI4gUDBEgxjpjAeyU6PuAlkmoBGU
	izC++qw==
X-Google-Smtp-Source: AGHT+IHyhUpYurt4vD+rrB/joKVLTsWMuBKF3q9/HAOBpTvjJTE86OHEg3O7FWiNyP92JukvKjLFOJ2CMZAZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:f0b:b0:dc9:5ef8:2b2d with SMTP id
 et11-20020a0569020f0b00b00dc95ef82b2dmr530873ybb.4.1709318882598; Fri, 01 Mar
 2024 10:48:02 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:32 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/12] perf jevents: Add itlb metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index dda904998269..82aab39c2a50 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,52 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+  l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+  l2m = Event("l2_itlb_misses")
+  l2r = l2h + l2m
+
+  itlb_l1_mg = None
+  l1m = l2r
+  if zen_model <= 3:
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
   if zen_model <= 1:
@@ -316,6 +362,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdItlb(),
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog

