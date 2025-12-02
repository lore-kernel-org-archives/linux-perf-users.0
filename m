Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A872D7814
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698058; cv=none; b=CqfEjaMIqI2cAKKHcg0BhwexdUSHYjjxGJefm3kslx4gPQcKCaGmn9iY9Pke2+u+v/PWjBZs8kE0DrmwMTvYSNwwdmTPjpYLvwCE8li7jPF0iiq+iM5aoN70pHypYyeiqWZVuvDTPBazULo7BWyxTlg5X7aVl3x0z60rhnnpQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698058; c=relaxed/simple;
	bh=7nI0hEnDbiKkHZA8PtES6A2M3eDxdTPLzXJex2BVts0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P7ETOupaI33OFVpcihwnmaecA7MLj5T4iToBB3pWkvpu40CE+8/ujDVvqEulh+pwk0Sh7Om2lJX8R9vNNId/hdciZrHb6wHgbqjfPv1k5D4JwNMDzHsR0BkFQ9ibGSeIBDWFpP6/Ic9ety2GkIcrCy5GREEe8vlj+nhy4Lngw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCvJuc+K; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCvJuc+K"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so9500818a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698056; x=1765302856; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4/xhOVEERyGr7SvaMrLMTc7V1kN7o1fokcuP75TU7s=;
        b=cCvJuc+KQGf9gjyktMvoqJBPv2QQroONHWctABmio9l1ymi6Z8HkLlUGwBiam1wZC6
         zdKV6vnDvLFhVayAZFcT/g5AidQyWKEQsBQSh81evCIBldy/2u0b3IFe2Ysw/7waAIh2
         xz4Vv41Ikyz6f8JlqWqDR8thuUHLPnauNjt6KTc6QYdSsc75GjyTfZTchUKUjUf//Pin
         mlKng4yRG88GQAMrqz3jD9kM0Pqp62wbCJ5MGV/hsWKmWWLSFCiC8NhJ+LMlTaA+NGfP
         0N9AWm1QkgbLlfHK9xxbwKNDr6Z9yNColeM3+4HdwJs82wkdQLxKWvF/oRnI//SDIbc8
         +xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698056; x=1765302856;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4/xhOVEERyGr7SvaMrLMTc7V1kN7o1fokcuP75TU7s=;
        b=bO6LQIoZtdced0Lt+EOeSf88ljTT61HDRdi8nlzt5gk6jFK/OE4WwJh6iu/fZiA6/H
         VClqBZhqS5w9D80ZnZRe6PmXwZBwBuGiEVrkxf3Cq/5eMfjLujme1bjmZDbPfoEPQX8z
         TEdeg4u2iVy/J+UDsqIf7C8ACaE79Pa/YTweBfqWTk3xZMgz7GOV6mgpiJOh3Z4pWrAT
         W8SHfmZZut8zPqZfLGkFYGASvvxdOn1t8ivv2X04o/6LKhDosHrc5AQG0OxcM/2ixCEO
         qCBoCvxFLzei/6NUmSe9JkjrvH79355PN8XiHrQEp79m3hCtR1gLnG/41UCB8ket90nK
         m24A==
X-Forwarded-Encrypted: i=1; AJvYcCV3mxb/h2Qark3tR8eQTu2f1HWmIUXLDLm6LTSd8uMdlljeeWXDSSjsv3njHIMuHjG/FA8iLklCyqnPF2iBljdP@vger.kernel.org
X-Gm-Message-State: AOJu0YzCs8qeenCdvb3ySeSAOimv646fuM9ozuEWYMnSJTGjFhW2AbRU
	viB4IXQCjQ1fxDAb0FkjFv/vacdwR403ddsvk22n+Aq3IIu+CyhVIT8UGTuDGOw3TBWqK43an5I
	Yz5NT4XSJVg==
X-Google-Smtp-Source: AGHT+IG312ub60+aKSUBIZJvHT6uwzqaUEpARWPmUwwlLRJM4Vrs/BeUFAdRK1VvTf3grTSSNiaTJnhG/iDf
X-Received: from dybtm7.prod.google.com ([2002:a05:7300:f0c7:b0:2a4:6f54:78fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3243:b0:2a4:50ca:9234
 with SMTP id 5a478bee46e88-2ab8fb44026mr260025eec.26.1764698056016; Tue, 02
 Dec 2025 09:54:16 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:32 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-38-irogers@google.com>
Subject: [PATCH v9 37/48] perf jevents: Add FPU metrics for Intel
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

