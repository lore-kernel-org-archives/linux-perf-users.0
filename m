Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED132B9AA
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899550; cv=none; b=IHvi5SfKJKd3oVyjevkEoF+PvdyVoTE8ngs0ppsA4lhmKPL8wpT4i9/qRi/SpJh9RVOl/ehu29EBv25qi4B5Dc3EFo04EZWn/qpgn1TPuB62n/iiEYEdL5sAF1c4o2vovah+RKb3yxPm4Ugdms66NrJN71R2z30bgsaCLWp8IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899550; c=relaxed/simple;
	bh=ehb9+lTGbZ1qDk8zx/gxtgX32wpwcKjuLsajxpEl9rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XcETFXwlYhIUlHVdXkTjti9CTbGXasscBPQ7O5Ly6r7OlhtuoYVvhXZMEGZ+70hSkRdCvwcrKFxvyi1hYAg7UWpx0yZNir02EaJdVB9JPfcCzNhUCCR4X5im2j5NO49iBVcMbi1COoEI5M6/u+APTRNROmg88kEVf+Cw1zJJDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egZt/jqT; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egZt/jqT"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12055b90b7bso252763c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899548; x=1768504348; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paWFxLvTCvU+EVxViFjzHOc9++WhWxJTYiWc7P0l41k=;
        b=egZt/jqTPrbtDRoQNRrVQZiOPfxQixeMQ7LDqMHzdWkWYnSvoj1EjmkyI2YjhK/M3H
         ZNGvko+qxHc74N6LncjWkLnPHwHzicdCQGwOPFZg1YJos4j0e86BaR3iMCFusT1yCwCG
         99uuBuM3tgzFZ+sd9ng2GNejKWl1OQDN0mYGi0z24gIHsfmuY5lp5GfgqymeOTlIpQN6
         I4T9TDzZ6IjtA5gUZMh4pTq5zEv2Gap3+acCw5221y2npK/8ix2jReJ74BMk7b5SEl+c
         wfQJmUi3QLe6BDTTPOL7rCDpAVO0p7PZE81mcMiCeJzLyZhCVqiCx+6URYwsbr1R9VV5
         xT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899548; x=1768504348;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paWFxLvTCvU+EVxViFjzHOc9++WhWxJTYiWc7P0l41k=;
        b=WVr6NzZj+HNStyKrUfsiNtMHmNa72K/Dme+rmQvH0JOHD46uuGa7Y5db/0kT+DSi8u
         OvFf/C84yY2Ozjy6cy4Q6o1iXAWJ+5iu1YxO5TUpY/rPU0W9dNNxnXCj4aXbbbx+QsCA
         8VuTo08ZZ/LNgNZ+VSeXH3BmW0s8WOJ6ispYrioNpCgJYIYLgs0/et20paJv1Yyhn1gu
         Ot4gsdffYYcStY0m/IUvvrtaubyv5KQcpEcdU3kTmiaJ3daxYYfseU/fdzF/64t9OUY/
         +g6ef/nBsPdrAAYX4wSPz+Q3RmuxcLcAXGuJvyFKQhWpD/WOJgAFVtWGgvK2Sa1Z8/70
         uN3A==
X-Forwarded-Encrypted: i=1; AJvYcCW688qmXZPRIs+cHlkGdIGpgm7RB7ENkjU8qGX/U52Fl3MwOsQt5JaGcUGrljneFBxHNBl5TmB1plQK6Q0T5cpR@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwyPSZPcEzdZU3spvA7pgm83F/bG77tjbFVkW7DFRq9Ao+viZ
	U1wXKXpfgFR9y90G0K01QyYp+D/mfglSiSNatowQJ5l70RPAsw7GAPg0x8CXoFFoRhhFlLDfUyM
	ZmCwEQDE1EQ==
X-Google-Smtp-Source: AGHT+IHI8aai5BW52rtKSJMV78OxIVmbD0L5/gXaoix+RCWYIr4y1IK7qLjzVj4lsp1SYuEXviIgPjKQWoXF
X-Received: from dlbup8.prod.google.com ([2002:a05:7022:fd08:b0:11e:60ad:95af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:51b:b0:11b:8f02:a876
 with SMTP id a92af1059eb24-121f8b40bb1mr5968589c88.23.1767899547811; Thu, 08
 Jan 2026 11:12:27 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:03 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-34-irogers@google.com>
Subject: [PATCH v10 33/35] perf jevents: Add mesh bandwidth saturation metric
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
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

