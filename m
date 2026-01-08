Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFC32B990
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899503; cv=none; b=pLxC2tP/jTPYDVn0sNJew8PwJYdam4CkElUUpAJc751ANxCcmcTpQusKLjRhS1/u4jz4QzPAd1Vj6ha4Q1ZFoCLVBuUheTaFacGU2ZnrTYVFygb5Ah2fj1+ZWRpfR3DPCLwfNlQLkCJTK1G2vKNwCvByEbQUA4Xigxv67I72QQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899503; c=relaxed/simple;
	bh=y7FaKz7L3UAtslgu2x3jUq5vT+1dSABmFKBuMuNMePw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SKuQOwG7VEMrmcYvsbiho+DQgJtIFLf9Fwbnt1OzxjOLXxYWDL2tbABoPNDv8/MWOSyOxwohJ9qmm1VRX01fLHZdvOGy5nPc2BwkwTEQ5jaMbkUqmAIfYqCXS73lbdH05q+4wbfgVNaCh5X+1Tp/fhdGykp9XT/TbaTFjQTH0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUeNijPw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUeNijPw"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f4617e256so15688403c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899499; x=1768504299; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JKS6gPP28FO6KPHugmrB/ENZliUhA7YoQoCZ5CSB0Q=;
        b=OUeNijPwFTKWPfTUG7MSpWEzvflOOfwP37qn0vhKzHf3v/9qbqUQrqKpEqthFnkNzX
         AYmrQ/9nFXbWbp/60AdUdSeG/xTnBWoQikeIYit9rPQpSUG6/u+sO+z7oxBQK73IQG/T
         yNkE/2mTmJw9pjFKu/G1Ls9e3bY4oenLdR6N2U+GiiLEJcIkIDV7q9ZHBioQouGyfqqk
         GJLZYJtLTz/g0E3ZkKZF5uRZixYR4R0uMKd12rIjWibrVtsE4IV1RWhk6yD72grxWJso
         PgTyRX/8KfAONLAShN1tDx3RM/Ilqecm3hk3G75ms0Eid7cBR/mZqzWJyGw4OMsgw5+R
         xwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899499; x=1768504299;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JKS6gPP28FO6KPHugmrB/ENZliUhA7YoQoCZ5CSB0Q=;
        b=XDsSoDuN5qMSHFdDedi0VSf8ztmxij1WSfQAy2jjzkxp3xVV+6kKVZNlAX00+5Yb4h
         oFuWW4+/JaJ9MI8Gd6QFT/2yGo++UI6WIFqY+Ci54pP2IXCUWCvbd0VN6K9K5Er80UdH
         AC1Mr4L3sEu/gjHORrPCOacivQHM2QiQ7KEWAFRcXG/ui0hSL9wf+3Fmt0ri6iloe6hq
         8urL701AO77qByoCbLSmzr3axP0QB+ASQrqvBFvm/79+Q7CnH7tUomN/1J2slKMDDB9I
         4FXUI5NdLOmQUo5CUR9PSHy1efdvQpznBlp0BhQt4MO9qMzq3emVezDuQfSgntLoLCOh
         hR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcSS9i4tE/N+5Np+YPs0pyBK2m1BsGFUAzaG4j4IS4ZPHGJ4dpf9OKpOGm5QAOtOefs0RKKgO3+/k6D+PcXGmH@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpM5PXLfV2jCMASsDnU2xPbqeparo1X0LE7J5J27xPv9QkYRR
	eGuhbc6xEnanccT64WnMfhlBlAC160CWaGpyWU0052N7DM29McEiQWWLmmII6zQKBJ/6HIv6wD1
	KuxBnJjtcog==
X-Google-Smtp-Source: AGHT+IF9E17SQWbJuQ50ZHhye5/4q7/rhOcbfrEcIRzVHTzDoIZ8q0s+78FGD/28qUw2K73W43movJxHsXH3
X-Received: from dlbem4.prod.google.com ([2002:a05:7022:1004:b0:11f:330d:ed15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a5:b0:119:e569:f27a
 with SMTP id a92af1059eb24-121f8b5fe14mr6321881c88.35.1767899499231; Thu, 08
 Jan 2026 11:11:39 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:37 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-8-irogers@google.com>
Subject: [PATCH v10 07/35] perf jevents: Add itlb metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 38948f63cb52..8fb0b55074a2 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -122,6 +122,54 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+    global _zen_model
+    l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+    l2m = Event("l2_itlb_misses")
+    l2r = l2h + l2m
+
+    itlb_l1_mg = None
+    l1m = l2r
+    if _zen_model <= 3:
+        l1r = Event("ic_fw32")
+        l1h = max(l1r - l1m, 0)
+        itlb_l1_mg = MetricGroup("lpm_itlb_l1", [
+            Metric("lpm_itlb_l1_hits",
+                   "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1h, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_miss",
+                   "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+                   d_ratio(l1m, l1h + l1m), "100%"),
+            Metric("lpm_itlb_l1_reqs",
+                   "The number of 32B fetch windows transferred from IC pipe to DE "
+                   "instruction decoder per second.", d_ratio(
+                       l1r, interval_sec),
+                   "windows/sec"),
+        ])
+
+    return MetricGroup("lpm_itlb", [
+        MetricGroup("lpm_itlb_ov", [
+            Metric("lpm_itlb_ov_insn_bt_l1_miss",
+                   "Number of instructions between l1 misses", d_ratio(
+                       ins, l1m), "insns"),
+            Metric("lpm_itlb_ov_insn_bt_l2_miss",
+                   "Number of instructions between l2 misses", d_ratio(
+                       ins, l2m), "insns"),
+        ]),
+        itlb_l1_mg,
+        MetricGroup("lpm_itlb_l2", [
+            Metric("lpm_itlb_l2_hits",
+                   "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2h, l2r), "100%"),
+            Metric("lpm_itlb_l2_miss",
+                   "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                   d_ratio(l2m, l2r), "100%"),
+            Metric("lpm_itlb_l2_reqs", "ITLB accesses per second.",
+                   d_ratio(l2r, interval_sec), "accesses/sec"),
+        ]),
+    ], description="Instruction TLB breakdown")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -188,6 +236,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdItlb(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.457.g6b5491de43-goog

