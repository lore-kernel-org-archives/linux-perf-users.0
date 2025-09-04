Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A5279DDA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961262; cv=none; b=El/bhvUtzCbe5vSvQISTEpjOmWy7cWBiPRam3r5EO6GY+eSinfw92vsZ/UUcqhqP4dJs14/qNRhGPrZuYHU5i+7rTF/K2QBLDtlHHGc54r1Nq6t9/m1sOJxdOR5SP2lKqt7DEhVfx/14tCo0U5cDLtPquJJ/eIEmNOMkCw5kA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961262; c=relaxed/simple;
	bh=RistnuAgHd4NCL4l0yE6lEPBFwvSNadT93kj/NUVg6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TgvKDO76E1OGhgbELCA7Bxz0TbsSVaV1fnsxpTwsssjfF8SaFvQwc6J67D/AaHQzsYFV0iAHMPba8tWlVLenNhHm6FEc0DtUw9OcB7GNkD2mg+71Gspt7WukYfWxBC55fhO5ANInOgwiK0jvep7juA/XW1jF6wVdnrU5LnZXHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+DOnwEq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+DOnwEq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso13713775ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961260; x=1757566060; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgqEItY9A2DTGkflolDC2RygmVecc1iPe1xmOKI5+pQ=;
        b=p+DOnwEqjd3OMbeS4uKh98kWBw3mEHnKD5ZV/irmAvW2uLtDkahIHubQEU0zKIwx8J
         PuWw5P6dfpyz7goXYgN9A8KbuwHEWAT2H8i/cZDQm8MZR+9nNM+HPcTKElkVEU9Unrck
         IQ7F89IiC77r8HFhs58liJ9LUUQRe3LEpu6BEY1ulhfsSsKCO5ZoPBuhvLT3cOQXXmm+
         JUQNdy30pDZ3h8MsBlZrVYkhQmIRnHZDmj13DPtCPunJRCHx7tKGeQGxXCtnUkJC/3YU
         m5Nsiy7+Xalyzi8MzwI5h6IF7g1+Jt9/Apmpa3+wqigeH0qh37sBU4UZS5z3yazy8j9c
         aZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961260; x=1757566060;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgqEItY9A2DTGkflolDC2RygmVecc1iPe1xmOKI5+pQ=;
        b=ZFdO26450vHpgzINOVySl3IDKX1IUSFaiMMeov1e6gtWhHZvBI9EVfW28yJ+yDLGCz
         DEcc3OQxqowrFSwqnBhVss3SmOCERWC4AwIJMnDYn3HAvXI45mpeI6Z4IAj2555xck4v
         1AhNgXk7hFJAKjyy9+5F/jjWU7kPO1T5Lc/+q6HOVYpi/vezwmC2+XQ16OHWUE17crA2
         oxLNSVgIeeZan3uUrm3jmQU1NNkts7EnRxe383087tbCdPwx/ztR+JIn/qKON2y/bzxz
         fJP77Ivjx4bAaWRsNY3a+0Up8ELhPPGqdRIdLuSCDSdo5T39kPE9KAGNXguUlZ9Ph/L3
         wgTA==
X-Forwarded-Encrypted: i=1; AJvYcCVjDa3kRCD8+qFOZuet9+GfAEHQiCJucoHdpS5xPltsMlA6Q2t1GAZ+MIB9uHcSBv8K04NGDRQ1WS2IoCyPb7Up@vger.kernel.org
X-Gm-Message-State: AOJu0YwllNcqLI+HCVTDhAnZYAF3W/qi6pTdssCOBjqvbVMXP8M6DwvA
	VfR1t7epiX/cCXwmNL1XfBpYUYW94IMSiyeVCMQDRSb5bZdIEG7Vzjw+gw7y8jiTDpZ8xtGlpfY
	VpQPcprw8Ug==
X-Google-Smtp-Source: AGHT+IF0wYPqg7zlSl1qx2A5P6s9Rtb4ovc11SlDLv1+Ceku358dlTNxKQe5YNKmsHdiFgykM9R6GbvmqjAn
X-Received: from plbkz7.prod.google.com ([2002:a17:902:f9c7:b0:248:7327:44b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:249:f16:f080
 with SMTP id d9443c01a7336-24944afb3ccmr226252725ad.52.1756961259744; Wed, 03
 Sep 2025 21:47:39 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:53 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-23-irogers@google.com>
Subject: [PATCH v6 22/22] perf jevents: Add mesh bandwidth saturation metric
 for Intel
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

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index e639e8998d87..36b6c4704522 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+  try:
+    clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                "UNC_C_FAST_ASSERTED")
+  except:
+    return None
+
+  desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+          "include QPI bandwidth saturation), lower is better")
+  if "UNC_CHA_" in sat.name:
+    desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+            "include UPI bandwidth saturation), lower is better")
+  return Metric("lpm_mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
   try:
     upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1071,6 +1087,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreMemSat(),
       UncoreUpiBw(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog

