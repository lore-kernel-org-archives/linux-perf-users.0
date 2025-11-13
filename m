Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA230F942
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004098; cv=none; b=mppHQS3zTEsFG/xGgLIVdsCerDfdF2I3oOY3V53DSiAkgOMRPzFAS8WQTwXTASOChOXh/2b4V0OnnFRp67sFLxmQa0AaYTPUr35A8N92Y93fzSiX9lbdcMzOvjk4PpgSjf3e9ikmBwXslQQhd0HymE3EI8Wa3WbsB5t03E1kUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004098; c=relaxed/simple;
	bh=1yK6ynR7Hdl8thZTAH93vnNwMoR9Uh6h0cH+mPhtQg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IL4w+bXoq/uJm2sc1yuGgxHe9xuBB60MmpyVNw1llhd+M78MhSnD3dX1U+TrDAUfdLwLI36pWD3duM9Klr/d+ZXfKsrBXNf7l6DEiY3jzYA4xl1kBc8Mdy9FFqD1zRuNgpx5ONY0YU1YlgHqiu3t6PBn9KlrrUIFudyWvQ4zz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8/d6nyD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8/d6nyD"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f48e81b8so7637945ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004096; x=1763608896; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wE01TbvFKkbywDCouhHHWzoZzOdNSz2AoZK72+q7CE=;
        b=l8/d6nyDdemhgCl2ZKbi27tRW4lNCwqDt0YdQNiD1MG2mFzT8VvoDy/VEOqAwHcuX0
         bbxBZa5LDgoscTTicqfkH0Z0FExm1oudF1ieoLKc+ZpOO8N6uqYI/xBIjHEI5sQxgo5S
         JYuK/xyHfEe3N28zGIvAOyZQsC3eeTOJmpCRQB2+5mYft4NR2SGztmaEOMJwziv3/tbj
         Cbp0UNZam90HpO+7/0Tt/5KQnP/sa7/QCctE0gNkQuS5hAkNjoS+XhR121A/MvzvHC6Y
         GMSLxSns2iRBbLtC74uhT2ujKGsJG1G+WACq3aKdn0icD2KNV0jsGmH8M2MCf0KYucvn
         YyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004096; x=1763608896;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wE01TbvFKkbywDCouhHHWzoZzOdNSz2AoZK72+q7CE=;
        b=OTKT0f+5f3T6iPk7p0Bjl2euj0lkOPYboR8Y9aTh+8crNKTmA5yGbct98DOU1XHN6X
         sxRqhCeufkSEe715zUbgDKKOni9kqVO0+/E9wnSg/H2gOyu797MMUzg/VFYxZJkIJkrH
         AepOCZRJs6+nDW4It2JIQvq1rswOqfpThMk86RY5Yw0NwMd1s+Oq/mTy2jIvd6dATRnI
         GXlFwtTVf9uK4E+OMnlbnaGqvoUufx6pURNoB7ABd/+URW1QXa9c5yUZduzqe9oQz/UP
         aF4iKekjdxz3kVmAMVrlDPRVPOQo/Ibo3Z2AcwBvVBIS/aOIcKjBYFLOlVJtr1d+8XPy
         tEUg==
X-Forwarded-Encrypted: i=1; AJvYcCXed+5kzj6A9z/EnTd8c3AngSc86hTB67+rWjsOnCOafW/lpW0weGnHNQcBS4OU0PBydjlZmbYL9XNgO6yYKf00@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NhvXH7fZSeXqXKAqD+weofGarXhRj6RwTXJZ1WMrL/AoApXe
	1eANDrNSn3sW6IKhupHLKWtImy8WKzq8SPymvgv6PLa152sLnw6PSoTbpmJGoIgmYYnzpriQ72W
	WOl3dObYv3Q==
X-Google-Smtp-Source: AGHT+IHm8vNZxcIftQaJ2jDi9kvs6TN5vtKmQaTOlvgOrXRzwsyjefycdbrghLh+95NzG5mhETJRk6o2lNkb
X-Received: from dycmg3.prod.google.com ([2002:a05:693c:2503:b0:2a2:367e:4ef1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:298:68e:4042
 with SMTP id d9443c01a7336-2985a55bd08mr17759015ad.26.1763004095949; Wed, 12
 Nov 2025 19:21:35 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:10 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-23-irogers@google.com>
Subject: [PATCH v8 22/52] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 60f4ecedae6c..1592d7db2ac7 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,116 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+    global _zen_model
+    if _zen_model >= 4:
+        return None
+
+    d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+    d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+    d_hcoal = Event(
+        "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
+    d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+    d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+    d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+    d_mcoal = Event(
+        "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if _zen_model >= 2 else 0
+    d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+    d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+    d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
+    d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+    walks = d_w0 + d_w1
+    walks_r = d_ratio(walks, interval_sec)
+    ins_w = d_ratio(ins, walks)
+    l1 = d_dat
+    l1_r = d_ratio(l1, interval_sec)
+    l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+    l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+    l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+    l1_miss = l2_hits + l2_miss + walks
+    l1_hits = max(l1 - l1_miss, 0)
+    ins_l = d_ratio(ins, l1_miss)
+
+    return MetricGroup("lpm_dtlb", [
+        MetricGroup("lpm_dtlb_ov", [
+            Metric("lpm_dtlb_ov_insn_bt_l1_miss",
+                   "DTLB overview: instructions between l1 misses.", ins_l,
+                   "insns"),
+            Metric("lpm_dtlb_ov_insn_bt_walks",
+                   "DTLB overview: instructions between dtlb page table walks.",
+                   ins_w, "insns"),
+        ]),
+        MetricGroup("lpm_dtlb_l1", [
+            Metric("lpm_dtlb_l1_hits",
+                   "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                   d_ratio(l1_hits, l1), "100%"),
+            Metric("lpm_dtlb_l1_miss",
+                   "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                   d_ratio(l1_miss, l1), "100%"),
+            Metric("lpm_dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                   "insns/s"),
+        ]),
+        MetricGroup("lpm_dtlb_l2", [
+            Metric("lpm_dtlb_l2_hits",
+                   "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                   d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+            Metric("lpm_dtlb_l2_miss",
+                   "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                   d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+            Metric("lpm_dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                   "insns/s"),
+            MetricGroup("lpm_dtlb_l2_4kb", [
+                Metric(
+                    "lpm_dtlb_l2_4kb_hits",
+                    "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                    "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_4kb_miss",
+                    "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                    "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_coalesced", [
+                Metric(
+                    "lpm_dtlb_l2_coal_hits",
+                    "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                    "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                      d_hcoal + d_mcoal), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_coal_miss",
+                    "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                    "DTLB L2 coalesced accesses.",
+                    d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_2mb", [
+                Metric(
+                    "lpm_dtlb_l2_2mb_hits",
+                    "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                    "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_2mb_miss",
+                    "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                    "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_1g", [
+                Metric(
+                    "lpm_dtlb_l2_1g_hits",
+                    "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                    "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_1g_miss",
+                    "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                    "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+            ]),
+        ]),
+        MetricGroup("lpm_dtlb_walks", [
+            Metric("lpm_dtlb_walks_reqs", "DTLB page table walks per second.",
+                   walks_r, "walks/s"),
+        ]),
+    ], description="Data TLB metrics")
+
+
 def AmdItlb():
     global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -398,6 +508,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdDtlb(),
         AmdItlb(),
         AmdHwpf(),
         AmdSwpf(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

