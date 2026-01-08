Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEF334C10
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899539; cv=none; b=oic4EixqGRRz8jck/ToCEgxobpZ9TxWv1GlLihzxijnyDExIXxi1TYCUuzW2cw2q9okVRK07LPvgh2DF6Ug/1niQ7sVWLNekoiROnl47xgrKev9TNVPkXM/kH8m3bKfoWYpQzjaHiZyaEmHd9IawUBDLmn4qyTPhI6cJ9NjGut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899539; c=relaxed/simple;
	bh=2jmqKph2zPBaDCiirJx0Zuul8V+Id9CgYa/L0xXNrec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ACIQhiOomnKqANKv06+NE7XgJ5/RIY4VLTlHx/cSmhRaL2ijEEMotyskJloHPOSQddBhLMM6O2Pgmd3KlZYjHF2m2cdoOaK5eKbH81WFsKueCX6+WPFb2b7mEp7T+5vEL/CBJc1tptJyhJhnEQ6yPy/MaPSL9vGMAYxuG4j11K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxiBcboY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxiBcboY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ae51ce0642so2720953eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899537; x=1768504337; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJoyN8MzitpnRKNksQbC+dtWJQHWKeGHeklIvOG/ru4=;
        b=qxiBcboYLAPgGGEBBfuJX/1fn7GYAs3cAmn0dakBE+ksVMFUJ17x2v/9CXzerMAGdY
         CwFE9l6Tm33MoVNpyGMmPWH8s+6WAUVNr7173fPYg9sD9ZxhHZV9Y78LSd1NXQs2XwOP
         n8d2XfTjFyUTGFROpMd1zM7LhzOLqir7THerFvh1886P95yk/6AxfJq5Xut4oN7JUXvo
         L5YyOnT6rFWCsEUuUMcaTkJQUvlWz41B5uL0TeZaROn3SwEtbxD4i7KnwjKB8CUL4y9Q
         OAsH2nEWxzrKHCl1UyGSbDrOgrt1wZdd+CnVDJXlVqG/bhZ/VHTH96IAuUmsb8yKG45y
         ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899537; x=1768504337;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJoyN8MzitpnRKNksQbC+dtWJQHWKeGHeklIvOG/ru4=;
        b=rpnCvus+cZLg+UgLHvubukJFgorZV2kkp0gtG0Ornq3UkorohjxnsCCotYD/+EUvl1
         EkSlJh3bR9owwMUp8dH8nrEqoUeaDrwonkSvhbLNve+BxEzOJGZLcZq8iCErhOUbWvTk
         9fBBpK6q41rSxN22+t/czpAO2D8OgKd/ojR9IUnpG3CwBot+a2/uFe/Louemxwy51c2F
         4fxbCD8KfOKwMEq6SMRvom2Aw13T8IEwybXEce+w26MtVJNq0hgJ3wajp4bh3GY0PUTO
         1gwSi4PBRUXeDlY+OVovzmh6IdGfKsDRUUtelqL8Q53MktpGTCdlm2EMDLUssWFZPVDU
         i2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVgfzQgggDyq2qu7V1sikf59jNphxBU0huqkQs661j2AkBYNuaW0bX+DeWDIgM6N014azqV9aREC/LM8q7bvCsR@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUxPzBfJpQ1qiuV1p5VMaSI3XfiOEyDn3aynratsxdoGGhYkd
	oofrJnDgnqAqz25HZdC4+TpyRi+lWXJnv0Xy37wE5gjduoHp608nQkSEU/PzsIkrM7YKtCfXy8s
	VI4+r4JvcxA==
X-Google-Smtp-Source: AGHT+IEUEByo3KVdc2tneC6+sxxVazCdj8/NYJ1QVKci61S7oIAhPXsrCf5wnLRlrXTGJYvPwim2AsCyOnYE
X-Received: from dlbqi1.prod.google.com ([2002:a05:7022:ebc1:b0:11b:8174:bf47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:24a3:b0:119:e56b:91f6
 with SMTP id a92af1059eb24-121f8b656c7mr5857099c88.39.1767899536988; Thu, 08
 Jan 2026 11:12:16 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:57 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-28-irogers@google.com>
Subject: [PATCH v10 27/35] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dddeae35e4b4..f671d6e4fd67 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+    mem_events = []
+    try:
+        mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                    f"/arch/x86/{args.model}/uncore-memory.json"))
+    except:
+        pass
+
+    ddr_rds = 0
+    ddr_wrs = 0
+    ddr_total = 0
+    for x in mem_events:
+        if "EventName" in x:
+            name = x["EventName"]
+            if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+                ddr_rds += Event(name)
+            elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+                ddr_wrs += Event(name)
+            # elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+            #  ddr_total += Event(name)
+
+    if ddr_rds == 0:
+        try:
+            ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+            ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+        except:
+            return None
+
+    ddr_total = ddr_rds + ddr_wrs
+
+    pmm_rds = 0
+    pmm_wrs = 0
+    try:
+        pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+        pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+    except:
+        pass
+
+    pmm_total = pmm_rds + pmm_wrs
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem_bw", [
+        MetricGroup("lpm_mem_bw_ddr", [
+            Metric("lpm_mem_bw_ddr_read", "DDR memory read bandwidth",
+                   d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_write", "DDR memory write bandwidth",
+                   d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_total", "DDR memory write bandwidth",
+                   d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+        ], description="DDR Memory Bandwidth"),
+        MetricGroup("lpm_mem_bw_pmm", [
+            Metric("lpm_mem_bw_pmm_read", "PMM memory read bandwidth",
+                   d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_write", "PMM memory write bandwidth",
+                   d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_total", "PMM memory write bandwidth",
+                   d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+        ], description="PMM Memory Bandwidth") if pmm_rds != 0 else None,
+    ], description="Memory Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -853,6 +914,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMemBw(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

