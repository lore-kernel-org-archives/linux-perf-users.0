Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B94CE12
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396006; cv=none; b=eaoJrKprZiZi9VH8QmXCEkjW9JG/g6N3hMawtmykrnHpAoW3OmpOS5qjEuzRG/fOSDFF3lGLyFPeyjBWGbrdIFqdX8BhHgsCuDQSyJ+ER9Su3Uasf1SMzH4fj18twFpvqYsfTUxj3CLn7M73rWJ2RVVBF/Stx+PqZiEuRbknPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396006; c=relaxed/simple;
	bh=Zv59BcF9/FFOXnYymXzoUfqt6uVYuFUlqvpmq/ZLPyU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m1875cCYyfguhslDBXhHXp47dXE6qYKGVG9hDVAagsZeKAy7l+f3hrMRU6zfinM+AoJif0hY7GeuGT48nIWwk3g+AHuw11GxWfUFEDnbGe80gjxOiWv39c+xtjGMgbNr7DnT+Wt2JRseRGsxw1jT7Vq7bBzhoBK06MnekhY8dbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3tQSVuk7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tQSVuk7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso2275230276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396004; x=1711000804; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wrp1xMdxyIWOSP8hDN276AUUBW2F4zIQGzyrmjQ0NGE=;
        b=3tQSVuk7v+A3ck5hoif+sLHNtUGbpifbSx+td9WjpWPrQ9N6CHfPUZTNz+k1WdWb7O
         2v6wQsgUTVwnK4k8Cl+dv9YK5I3MdTgOf07VgvE5wixO2PmLkI1G0QSRf5QEwLHK/MMP
         2RQ2s/dGQA4eCx0no20fLeh32yxhkO/PFqjxZ25ga3pottN8ereTlhnPqcbLkFkPyLTF
         dnS/EihoU7DEls4/CjLU1DlqMnCp1V9IhBWC+54i8twpzPvuG9fGBgaXNh95C73ffql8
         7her1DLxyQ1c7HBjeFaeFmdsO59houmkC93ClXQ7b8/RDe3gFFsI7rsDI0t4eoEMpPf2
         ioFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396004; x=1711000804;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrp1xMdxyIWOSP8hDN276AUUBW2F4zIQGzyrmjQ0NGE=;
        b=njT8i31UEK6qxyVXPeXXhfZRtg1OQEiESpt/PZqGre4GC2Qwq2eQlRomGL7I/1oUsG
         Dalqv/u33seSawZH0j4jpyiLtTRqBjAfBo1hK4HWcWD4uxAyxKO3LOKCeWUTdp0SD2En
         cYqFzgm2/NpAP99Pz7Fm8r/0yqDkqRpUxMjLYORH8tl0r30rMnhG/LnqKnMoKk4Qz8nf
         KV3zbAr4nHL68lTg98BFhVoQAU8DUDU3A5jkDp1ynvAupgZ5/NgC8qvspeEb7VetG0bC
         f6Koxx4iP8GlxlIUrBVTAdDSeW5seJZC7czVNQYtY21Lhew+om7S/Vzii/mY+fJk+Mml
         h5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVJJySrXX2kxioNGErszr02E4sUsPhvZldvLns1/Nkr0GvzSwGfcoIMzVNdNcF0GaeySMUbZg+SVy2uiiBawnLRNZ5noA1BH7JIRfeZqH/voQ==
X-Gm-Message-State: AOJu0YzRdajQbOoZ5NzfHOwtuf+xGF3TvuWHiUJzRmITWUIWV0iLIT1R
	N450RAznX5zRPZIuXvFhXSHg28YUoq0M0Qx0g0RWOmiflgLcAbCKf6DLD5uLihVkOrior371M1w
	H84ABpA==
X-Google-Smtp-Source: AGHT+IFDJM+0l2op5SV6RAZkgs1N/ukCDz73rxkHFqK7G5dqyPkyfs4SefZFM+JjpIuo/No5WhR+xvC/m/oo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2311:b0:dbd:b4e8:1565 with SMTP
 id do17-20020a056902231100b00dbdb4e81565mr255527ybb.4.1710396004209; Wed, 13
 Mar 2024 23:00:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:12 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 13/20] perf jevents: Add FPU metrics for Intel
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
index 387981d58320..da97a1781be7 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -320,6 +320,95 @@ def IntelCtxSw() -> MetricGroup:
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
@@ -703,6 +792,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelCtxSw(),
+      IntelFpu(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

