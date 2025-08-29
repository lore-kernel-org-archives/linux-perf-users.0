Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14623ED75
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440706; cv=none; b=OWWfPc03YiOsq38LiX9t5Vd9TBiIb9msV8DbP/rzrLbNXR5XsE4oHHzYnFmhNOxYOAMtjwSTLC3qGmGXwfMG9bA7IzbfPoP8KY4bWpDPX9+644Pv3zDPAxx0XneVhWA8Czx4sXyitkwZ7brIyAMmD7Z4MFGFi+/eez/4z7obQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440706; c=relaxed/simple;
	bh=JVvQ5aWyqS8ABkGdJPYJAdFSP+crBiS5W5abbZcmtwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eEo0HaWpLdKpCgFnT5ecjG485zq0KgD+2FSYIG1mXgaptSUTjByYaIQxMf2FeGpBduBW2rbcYwBaOZecxi27Y85rufeWUEOQ0KO5n9naClIfKHG7uyT+016do4CKAPpqmdxdDCqoJvGQIAAEISJnTeopeeToSCLuzr8j5i8TxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCJz0U6h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCJz0U6h"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457ef983fso33039385ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440704; x=1757045504; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J11/c7k6d7NRkZubqaZjO1lfgt3+pUlQA9Rm7sQ3hB8=;
        b=mCJz0U6hLGumUFn4lP0MQYSJJHtijwVASyoOSGH3SpOiiOwgzpZafvy4J8i3pW8u4P
         PprdkC0bo4ZZ0RV2j0vX7BoD1KEYmNdkFcFgM1UZxIv5egbxBXzV/7DQsD/5nbIdvcJI
         S7DPSr5g++mEVVTOWyV1TBnZK8Fy+PN09sr7LY5gIy3zsFgV2aL3xN/UpsTzkp64QTQW
         2wC12NP1wb/MhHWUnIMaMpH0huVqoSlijwQeJmEW5LGTul8VtvnZM4mzK23oARwxUEoy
         AhYNCfGzPm/z7DhPhL71mGAIxzmCG8YixnXB1nwMsn8RG1rE49Y5cjDHcrxptG5GVTGi
         eRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440704; x=1757045504;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J11/c7k6d7NRkZubqaZjO1lfgt3+pUlQA9Rm7sQ3hB8=;
        b=koVFsvIzdazXNAnkecmRSdqNxPfiDW5Ed/mL7JEFqP6LwfYwRI+pgpvW/6xwhQY12D
         VuWmMYilrTpETG84Kaf/mBN9nfKnZWR8nk/BIGKopomiYQ1r5iTyNagN85sffb3WZ+LY
         2WqrWDaJATPlrkOpT37DYEg17Znjuc9yu1zJdl7P46w6GOPxNB6TY3UZd+bi5JGGxwaj
         LNkv7vH3piLUfczkYJpufGMM0tc+G4c+mQ7c872dzb/QC4hT0+386kgLyZZ/pnk/1Ros
         Bkb0D4ZuK4fsQ99SAd+XBmrPbTygWRuwjIkKoo9p0XbTjB2/GHwvC8ZICT/By+WgzQ52
         B3AA==
X-Forwarded-Encrypted: i=1; AJvYcCVkHfRNGZ+GNz0R6P8yn18dUurlmQTGAB+j4QdNapnj4E6xyMeS1dZ8u7LWHL36mQkbGl2Nrgi6o7sEYEQRHrCD@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZlddMo7NS3//Ck8SAUVJkpDHtsmxnUaFpioiQLC2yMF8ueiT
	ZXqtbIUUnV118mpG8LIBuF+zt3b+INOwaI+FxhbDg7G6JrWBXq/5wTRMNs8/pP3hVvHWDG9ARfC
	hxCOnC/BuOQ==
X-Google-Smtp-Source: AGHT+IHFTTxHsWmKNhUSnlrlYAzP8F9m9gYEW5W/LHMaOY+uFVOd1rPMKJ56T26sIn1vCi2rmYMG8qCLMFGo
X-Received: from plbkg5.prod.google.com ([2002:a17:903:605:b0:246:9673:3625])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2389:b0:249:18a:baad
 with SMTP id d9443c01a7336-249018abd51mr39805395ad.1.1756440704070; Thu, 28
 Aug 2025 21:11:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:49 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-9-irogers@google.com>
Subject: [PATCH v5 08/22] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 53b9606ef1a2..cfeafb58e8b4 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("lpm_swpf", [
+      MetricGroup("lpm_swpf_totals", [
+          Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("lpm_swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("lpm_swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("lpm_swpf_bkdwn", [
+          MetricGroup("lpm_swpf_bkdwn_nta", [
+              Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t0", [
+              Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+              Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("lpm_swpf_bkdwn_w", [
+              Metric("lpm_swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("lpm_swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -289,6 +353,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.51.0.318.gd7df087d1a-goog

