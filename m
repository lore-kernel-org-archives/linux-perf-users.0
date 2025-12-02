Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F42D6E60
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698041; cv=none; b=Dl9lp4nw98M/BhcLxn+kn7H5BWTt/uecBiEdc3HLYBEizrUzy8PmE/RcWPFlzsDy0vFIDjGlGO1oWFS59RWkgbxwhOG1QXIkh4dAJphM1cdSYHNsWNMoSfx/wSi3ejS2CQyb1zpyL5/GIWc9lxKHOFPgTwUzuxFeD4UeXFQ16hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698041; c=relaxed/simple;
	bh=szV5c/klxqwi85v6hDhJdpF+W1mEdRaVxUIT+ScWzVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Rq2G9uwO5WPtQoVO8AIJw2aIJzI0tr2oDhuoEIg3jBxN1qj4X7pbEiuGPmvvlKIndB4fCYXPppvFsqgc4c+z6wipix+y49fRLA43eLOHNts6TkX3IBasEetm3LYs1gduc7fvf2y8gKELTYgeGVqt4uSMYEIISfOu4GBVNxtpfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXBp8Q9c; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXBp8Q9c"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so7470239a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698039; x=1765302839; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3fmXtA0VS/bmYEg2BbSjjVcEoYGv2SDd9KAsTbvG/8=;
        b=XXBp8Q9c2Hl/DqiMY8GTNmYeloHQ3pxQ69BT4M2+fVC+REfQFTxrpOfFxBmSk4lqJA
         Phg/bjhCFWGRxElbfCJKit6UFa+AwpgQXWIyroIIxZA1E3NpDM5iXogkXsxaK04yu6E1
         uDzRE4wXetTbnWmML5v1CLXVHUKX+jFTOrNK0vTSBXUNopwKpJZyd2EDn9T7hr7oQGYU
         LSXCTlldlj8FqB45VPh8xAp8RA73hxtWICwa/pZm4/w+dYwDzCLEJbuTpyJ8Mq7Rzlra
         4n6Do1Qr6uMP87FzKxdQ2/oCppxvrtZMVCaWBD32vu7umRCGZFPLXns5s6YSbxxN/ysY
         vRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698039; x=1765302839;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3fmXtA0VS/bmYEg2BbSjjVcEoYGv2SDd9KAsTbvG/8=;
        b=RfEHktxAQQmQ/VUuHYoYjuZbdsLREfbLFJDUCS9tH2dCJIqJgUNt7wKQvwlpWaZTxm
         kuI4rRn3JQOdH0YhBjOlyKjnv8LMGYxpync2jnod/f4vdWnHNWgxJd7CsddpUrKfQh9G
         fuI3lySpcAYtwH00JJzDpRcZ6yuZxSkGRsnUDdUwDmADUBSf5vTMRSLrnRgJGLRYL4Ij
         fT/T8wNGG8Sc/vXb/XyxXiruvjH/4QwsWA65m8OtpQoBAEuVqosazjuCYgKkZZnOPWbf
         aQMGNVZGsyx6fzkczgSI4htxCnKJ24JjBb9QJN/e7MDi8xEmI0pONTfeDaOVPFdkC233
         BEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWay6C84u9WGl8EBfvHnElRy1fWu2CBfMIxMkOkNazF5eWi7f/rU6Vgwjs4BklQX3NId23wYWIHhqtwr04Xzyh3@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoNhqwHabbTHDQqVXOi7AISoHeuzxXKzMBzHPnMiESdkaih1B
	YsAQj+IKFztatOHXABNxbVtTslV80/fboFGEMy6ySC1/QAu8pMEWk6UJjrLUkuP7e3QF2mwlPIE
	q9itF7WDwgA==
X-Google-Smtp-Source: AGHT+IG+9ilXz5gVmVUIGvBMb1Evs62040WJAwi5pvbFDXSLe38ZR9z1a5GSthOPddBy2hZfZJJtgWL7cxY0
X-Received: from dlbqd22.prod.google.com ([2002:a05:7023:b16:b0:11a:5223:14ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f0b:b0:11b:ca88:c4f5
 with SMTP id a92af1059eb24-11c9d860f40mr18393276c88.35.1764698038740; Tue, 02
 Dec 2025 09:53:58 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:28 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-34-irogers@google.com>
Subject: [PATCH v9 33/48] perf jevents: Add L2 metrics for Intel
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

Give a breakdown of various L2 counters as metrics, including totals,
reads, hardware prefetcher, RFO, code and evictions.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 170 +++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 7fcc0a1c544d..d190d97f4aff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,175 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelL2() -> Optional[MetricGroup]:
+    try:
+        DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
+    except:
+        return None
+    try:
+        DC_MISS = Event("L2_RQSTS.DEMAND_DATA_RD_MISS")
+        l2_dmnd_miss = DC_MISS
+        l2_dmnd_rd_all = DC_MISS + DC_HIT
+    except:
+        DC_ALL = Event("L2_RQSTS.ALL_DEMAND_DATA_RD")
+        l2_dmnd_miss = DC_ALL - DC_HIT
+        l2_dmnd_rd_all = DC_ALL
+    l2_dmnd_mrate = d_ratio(l2_dmnd_miss, interval_sec)
+    l2_dmnd_rrate = d_ratio(l2_dmnd_rd_all, interval_sec)
+
+    DC_PFH = None
+    DC_PFM = None
+    l2_pf_all = None
+    l2_pf_mrate = None
+    l2_pf_rrate = None
+    try:
+        DC_PFH = Event("L2_RQSTS.PF_HIT")
+        DC_PFM = Event("L2_RQSTS.PF_MISS")
+        l2_pf_all = DC_PFH + DC_PFM
+        l2_pf_mrate = d_ratio(DC_PFM, interval_sec)
+        l2_pf_rrate = d_ratio(l2_pf_all, interval_sec)
+    except:
+        pass
+
+    DC_RFOH = None
+    DC_RFOM = None
+    l2_rfo_all = None
+    l2_rfo_mrate = None
+    l2_rfo_rrate = None
+    try:
+        DC_RFOH = Event("L2_RQSTS.RFO_HIT")
+        DC_RFOM = Event("L2_RQSTS.RFO_MISS")
+        l2_rfo_all = DC_RFOH + DC_RFOM
+        l2_rfo_mrate = d_ratio(DC_RFOM, interval_sec)
+        l2_rfo_rrate = d_ratio(l2_rfo_all, interval_sec)
+    except:
+        pass
+
+    DC_CH = None
+    try:
+        DC_CH = Event("L2_RQSTS.CODE_RD_HIT")
+    except:
+        pass
+    DC_CM = Event("L2_RQSTS.CODE_RD_MISS")
+    DC_IN = Event("L2_LINES_IN.ALL")
+    DC_OUT_NS = None
+    DC_OUT_S = None
+    l2_lines_out = None
+    l2_out_rate = None
+    wbn = None
+    isd = None
+    try:
+        DC_OUT_NS = Event("L2_LINES_OUT.NON_SILENT",
+                          "L2_LINES_OUT.DEMAND_DIRTY",
+                          "L2_LINES_IN.S")
+        DC_OUT_S = Event("L2_LINES_OUT.SILENT",
+                         "L2_LINES_OUT.DEMAND_CLEAN",
+                         "L2_LINES_IN.I")
+        if DC_OUT_S.name == "L2_LINES_OUT.SILENT" and (
+                args.model.startswith("skylake") or
+                args.model == "cascadelakex"):
+            DC_OUT_S.name = "L2_LINES_OUT.SILENT/any/"
+        # bring is back to per-CPU
+        l2_s = Select(DC_OUT_S / 2, Literal("#smt_on"), DC_OUT_S)
+        l2_ns = DC_OUT_NS
+        l2_lines_out = l2_s + l2_ns
+        l2_out_rate = d_ratio(l2_lines_out, interval_sec)
+        nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
+        wbn = d_ratio(nlr, interval_sec)
+        isd = d_ratio(l2_s, interval_sec)
+    except:
+        pass
+    DC_OUT_U = None
+    l2_pf_useless = None
+    l2_useless_rate = None
+    try:
+        DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
+        l2_pf_useless = DC_OUT_U
+        l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
+    except:
+        pass
+    DC_WB_U = None
+    DC_WB_D = None
+    wbu = None
+    wbd = None
+    try:
+        DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
+        DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
+        wbu = d_ratio(DC_WB_U, interval_sec)
+        wbd = d_ratio(DC_WB_D, interval_sec)
+    except:
+        pass
+
+    l2_lines_in = DC_IN
+    l2_code_all = (DC_CH + DC_CM) if DC_CH else None
+    l2_code_rate = d_ratio(l2_code_all, interval_sec) if DC_CH else None
+    l2_code_miss_rate = d_ratio(DC_CM, interval_sec)
+    l2_in_rate = d_ratio(l2_lines_in, interval_sec)
+
+    return MetricGroup("lpm_l2", [
+        MetricGroup("lpm_l2_totals", [
+            Metric("lpm_l2_totals_in", "L2 cache total in per second",
+                   l2_in_rate, "In/s"),
+            Metric("lpm_l2_totals_out", "L2 cache total out per second",
+                   l2_out_rate, "Out/s") if l2_out_rate else None,
+        ]),
+        MetricGroup("lpm_l2_rd", [
+            Metric("lpm_l2_rd_hits", "L2 cache data read hits",
+                   d_ratio(DC_HIT, l2_dmnd_rd_all), "100%"),
+            Metric("lpm_l2_rd_hits", "L2 cache data read hits",
+                   d_ratio(l2_dmnd_miss, l2_dmnd_rd_all), "100%"),
+            Metric("lpm_l2_rd_requests", "L2 cache data read requests per second",
+                   l2_dmnd_rrate, "requests/s"),
+            Metric("lpm_l2_rd_misses", "L2 cache data read misses per second",
+                   l2_dmnd_mrate, "misses/s"),
+        ]),
+        MetricGroup("lpm_l2_hwpf", [
+            Metric("lpm_l2_hwpf_hits", "L2 cache hardware prefetcher hits",
+                   d_ratio(DC_PFH, l2_pf_all), "100%"),
+            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses",
+                   d_ratio(DC_PFM, l2_pf_all), "100%"),
+            Metric("lpm_l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
+                   l2_useless_rate, "100%") if l2_useless_rate else None,
+            Metric("lpm_l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
+                   l2_pf_rrate, "100%"),
+            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
+                   l2_pf_mrate, "100%"),
+        ]) if DC_PFH else None,
+        MetricGroup("lpm_l2_rfo", [
+            Metric("lpm_l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
+                   d_ratio(DC_RFOH, l2_rfo_all), "100%"),
+            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
+                   d_ratio(DC_RFOM, l2_rfo_all), "100%"),
+            Metric("lpm_l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
+                   l2_rfo_rrate, "requests/s"),
+            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
+                   l2_rfo_mrate, "misses/s"),
+        ]) if DC_RFOH else None,
+        MetricGroup("lpm_l2_code", [
+            Metric("lpm_l2_code_hits", "L2 cache code hits",
+                   d_ratio(DC_CH, l2_code_all), "100%") if DC_CH else None,
+            Metric("lpm_l2_code_misses", "L2 cache code misses",
+                   d_ratio(DC_CM, l2_code_all), "100%") if DC_CH else None,
+            Metric("lpm_l2_code_requests", "L2 cache code requests per second",
+                   l2_code_rate, "requests/s") if DC_CH else None,
+            Metric("lpm_l2_code_misses", "L2 cache code misses per second",
+                   l2_code_miss_rate, "misses/s"),
+        ]),
+        MetricGroup("lpm_l2_evict", [
+            MetricGroup("lpm_l2_evict_mef_lines", [
+                Metric("lpm_l2_evict_mef_lines_l3_hot_lru", "L2 evictions M/E/F lines L3 hot LRU per second",
+                       wbu, "HotLRU/s") if wbu else None,
+                Metric("lpm_l2_evict_mef_lines_l3_norm_lru", "L2 evictions M/E/F lines L3 normal LRU per second",
+                       wbn, "NormLRU/s") if wbn else None,
+                Metric("lpm_l2_evict_mef_lines_dropped", "L2 evictions M/E/F lines dropped per second",
+                       wbd, "dropped/s") if wbd else None,
+                Metric("lpm_l2_evict_is_lines_dropped", "L2 evictions I/S lines dropped per second",
+                       isd, "dropped/s") if isd else None,
+            ]),
+        ]),
+    ], description="L2 data cache analysis")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
     pipeline_events = json.load(
         open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
@@ -386,6 +555,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelL2(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.52.0.158.g65b55ccf14-goog

