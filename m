Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910933A1CD
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165761; cv=none; b=NQeHxV6zTMJK6Wf4XDPIMINsTQeiJnyxsDqOtvhubLw2sczM/uuLqEdrRGFKrZ5U5J8AD8qraibbZnCIgz3duN25vxUkoHS+sRedsDuOXdchO8Q8qncqmEOGlGjSFen5CWVfxh1O63uKCG4i34j6fc50MIIJg95Da6Kp6trsmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165761; c=relaxed/simple;
	bh=Ttu1a53AKHn6jERMdPOWyCk47DSzrYVS6BszAMd1Sa0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=akr8b/TI8nLOoOs3YNn4e0S8zBaK4DP4YvWRPkEthA2qwzV6S2Mi5PIqhveN81sERhpbeHO2/Vt7kjVQtrJd2ogmX4SJxvu9FMvQaAGe68IvJiJ769e8E+kvC1RuuZBou5dGwLxmYbQRA9CKKFRLN3zdg+SU52soOqT1V7D/TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lioECYG4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lioECYG4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608d6ffc64eso5239387b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165759; x=1709770559; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=lioECYG45CGgEL39o9YCUX3yfw0g786m17svPDv+ee9ph8Uc6BIALvCO8gPAnXvxvb
         Y1cxl2T+y8aEG6uHjYnTwSxGIvg1BJ6XS50rTLdBgwcf9loE6HdC7CupVXxxsts/Yfli
         XNfnsQkR3gwtHKl4c1IzZrdSPZxugVD73Mhf3F5BVzme4Lr/BBx9A5YzRIMV9VsWT0Vv
         bgv/zJEq4T3SphnZOhndqhX2LJ92cHNOUiwMuB80pk4R1Ll72nZRJtGhy6SvPFPx66Oh
         ywd4Q1VC0X+ZvbvIb1HZN8uNYbTrxEsOfyn5zyNPBMYIpFLlvQFUuBtdPlnksp+iv1hc
         rCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165759; x=1709770559;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qpQTOjMlbYqRHWOkfWf3rXeImb6hJen/IuHxVmpGuM=;
        b=Dq1M7wFLxMdnxKZ477JvPfeyk5CBM5Z5AF0WPHZa5569rPFkxTenbHQbPGoz1Ds3q9
         DaxgRYPbUOQl977vTSytLOA1UEMP2hUKaHtktLemXmEOQZxecYdbauEIf7VCfwo+EJuk
         esTAUzyF7K0MtlRI8Fm4YTakHD71FLuZoZQmQSUfiU0SlNFdetJMVVs4Oeplra/MvJnu
         TFSF0G5HELLE/loEncyFlqTWGqMxSwjXnnvZr69/ACsy5vUysDoKhv8ySEIx7OeoV/5K
         Ff81l2u6JNxo5WJO/b7NxH6/n5xUhu4ALiPAJiHZ9A+xLLxMEyM+5e6sDDcSjjHJvaxg
         7ZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ASKav1UeMsmTWStE9+2Rm16RokXc1zqbKqFPkWvhgx8djdxP+fhbFC9RJO2THWZWh53oON4pc0K5CfuPqr7nsCzlSC9bqaELQx4mVUDt+A==
X-Gm-Message-State: AOJu0YwtRvzhknnNdQ7sBZTxxbwWnZ8u4cJzSRVt6mnM32pt2CLRA5in
	aWTRFiEwkTdGBK4y4O/GlapJgV1jF+xQW0Cu3kLdr5jt8P7nQxn8jroKYFthIvEoFdjwMA+RcbK
	CCvy9mg==
X-Google-Smtp-Source: AGHT+IEQk8XrTF3o9KmATG2La436/npe6N6T11SFnq9O/054bk+ykhydARer42z3Y9hwMbnlb1yNe4pDE41X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:360a:b0:609:6150:da22 with SMTP
 id ft10-20020a05690c360a00b006096150da22mr77628ywb.1.1709165758889; Wed, 28
 Feb 2024 16:15:58 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:31 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 07/13] perf jevents: Add itlb metric group for AMD
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

