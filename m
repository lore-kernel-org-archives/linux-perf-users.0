Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C726CE0E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960880; cv=none; b=QLxb4iLAuxif6LAdUqMOSZSEoKW29LrvW0T484DCL1Bd7tE0/MrmDOfYufYzu+Ckmj/UcEnnfjlc0iJkBlEKZvVudfYif38+pg4jBXGNEvZhd2VBQ8iQEdcoQqtwZwYihoJhdspRrhmJNYaQQEZESWo/rucZyYx2VoIawOTZ7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960880; c=relaxed/simple;
	bh=BivOpsCDlj6Ru6Y1v8vqQWzWVWfc4mJL7YxG+enkvi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=H/JcjHrKVCxhlRvz/bGYGcfcjhpcguKf6lUzfNTnO14Htvffj1VlxsfI3y6sOULgDPnQBC/vmONAtyF1m9mQEnNFNU3dvLkHPOLA8PUFIqP10g/IrAbkTHzseRep2XqykssC7iBWd4Ezwx6hOGF29IKu0v+31q+tc6dmXgXxNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B20lofRK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B20lofRK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fa4be5063so445762a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960878; x=1757565678; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45l4Nbc70EVKZSax2ToeXyk5HR9RXkMGigjhQ29rNYU=;
        b=B20lofRKATaQjzpG+HB4MQ0TyuYNTL+1cCxyDxOhiMI1APGQsr4NDyfctmP7p7TE7x
         W7z9nIevG5I2d4oTxLNnDHY1alg3R/O+BTIMBTvgcPuYN20ET8dcztQAqOZ2p6ik2uok
         sZ5xmoBRxegaLo1nwRmOB8xuDYIipuaO9qXCgL94DMmTIbWDmoTGc1nTz3FZMeur+YsX
         ovUo5rLNkl7iBy+lydNEWmGY1AF9NuuIvE8ZV0F4icd2/x/jjU3b5JOyS4e8tQhxYYzI
         B0QY4/JQvXbY+AwjFY5rlqIs/eBxJQFdd1kixtIQXPbT+Rc2LjpLAMpONwC9dvdFbU4g
         3DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960878; x=1757565678;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45l4Nbc70EVKZSax2ToeXyk5HR9RXkMGigjhQ29rNYU=;
        b=hJKnEcyEKM/iUuy4ZotaHEZYoeQ+beGGSL5B4wPNQZZncFwzopibGRLnafdkVYggQj
         GN269cG/b1B2QnMXs7ejqpumZUBO2MMRGlpjidEQZ4VpV4EgRDyy92HK8YGAu/7n6UPk
         MiqiYGbdD8UbEpDhjoQOQVtTuo4vRgKkNWJzXyEuK6f0jUhr+P3jn28qLp0mWiydDFs2
         aw79qsgZ5Vu1GWt3EHeBjBdUNiWwV+54IZ+btl0iuJLytVwIdwHaOy6Zmt3IO5J27QXA
         XX2jkKTvmQfklLUyuv9zDOx+unr7bp0ewj9nQkKWBbALI0uYskwEp47LGJ/UftTaYaLs
         3uCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjnpT0iWJgSRvBx39ahxFiIpp6NFuDhLetMUqzt+//WZ7JSot98JwOn6U7mjYPdJAhlt0pVDBYTqzl9BBrfOeh@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJWmr5LbirNPr5QvMMH5PGZ/BkaI0TwbMX1B3B/7NmFoEtHU3
	KCu+T7HffTCizwU5KEn1HMryPtJNAYHtpTvh7T0zLKU0DC9lQ61cy8aOAV80iNCN1kDM7mhXclQ
	DbEkgmAk8rA==
X-Google-Smtp-Source: AGHT+IFjrwY6H5XIxngL3wSepYwbC5YU2i0XhpZ085evNzhAMNsUpZLoTY71sUiT2wF+USz0iC3XmuS8kyGH
X-Received: from plbkc12.prod.google.com ([2002:a17:903:33cc:b0:246:5b98:9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db06:b0:248:7b23:5129
 with SMTP id d9443c01a7336-24944a4152dmr263420495ad.16.1756960878298; Wed, 03
 Sep 2025 21:41:18 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:47 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-14-irogers@google.com>
Subject: [PATCH v6 13/13] perf jevents: Add uop cache hit/miss rates for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics giving ratio of uop cache hits to misses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index a782e41dedca..d971fbf40318 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -571,6 +571,23 @@ def AmdSwpf() -> Optional[MetricGroup]:
                      description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
 
 
+def AmdUopCache() -> Optional[MetricGroup]:
+  try:
+    op_cache_hit = Event("op_cache_hit_miss.op_cache_hit")
+    op_cache_miss = Event("op_cache_hit_miss.op_cache_miss")
+  except:
+    return None
+  op_cache_total = op_cache_hit + op_cache_miss
+  return MetricGroup("lpm_uop_cache", [
+      Metric("lpm_uop_cache_hit_ratio", "Uop cache full or partial hits rate",
+             d_ratio(op_cache_hit, op_cache_total),
+             "100%"),
+      Metric("lpm_uop_cache_miss_ratio", "Uop cache misses rate",
+             d_ratio(op_cache_miss, op_cache_total),
+             "100%"),
+  ], description="Micro-op (uop) hit and miss rates.")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -657,6 +674,7 @@ def main() -> None:
       AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
+      AmdUopCache(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.338.gd7d06c2dae-goog

