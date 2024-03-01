Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AB3FB10
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319407; cv=none; b=HgzOYdnsNClHONE/OOFGEfh36Ao+F0c5FR//xZRjqk1QHWhuSSCE+eLHZLzNAccYUU2nOyO3+4bJ7RBZXWU39/hQ/jJy18IJC2zD7BXG+GbMrjY2u/tAOJlCKCI7KUbpHEXpchTgmmof5+j9uQZ3NudGh9fAO/erjsuRYfpMOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319407; c=relaxed/simple;
	bh=Vef9VTUxJdFoMoInyvsFelDJcm09RH8PY/vrqOgBuqE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=T114+TgD1c2ISIfcEL58WdIoEuqsiu99U65vZemTdwvzpA0Kw1jlIFPOF6b1EK3l9LmA1MBPRXQaJrP4UbKJGmGcnuhhcsA78UFhVtBoNt7v+cC+HnMsFhcFSX8MLDk4jAVZa1HzQUd3mv0nIzsZTJhkoV5pwBOKPY146IqDYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZUY4lAb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZUY4lAb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6097d323c70so24856997b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319405; x=1709924205; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYoE2D4a3KJQc8bbU4jnrR8QgBUsbfSWcnqtOE2sI50=;
        b=UZUY4lAbOdiuH5DcbT5xYaI8mxFj5jur2LLLwdgfor2whpDAC3bvCzW7Pp3pZutOfT
         fD5Mf44OdOgoeWt2MnZvRWy7Z81npk8aFuBDm5B1RusCjt7CZ2IX33LrIEWU7W1BV7TR
         6cs0nefNogpZfHHLhrUQW1GADDQK6it4cZPYpr476HmkQttsXGdWZTY3x+WhzViiBWmc
         8RLFxBd7WKxBNODyBxPW4y9pzwqJoEip9fqgYX18p8YjO1016gnA+HOtWEcPvopKietw
         oR3eSVdehORBpDUWJT+Gejp16wRPXKmgsrN6Nmw4hCE9qNpCDEFxTuhI8C6oDXLdXuGB
         E9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319405; x=1709924205;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYoE2D4a3KJQc8bbU4jnrR8QgBUsbfSWcnqtOE2sI50=;
        b=uuuJH/EUroadiTAraW1JN6jcgW1z9r8jmMvUUaJcujKf5AFlfNEwJeNAPsp8cr/qjn
         7DHkQs0+gBDatDGlTfV3nMkI+GBwoInDYh6tozHF+FEZ36mdpiJKNFBWcruTD8uCU+D9
         Djsn7Pzp28+OgSYYSw+PcMvSu6Xv9UzcUt3RTutF5SXVnROV0kdrm6MsIUbt6DebSlBc
         Vp+tt3aTHyQ82J6/YSjYMjuo47OGwIZvQRjq41ObX355tPrqVJutxZ2QICy/EvHRGJxe
         CDDW9fjAaD2c1EsGgBE4FQlWC3nL0p9wUWOZK9+ihzWG6zAgSjQd/cuuSxrAa/jdQbsG
         e8vg==
X-Forwarded-Encrypted: i=1; AJvYcCWE7iN6B29OB84HDYeOZJf6t6RQTmLTKU4yIySZCoROaii3Is1ZdxP7ZhXUlt3KdxHhp9bQpldMx1JdtBqV3EYDLVMNm9QgZx3RksOorPe/2g==
X-Gm-Message-State: AOJu0Yyw6S4WtECQDM/7q+ZkNMuB3nb5BdDCh/vAZk5wvSSRfj5O6mKj
	yUat5laWTdPlc49NQpAwwyMgDUhgIyXrTyfeh9JEVCKQDlgLQLqJ5wBCVZXL9k2jXsUpBTbaEb3
	6KNUptg==
X-Google-Smtp-Source: AGHT+IF0SWVVshOg7HdsBIR86ZUbzjXMuc6wwH4zn+FDddCl5MH4vJhOjvctNYIFJLl28qP8v4N/OmgNrEKs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:ecc:b0:608:ecf3:ef8 with SMTP id
 cs12-20020a05690c0ecc00b00608ecf30ef8mr483741ywb.0.1709319404865; Fri, 01 Mar
 2024 10:56:44 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:52 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 13/20] perf jevents: Add FPU metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 49e51c33c0f7..6f18d5fd9f95 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -326,6 +326,95 @@ def IntelCtxSw() -> MetricGroup:
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
@@ -688,6 +777,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelCtxSw(),
+    IntelFpu(),
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

