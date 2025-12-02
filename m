Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A72D948F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697965; cv=none; b=eMD+n2bUNggI38fbZE+70jVxT9pDPOc/cxgT8VwBgSSUbXlQMVd/yY8J1XvZCoDxan8q5KUwDwu9L52w77Ragssr2k3QPKlAa1zM8Pcj875WLG2Rxj1kEmUG1jJ3FnAMWhbbcLvmn/xSfAAIg+2JlXsEsUrtBg1s3afynvlWRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697965; c=relaxed/simple;
	bh=cnN28YgDZXQukPdyU43RwJGiMTKXLOK9A4I9IcbNxOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nh3xieiEOfWVrdU35kKVXPqCxglWM0tLP3/A91BTVG3xJQLyj/JEn3TL0ZdGkIoYaqrMSK0DNIQjGcfXOrSCjCmQVM+ekmW2wgzcjKjSQZskav3zIyVsj2ozUaOXvfz+f4bCdwbR5bPWUUsG3tC8AIZ3ol7RAoRLI3qxKi4Y6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0wmZaMzI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0wmZaMzI"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8346118a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697964; x=1765302764; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SS4YW8sLI9htj+EOc60XF89HsfUzPAe2mr9sCDtgbKM=;
        b=0wmZaMzIdQeD10MvPErYob5obymA9KlkKrZfkEMlRkMLS9OaEJjWgDAxf50rfO0PRw
         EGKgR/sz68SUSM6KwH0XlDpAoj9A9B5irL0QqrFRiSwF9m+/6KrY3/ahBBX/wWJ5aYaI
         32+7nT0JVNgVrSFV9Hk1r6EVFiQZAxwK8g2NDodaIHUFxfnGwQ7MA93poICVfOxZ5sRa
         y9ulCg/lE4s49ckKwIdUjlfgZFMFG5o3wCGK2jGagH3mhUL+SU9NlwGBZxy5Tc4TO3P6
         0VLM9L4M3kDjRQ4n5+6sc67PDhuRQzlB8tR5r6Ovd+AyLXbG16cPWjdqtOjtWdu/Hq+o
         wrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697964; x=1765302764;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS4YW8sLI9htj+EOc60XF89HsfUzPAe2mr9sCDtgbKM=;
        b=qw92BWXpWp6pvclVUoJ9OHAtAUgpRs++1ZPiEuM/+QeuAGkZv1OR3ZpzIInjfHyKJM
         Fpcx3JAicVLoRGQDVElbyN68BNA0zb4Dck0e8UNF4rYMjxP8NT03TBUv4TVkk7F6GXBY
         h3i52SEBzMiUfeZIr10sQClY/vz/sEcpryPavqweNW3GjxyoFCtcQn14zfNAxs02jLGk
         L5WQxSmLtrja/j9+N7llMhN2xPtgVJi7oHvrgkN+E+GLiH6b06TLBzyZeWbVUx+/Fhi/
         cDjDkqUXAkRkSbwNOKV6rFvB/iFMOOhUlxAs/43EBIRABOV/017OuX4o9f4QxTcbltEL
         tBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUrpbrN9M+uC6ie4ZGdRNYfT8eFYwEqjO0GDooUdbpOyIDihbqTDyweArU7GoTBvANgJl5x8c0yULK7tqcTblCM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DY9sLmq3AQ32Vb/kAbyvnk0MsRdEJejx4cZBFcCzQdZ5i/Fs
	hSDGyg4kTjroLtkvfDb3ewYcRi+xM7cMijAyS0cHugJ0XbRP5nF3HZVmcglAOn1yevLWYlS8bQI
	3MTDvyscI3A==
X-Google-Smtp-Source: AGHT+IFbO090MPtUKeOBcaX+KQGDkyCln6i9NwXnUXKHCxgAt3d2X5Mov5nlDJSvt0oJKMnRHG/xVaD1fZaX
X-Received: from dyau25.prod.google.com ([2002:a05:7300:6019:b0:2a2:53a5:570f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:da10:b0:2a4:617a:418a
 with SMTP id 5a478bee46e88-2a7190f25ecmr22820939eec.13.1764697963387; Tue, 02
 Dec 2025 09:52:43 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:15 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-21-irogers@google.com>
Subject: [PATCH v9 20/48] perf jevents: Add dtlb metric group for AMD
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
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 7a418990a767..2d1d25cb40b2 100755
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
@@ -235,6 +345,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdDtlb(),
         AmdItlb(),
         AmdUpc(),
         Idle(),
-- 
2.52.0.158.g65b55ccf14-goog

