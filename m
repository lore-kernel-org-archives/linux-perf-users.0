Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C32DEA7E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698029; cv=none; b=lcyENUAWSZY5mmqWxy0ZkSQ4OZono9zwQTHkSoNgBJNrlFZ5blHXNXeeuN+NLaFotKbGMMxfT2vTyzgLzNJCVy3FCFpUy6iT1X/ove8ard6gOxz18NDRn+JUnMCmaZ5OZJp9pTB7hTsalbKCYKQcD2IvoSSj2nTmSjVgf4+4GkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698029; c=relaxed/simple;
	bh=zReLgRq9a+nlcSbYpcVCoeI4hVxJwvMJuOQNynM3BOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eYRg1vsGZvBEXvxw8qkgT4QAWFY/WXEBpmklAcvFnnmX7FgaRmakzFIn54X5fKx1vcU67Z73oSfd4RBKV9we3Wx9KBTr9MN1WCMWvyLr5D+gamGB3+WH++ImnVwEzL3SIZE0EoZE7Z01MWDF6u5notX9Zos5VaAVTWzElr2aTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKZYvu5Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKZYvu5Z"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so6468717a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698027; x=1765302827; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEBbmMgbzbHH/P46pRjpPoQAKWN66Kal3tC5ODhFh6Y=;
        b=QKZYvu5ZQVujK5nxRuN6uEFj0Enh1Tawm1OUVfMq8S0qqUXOPsYFPuM5o6moxNpJd1
         eMWBJpSvPCMJi7o9xqfGs2Zb+bmeDDUec+yPNkwWrgBeEVlWQkUjlamPa/O7ySyQPX5e
         +y+8nTVFPe1cIfBuX/GPnGgsIBBFxszbrT8jFeH14NBdk0TERbJJCeJyf4WvZ77ktIW5
         N3saihaw7o9IrvQMwgRXk+QTqARy6wzJkIM+1O7Z4iCTdioq2rhFcpgYSNylmh+rRH1B
         vbPeqEJDb0dmwilKcskldyYLyNS5Ef2eJkEewHdUY1SBfHmD3M8ZR1chfHwZtIm5Jrpd
         Rs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698027; x=1765302827;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEBbmMgbzbHH/P46pRjpPoQAKWN66Kal3tC5ODhFh6Y=;
        b=lAFEFTJ9zO9nO1/U7HvoMuDq0kKQy+Yy76LvDAgw8Jb4x7j1gga2cLUuiSQqdCxp4M
         9QcjpwPMfgvlcy9laPA6i1xBEPygSmrwzE5oqUQ/HygPgHMPN8aZfiEuKda9DZfkhnOV
         Z1c3lZLrOzfDInmCQ5xkS3HMCFyqc9ASKmrTrO5eLSLujO42/RX6jfVLOave3d9oR2sf
         aiS0FB8IRvWmPFYDQ2EPwRNQQIkuyWgvXNqqCf3bpyPaxHnxbIlcc5he3b2/HYwlr0T7
         zLJjK6pyaWY2NqUM3DEHDnRX6QBZ6TM4bCPrq9DVq1Q/6ZeldQTN+iNh58EJOsa8ud0j
         osFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJo3a6i5t/njHFKrM4W/ZSgYC5efUJeqBeiyQ2OVdPBojIBsnQysc4zmLgDVsbkOIDp1ECkdrJ7zxq3mVcoN4n@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHTm1JSFxGYMHY713BLtElNTEYadZhanVRXN7vgXsTeI3xK2W
	RiZ1jp7ZI6aBs9aMU1G1yIWdVsXECJStWbMMFKodocAfA7j+9l0GbkPSdmksiVM6Oh/e+jwYWcg
	2cxrb9FTbGQ==
X-Google-Smtp-Source: AGHT+IGCoSCHTHIUpNF4oOBSOgZwlU6M1njNf7ndIMOB2AcJAm5AJL4gH1kp64i5hCdZN74AwmzlT/9G5gz/
X-Received: from dyboy20.prod.google.com ([2002:a05:7300:ed14:b0:2a4:4bd0:6ed8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:550:b0:2a9:9688:6ee6
 with SMTP id 5a478bee46e88-2ab8fa78bf8mr254444eec.4.1764698026924; Tue, 02
 Dec 2025 09:53:46 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:26 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-32-irogers@google.com>
Subject: [PATCH v9 31/48] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e1944d821248..919a058c343a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,71 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+    ins = Event("instructions")
+    try:
+        s_ld = Event("MEM_INST_RETIRED.ALL_LOADS",
+                     "MEM_UOPS_RETIRED.ALL_LOADS")
+        s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+        s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+        s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+        s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+    except:
+        return None
+
+    all_sw = s_nta + s_t0 + s_t1 + s_w
+    swp_r = d_ratio(all_sw, interval_sec)
+    ins_r = d_ratio(ins, all_sw)
+    ld_r = d_ratio(s_ld, all_sw)
+
+    return MetricGroup("lpm_swpf", [
+        MetricGroup("lpm_swpf_totals", [
+            Metric("lpm_swpf_totals_exec", "Software prefetch instructions per second",
+                   swp_r, "swpf/s"),
+            Metric("lpm_swpf_totals_insn_per_pf",
+                   "Average number of instructions between software prefetches",
+                   ins_r, "insn/swpf"),
+            Metric("lpm_swpf_totals_loads_per_pf",
+                   "Average number of loads between software prefetches",
+                   ld_r, "loads/swpf"),
+        ]),
+        MetricGroup("lpm_swpf_bkdwn", [
+            MetricGroup("lpm_swpf_bkdwn_nta", [
+                Metric("lpm_swpf_bkdwn_nta_per_swpf",
+                       "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                       d_ratio(s_nta, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_nta_rate",
+                       "Software prefetch NTA instructions per second",
+                       d_ratio(s_nta, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t0", [
+                Metric("lpm_swpf_bkdwn_t0_per_swpf",
+                       "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t0, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t0_rate",
+                       "Software prefetch T0 instructions per second",
+                       d_ratio(s_t0, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_t1_t2", [
+                Metric("lpm_swpf_bkdwn_t1_t2_per_swpf",
+                       "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                       d_ratio(s_t1, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_t1_t2_rate",
+                       "Software prefetch T1 or T2 instructions per second",
+                       d_ratio(s_t1, interval_sec), "insn/s"),
+            ]),
+            MetricGroup("lpm_swpf_bkdwn_w", [
+                Metric("lpm_swpf_bkdwn_w_per_swpf",
+                       "Software prefetch W instructions as a percent of all prefetch instructions",
+                       d_ratio(s_w, all_sw), "100%"),
+                Metric("lpm_swpf_bkdwn_w_rate",
+                       "Software prefetch W instructions per second",
+                       d_ratio(s_w, interval_sec), "insn/s"),
+            ]),
+        ]),
+    ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
     global _args
 
@@ -291,6 +356,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelSwpf(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

