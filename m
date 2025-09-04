Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386E242D79
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961254; cv=none; b=Nqf0xN9YDZHAwk6dC/+LM00DBBA7rWJVvHEPNHMGAICRnOZrJJPXVgSgrf4uzStc3cEOspG1Ia1A4vlF62lOBqCv9PfcYv2Pl89FynXYogmEd6CP8zMON2trOq1vvreAxTNby5G5Hi1FdZm714IGiOdhvMyToJbCMZs5GDbk2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961254; c=relaxed/simple;
	bh=eCeE/2YA1gW3yikph8tyIv9Qo87llAzuCgL/jet0ORQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fEvNi2i+jzt16J0g7Bn1Trfa6FGecpVr67wen/Ra0S6wxWBGfd3DqMhXO7lWAF+5KzPP0LVbIXPmCxOFGre8FjeanwAjmmnjKHyXsELit7yRrWsRFaERbUWirYMquaxCO0hD16bP6OgRfjZg4S5KbiUPF+q0jpHd7cNzgq5CPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/RSaRXT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/RSaRXT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3234811cab3so637748a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961252; x=1757566052; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41eHmEOBCKxz0FQX8SK2j27zDRY5OHr/EQpAd6DfRhw=;
        b=g/RSaRXTs7UZ23v/atNMPUhIFiVHNPRDjhkcjQiokjzOlb5CTO3TtakqiiMmwXQ1ZU
         NJQohxytIzPtIZVsiqIDe422iCcZLGYYp+DBH0NGlmYmxCeUjQiLqaYvFEwy7wNHhRqu
         JPW7VtCL+0tdRMFeuTexIM5pt9vGI9xhenhWTtRv3XuZ2qTzcE6NW23KVhFpxMwg179S
         diPUVCgo3Kse2dLozfeRIRF8jSBI7SZk++3ARmFIbiJQX/x0yVExEjUeEEn8zPC94+Cm
         jHx+H0Rfc2JFqlXeTFKYtzPetNHM8jfcu67OUhOtFm1Uc84ObVkp47zs+fRVtCEexEB8
         mIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961252; x=1757566052;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41eHmEOBCKxz0FQX8SK2j27zDRY5OHr/EQpAd6DfRhw=;
        b=hvX+g+7PhiSDg91CkqvAAB0yDlYPm/glANRAtia2pH52gtO6uuQ+vsEeA/v6o6S6Az
         vOdkrEU3VprNJDs3Off38P/gQpysMzEd6pky3hKno82Zcfmi01MbJ3OZxsjmtzlypd64
         OWUNczsPLVAf22YsH/Z2/IVG2sn1S1KmD2q9mswXSR1gNG7B8eNxhxahOy14rqwF8Mvl
         2xJwusDmgaavRi+oWAytMm6hbLq8uca5UQ0bW0Qj+SLJ28Isaf+l48FLNZ3YTj673ooO
         6xgIFhM9Ol0HpM5uvMnyGNk5u2DksjA+VwBiUz99RWxW/NiJysTcLvOC52wMTwCwcWOE
         FWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXVOxeovSFAheeJIwN70HSzesJjPMmkemRcbazOBc2OlZ8pe6UnlpA1HaJizeGPBLE4ieYBate7hSHwMRFNv+T@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvqv1jmHFBNUPfQzbQsfF479vCNWvoypXbfFouUxl5CwSRIFv
	JeleDXAcPHtimQWNNEW2nPhga42BdO9XOj3Pe8l+ndthz+h4FdRIoE6fJxitikBrf2BX1+0JMm4
	ncm1MdUWbmg==
X-Google-Smtp-Source: AGHT+IFMGvdDOM894XFlRC4C8ABn2l/2js1gvMdb3naZGms4QkhWcuW7svL1yywkey+lraXUjRQta+HUkNvQ
X-Received: from pjhu32.prod.google.com ([2002:a17:90a:51a3:b0:329:7dfc:f4e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4b:b0:32b:656f:5a5d
 with SMTP id 98e67ed59e1d1-32b656f5b5fmr5026346a91.29.1756961252229; Wed, 03
 Sep 2025 21:47:32 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:49 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-19-irogers@google.com>
Subject: [PATCH v6 18/22] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 30cf668c7769..669b5668a753 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+  try:
+    m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+    m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+    m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+    cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+    # Turn the umask into a ANY rather than HA filter.
+    cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+  except:
+    return None
+
+  m2m_total = m2m_hits + m2m_miss
+  upd = m2m_upd + cha_upd # in cache lines
+  upd_r = upd / interval_sec
+  look_r = m2m_total / interval_sec
+
+  scale = 64 / 1_000_000 # Cache lines to MB
+  return MetricGroup("lpm_dir", [
+      Metric("lpm_dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("lpm_dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("lpm_dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("lpm_dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("lpm_dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -923,6 +958,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.51.0.338.gd7d06c2dae-goog

