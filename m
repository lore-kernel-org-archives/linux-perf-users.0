Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4475CDED
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165941; cv=none; b=bkxnVF+qPAJsW90irIwklH6Rd8I2uX4q/MMfwhXel7m9clBynn7SYPJyKKh8lverCR0za9DEzHK9TcOU6cLUMs44n0P0bXi22Y88xIZDIOHy7K1VbPOJS1GNVuWHnLjwwEZYSqH4xdDqw4sl3T3IfYbcFvJ2esu64I3M9NhluNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165941; c=relaxed/simple;
	bh=n24bfMvbsLQrhJDf7paSd47VFWDE5Eb6tLHa7+2e2r0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cn0QmnwPbj9T4Eg2lHT6Reb6p2/JUN/Tbn2vBm2yF0tkloKoQTEUfkNjX+GomOeY/+kJHQlfH0vh0d6QXy1coNg81W/4kRCRrNQ6yz8NyThMfnphqx17FnZ/on/BJ6ECEqNvO/9P6/yrcCb0C9RcOtN4y+WJKgqqaVpc1tr9J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrth8MBR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrth8MBR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso6446157b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165939; x=1709770739; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssvmfSzbf4Bf2vyw+vKAKxfn6gLVPgVaJ3+6XRQ1Cxo=;
        b=qrth8MBREDCJTrleDBrvcaqUHpkrb00Y19EVfjNfUN9B8oZw1XTRDF0lXpEPIlrxgP
         5ENyMP3H/WNzf1eAsoLe3aoIb1RBSZbg/PiVPaewoI8buU2LtG1k4HLbjgr4mGfGDvlD
         0/2KND3NLY3iV38VfUIUcnAx3m9dBPsi2XarNSlLycUmRDWI6nbN4ivRD/8gIYSPsCly
         bb9fGbNMPCREHF2oIVpF3RITj/rX5+cN0m5DciPNRcPbSimBMdwNLSCarEpzbReqn/dF
         SpphuyVhD+5sUOodIZUqM2Lh0qNbnEt5hRJ+UXSCcaqbzbGiFXIk7FfEf3y2KIaZw67I
         RIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165939; x=1709770739;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssvmfSzbf4Bf2vyw+vKAKxfn6gLVPgVaJ3+6XRQ1Cxo=;
        b=XpPQmkkl7Ba0HnZeQaMfL6d0rnFmnckH06MMh1wSKeKa3ORz3XeSszW7PK7nJSgcF5
         V3U+EMROXJatW8vbM6GzbeMmYKt9Tg79MmrfvXgD6I/CoKunBadSGOqY61a4u0aFaaWQ
         S4Qk/LOr8rwPyBdikEUafVkSDweY40HyPeIpPUhrmfQwqaTLEBh+Ek387OgEmS5C3FaK
         bHHUwKVjQ4oyvUeUP+kdhokgSTBgR2dPw35dCLgDl+aGamh2+PKkSxLfsZCU8JOm0V6r
         Rn0XUkJszp1l+Dk+T4pDioTyxMBRRs//vTGc6I82+TKIbNyDm48ff2err449XS45QUeQ
         /1mg==
X-Forwarded-Encrypted: i=1; AJvYcCUvnDDhEPZQT2urhO+fRAO8PxdeTfDXffyKNkZxgdvH2eu+QaPL94Fyt07bKtxFWHMR3ve3h8a2haTtkEI9ZqsotY6HUAi2YYLehS71MPxi/A==
X-Gm-Message-State: AOJu0YyvKk+JVRiKO3LZWw0ycYx4kem7KqfrxsqhafyaNHU3v73kCIGo
	ncqokZRqUydc3TObdUBJjojq3dB4saaNCcOyoPLqriTSuas6ibR4ubHD2BFgq2QEBaaaiEKp/Nc
	WCNWaCA==
X-Google-Smtp-Source: AGHT+IFYx1pPpl/3L/ukt52mSMHT09pD1GZ+Vg5CU2Ry8/gBNKYecgQfOm9KeJwP1leD9BBJnhi+/kJ5KMhs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:230a:b0:dcc:6bf0:2eb6 with SMTP
 id do10-20020a056902230a00b00dcc6bf02eb6mr41891ybb.6.1709165939066; Wed, 28
 Feb 2024 16:18:59 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:00 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 15/20] perf jevents: Add mem_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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
index e373f87d499d..8d02be83b491 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
     Cycles(),
     Idle(),
@@ -815,6 +876,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMemBw(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

