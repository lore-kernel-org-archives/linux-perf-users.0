Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7125C6E2
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440723; cv=none; b=Cv8sBhPz4u+D8lhkNkn81P7NwmsMDL5Om/Lg2UwAAWLXG8sjWucN6XSh61Cs03QoK/sDYtw5Ce7Ebkv+m6zjFNATbGLYxLJr7BqmzX/Y+SG68x0lBkjyqhlTD1yzR/+l9fz8zZqJSJjC4l+Pw9RplbRPScIF+MUTxZci+IS9AIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440723; c=relaxed/simple;
	bh=K2TpTQA8GY3Yd80e1bmjkGeomITw8Ww5CSAf23qe2JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Itbnd39IFh+vXiA0m+DG5tWtiHedoGqRTx1kDQW9XSc0+N/V2Nmc/jO50HREQ6u82CHH9Fg7CYV+T7G/zcPJe+58TvsAM2dN5DzQkWQw37T2t1MQjH06bF2tVKeaI0IDFG70r448uAhU7z6g0LblnpuOF0KgR1RS9ECOYHmX23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsIE6Hl2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsIE6Hl2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24895637fe1so18847585ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440721; x=1757045521; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTPCvCoskLQ3ZZ1khwfyM6kRVB+5pf/yTpsT9eEs0Co=;
        b=XsIE6Hl2n0qXd2uxdAlEvCFm8+LW06I79DuzNv23YmrOsLcXM3bgu5phlPVj1WNz4T
         JuIsjmTY2UDE6oR/ACkgPPGSdFAzRWpDUtmohyk7rMDsq1KYUjy/8KlDbELS4w1wMdTO
         k3q6hlYh5G9zVOdaPUBW+o4TeBmQ8J6kFdwXRlK+/4f1eeacD6yJfZ6Nbk/gnMVMumnJ
         10WOXqu1tgo0uTYgRkatc/FVwTY9vESHOaB9tVAl0AhkT/3a4zhxfBPKSGluV/g+k5vE
         P/okQ3/hUpAD8dyoSz772VIKuVxBa8ygXOVnjTNOvpGlPoEsiCDcfYkWpQhDArgkCuD/
         kLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440721; x=1757045521;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTPCvCoskLQ3ZZ1khwfyM6kRVB+5pf/yTpsT9eEs0Co=;
        b=k05+O4VPVNwkK7zZGMAXkesMxSITx2r7NPbWi+sI4FnlVQ6hGzWYkIjmjyUUz8+PMj
         +c2DYlW3AHSho8Wwj8z0cbRh1VZX0iAe9cUxPq2L327WBB5GFHwd79/OfqrFq6pTBpDN
         5Q9YX46ASMZAUtzj52sJFEPcf61OMz9WaRnRcSFXJwsCf+dxpa3CA9wX1BvR4kOj7Dv/
         SLeAPHHIq0TvyDAiQihZKrHW7/C1994aZl7IYJabX5zrVsrFdEYo86tIYtHSMWQW75Yw
         4n6ay1zr/wW5AlOVT+zG1Q7N8khEp2WduUjlZa5IK3CEmKciRJy8p7sMiDuvxj83KArt
         nnnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpXwQ77oF9q59S1Exv5nuzPEgIeq7bTbbJCBRI3K0kG/doDAhvZoOwivPaXc6orIN4XXtCN7ZZtNqGzPpL2bvU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58EAugZXqPEJ82O6ogKccDBbzwBClmEDEXTWJKInnmJT+sdLO
	29QH5sC6prYfaoTxLXTayWh1/lcW1Wi/4Bpmk6DeHWttgl4qtiJr1Z6jWNsQwW4zavkXpYNnrkA
	jRpE4+D5BqA==
X-Google-Smtp-Source: AGHT+IH9APAmpFeGNYjEBTiAkwljAaOLhFvSr+80apzooIPzH19DkijO/EtBquNtHWMxbT2OolkU+ucaUlhq
X-Received: from plfu3.prod.google.com ([2002:a17:902:e5c3:b0:240:670f:ad71])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef50:b0:248:614c:b8aa
 with SMTP id d9443c01a7336-248614cbb24mr188325795ad.15.1756440720889; Thu, 28
 Aug 2025 21:12:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:58 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-18-irogers@google.com>
Subject: [PATCH v5 17/22] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 82a5b037edf9..782bc7f8926b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("lpm_mem", [
+      MetricGroup("lpm_mem_local", [
+          Metric("lpm_mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("lpm_mem_remote", [
+          Metric("lpm_mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("lpm_mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -897,6 +923,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMem(),
       UncoreMemBw(),
   ])
 
-- 
2.51.0.318.gd7df087d1a-goog

