Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FD270EA3
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961247; cv=none; b=aeFFG3Aoh59iK/la0Dgg1pHZpDt4gZRA8qiAI3rN/BsisdaXvlsaQsKdf21/bxjxFOcEsq4yHbrPo7PkccxSC4ulaxXpUJ2TUIyqEkCZg/DXoKidjoQVGVgw34hhOqDIsPg2uE8XaB+YGkjTYa70VVSUC1bPUEDwqhgN8xz7yfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961247; c=relaxed/simple;
	bh=YdTxH6y9frl+TnZ/HrOjpMGClf5sE6yVwuacJCa6Jxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tBsAhdnZXZJkiWD5UJPI7gNTBT/XrU6Z4RWPBh4ErhmuYTwFP5d9DnkO02lBKSzlOv+UyehPBzsn+klrjnzBzd6UPJ2NsryNXNBo5yvo2EdGEqoCR/tsXpyj9X75Cll1Xlx9YNS8o7lhxK2ZYuxqHm7BsfFG9tv0uQz646xkMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEr/1zLB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEr/1zLB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24b2336e513so9471625ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961245; x=1757566045; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mmPdAGXEOE7KWx2biXig5nimTGrLZ/rJCGEveCUCIo=;
        b=UEr/1zLBHeob6ZkVriqMCM84I7JFPzq79heSp8XIbiavrwfXraZOGRurikUSDG/LRY
         x6piW0V1cG0zCRK8YHCHe9+S9S7SmoBXb00oOiVWT1dzv9SlJ7uabtjAUJOnkXP5fnCX
         rIeJuY/RnWjhTl/lcSEn8/40aJ6sZFVnbH2kQEr114QJdZbMu+g3q+2IBDS1M/ifzRhl
         gBeTyiGgX8+FqNas2RELQodOkGudbndo0i2YT+U8bSuEZPT9/BYz8n7YsUeEixXgKfUh
         ctoDSVjDrNrwSOWWBl3TIVrQiUOKK4mGxABfmfRMgo+bN0BkX6IvpspMfu0H/byrYHh4
         3SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961245; x=1757566045;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mmPdAGXEOE7KWx2biXig5nimTGrLZ/rJCGEveCUCIo=;
        b=P3u7CmB8mA4f8VQlaIeNuaCs6o5hlAhgY+kP3oUQYPJNUVwp4cMQgDB1XIyScVJB5U
         8kogGB4+dpdZKUC9oOjSQrAtxWmHu8jSLRMIu6xZcYJTyAv+yuyrFsWyg+jmoWSpV87W
         W05SNSqBq+seHJq4EnjvJZ062wwoLW2WQoqfDkJY4g6XgG9EihhvjTx/4KfjEayXDZca
         QPw9nfA8+kxGR340ffwWbvzAvUEDkJyVkVPFT/v5dFlG79BNMRfMcFlzi09P1RhFieRT
         DYPO/RmxuXTR/adQ67uqp1x6z66BYcysdezRjUwUybmZg4BRPJM00d7BB9JNVf0ZX/Vu
         /J3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRLOWZRNZRYFSXKc8FzX4K0DrSpCigCxzAmVmgat2u0Q8IjlUihOE9iiYHo2eljnohDixg2HwHhAVrNmVIlWO7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+54zf2/jJsCFhpjO/iHNIA+iuspKM/ULSXAVUj5GDhXU9wBi3
	u45d96zcloD5hvRcE7cINGmARnkpX3+DbDWIMABAWZC1cnZmW24ea8HB4rixNTPDGMhz9IawPzw
	IoX4NGirAfA==
X-Google-Smtp-Source: AGHT+IFSb7A1naP6p2n4aNPq8tRsJFKT5ufQ2kKcOl1qT+JbNNjd6iTpSw07G6Grzp6VvWF4c2ILkSFUSRPL
X-Received: from pjbst6.prod.google.com ([2002:a17:90b:1fc6:b0:32b:95bb:dbc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:24c:cf7e:e48b
 with SMTP id d9443c01a7336-24ccf7eea02mr2859345ad.8.1756961244796; Wed, 03
 Sep 2025 21:47:24 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:45 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-15-irogers@google.com>
Subject: [PATCH v6 14/22] perf jevents: Add FPU metrics for Intel
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4f8dc054ad98..ff571256e100 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -316,6 +316,95 @@ def IntelCtxSw() -> MetricGroup:
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
+  return MetricGroup("lpm_fpu", [
+      MetricGroup("lpm_fpu_total", [
+          Metric("lpm_fpu_total_flops", "Floating point operations per second",
+                 flop_r, "flops/s"),
+          Metric("lpm_fpu_total_flopc", "Floating point operations per cycle",
+                 flop_c, "flops/cycle", constraint=nmi_constraint),
+      ]),
+      MetricGroup("lpm_fpu_64", [
+          FpuMetrics("lpm_fpu_64_single", s_64, 1, "64-bit single"),
+          FpuMetrics("lpm_fpu_64_double", d_64, 1, "64-bit double"),
+      ]),
+      MetricGroup("lpm_fpu_128", [
+          FpuMetrics("lpm_fpu_128_single", s_128, 4, "128-bit packed single"),
+          FpuMetrics("lpm_fpu_128_double", d_128, 2, "128-bit packed double"),
+      ]),
+      MetricGroup("lpm_fpu_256", [
+          FpuMetrics("lpm_fpu_256_single", s_256, 8, "128-bit packed single"),
+          FpuMetrics("lpm_fpu_256_double", d_256, 4, "128-bit packed double"),
+      ]),
+      MetricGroup("lpm_fpu_512", [
+          FpuMetrics("lpm_fpu_512_single", s_512, 16, "128-bit packed single"),
+          FpuMetrics("lpm_fpu_512_double", d_512, 8, "128-bit packed double"),
+      ]),
+      Metric("lpm_fpu_assists", "FP assists as a percentage of cycles",
+             d_ratio(f_assist, cyc), "100%"),
+  ])
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -726,6 +815,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelCtxSw(),
+      IntelFpu(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.51.0.338.gd7d06c2dae-goog

