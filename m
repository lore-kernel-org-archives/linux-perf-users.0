Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096936C0A3
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539595; cv=none; b=X/fAXCWMScWwmVSHl1U4Jj78wWo2W2uq9py9n2GqMO6h8Hc0+4fKjwzbLqiY6JZSluQNZZZrR+0193bFEd1FK4CQtG6Q2hC8BLobUYX7/cm3BPlmdK4D+FbDS1y3KT13sSVa705ubGEzhrHQyH28Mx2dRiWCyG4iGUvqxqrQpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539595; c=relaxed/simple;
	bh=ehb9+lTGbZ1qDk8zx/gxtgX32wpwcKjuLsajxpEl9rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tgiK7PY/6MI//zYpQmmJ0zbGj6FYXxl2SdWrklGgNcvUY+Bx7tZ2osla6BOlkgv9yrV65a6v+vKUHLdNKP5psj3WuWakjut9EaDvS4KWiuFRsAz42jT5e2nec1Xt/dWgzNikpvy8MAggR+ICPgyd60u7ZjJNBWF8Hkzw88evHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yncgfIVb; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yncgfIVb"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1233b81a92dso148472c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539589; x=1770144389; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paWFxLvTCvU+EVxViFjzHOc9++WhWxJTYiWc7P0l41k=;
        b=yncgfIVbQAq6949fsTylzq66hXOy0Cn2KkQ/lAtbWcEl19TG2TWD30r7FTEL19L/lQ
         llO6COACwS5OwguujOvu5jkIzVxVWbM5wqLRZq++HedtlvS1NJ2dlQBqKSuPbT7I6hPp
         Cil/myrATwO0wfdSQGObTMkHCi36t7Ey7g9Gz+0l0cJo0JutpiZHR/VdwG6oe3s1CYRh
         733qi3XNKvjPiYF1z73tWaIbLkMhZiaEGVNNAddO80GmmhI6tDlVJI1eBWnfwK7rUXgW
         o6X/xMSzCenP25urxf2zc2F6EdptVPQ1M28qnw09pH7c3YYWUMdAau+aVTO/VMUjC+8H
         vxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539589; x=1770144389;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paWFxLvTCvU+EVxViFjzHOc9++WhWxJTYiWc7P0l41k=;
        b=rnRnSl5mXngMF4FqU7mXd7xrEmwT/x241ckpsCWxcuTyRJGLQVxzleLrpf9hMhDgBe
         t3MyQABEtPQVinFos5WmcCDM434V9uQzz1g+dzlzx9ag49i6Vb0YrtuMZcu+siI7uozU
         YO5hl3m+iBL8va+j30Giv6YbpwDybdE9r6SEC7Ejc+MIRLr60Q5JCJU/0TXukCGDPp+V
         o9FY5DycBqhJWD+gN4uTqhIxzhLVKlQL+9A4FpiRBOr9o8Z8Qu3XnSGqmzjLOkrzL744
         URt2Khj20s4RxxtKV1QQHMyBQc2qNL476l3Nj7L1xV0IvcRVXg6+5HKWprupGnIHB5Rr
         C1HA==
X-Forwarded-Encrypted: i=1; AJvYcCVhGW5jhUpSxmOa8yHYybp6/h1rOYqEP3tRx5/nr/kOz77Usj9m6x8FAFVP8BxgkFN9ZG34KAjoXdzH4DjCiTvy@vger.kernel.org
X-Gm-Message-State: AOJu0YxFeyMImh1O6L+fFmQxQbrr0AYlpxzWBalkVZu0kieHONuImdhz
	AoVaTHwcBqKVA0nGdG8AWs13SL1CLJBZTn/y3Cj9I1xebht4GSIjnfg7tuogHeag97Ie+MKnUS7
	r3Q+19HF5ZQ==
X-Received: from dlbcq17.prod.google.com ([2002:a05:7022:2491:b0:124:9694:5535])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f90:b0:11b:a8e3:847b
 with SMTP id a92af1059eb24-124a0577d9bmr1429544c88.5.1769539589230; Tue, 27
 Jan 2026 10:46:29 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:04 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-34-irogers@google.com>
Subject: [PATCH v11 33/35] perf jevents: Add mesh bandwidth saturation metric
 for Intel
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

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f6bb691dc5bb..d56bab7337df 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1033,6 +1033,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
     ], description="Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+    try:
+        clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+        sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                    "UNC_C_FAST_ASSERTED")
+    except:
+        return None
+
+    desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+            "include QPI bandwidth saturation), lower is better")
+    if "UNC_CHA_" in sat.name:
+        desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+                "include UPI bandwidth saturation), lower is better")
+    return Metric("lpm_mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
     try:
         upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1097,6 +1113,7 @@ def main() -> None:
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
+        UncoreMemSat(),
         UncoreUpiBw(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

