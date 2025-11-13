Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8231619E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004123; cv=none; b=aJfRp2j/nzEfQ/BKQahJQaeaKMNmdJ6WUAjaGyUGR8LbqXPcZ1OSCea5eb/hGU4UTGLEVBq7FHKAd0YVT18ABlU6aNYP7+fiaIZHTvHtpCdGV9VKYy7Hq8nJQKROAv3MdnxXVEsPSnB5k5kveIm8hgzW+auuMwpfGbs5txKWRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004123; c=relaxed/simple;
	bh=yVmvGvYb7C+jMsZDbt7D5PQZZC8wRrAcVHDCtuGBsC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OXPn3I+d0pW63ZHQDU4NTpTXraTuv2kfkUQZx+Bf52TJ3ZKnqCngHFZ8y7pIKDd4k/bFbuHA8vUtE/3drKhX7SQ52PtVzWkAYw6d/Meegn2kVrXMGAC9xmk97AxB96wXecPQWCpu3EDbkHM7UxDbAjTAKEPUJQo6bcfcqjzjpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usfpI3SH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usfpI3SH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295592eb5dbso4395295ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004121; x=1763608921; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGDim4Ss4cIrUgdOZW5zIcnGg/eQaYNuaW0FNpSWZdc=;
        b=usfpI3SHOniVPYIvmYbRkOO4NheNgDSrUAmiDSq6gWIHzamvbfbD3/Syp464PRu/PT
         VZV411bB8xboHxjLGddVx2/gS5MiE4xNoZgl9APOsb3m5i3d+oiyQK5WJ/m0e/+7y6YU
         PIYxyCJAjKLiTWvVS0KXX8ehjeRiK14DV4dDUBJNunt2YhWLDQ5ehD/sxsphFDLs1AM3
         Jq2/i2FKwrL9QMlPGe+bIN8jKZK2uTLbnStRvt7hAD783Op4Vk9rOsTYMAXoxWEgxZkp
         GpoLoaDBj60MUfcbtRtIaAM+wW1/9E1Dwzg8IayfTQ7hZT76x6naNJxvzG3zlOIocPf7
         MZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004121; x=1763608921;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGDim4Ss4cIrUgdOZW5zIcnGg/eQaYNuaW0FNpSWZdc=;
        b=jHQMglx5auDepnUpz6Os4JiwS6TIdBmy18gBUFLGqzRPM64VSnFbUvt/ZGuVBKyagO
         AhoPVuHryuT1/E+ZpiNGvv78DTqQXATRiE0J3TMueQ4y/Ol2N6xdrHFJAvh3bfMy0MFT
         yGVg4zKb+Vt9NckHzkA8Q3uMIV+UldBhcvFTcyszYlDXMIuHMHHZDWgDsyjmJlK0p59+
         iVOhUYbl1zhcU+gtXDRRoX/iF3WKc1vwiqutyWjDyuSfXdnilwrJN2pMtQN6Q5pUR4Rx
         Xd1WJOCsLDMkD/GFZXV0ur4nTsESkXvgC3rL25n6roJ1ITSk9GsTthRktbh8Hl/LC1Hz
         S6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3j33v33PJguFeIHe0EXzCVlYlkkiRhmzhObT4h1cM42e94ZmFsejH8f/4zYDlvcRi0p0reXzQL0256lF3+8G@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaJUT9MplEJNL7TpM12RODjh2Tg1j0aU+EWbTFPTUCRHPahtL
	9+Mcf5gq5Gy1TekzBhM/A6/t8o85sp8PNlLRHAOtK8OnJPpmBQFiRWf8gRoNtLnQhACppO3nHpf
	ErvrmyEp9fA==
X-Google-Smtp-Source: AGHT+IEtX7wMRMEYuyE0bXrmIH0iCuyLNbVC9w/ucRaeW8uIrwt8nzLGat3rZT3vAZw+fsaXYqK5C8GB5OLi
X-Received: from dlbvv20.prod.google.com ([2002:a05:7022:5f14:b0:119:c913:cce9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:295:888e:9fff
 with SMTP id d9443c01a7336-2984ed410f1mr74215585ad.20.1763004121277; Wed, 12
 Nov 2025 19:22:01 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:23 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-36-irogers@google.com>
Subject: [PATCH v8 35/52] perf jevents: Add software prefetch (swpf) metric
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
2.51.2.1041.gc1ab5b90ca-goog

