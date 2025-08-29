Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3B26CE28
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440733; cv=none; b=cAdDHw1unM0F15qsMoIKq5eglGyC9hXUGRwujJYs6JHr9a3d1xOTmtWYHywCahW+SjpX9mxQyn45gEEuWHhK0Xp/f6Tfg2+Bfgjt0xIR8eM5RB7pN1xDZ0Khp4htrvqVnG2LRQEoVsP0jcpZQnwChG3MDyYmPBRZyReIaYa5MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440733; c=relaxed/simple;
	bh=qC9qZKKpYDUm+kJyCEJpPENdOECbimVQo+edYHDXXIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oVqiZelnqvVn54qhab5n5k+m34Iy34gxg+4rl2GVNDtg8aqr+8NRPdopaSoEFQW7y6773PDnbrDWU2YXl3rxhV/Q0AC5TXlb52dIYKHZGiWTRfRoLkwpcA02XYvQov0Qnp1Fu/UJVbSbFZtptoc4Sdf8ArqpCwFKBj7vz/IIASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p97Magzl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p97Magzl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248abeb9242so14234075ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440730; x=1757045530; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLMEPbiOl1CA0uGgkj22XdQGVWtN3/kulLXNUlnyl2g=;
        b=p97Magzl/nKZgt0COjJuR2mu8LNzhjoPoIuFwDCA/vtxJNJ/nyjZ90Ck5VqdK+StU4
         LIjDOW3fsNqmG2vCV9/n3ZaX6wXkXLrQsy/33sl2GeevMNk++mjXmQzINtp6vQIM4+0u
         fcUOZi19AFvu4AKeCjrLbzdNYo/n+ADPmocbCaWcIIqQuSJ1ZVdMKVXzwkwqWoun4sEx
         HGQbBooKilUn6yPULNctJH0mxHZz3jmyL0lmbm7Wy7MA6192vCU4ejEPRjuDrU7g5ZBP
         p92hGMTuZxXB/Y0cmglp6zqeuUGYXBYgLLSJ16jzWcxyniUo8Y0FWnbRKM9obM6B4Gtd
         VYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440730; x=1757045530;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLMEPbiOl1CA0uGgkj22XdQGVWtN3/kulLXNUlnyl2g=;
        b=B6uds7nnuGbkEUGndvWTK2AK8bGRNhnfK3jb9rnxGlSW4TgWZ3caVrXrjEpEIRvgv4
         3ZYZ//2acujXW2Uzmlo1n48B0ypoFZkwa/oLAKTWSkY8478SwXg1J/Ej79H9RpL7ZKcJ
         fPmZ4gSP8DMcgWTpSa1zoz8T+OJBxVPejYvhHgsAAX1qtDKuyetTh+7GPiJRUeW/GwBb
         oyJ0ppPIL6X8Sx6UOeH4D3gj8KqANdKUMrlhPw5LwZ0EW03gcwyR1xhLlMszBBAcjDvw
         lm3SlXndQsqmexL6+yPlj+CLOTjIqGg6lqEHd2pWbaKgpH3m+3ryG9p1eIhisvoqx9vn
         IOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeF7XTfHOn7tTca8vwW1YibWcBIvi7zSL4vfn2hDhxAmR6A7Zi0UX/e0bFm1Mpphp6lsXKA0tlfR3SYx5h/KtQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqzJysmpaaILlhJqiwJCXQlq6+noe1dpHPlJoLfJ+sJ7AipdQ
	1cXqSe9U0znNLiIkPSPGe6U+YUqCokla9ikxeH+z7yuOyRQNFEWgu2N623D7cT7BKYkBnILe7d8
	rDDFaIyJGFQ==
X-Google-Smtp-Source: AGHT+IHDsva2lKFanEaCvFFadJFWsw5tY+H9T7b+ytrl0xjAXY/bleP9SdCSpagPCUKeSl3MKOb5pT7fhOqm
X-Received: from plbbg1.prod.google.com ([2002:a17:902:8e81:b0:248:7880:829c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17c3:b0:23f:f96d:7579
 with SMTP id d9443c01a7336-2462ef446c2mr321044585ad.37.1756440729973; Thu, 28
 Aug 2025 21:12:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:11:03 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-23-irogers@google.com>
Subject: [PATCH v5 22/22] perf jevents: Add mesh bandwidth saturation metric
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
index 19c7357c496a..7250e8c8eeba 100755
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
2.51.0.318.gd7df087d1a-goog

