Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE5242D8A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438326; cv=none; b=q1qh7zZKewdFm8BcEsb1XITiwhKUAVxyr1nXQkDt31imjdMs5TgVwcTjOGEEpkcNU9yaFLTUZrU/3WaKDeKVxtGrxS93Y7dvF/Gr1+QDyS+C2rD/Qxcj0SU8om4Gmtc2Ad/HzawrmpfHxZfUhaeMebUc01NX3BVPUjETTrR4QOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438326; c=relaxed/simple;
	bh=mnGCQoVCpWKnS1efSKzWUWHETYIVpoK2sS6bGiha554=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lmJKu7YGr6QGSxuy6r6ovpi3bucwFUGji0vFi3IpzdPTIFmWmTyBxrzQrht4SZH8speZEqNsSH1jhDq55JoyHfKE0Jd1MEfCNvGI6Ch3uHyGGFs6TNxgQ/+DLFwKkCIbmNWU10TqXsRoYppxLuGHRYKZpwR1tURhmNQmFK+BPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2kIs4MXQ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2kIs4MXQ"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7f7dd47f712so579330585a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438323; x=1757043123; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5R53CM2TPsjTVnqMuru1HC/vS2z5OSjStJIxd3R0X+w=;
        b=2kIs4MXQ5XriRWYUBj2Vi8mvkUK4qbYk2+led4Xpim0OzanR6zJQJxN65ImWSfO02D
         inZcsSyNFfjNLP/aZA+JzHzcmHMNDa4AcefSiKoKoRSlEHcknUO3W4RY32q5s+wcAXWL
         tdzIV4bg1MvFt7wI9hiCMn/A5uGG39mKbJVuNJt36ifEy3UGIiA/qb54KzZc4jwUeCVm
         9ZLI2Ea0zUjFd3NA3odmhx1lcnVXoCI3P0sf0AvVxoa5v1SojPQ6C1d/BQlkWo5PspRq
         WX2AJpV2w4TAHC9pY+VS8L0AJZIuWoYHQ1C7o5U5KSqjQg9NL3F+OflDz/7T1GBrL3Nv
         DOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438323; x=1757043123;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5R53CM2TPsjTVnqMuru1HC/vS2z5OSjStJIxd3R0X+w=;
        b=BYbmwe3UV+6Xnt5mM41zNEudpueq2euxVyoXKjHO9KFStHXBIWZwLlX/lDZOM/GrPP
         Ns5Nz7M9E6YyIHlXf8+zIfXx/YYzOYp34YGxqPRGAAu5PMRwH7Thv9H2NTGW2iD6TEyu
         omehvoxvj04pghvcmG+2NVedakABQnLTvARBCSJnWDuyX5lthTBRprxbGEdJ7Z6f+Quc
         6rBUcqYCodOFqJhg9nuIk97aZeCGV0ixLeG1b9opLXSMWVUfd039DGw0l2VvobCAgWww
         /SOAykfVE7I2niu5Xms3R5gor6GbmMWDyopM/qptnyusC2qgarW4HoPbaHMLVstgaSex
         FFog==
X-Forwarded-Encrypted: i=1; AJvYcCVwopsXYmrEfHQusozUirQufp2iIa1UjeOMAlpkTijH2Engr2hS5E5Pd3UVyhExNrow09wrzOoMef/UMCxSXWSX@vger.kernel.org
X-Gm-Message-State: AOJu0YxQS9hfd+UQWnDC+azq6Rf7vYAdX5Dtmelqqf0Fq2xo/DsWxwbC
	f7Pkvh20+TLalKuM+TejrdMjELleKksQmpKWnJMRLhL/sVitAbbgZ3kkCSy5F7dziDzjLvomaXp
	B6wVYThwW0Q==
X-Google-Smtp-Source: AGHT+IE5KwZNXbrjkrGlNCyrW1riQSZJaDMhR8fcmb36i7fQTK2aprs5AGLAz7G1Hsr/ljtWTDIKNCwWp6Y3
X-Received: from qknov6.prod.google.com ([2002:a05:620a:6286:b0:7e6:9480:7485])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4409:b0:7ea:1060:ccc0
 with SMTP id af79cd13be357-7ea10f53884mr2440632985a.8.1756438323478; Thu, 28
 Aug 2025 20:32:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:34 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-10-irogers@google.com>
Subject: [PATCH v5 09/13] perf jevents: Add uncore l3 metric group for AMD
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
index 38ff7d1caafe..71500ea2204f 100755
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
2.51.0.318.gd7df087d1a-goog

