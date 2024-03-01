Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE13AC2D
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319413; cv=none; b=LVJeyauSx3SlqL5jI2L84kyUF0+hiINXoRsDuphVD4lIXrBeYOlL04rraYzbto3y31sA4ogeKAejO8zLMlPR0rlGkfRpkBPPIPH26c7bWhbOAXxEQbeDXG7RvfyaFhvp/c1E+IUEWgiu07UU95L0CTnkgPxMqjskxjLwi7xT2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319413; c=relaxed/simple;
	bh=panIrCvcM8hwmTL6w73OOIwaBmO4XEVl+dEJoBh+wK8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tpA3neWrheLI1BIWx4ym5MEN8rTt1juAANGDskIAycPIAlswnlZMtyaWLRmoq1cN7VvLpOzV9BgSfzHYa6kZFOsvA3O40QrZFO3t6XHmDS4ARGtjjfodhzhVoN8RIAvSX4zC29NLXBJCxet4Gr1nNP6eUPEbNRIE1wN76xepvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05HGQoF1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05HGQoF1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso39640947b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319410; x=1709924210; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9VN6M4iHhNGfXDgUsA95lPgDC+51/4VBbMVT4/EKng=;
        b=05HGQoF1lQ+Rph0uRkJXdPfSSIX43pdvwKamXL16jErTuwF0wTiu5xSjQV1VLdiDBG
         u/W2kw1B3MoLa7XDrKC1dVQoYxFcgQhURbqVcn40wBzDuBV6eeGqndPxmaRA4Mfkgx6J
         yoCiWp+DlM5SEYhpjAD7lUyUNrY3ioliFtGhWs0Ka6PCI4Pji6OLeaXo+9vCJxEADgoc
         vPF0ybl3XqmLUBtOJaf/rneqVl4xTNEb3eEHYIjHfIGfZULfuMdq7iwYCh27F7Ne5rt4
         1/2Z+mZ+8JgMww/1zhZzP5OLa+y007lTDu9XAHfijFMslBEt3L8Iegr+16/pCbzIDSgF
         MJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319410; x=1709924210;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9VN6M4iHhNGfXDgUsA95lPgDC+51/4VBbMVT4/EKng=;
        b=Uppq2ddIXCMNIy4BjJ+f+My/JBSNNh0jHl66jEhP+q7wGQB70EkhpGi/HUwnNEHVqo
         mNoSYh8ByMU5zq86iVtAC7JvnMVaKIcNELE1un2l6bOQ/6aLzKEIMQabgyprVhs75xhW
         upSmOw6QlBc0QT0gwv1LmMqBv1rMI29vsAE+FtB6gYcwgzu+kpGw1F54Tg7xJJUKYzTO
         MqFK4/TmDz7qujaTi3adCxXsrhk+72AnEUdaOjCMGDc3cUX2xQeeb8m79blIXO5waVFT
         +tKPmDBgpFORrrRbpnkbmYV8F1ma5ZyIFqa4bwVFENtPXfLvhWhKNYuqQhdNcexts9gT
         kL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoBi6rESuCrf628B9Ns3u8Blmb+nmn0f6I/LOel3AOsxmY/GNDWFFgLhaMkx69Mve3IZsP2sAf1csJgSjMeyS8Ur/I5loG7QbDgHFuFcBVfw==
X-Gm-Message-State: AOJu0YyXni9o8vLNnikg3QZcCY4kJrfc6Lyv/A6QhdGSq0B3XfbK9df6
	ov9rycUMBk1sVU4hG4rMaeZFquUg7ldjlDS6rT7+EBKIWUSnuRRaxb7cP8BQwPJ1KNbdse2WlVM
	YSDvNmQ==
X-Google-Smtp-Source: AGHT+IHukrvXXf9dKyNrHu0Wr/egMKoGJpe2Mj9fmA3/yh9TWJLZGgHyZc7wGu29UBH6pQdCHemj+zr16pX3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:85:b0:609:3cdf:c737 with SMTP id
 be5-20020a05690c008500b006093cdfc737mr528497ywb.10.1709319410636; Fri, 01 Mar
 2024 10:56:50 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:54 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 15/20] perf jevents: Add mem_bw metric for Intel
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
index 2cd30c557a59..a5d68b7deab3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
@@ -798,6 +859,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMemBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

