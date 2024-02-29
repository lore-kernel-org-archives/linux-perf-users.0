Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAA5B662
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165933; cv=none; b=ukylukaHBZHYpFpvnNx816i+6FctJyo+HRZLVNbB8/yH/OV4cnAo2OQQZtXb3v8yE9+RV4koHPyp5boPqPvwkx0H5b7UDE5NnXoa2Nlg7BBWHtiCc1X1n/+VgvFiiI7FMdiEh2su4jNlm8Tx2YmP3TLReTaU1impvAGWQUu5GgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165933; c=relaxed/simple;
	bh=RoQ1W/NshIyvCHXY6NTFpS7T0JU0YBtNXF8QOlBoiBc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VJpTxBFRBfd4iO+jK0wUKzWBAP7JyX1z/+7zSYbOUtpF4ozyvLCWk8ofbB3Uj0etpYeX7mVajtIMd3SetlbO2ACYsGxoMMcCZb/DEr8goaqP7pmrcXp8k9+wMzz3S8TdXuRD30+riWIOT7YUMiXRynNpCb74F3dkP4FZaJtLRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwXLDHV5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwXLDHV5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so3590417b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165931; x=1709770731; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9n/LydSsWhh8X4HCatLjTPGCEDU519H/3lA2USzD/Q=;
        b=LwXLDHV5wo+aNP90JaDftPEmq+JdDTH2jn2MGmqR83KNvvHElTfITFzrJqu+03mQ8S
         5Y9grskiB3qpV3v9ACr7T4H4b8vZ33NZBliYBzAaK7Drx/DNt2et+srvhsu5fS7doyiF
         wHhVDBOxtMbTWfzEgHqGON8E4zrCqI02sr4zeN1YTMzEXD+fLM1cJGQzKR2r6VD9gYDg
         er8/lJaS3naax0noTEqeoBnYqml8gQD/Htja1IWjiW/mqy6bw/EVxk6cSmqFN18fuJhk
         z9vumwAj655vbcYkBMO6r8pNqqbKEF0XFl2UfDb/npQ+RiPRcutv55TEmVP7InKCmZuw
         rBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165931; x=1709770731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9n/LydSsWhh8X4HCatLjTPGCEDU519H/3lA2USzD/Q=;
        b=IhFJGl7KHqYUuE6eEKdIG2uqA1qbHp5KEgBow4B9pjBzXevwJbQT8dsL9dLTVoN54h
         CLlUFd+YucNCvnaWiP6mpeHtVd0aoXY3/RjoBCZ5e3omuo8q4vqzG2QOVBCXNF8ZOIdk
         T/9Roe5R+1FGdmTqzXEPQhUMZCsMp+4rYIpavGcJ5G68G6NbgjFYm1NExZyzjKWm9MI7
         lMYjHGKzDQYeQyk473nrYeEKrZm58zwcrUxONPQg1JQ+f3dnrw90hwIrdFtVC/kum77K
         z3Kk2fT+4k9TtpOCJ68bOkN9w0MfkTMKQLX4zvKABHqZt4G5GKJm9nQE/Bp274WnApaq
         OORQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXOZwotaBCxG/+uO6QWwzTqH1UxC2saXjW5LqVaAriif6qht4z5nGhL3jKFBPyhVTk5CEI1NoiKcRygUKBLaXXkeEJTeAcbqmYHefAE0VFTw==
X-Gm-Message-State: AOJu0YyBX7CavX6MfzNwlhSsh29hOMxi6+fSPF/G6oV1Q5iv7e4xtczG
	HIN9+X6QgfGDZkLXUzuh6j/mMUmOQ8aVO0mTLKnamLjq5nVLlkjqvlLjegKTzodesYvkDUsEG1c
	6rGuK0A==
X-Google-Smtp-Source: AGHT+IGf/B2F4EB7a0HT+qONfUI7nOsQgAhAuVA9WeKqrfWQtvYurTpZFcr7X3hmWfQfblLZrtVTI9pSmfCc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:49c6:0:b0:609:5bd8:de84 with SMTP id
 w189-20020a8149c6000000b006095bd8de84mr54268ywa.0.1709165931456; Wed, 28 Feb
 2024 16:18:51 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:57 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/20] perf jevents: Add FPU metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6ee708e84863..dae44d296861 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -325,6 +325,95 @@ def IntelCtxSw() -> MetricGroup:
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
@@ -687,6 +776,7 @@ all_metrics = MetricGroup("", [
     Tsx(),
     IntelBr(),
     IntelCtxSw(),
+    IntelFpu(),
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

