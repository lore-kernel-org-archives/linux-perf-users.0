Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CB23D2B2
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438323; cv=none; b=QvkcBgSnv4OEutN4LN1daR0rSKNVGAKBRl+SiM1wuW1v5QKhV63guv1y90vfNABigPDRqcLPVWKITlN5Ly9QwysGITEHeAi7VB4OrecnryOAkGZqBjFWATn3M3etwkOQIK2M/Cj0FKPFm1W2xIG7whdgIPAutOInl0IccjgXZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438323; c=relaxed/simple;
	bh=7HUXS7jH2VNCmaePpmahYNNoI04Cr4+LxjW5FlN9btQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t9m0U1+Xwfh+6QVOnYRxzPCEJCK6tbe5ODBDvD1g0ul1xWsaC4W5/gPX2+agAoSmek15J8a0BWF6nXh//a4V/FCC1ehNLIYcx9H/3BWgozyAl9bZASGHh2seCvQ8MWJglhHYpFMkXj+dTkgrUdnyhicvPSMZWwvAd6HNZ8Jtg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzdWfQcz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzdWfQcz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445803f0cfso21794715ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438322; x=1757043122; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF2FIgYGl4ZqrDaV8kAKZUXJtv6VcaO/Qv9P5dWo5oo=;
        b=YzdWfQczec+iI4UIF4YVRVo4wy/djS9aI3C+jmK4+00ZyzC9NjR38JOf+StwN5+5at
         2geOlhm21YKBrBGFS9JAS1oS9xuR4KfutOi0HsTe05N4beXp/4LfG5KZiTNTYxfdnPb5
         HDE5Qbegb7lUJQS/jf3S2vD58FsPa5xCP/sgxT9d5QdqOVL7Y+/m47vLI28n/JjmAHaP
         /dZQWt7QOFC5N/HlfnvYkMYNDOAaszu3tFsWQg2sVrgEI0cLJYj3d3oQIBo5AVP8hAPs
         XUUI3t+hHvd8Hyyuwj798q5RvtnhyR+8Q17XE/TLmmn7VgMxJAEly+H6aX3yW5PBNpEk
         tVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438322; x=1757043122;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF2FIgYGl4ZqrDaV8kAKZUXJtv6VcaO/Qv9P5dWo5oo=;
        b=V4S0KCztqPzatd3JGjl6rvYlnEE2SAfv8OuB4g15r7AeKG+4uy3eTMgKYifOhuZciI
         wppGr9bH1XZYI7ybPDNAXA7lsZMtggBOTtAuQNpXCA9ZiFQFjKiFMowMHPmSXI7dw8MM
         g+9Cp/RESgLe5SqOjCkY6/BtlASc83yhCW5z5rvMj2t4t6vJmxp3K0PgAut4NUUJP85s
         ZiBeu73ukBmixTTgFOkuTu2GmwEsOoEAzW5Rzz7en50miIG1poVyiiAD9qtkZquqBgel
         wsarzfNk/tKYUROwBsuRo7fSilED1ZsC5E/fUZkg5OhxXzWn9ArT1sHZRU3mzmq7e5tU
         gLgA==
X-Forwarded-Encrypted: i=1; AJvYcCUC+4N829KS78wlI4UiOoQcPtlSMGmVxt5Ic1ryvZy8ovm2tITDW0Qovl4omjfw9nkx4mNoHtdqztxop1Ho4RJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQm6xySQQ8VtS5KokZsyHHiBCxODHT5V/C2I4ZrzYuDcxlRCk
	x8VMGw6zp9ccvWlybFEiWLudc6jBf+6CNt55OdTIORXdes9LuX7gsGfgYAr2aa3SH5jKg6CqpNg
	WKx6vdEPd0Q==
X-Google-Smtp-Source: AGHT+IEyPzCs03+Fd49SJT4qy0cUi86YdDbdpWb1/R/U+YdYRjcyFlMnA0X80KYGfT4R7u14aQmeh9uuNbfu
X-Received: from plps15.prod.google.com ([2002:a17:902:988f:b0:248:96be:d4d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:240:a54e:21a0
 with SMTP id d9443c01a7336-2462ee13154mr350265615ad.19.1756438321737; Thu, 28
 Aug 2025 20:32:01 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:33 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-9-irogers@google.com>
Subject: [PATCH v5 08/13] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 8f7265a732e3..38ff7d1caafe 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,114 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  global _zen_model
+  if _zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if _zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("lpm_dtlb", [
+      MetricGroup("lpm_dtlb_ov", [
+          Metric("lpm_dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("lpm_dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("lpm_dtlb_l1", [
+          Metric("lpm_dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("lpm_dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("lpm_dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("lpm_dtlb_l2", [
+          Metric("lpm_dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("lpm_dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("lpm_dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("lpm_dtlb_l2_4kb", [
+              Metric(
+                  "lpm_dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_coalesced", [
+              Metric(
+                  "lpm_dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_2mb", [
+              Metric(
+                  "lpm_dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("lpm_dtlb_l2_1g", [
+              Metric(
+                  "lpm_dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "lpm_dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("lpm_dtlb_walks", [
+          Metric("lpm_dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   global _zen_model
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -386,6 +494,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdDtlb(),
       AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
-- 
2.51.0.318.gd7df087d1a-goog

