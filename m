Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F02259C92
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960872; cv=none; b=SzflsxPCcBG5FLqcVgCNf0wNiLp0pmSXhw1VHyDBAoudpDx0e1C+rRW6g/auOFuCpUqBnO5SQKLMwCGsT91va3QxSmYwtVxrti53L54JRase4J5O8nu8hclwQ7Om1/7tV+aEYLxWB2wMErTKpDGjZQuZ7epUfYWHIzJPybkcOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960872; c=relaxed/simple;
	bh=cK6B3yKp/oAwbABBw+loVZPkiLk4KXwkSqwQNA4O3+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EulclXIs/PFSIuHsqWcdVxiS9phL7QdlVj+sKB5cv4Py2GIiUbBBgFVxhf7tOkTlkYFA6fWGa4321TO9I4hvLMfCHl1fUEwLN0KvVv6S+olMdbEWrYQkeAfPnDcM0LLFr3JmbgOxneszlBSMO+AC7cImAj+N0q4/uNsygrfFS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fhnm3bf7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fhnm3bf7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so11849525ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960870; x=1757565670; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPHDZybzkw0C8ovc4q8vLwc6Rbl59eyCCQCaehdkrpk=;
        b=Fhnm3bf70urcFPH2Md/L2iKvwlnBr33zhr2HMTnBSoUJKYBMbL11AWSNqGM7Vk2K1T
         94gXdyjEQYDyOWqk+iaxU3Uw5wT/mP2Rf5WJnSg3KIk9RTzmDgHRGj3GMvyVAsW5sEcK
         z3++O8qbWaMWVaALjCieuTpcPUBlcJ7FBOrH3tyWWjsI2/RrJFNB7FCrUusXME8jNHq+
         dSYoeoY+1TYNu/7N6I8GN0MzN1eHzlhUfliF+8oy8W4bugu5YlfYEbbwIiymr+gLx2Rt
         owpSSandbfqYiJ2kJcSUecoIu3wm6zuBVVIuSoJRGSJQZnqPNthbrG+AHji6HnSUhqSD
         Klwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960870; x=1757565670;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPHDZybzkw0C8ovc4q8vLwc6Rbl59eyCCQCaehdkrpk=;
        b=osNms03FOq0lzULBVh1I21qygmcQ4rdy/L5LdjXl1+JDwfoxfahQll2bJ0fjizT/3G
         mK3VVCZbqmeeEeARQDt7gm0AEkf1sngAX2nnmMF+n10kAy1lc9mHj/ToJN3OJz1XM6r8
         RDb3bkLioT0YkYxrrrqA+jnGIcqZMtaxhIlX2K+Az75bhCvcSfYN1epvR3jqCRc9AZ4y
         ZDoEkFS1wLkE6s2VYcvZpci85bj9hwfpm9rE6wpXieeGWK/2YtP7AoW0hgl/XOxsSABL
         iAvWpmIV1ILZGTycIRL+/DpnDNDAy7WctMycvPOZUgzGukqer09ont6+9BcL4WDTrCzC
         2gUg==
X-Forwarded-Encrypted: i=1; AJvYcCW1DnJ6vCX5topWukmYkCxGw5aWQqxHMpYwsfb+Bp35lwQVqP55xj+fmhGR88kEBBidjR5F48ikOhNEMzMwx/kh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CLrq8ap8yHzeNyBQ79/3CMbqB4cY2FEQ6zSgLRhhdLesIOHi
	P4amm4Eh2N2dJIVE6xh34MIwGiyOn5MeVl8WwdOhSjvwUx7lYodLA+3RTJUvtI/9KL+h2V8Gq0Q
	syToy9gL5EA==
X-Google-Smtp-Source: AGHT+IEp7Y+oDlmnZtPDeCg1m5xYLuWN0BCan/DBqboMzndp2bfnN2yKn31ewBo/bKD2LHOlSwifiCuIlmr+
X-Received: from plcz17.prod.google.com ([2002:a17:903:4091:b0:24c:b394:50e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b46:b0:248:e6cd:e14b
 with SMTP id d9443c01a7336-24944b19648mr67886695ad.56.1756960870146; Wed, 03
 Sep 2025 21:41:10 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:43 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-10-irogers@google.com>
Subject: [PATCH v6 09/13] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index c3f0f1439c01..a2d1b642b62e 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -466,6 +466,22 @@ def Rapl() -> MetricGroup:
   return MetricGroup("lpm_cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("lpm_l3", [
+      Metric("lpm_l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("lpm_l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
 
 def main() -> None:
   global _args
@@ -501,6 +517,7 @@ def main() -> None:
       AmdUpc(),
       Idle(),
       Rapl(),
+      UncoreL3(),
   ])
 
   if _args.metricgroups:
-- 
2.51.0.338.gd7d06c2dae-goog

