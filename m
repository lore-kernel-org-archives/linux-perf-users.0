Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169B53383
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396011; cv=none; b=GWv724/Tm10hShJ1ppPaEdnnnI2xs4aPoywD6FEouiqQByWXppZI5KsaeOVLbnLl8rmN+d5vf9gc4tMm5VMrCTl9cBqsUKZIZjY5Tj5V68M5hv08HB/1FP4vikuJOh3470Sn0YVZtvOiN2DegZlGlh3sDfDfH7vClRqL26RtO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396011; c=relaxed/simple;
	bh=9uJw1O918oN2FYmURJnSNa9KpCLd9v9rjdrnFyM6JbQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QDF2/cZacqUKeRndClDhTdul2yXKAt+hNMpH1u6TQyg/AQqwPe3VAAtADrVN/scnod0rlEyESeULTXYbwbnCt+VGj/LZqzj1h97aW+dk1moaaNXCrUzEs8IFJJ1mPkT+PwFQY3+PgK5Yca9D4rzD/JnllQYzMMtkuCQzKjLWAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xvzDl1zA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xvzDl1zA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso12997537b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396008; x=1711000808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFiXNnmb/ZEVra2BYkk6K4dsDX+iGAa4EIuUf6Naynw=;
        b=xvzDl1zAnPtrzCvpyOQeQ81wYM0OvPZ5Fy71crfJQS/Q1zGIfq1fuq/0vilF3UUIEU
         y0b6EaFzv7iPr8WJ6ByFntBx3JFLeJE1U7l2bwgq7Zn91hZsfBXOerG8E74XI9Qug+Hc
         sqwXrZ+lp6aohPM7Wd3wdQ77idp1G3xHf+g8oX9za+56Uq4CTYFk0sCuONPjBIsVMx/y
         x6/v6q/00iqWurkZXWhJQ86Ev/3poRCtY3iy6kudTN22hdF9P7Dh4UJzWpE3ghl//bNh
         Xo3VJVxN9sq0N8dAW4Pho+WNMhO7Lyj0BH/RWXGzJeM4+mTFaU6CM/62orSRR7daXn2g
         DVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396008; x=1711000808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFiXNnmb/ZEVra2BYkk6K4dsDX+iGAa4EIuUf6Naynw=;
        b=tqVOWv5I17CutHUWtGEyfN3CZwiSZb8Cm6I5vJp0D9Hw+mlkChWbQYQvcSH9wLtNIo
         CJixGDwPkzvmiftYO6QbYURoQP9o+ht0VMPm97u/7+FoLLk9I2HaavST10OjhLF/DHnf
         ekvHa2EPreWhM4CBY5Iy65JOhWqCZUjk6uGs6xAkvqGyGn6oT+94mgnoS99DV+sZx0FC
         TBvn56jDazOHCgL/hiT9mxmfp8MHsbAQ4iT3cmTj0f34oMbT9AmfBQcFPB4CNro0KTtJ
         oXY6P+rcprUQA1eDojmwceRUL2aItQOHPlxzGlJJBllkso3E74MV9s0xEtB2EwI0Wmkx
         jxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5S2iuoYXaXu1pk2pwE39zknSNPKre91uwIsNfvJLA9n0Yb7GY/bkKV7QFx3b3XnkGEZ7WvSgsZoRb4iHHcoEIVEFQOxItAz6hYQTXh6s5w==
X-Gm-Message-State: AOJu0Yy+XusvQjCijz0yE8ZwiA6EFqzS8e1GoaZYWJRVukzPTq6IkmhG
	lOjXZD/dJM4bOjxYBVdGbLJRtnG4ZAXE5iJ/4aW3SEWF2EqEs2yAujRKa9G/myh3alnos3QDkFi
	p4MrnsA==
X-Google-Smtp-Source: AGHT+IG6D/9cf2FaWOjiiIaSBSmoU23i8ct9mqVP2RbqJuRzciG2uPuROEkE4L6iloxBiIFlCCfNNNw4oDCo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:d54e:0:b0:60a:2307:e3b with SMTP id
 x75-20020a0dd54e000000b0060a23070e3bmr131957ywd.3.1710396008638; Wed, 13 Mar
 2024 23:00:08 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:14 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 15/20] perf jevents: Add mem_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6a864c0b863a..c7f536d3d4ed 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+  mem_events = []
+  try:
+    mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                f"/arch/x86/{args.model}/uncore-memory.json"))
+  except:
+    pass
+
+  ddr_rds = 0
+  ddr_wrs = 0
+  ddr_total = 0
+  for x in mem_events:
+    if "EventName" in x:
+      name = x["EventName"]
+      if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+        ddr_rds += Event(name)
+      elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+        ddr_wrs += Event(name)
+      #elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+      #  ddr_total += Event(name)
+
+  if ddr_rds == 0:
+    try:
+      ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+      ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+    except:
+      return None
+
+  ddr_total = ddr_rds + ddr_wrs
+
+  pmm_rds = 0
+  pmm_wrs = 0
+  try:
+    pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+    pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+  except:
+    pass
+
+  pmm_total = pmm_rds + pmm_wrs
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem_bw", [
+      MetricGroup("mem_bw_ddr", [
+          Metric("mem_bw_ddr_read", "DDR memory read bandwidth",
+                 d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_write", "DDR memory write bandwidth",
+                 d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_total", "DDR memory write bandwidth",
+                 d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+      ], description = "DDR Memory Bandwidth"),
+      MetricGroup("mem_bw_pmm", [
+          Metric("mem_bw_pmm_read", "PMM memory read bandwidth",
+                 d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_write", "PMM memory write bandwidth",
+                 d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_total", "PMM memory write bandwidth",
+                 d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+      ], description = "PMM Memory Bandwidth") if pmm_rds != 0 else None,
+  ], description = "Memory Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -813,6 +874,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMemBw(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

