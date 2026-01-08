Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364F33343C
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899535; cv=none; b=ijUPdj1OAOvfqjG1mEl2732zyvaGWo/dXWCzYNefKTFvInA5T4M/IzdkxgrDfvNVPaYQcM9vRdt2KUzvzxq5qD5X2cQPLJ8RKcZiP9Nzm0qThhB8OSWlojbzMi66guB82uEmaYDgYI4D1q0bkLMjC2CPJfVX+u2qxyq9cWugJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899535; c=relaxed/simple;
	bh=BuZQB1JrWPbol810BNiSgRTMMbqOOuEypIktx0AEIeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LmaXNn7bSr39RzGRgjKZi1KXfwIkaYIBL6uAeA7VWaDRt69cN4Sco9SC+4YB3o2ovRVbEEjPtl+JBfse+V156b1F/Pr1+zYRXuRhfILxvmxhOmcNc18EaHqw0CA31EIQD0pg+AsNGsOrMONGJix4ER9YX2SkE9a2xSyFAoEgCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSyFBcCX; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSyFBcCX"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-121adbf76c3so4041310c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899533; x=1768504333; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tp6WggX015VKfu2PeZYMD7tqCi4geCJV/SpM3J5HtbY=;
        b=qSyFBcCXN5bt9sbSZx9WHCiyof8t+2E6RzlYCkzFdBrIGIi0D/8/C1cqmn0MKLVHqX
         Ixpx7ufZN4ADxsH1/v5Hme2Zuo/4Rv1nCtXWYMbTu5HpN3Fd2qfnVUpLZ1hDwv5Yzhmq
         fVKsP150Psa0g6JxFW9BwUU/URLyy3wBLx8dcUesQDV2RiVpBGYMk5U/nAYT0EVJFP64
         K7L2otnO8rYKzdScAClV90BYjH9js64O+dcSxDp69lbM0K6AZy9DXS0V/+/ySbTLS6FQ
         Q+Nng4NsnOVj/fnC6R6gI7HkMwR5+ZPRpASwbww//5e8bG8d7HlNB7J/rosPO9oYdZym
         Pp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899533; x=1768504333;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tp6WggX015VKfu2PeZYMD7tqCi4geCJV/SpM3J5HtbY=;
        b=KNltdROsf6JnqJq8dDFE+uAqZl1HN6UTlyO9PxU2vC+e3C3zN1/w/pZ/1iWuM66tCl
         ezy0NNwGPGmqd6JXMsEJDIlp/p+c655eq/gBbcFCscBQ3oI5oaRoNRYAwteN8eTvYR14
         fNHgLl+pSvsfCH0gjonsNYvtqSK2QF9IvQRvK8uYPLcySN+a7SvlLUS4ArR6Wq2jafwX
         W+aslJ7wTt5HPw/yTgjjW3c/nVFUgqipg/CH2jJAqRD/OW89leUYihKO5Mo/eAwcgNpw
         2HqLUAlT2OG3aIPV7Re8h3Cs43EhnWLps4ShdmBoTumQ8l+dEFqsZy7onTol85Cycmqp
         UZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj62NP3J5eTkdiIXUHfGJtUrM07R4Uo3fgdG+Q50ydZgAnmX3tH3JQQV6x8phEiW//1ACg2HzKdHKW4Nbtm13Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyThPLgvIYVUbj0MHo62rbtO27RM2lr8+cHVygKOmxqBiGe2qnh
	pxI8UEzWjLDOp7X0erlNvFAnupch20JEyvIIH+UZBfieuElhfLoPWlbxNBzSs0+Ha5+0MXRxKnV
	uFlLwPxAX/Q==
X-Google-Smtp-Source: AGHT+IEkNeaw4l1TXm0xbrE4AQ0rsg1YnY4TSJt+WAoehhtjkqQ5DltCA8HTBoevtZoEo8as+gkI/Wy3ZT4d
X-Received: from dlbqy8.prod.google.com ([2002:a05:7022:ef08:b0:11f:3701:ba81])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238b:b0:119:fac9:ce12
 with SMTP id a92af1059eb24-121f8b145c6mr5625476c88.13.1767899533472; Thu, 08
 Jan 2026 11:12:13 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:55 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-26-irogers@google.com>
Subject: [PATCH v10 25/35] perf jevents: Add FPU metrics for Intel
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

