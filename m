Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1931A057
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004134; cv=none; b=n2wI/nf8YRPOX83WxvAfiqTwED3s7/y7S3O0HZVKqPG2leJ72cNPDnacv5lwaXuXNk82aGudOY51l900ct/FF+QATVvzRAwbOQBRnz9IjOkdPvVwYVLyrk6c6KFZasUpqXVefsp8niZcHcKDLIuqVHkuCFKnldwaW5VvxhUMCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004134; c=relaxed/simple;
	bh=d4RxGLSdFIeTYV96kruzxgnuztTngpebtrIgct661XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=B7nzxotFGRVqqlrJG2Y2iMrqH9bc8Gidb60e9S0JxsHoJPJ4RzVCieb1VXgQlaZXeqHQfc4QklUNXhhS+M8OgxzRG4Ra0zX2aq+yB5okJs4cEXbGNT/aKWf/gThOpaoyopMfymlA8283ASRelmk0m8XZclP0JTRfWfl1yLhq014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiC/hXZI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiC/hXZI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2980ef53fc5so10086965ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004132; x=1763608932; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKqE3/yUj8MumMyIK9pHYeAOfW6nk8QbcPfRfBVP11k=;
        b=kiC/hXZIW48a1cYhm9QRZDNEZFvGdcs7+LBsZaQj8RiI6Sz1s59w4eKfbHP/ESFy/P
         BV0sJ5782isrACb6dnsgpEh5fVrRvPL4UsAtiqcrKlkaJDCANWK5Q56I1OxKaMRS+yQq
         6D5bPEnkPi99gefMamcdKTaM9MRvLyEyuBp+/31uhk32cBVfZYOMBKGAA+UUeTDRJHnt
         k7JtAiUbnVbOjOyTTKr5x858JHYnswdeVQfitDu3DVanZlLL1JFBhGyOdXgu5TCE/4BK
         sSnh6+Hno0iIY2goUtjmCmxQYKlLiWmmbaCxpi0a+9r2en0nX6neagPkeK0FZiq5/R4N
         dylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004132; x=1763608932;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqE3/yUj8MumMyIK9pHYeAOfW6nk8QbcPfRfBVP11k=;
        b=oKNhddVID+xZQmD43X3scbty/s0mEDrRHyDn//lhN4zt8mGjfEDPKGp6Bpw7pFWgd7
         yaUuMbtTxHbH5VNlEmFfj+k5ebMnIORNWYDQtcDW1aH8ToTjPCtBB3mDSsBgJ7zWaLsi
         1TXPOY856MyKOSiwH5neNoWF0N8CQyqqr+dLR4/Zo3FotWf5Vhu3kLu9tyva6s3PNIGM
         qzp6C6XvJA9YzNbpfXBMf+gmSBzog0KBZGKlSuHOCS5wyij8kd28oFJrBa79fsY/q1Ss
         IgbxCRZgOW1GKmxA0uDmgGOPE/t2sGIhxU1KyjJ4JHDomPXl7sNnyJMaHrt2tXTZfsPd
         0H6w==
X-Forwarded-Encrypted: i=1; AJvYcCUGe50MJoHLpan7P8cEEnwqIqyw0W1Z1cROXfdEQnh+hh7WiJMzcRWJplq/LYqd3/UQV6YPO4sCOWtVWAEiB5Cw@vger.kernel.org
X-Gm-Message-State: AOJu0YxycRqgWC6ik7cGq1KLdLlPC+97c0hxkzyxGHfQ4wUGnTm6kbSP
	rWtwHXVqQ9u900hJB4Wh/4a2uZdRp4gUWBCRM7z1wumMgxxYk1CpwtRZNjYrb1vFJ3BKx3Mk9Cp
	6tEgbXGGm6w==
X-Google-Smtp-Source: AGHT+IGTAgI7kyVDNSTXGTAp6u8q7KFtPSl45CEhXLw84AiAiZn6LPcNi40toInj8/yjq+uquBDZPly4Sk0P
X-Received: from dlah24.prod.google.com ([2002:a05:701b:2618:b0:119:49ca:6ba2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0e:b0:295:54cd:d2dc
 with SMTP id d9443c01a7336-2984ed48921mr77228725ad.16.1763004132359; Wed, 12
 Nov 2025 19:22:12 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:29 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-42-irogers@google.com>
Subject: [PATCH v8 41/52] perf jevents: Add FPU metrics for Intel
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

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 97 ++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 9cf4bd8ac769..77b8e10194db 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -320,6 +320,102 @@ def IntelCtxSw() -> MetricGroup:
                                     "retired & core cycles between context switches"))
 
 
+def IntelFpu() -> Optional[MetricGroup]:
+    cyc = Event("cycles")
+    try:
+        s_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+                     "SIMD_INST_RETIRED.SCALAR_SINGLE")
+    except:
+        return None
+    d_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+                 "SIMD_INST_RETIRED.SCALAR_DOUBLE")
+    s_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+                  "SIMD_INST_RETIRED.PACKED_SINGLE")
+
+    flop = s_64 + d_64 + 4 * s_128
+
+    d_128 = None
+    s_256 = None
+    d_256 = None
+    s_512 = None
+    d_512 = None
+    try:
+        d_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE")
+        flop += 2 * d_128
+        s_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE")
+        flop += 8 * s_256
+        d_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE")
+        flop += 4 * d_256
+        s_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE")
+        flop += 16 * s_512
+        d_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE")
+        flop += 8 * d_512
+    except:
+        pass
+
+    f_assist = Event("ASSISTS.FP", "FP_ASSIST.ANY", "FP_ASSIST.S")
+    if f_assist in [
+        "ASSISTS.FP",
+        "FP_ASSIST.S",
+    ]:
+        f_assist += "/cmask=1/"
+
+    flop_r = d_ratio(flop, interval_sec)
+    flop_c = d_ratio(flop, cyc)
+    nmi_constraint = MetricConstraint.GROUPED_EVENTS
+    if f_assist.name == "ASSISTS.FP":  # Icelake+
+        nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+    def FpuMetrics(group: str, fl: Optional[Event], mult: int, desc: str) -> Optional[MetricGroup]:
+        if not fl:
+            return None
+
+        f = fl * mult
+        fl_r = d_ratio(f, interval_sec)
+        r_s = d_ratio(fl, interval_sec)
+        return MetricGroup(group, [
+            Metric(f"{group}_of_total", desc + " floating point operations per second",
+                   d_ratio(f, flop), "100%"),
+            Metric(f"{group}_flops", desc + " floating point operations per second",
+                   fl_r, "flops/s"),
+            Metric(f"{group}_ops", desc + " operations per second",
+                   r_s, "ops/s"),
+        ])
+
+    return MetricGroup("lpm_fpu", [
+        MetricGroup("lpm_fpu_total", [
+            Metric("lpm_fpu_total_flops", "Floating point operations per second",
+                   flop_r, "flops/s"),
+            Metric("lpm_fpu_total_flopc", "Floating point operations per cycle",
+                   flop_c, "flops/cycle", constraint=nmi_constraint),
+        ]),
+        MetricGroup("lpm_fpu_64", [
+            FpuMetrics("lpm_fpu_64_single", s_64, 1, "64-bit single"),
+            FpuMetrics("lpm_fpu_64_double", d_64, 1, "64-bit double"),
+        ]),
+        MetricGroup("lpm_fpu_128", [
+            FpuMetrics("lpm_fpu_128_single", s_128,
+                       4, "128-bit packed single"),
+            FpuMetrics("lpm_fpu_128_double", d_128,
+                       2, "128-bit packed double"),
+        ]),
+        MetricGroup("lpm_fpu_256", [
+            FpuMetrics("lpm_fpu_256_single", s_256,
+                       8, "128-bit packed single"),
+            FpuMetrics("lpm_fpu_256_double", d_256,
+                       4, "128-bit packed double"),
+        ]),
+        MetricGroup("lpm_fpu_512", [
+            FpuMetrics("lpm_fpu_512_single", s_512,
+                       16, "128-bit packed single"),
+            FpuMetrics("lpm_fpu_512_double", d_512,
+                       8, "128-bit packed double"),
+        ]),
+        Metric("lpm_fpu_assists", "FP assists as a percentage of cycles",
+               d_ratio(f_assist, cyc), "100%"),
+    ])
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -736,6 +832,7 @@ def main() -> None:
         Tsx(),
         IntelBr(),
         IntelCtxSw(),
+        IntelFpu(),
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

