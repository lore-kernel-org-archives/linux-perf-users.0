Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56590239E9D
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960870; cv=none; b=pT6/FcMnk+hfV45sEPg+A58EDv6OEHo1rCgbc6JU4cSEm0ywW5bYqU/kFCKzyRNJ8NJU+dbMub0HfvGjPnaf9d4UDYhzLejta3lH48MRvAI1L/hegL9+ozD6s7nqogjG4Nyi18OpIpltb05ojbB8zSyBPi0tzSq2E4iwGp7bzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960870; c=relaxed/simple;
	bh=EoT3DnS8xk0FTU0lUCJn0qCeTndblUw8A3qC7rrZwlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NTBv5zg800AhHcAw2r3NuI8I4sy7fAMYWzaS4/1Ja9C0715/rVwFu55PKstCeWqVZhiIuD0vJ569RzdJISNxCC6VZBnJU9BgACJzIpqHqCB3VEgvoXAXU4BzPeFeLeicBI7Ef/Y+UiHmNc3JXaBtFJ3s+UHXGSH8P+cOuNqZkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxLqQEu5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxLqQEu5"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174b3427so457635a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960869; x=1757565669; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz+VhCX6fUm7hjcLcGzVXEbYIcfKNGtlnzpXylk1Bus=;
        b=xxLqQEu5sA38hKfOykXNRM2HfKZ0z1Y9c2Rw0reGduiX2Q7pFdyS5t6+HqBboSytsN
         /osdc5DxBHlDtgRwCdS9bH9Cvg0TqHEiGFAH6iT+StNUKaMNfVHb03C5kXR5snvZHhTb
         Sc0l2W20RRsAx3Zrg8nhPXEl07YE1SHIuw0bTpluRQ/Klq/C9WvSSVL0zebJAdLo7hw4
         peDaPGK1/9DdHta3ttCbf4uJkHNC1lqhTefSio5vZktO/Zm2QVpiQBzwSaWos/gTIdbP
         +E/hN5sW9IoIfd28iz6s2b6EOOQKIQ/oCX3SjGUTqt0V7XHQcIIxM6kKWIcOjMRQABUw
         aWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960869; x=1757565669;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz+VhCX6fUm7hjcLcGzVXEbYIcfKNGtlnzpXylk1Bus=;
        b=nt1bD2fEQ1Jcrin7DQ1o4+e0bP2XvQ6pjodJ1yyhjwjku6Nztlen5sfg9QIjv03NmN
         JRItkk3p1Pkn4KBZC6JPs51Q8IWvTOjc83yDXgYLrOqEotAtWJxHefVEJQqPaz8mGO1T
         3IN172mIWZ6skFDPcB7FfYXsgl9iG5370Kj39itprLSlRm8xH4IKRksmKCZ1H5e3uwoT
         LrsisHRDGBv8pv6vBkjxHs8QhHS5z2L/mDMBxaarJPBiWyzlQClgWgvaAmxaTGU2xG4Z
         6XZdjIHGuDt9e5DaFZtpCrogsVkbguQWYHSkgly60M9LOcoP6nKQgF6HM8Abs+RQOcSg
         2kIA==
X-Forwarded-Encrypted: i=1; AJvYcCU/61Ydk+vgBstiF84Xa3zKuqJ4zAtvzBQOqC/abdFWgyIYhPTBQMc/9dFzcIAHYdQFOtk8U4bMC8Y1JaB3H7LY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+vm8RZZzdVwsRy3C8bmkaXWrVxMM8bGckdAakSF5my7AlJqv
	D5lfKBFFxHAPtuW2IB8c4DD4esT8x569K3Sz7ml3yhveSDYKPU7My4hhq6rEkkd3TSD0sWTp6oO
	QuYMGzudulw==
X-Google-Smtp-Source: AGHT+IEc4a701ch6Mft+tNj4eq3v9cdY8rNLHi6NM6YlHs2+eTkQEeZV+busl0FKoYiYaBQtw5Ir/feC2F6W
X-Received: from pjuj5.prod.google.com ([2002:a17:90a:d005:b0:325:a8d:a485])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9183:b0:243:d209:cf86
 with SMTP id adf61e73a8af0-243d6f42004mr23416382637.42.1756960868523; Wed, 03
 Sep 2025 21:41:08 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:42 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-9-irogers@google.com>
Subject: [PATCH v6 08/13] perf jevents: Add dtlb metric group for AMD
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
index 40128903eb7d..c3f0f1439c01 100755
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
2.51.0.338.gd7d06c2dae-goog

