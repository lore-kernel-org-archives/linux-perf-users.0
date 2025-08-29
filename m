Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91822F386
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440717; cv=none; b=rYfI2TiZU6ZTjdG+rMqkr+x0CZGUyHHNhHXsJDF6PXm2BLRAIioAmB6EW+X3bDOqY5SmPtSbuwjCfzTr3RF0fF5Kh++CHwrcrEBWcILXPUs8rwDoSqpodDGH4c5FWQhqpPoaVcI/QacvYtByT/GHL+jCADDJRpEYR6+XQ9hVTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440717; c=relaxed/simple;
	bh=q83pyc9GwTrguYLrYC4MdMLJFIeKfzXqJnH4QUMmSJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p7RHlqMUptfZvMX4QVJVHsSDtXe8n0ATTtJIY6bvdH8f7gzM4cKqE5+wR4089fRhZ+Kkz1nnxqG0+9of/VrQlEloJGPSy4I7l/7LP5V3v3bWSnxfyGFbfgfseRI98visjM/EzkaW9FnrxI+SdBB1PjJqSNPdEW0PAOFElGaplfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pj7+Qh4M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj7+Qh4M"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246f49067bdso17369375ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440715; x=1757045515; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0cMwOEM/cnBM/HBeAizuwInf3eDMHHlC2/oycrMsIo=;
        b=pj7+Qh4MKt0+8pd04SGb8waXgLXlalzROEBOZQgr2IJUBAfgKO/yRAnv7uNDimoI0u
         Ig901m5PRNdGOZPMK/3R+bnaRIncieUwcpPOcKN1jjxzzxN5Dpf1LE34Rn+6vgdPAOC/
         9aLXHRh927fRkINu9YrdSLEZESM99f3BepsstOupjhNqa0d5McCYQ/unRCAsMDmMSHx5
         B/lCvupDG1GI8+gFwO8aBmwkoOyOFnPtbWniaAZSRIPZ0O9GEzB6oBsw2tJy0Q04LF3O
         AU3hVdATYriXCs7asvlrdUBIS+9r7fwrBLdYlRVehQrkYDOYOKiphvCkt2S6lTFRsfAr
         9Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440715; x=1757045515;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0cMwOEM/cnBM/HBeAizuwInf3eDMHHlC2/oycrMsIo=;
        b=FkvQGVYN7Px00dg0qmrgBX2ZWyx4jdBss6IH9wPbSffDbCADR27Fgl+jtp1gMXMlcr
         NvfvWLGa3tuV1k3/YAzIEB77sXzHN2vrsAToCqgN9MfwEYrux6hPu5nK/uME4wVS0zFc
         lNOZCwKd2OFCtf19lXnKmLjy8SJG2IJ5TjNKjNnUeuLIY+zMxLnZ5cziXK7abDMcZKVk
         HDC/gb1diy2axiIJh0B/XAghmEz9ketRziLBpGeYGtYM0FI4fm5Xq6FMbZtw+dl8Zp3v
         +6v4jzXdptQ8upCd24By5yPwNjyb3l1WV6dmMnDUNYOz2HRxBmh2qwQkCXlsRudJJNa3
         zYxg==
X-Forwarded-Encrypted: i=1; AJvYcCXt7TqeNHHAxwnNl6i5QxNislF4cgQAmzC3NCFK6Rv6XftyavxcHxTaN0BQhqtb3Bpf1v75WQB6MGbrbp0MIVX4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc48NEKZIa1R8anKYoyQ/0Kyfa52czz6YdhRd7YRPn363+fuo8
	UxwhUHvUU7Z+gjevoUxyVH5d6GIGl78Z+ORGsJKU0bn1J9zWgcDbICW7mRiIWD/KTLsZTop5OzE
	hzd88Dsv3oA==
X-Google-Smtp-Source: AGHT+IFG1itPkTtQQbyHmTn92hb5Gzvbg2Y1UdKnwq/4E07DnXRMz62rPxrZ++zHt3/Of539sE4behT8oMfB
X-Received: from plbml4.prod.google.com ([2002:a17:903:34c4:b0:246:8cb:7c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c5:b0:23f:df33:21cb
 with SMTP id d9443c01a7336-2462ef4bf58mr321491015ad.44.1756440715457; Thu, 28
 Aug 2025 21:11:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:55 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-15-irogers@google.com>
Subject: [PATCH v5 14/22] perf jevents: Add FPU metrics for Intel
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
index 31ef0373d982..f4d0676cdb77 100755
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
2.51.0.318.gd7df087d1a-goog

