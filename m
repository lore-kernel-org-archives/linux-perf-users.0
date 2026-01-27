Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1736A013
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539580; cv=none; b=Xu+4TXHQpikKMXRfanfR5je9ehBcUueK5bpPLVhAVJ3hvvrAGbFvhXNPQj/wzKgf2fqR+RAMjgTTA3oxfZmbsRzsYHbJya3kJlO/SMus+w5ro9Ua6+pZJiGZ1t+pbFEZqA5ycGIJkJrztNYUfpiIxUC5HesYciGW5Iay19u0icQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539580; c=relaxed/simple;
	bh=BuZQB1JrWPbol810BNiSgRTMMbqOOuEypIktx0AEIeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Uqm5kH20kNh7YaI0VXNt+I9FtvQpPavYJ1+8af4Nh/OR9yDLJbUY9g+xT+Bd6a+dx6PZONiHcWZ9j2WZ9A6Uupp3t6oGmWHaDoL6mzH9X8ymbh7JMrjzWAoTJ+uKbhVDAXwSQTVWuTwOcd9ENZfK/St1lGRD8s4JDS7kMJJm62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICrehh2/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICrehh2/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so18717577c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539575; x=1770144375; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tp6WggX015VKfu2PeZYMD7tqCi4geCJV/SpM3J5HtbY=;
        b=ICrehh2/EcnhwDO/z44FUXyyRd/3KzTcstnW37DrQ4dfYMeKxqHkM58lMQTDVbKIiV
         OPgX+FXxnqI/revokzhdlZLSZXoHW6qGlvITo2Fa52snRfLln7Uqv78z1gcM1qSrqVtT
         fdItVQufrv6mo+4mJl3KC6UdHBagLWu23JLojklXDRaNIvmfQYsnXtzAvdQ7eeZLDoIg
         TUxKR+MpQnWySKycSH8yXNlh26zOZLuEMlbneAS3O+NErtMGRX7QxTh7xZpnVzwlysCZ
         486qVkxxx7figcfaCfEICsxtsVfk7zp6JyvwrxBZxsawPtmk9xBNM3oxOhTXHh0h3SU6
         UZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539575; x=1770144375;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tp6WggX015VKfu2PeZYMD7tqCi4geCJV/SpM3J5HtbY=;
        b=nmB6OzFnzoPGTDTGolzq2faXL6ylobNwJqN/mI7TDmNfs3OCpSDRY/lc96xvc67sSJ
         /JNzPHXhecmHSLpLSJ68DVm7kHd2CvVICwZjzB6icukFw3f3t3/jEO4tqpQWgVfVzvnj
         +wGevGmdlqN0Tf0e6ZF/QauLt6M7ij+GMZCqByND3uJsgSYsOgNqk7LeoECQi4MNH410
         PVD5wAppXsMuRbLnqDfKBu+0bZVZCmY7bfHMSlRMHwrdwMyTAHKDrH+geaOsJO+h7fWf
         n/4N3o9a54SiZVnMUykzCQVwa44KVEdjiEQcvaBwNlLpWYTQQ5RAgRBgELw5Oo6FwaM7
         ht+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWswYknWsneqizzUR9XOt54/rn3BVlBJFbTCw0pZVqqjTcDPMJsMTkcgrJZyaaOk2ta1S7nJz9YdZFnK2f/RUUi@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGv7RS/tcouHHz558YZy1I3TGoYoOQGiOS5yQAEcBXoflCoDy
	vE3rSZDugV4h1OFmFTOAQ2+5x237PrmvVisSAJru7Fo1WJIRz2YAgCKZ0R/BUJrT+0/t0eo4XCw
	8Bmqo9S7g0w==
X-Received: from dlbrl14.prod.google.com ([2002:a05:7022:f50e:b0:119:78ff:fe10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6609:b0:11b:8161:5cfc
 with SMTP id a92af1059eb24-124a00c4cbamr1673614c88.36.1769539574570; Tue, 27
 Jan 2026 10:46:14 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:56 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-26-irogers@google.com>
Subject: [PATCH v11 25/35] perf jevents: Add FPU metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

