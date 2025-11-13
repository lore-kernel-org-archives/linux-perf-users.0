Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803C31E0E4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004149; cv=none; b=E2JgH5hMqmfNBNNHhdE6C/zJirxj6j0iZhsmM9Pt9REeEZeEc5+93nhEdhNIDSDty8+KUtka9nuFhYFZISbj3aRl/WcKbrRwunThDUeAJ0cOZdrPHqkBORJAa9IupkFlVQzC8Wix/eA0XMg3IV7SIkjuzlNf3wB8fjxuLctdeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004149; c=relaxed/simple;
	bh=oXAmtgsImllTRrtDplcjWM9IZhTB1W9ikRhG0FFfEH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gVoL7ZaPH0pP6e0c5T+GsutcU1pdcL+kCcK6HRa/CNWkvIw5Vo5/oJBNeoCvxf5KTbzfaYRIEtIpzozbpnaLLuyT+Hyafdw5t2yuoqftZVPIMrBw/6aVub4Gxn5OROa4NXEHDDVBEGVv/r65aPDdF3xnm1GEQcWdcyD8SZPEzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXfMHv0k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXfMHv0k"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295592eb5dbso4397175ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004147; x=1763608947; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2yA77Jngt2V93ChqEEVEBYrKD8KbAxrlMWRT/ziXs0=;
        b=sXfMHv0kyvxBsexoL3bXR7KC/F7yyw69URQKN1b4Y+q/PNXkBT35SwHdlTVUoD1Pux
         8olA3ktSZjvZgK1ow9xgMbQ3ZZt7UB2STwo90pVhdsTuONBXAqMaRr4sVgt69y0SSgQ6
         kemooEtJPm/6rxf/RJ708pVVhD0RwOjga6oZ0avlwtY8Hb76EGS5gLtEdrH2yK8GCj65
         K9RR6f04pTTcKHJTp7bT9lVJcIwly6TjYFNh+UoIB9quVzIMtP2VhMdqmHnv54W4Kwp6
         uGML98NPs4LgsZ218b+GCvnbH6vVyR/pVrZMKrsX0hzQ8IljUNU5TtZmUe9uIR4O+O9x
         k95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004147; x=1763608947;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2yA77Jngt2V93ChqEEVEBYrKD8KbAxrlMWRT/ziXs0=;
        b=wE7uyKSaHtiFDbNWqEiRziiGulldlhPq15uerr78J6U1GO7/mN6z/bPsmEZm82JiUu
         sqzbSqS1CaX+LDB85MlGuqr0eBmgI89pooSgReT9S8sTKC4junTj5siwx3PEjNwxXjCR
         8CfHHePOjYiYWCUIhiTMRaKGctuo98y4Fd6uspyOh63DVikBp4cBJTdHG2xUd+bxU16E
         rh9x0BaNnyULcJOLeqNiwziHTbx/za+CRJp9Ch1nSXO9V27Kno3Wo3uphC3oORRXdd7u
         q+80ogr6uata+gwmnc/69WhlSr84irDmLHdamV6hpaqCIoESJAqF9W2K98z2dJz2foMJ
         /xtg==
X-Forwarded-Encrypted: i=1; AJvYcCVpHCf+kiduiKYktbzF3cedj5gKeSnlSqvc2yYaXLRw05ctbO02l1SX7n7HzSEzGcdeNj1M7OgazBet7kMFLD9M@vger.kernel.org
X-Gm-Message-State: AOJu0YyHboYk08KDQ3p6Rn13qV8C9OAqSOvYN0iYEVwzD4DYI5V2puEL
	UpiwhD5nVSgizjM7CAIN5OM+E1M87boqfaPCU+MguJtVMjRnLfrjUNT3/X7xKhxpAz/Xhf1nohc
	rWEa9aEJtqA==
X-Google-Smtp-Source: AGHT+IETV7NmdBB6OQQbZJCyttKLnd5FX/GWTU35O2jI5hlKHBRCYYEaswxN/MnfzJGT3I6n2GJ1fJDmCeS6
X-Received: from dycaj13.prod.google.com ([2002:a05:7300:fb8d:b0:2a4:849f:60af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0d:b0:294:ccc6:ccfd
 with SMTP id d9443c01a7336-2984ed41a1cmr58123335ad.24.1763004147161; Wed, 12
 Nov 2025 19:22:27 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:37 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-50-irogers@google.com>
Subject: [PATCH v8 49/52] perf jevents: Add mesh bandwidth saturation metric
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
2.51.2.1041.gc1ab5b90ca-goog

