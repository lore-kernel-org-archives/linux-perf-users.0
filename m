Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119418733C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373079; cv=none; b=XM55KaURlTCiOeJR4lQHTfc8sREcOeDOzW6pOsb5Y466JlZMs4Pl8k7hyVS0W+QNcjVLWTcIj8RAyBMRYduCr598QYKwc8xD5FVHpkq4Uj9ztrJIAian0LS3F8omBumuCdrIZ/OHqPzvBol05XOEawmztTFNgrpIJlPWA4V3fKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373079; c=relaxed/simple;
	bh=a2C2DEYeeC0JRttDkbCQGloUW891/rcR9JHhku2TjOA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pK1ce2ckRHf+tG2bYUs+55gao70JRiHxXIkuFZKg+FeLfUurRrQZYNqGDZqDY1mBezTLsglv6VGggw0YxR8B23h0UPt04bWepjLdlJdDjj8NAzpPM1obK9vGkoAU536oVa4eM3gld7vWFz4Zjv6TGAze1mzTMJ4E7cK85rO5ooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wvhm/Fsf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wvhm/Fsf"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5235d1bcaso20327187b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373076; x=1727977876; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTtHCqLrWS9wifwWZYlofn019VV7+dUOgk7GQL5znTY=;
        b=Wvhm/Fsf+Ar7P4eUJfSObFLU4tTDWyF8mUMLNoUaF0Ha06OvONPfbNn97cPw22pAeH
         vvIuYwx+/tbONkMqd+puv+VfqwxpBx9+Cw/7aYfMlUJMQ/Ryj/tbpPBWPd/JVuNsCduD
         tS7jGkC6PfxHrQEmf8QY+ICzUdLvPCoSTCJnBNvbDLMeHaTEi1QEjQuYw82hkmuJgp7T
         3VEyZzlGa53iqi2jx7d2mffnABLj0YpAj8YjpX4ebVvFkGpLqYOBhg67k6zs1zIojDYX
         nSu+EEjoKBfK0+TAPtXs0PLGN4GrvV49NXIpqD9bC+zIiNmfsgjasVax/fMeYWA93ptI
         i/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373076; x=1727977876;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTtHCqLrWS9wifwWZYlofn019VV7+dUOgk7GQL5znTY=;
        b=doMkHcwdXK5X2bsb2DcbsoKWz/6KA8MCqrVYh/y8Yjd7G92sEJ8AJzUKHhq+R3ixXY
         pp7aP+LTEG64NGL1JQIMa3yY05J+6+KHbRu5mPOB/2eRxTwC+9NkTSH4wAPH3sM67Z9W
         wwhg0m4TKDzAG6mhFl/5ce8ozmIgy3ezz24nxPrLsZadsOCKfUZKQ4ktaka51ONdR+wL
         vCjTjwNt6ljaFo1VZWfbGefUssyVkglATCEfGTC9toc7CMauZ5htusbC26+Vq4n5D6z5
         U8c7VGhA8/ElHkDiTmS2oBpH08diedE1mRMXLTJaJa3avMCihZWJC4Dw9w19MgFN1Qu3
         zurg==
X-Forwarded-Encrypted: i=1; AJvYcCVW0wGhsdhLK3L5TOomzIDcTLQ/brw+2sUGiK2eT/zICNN+HLdTH9HNNhVVoNJSBBqvUxWWbjHbaxuNVGQwvHZG@vger.kernel.org
X-Gm-Message-State: AOJu0YzLat7CdtZ3+AtT80+xyGiwXYfIo+jCNxXwrCUeVVzeRJ3l367n
	hbXlQIy0wK7fGzAMPQSDfmf36dbpIcrg0oiuw73nK2AoDocyTQt/o/EjyTVuLvmk27ZBu0Joa4m
	RWG2ykA==
X-Google-Smtp-Source: AGHT+IEhmvvlqELFMwtlv7WFBXlsutk/M7yr5CVNk/56bWPPeXVWPBKiG8rOsNY4PBMAfKgELecg5HFbD5x5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:a527:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e2604b45318mr289276.5.1727373076537; Thu, 26 Sep 2024 10:51:16
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:27 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 14/22] perf jevents: Add FPU metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 7cd933a28cfd..dc14fff7abc3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -315,6 +315,95 @@ def IntelCtxSw() -> MetricGroup:
                                     "retired & core cycles between context switches"))
 
 
+def IntelFpu() -> Optional[MetricGroup]:
+  cyc = Event("cycles")
+  try:
+    s_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+                 "SIMD_INST_RETIRED.SCALAR_SINGLE")
+  except:
+    return None
+  d_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+               "SIMD_INST_RETIRED.SCALAR_DOUBLE")
+  s_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+                "SIMD_INST_RETIRED.PACKED_SINGLE")
+
+  flop = s_64 + d_64 + 4 * s_128
+
+  d_128 = None
+  s_256 = None
+  d_256 = None
+  s_512 = None
+  d_512 = None
+  try:
+    d_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE")
+    flop += 2 * d_128
+    s_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE")
+    flop += 8 * s_256
+    d_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE")
+    flop += 4 * d_256
+    s_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE")
+    flop += 16 * s_512
+    d_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE")
+    flop += 8 * d_512
+  except:
+    pass
+
+  f_assist = Event("ASSISTS.FP", "FP_ASSIST.ANY", "FP_ASSIST.S")
+  if f_assist in [
+      "ASSISTS.FP",
+      "FP_ASSIST.S",
+  ]:
+    f_assist += "/cmask=1/"
+
+  flop_r = d_ratio(flop, interval_sec)
+  flop_c = d_ratio(flop, cyc)
+  nmi_constraint = MetricConstraint.GROUPED_EVENTS
+  if f_assist.name == "ASSISTS.FP": # Icelake+
+    nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+  def FpuMetrics(group: str, fl: Optional[Event], mult: int, desc: str) -> Optional[MetricGroup]:
+    if not fl:
+      return None
+
+    f = fl * mult
+    fl_r = d_ratio(f, interval_sec)
+    r_s = d_ratio(fl, interval_sec)
+    return MetricGroup(group, [
+        Metric(f"{group}_of_total", desc + " floating point operations per second",
+               d_ratio(f, flop), "100%"),
+        Metric(f"{group}_flops", desc + " floating point operations per second",
+               fl_r, "flops/s"),
+        Metric(f"{group}_ops", desc + " operations per second",
+               r_s, "ops/s"),
+    ])
+
+  return MetricGroup("fpu", [
+      MetricGroup("fpu_total", [
+          Metric("fpu_total_flops", "Floating point operations per second",
+                 flop_r, "flops/s"),
+          Metric("fpu_total_flopc", "Floating point operations per cycle",
+                 flop_c, "flops/cycle", constraint=nmi_constraint),
+      ]),
+      MetricGroup("fpu_64", [
+          FpuMetrics("fpu_64_single", s_64, 1, "64-bit single"),
+          FpuMetrics("fpu_64_double", d_64, 1, "64-bit double"),
+      ]),
+      MetricGroup("fpu_128", [
+          FpuMetrics("fpu_128_single", s_128, 4, "128-bit packed single"),
+          FpuMetrics("fpu_128_double", d_128, 2, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_256", [
+          FpuMetrics("fpu_256_single", s_256, 8, "128-bit packed single"),
+          FpuMetrics("fpu_256_double", d_256, 4, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_512", [
+          FpuMetrics("fpu_512_single", s_512, 16, "128-bit packed single"),
+          FpuMetrics("fpu_512_double", d_512, 8, "128-bit packed double"),
+      ]),
+      Metric("fpu_assists", "FP assists as a percentage of cycles",
+             d_ratio(f_assist, cyc), "100%"),
+  ])
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -707,6 +796,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelCtxSw(),
+      IntelFpu(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.46.1.824.gd892dcdcdd-goog

