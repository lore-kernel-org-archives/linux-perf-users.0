Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944A17DFE4
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372489; cv=none; b=aCJ4CVzDYCUsnsBkHcIUgpzCPIRKE+gBoYcqGJgXJm0qQylPv60KVGcqnTojRVOuk7x76ycGtwPdEdF1k67EsTlAZpm1Ocwz5+alZtvOPg0PyueWbk0ncAbfINc5IQmMerN+GN3MIJy00Jp3lKuCCtO1HWe7UsezIrwNwZVmZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372489; c=relaxed/simple;
	bh=cIMaKODlIQfWjwdaOl/2X3SzVdBENS/xWTEUuvLVAWU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tiAjLsx+zFSz05Lj2Nuyx7j0DeDYFI1CgaRRpOkdIH3R6CfaK1w/2ctVKDoDmwIlcYZh569Y6f/9e5Q/vIiMopom9va3e4cGszwD2TdXgHtfo9HdE3AXjLPjyNYM8OP00cmsg1t1GjMAMQy/ENGUTU5RQ+apFZut7h7AgvNweBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nICtZ4kV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nICtZ4kV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1923643276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372487; x=1727977287; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqA0HwjkEMRfn4rBqXVohYotQoaEYwt24VeEOBZhY4I=;
        b=nICtZ4kV6qVWOHrdab8ZTbePovqofzVsxtq9tckpUW7xUs4Dcz3EMT5y2eoUF5mYzW
         eQMRPYeOEqfd6vkr3/OQlTfDjKJ9cToZzkdpFHiugVGtd/CbDBkFsPtwL6l2YZCPBi8f
         uIscwwmkkOIeRlA0+CCoxfN6GLp6EobASSexLJodAHe6m/WON4QnmUXNqvj8wxgcH/hC
         y2LcpQYIzMleRoMJwoLELu/QLr8ZfmCj7sAPbbfpwgO/yEMqPs/iX5UP4LAH9DDfDKQC
         ddiACon9iAR78KjfCZ3W6M1cWZX8ygtbSb1lH8ny4AE2M5wLhIlvLNcIEJRKKQEfsfjn
         ZfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372487; x=1727977287;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqA0HwjkEMRfn4rBqXVohYotQoaEYwt24VeEOBZhY4I=;
        b=otpb1V5jAPu+XTBY7qEQ+Fp4TWYqDxu3ZdsxvlJkL1h6n7uSnrqcWsfSM9ZrphCTxI
         1ake+cweC5PMEJhGjVM+dRpBLPW12myjgyyimMy6fQnwk9c6vJs6XH1IR0e7L1SKaRJD
         O6InPsnmxCsaOuvFc/iDLhtKC/HhBmRwYRyLQL1WCAZ2ZF7VBitYMZy2xFfmLoevvSkK
         p4OLSZeJ4IVhdzOFpxu0hBkVYM3h2c5cMsQWMeEA8HnjVyqgHcL+NR5+sUHoz7pqSlAc
         XYAO5aa2hcdi9lTOc7zSnydY8qJs8OroCLcjDnP9fItn2r1Cj6H2WyMta6lR7ZyxSFjN
         U4dw==
X-Forwarded-Encrypted: i=1; AJvYcCVqNRErcXG/fLs1/WtdCUmhA4fp+JiUtMDbALvigW/HB9BKcFkt3gD3o+JDBG0tWxfBitd1e8B1AVPRfws1ld67@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGuCyJB+tq7fxrhWRnGUWPY1a/ldtv2G0J3pjLtFR1eaaOXVF
	jPrEZsF0aGOLWZ93UXki6KXavqSwPFwOMz/taVrK8vfnAMj3CIFvOxnB3lBNQqB6Con/tvcNcbz
	230ZN2A==
X-Google-Smtp-Source: AGHT+IE94klXmp+qn3GvZ2PkmtcS2BcW6kckGIotFl44MsJdIBQMTTpB8//026BOk6pIF0SoTYBVL0xXejCI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:3d2:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e2604b33cc4mr234276.3.1727372487216; Thu, 26 Sep 2024 10:41:27
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:57 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 08/12] perf jevents: Add dtlb metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index bfed478f508b..7fd2139766f9 100755
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
+  return MetricGroup("dtlb", [
+      MetricGroup("dtlb_ov", [
+          Metric("dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("dtlb_l1", [
+          Metric("dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("dtlb_l2", [
+          Metric("dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("dtlb_l2_4kb", [
+              Metric(
+                  "dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("dtlb_l2_coalesced", [
+              Metric(
+                  "dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("dtlb_l2_2mb", [
+              Metric(
+                  "dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("dtlb_l2_1g", [
+              Metric(
+                  "dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("dtlb_walks", [
+          Metric("dtlb_walks_reqs", "DTLB page table walks per second.",
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
2.46.1.824.gd892dcdcdd-goog

