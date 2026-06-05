Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561C4611C7
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645237; cv=none; b=YL6uabNkkH0xh8mGJg75J2fV/k2SXTq7d2IPPUU0FlcUmwqiCDbKhfd4BDdUZWyAyY/+iGbCidYKs/7ucIyCqp14HyAxEPIG74FDUX3KcLnL4tt+v9T77VR6/jekswyt32lUl6S/b+Rsi7xU3pZLRpAmOIhnnObzjm9gpb1qN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645237; c=relaxed/simple;
	bh=ZD8nySNmfII//eX2G0gtlpqpA5fO9vJF8ULOOxAor5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JZw3xH/IClzAI2johjcw39dWrnU+JROSEi1ivHXidQNAZMTVpjn4mETqEluKsHceaqr5GndzRsA2DCkFho4++d7sqSkc1GpcmRHeNd7MtHtWZvKccI5k/X0bKZwW4jX+TgnDCHXwWbpxSINsmySiCGdikd1GDemn6FLZ3kivdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIyhwFY2; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIyhwFY2"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so2033480eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645235; x=1781250035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqXzvj0HL75GGH0vSM8SpyCIJBlgpw+ijia5w1nscwA=;
        b=uIyhwFY2OBVSZ+O42msYd7d3nXvnI1HWUVI4DXGVLBa0GYLLaAWbL0WnNLni2Yo8H8
         k92NwJ9Sa8HRZT8NnGghbodtWbaWrBkLic7BXotVZIWEwpcNxQziqsEMeKkAyrw/qLVE
         3slPwXYefWHE5QCYWmBPCclks2BWl2uJdoSoa2r8frDKoV4rJW2x6v7Sb6Px/VyLXBZS
         u38xdv757adBA+/L5i5IlGVatXpTOnTmEl+wD8X2td3qQGUlOOr9PrwPCVxNZaP7sryx
         372SpRmfq8g9oeG0GvJ03IRGLlsgRREm2r2jbfCODHtMiyjH4LXjYjtCDrijUleELpuz
         7kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645235; x=1781250035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqXzvj0HL75GGH0vSM8SpyCIJBlgpw+ijia5w1nscwA=;
        b=gvz7LjTHpA+zpMkDvFLSPAmAzfg4DzIQWanm4KJw3HlsXWxY+rJtoTrANd7HIvne5U
         90j04vOofr2aGmC6uvtkygAcous7n30LhEHjd/eFbTDLsc/FUIn861fwp0ow2akC9W8o
         IBcj4+B8bi4y6R8vt5XV9kIlE/n9g2gGvqI9nca8acfStjQi/5UD6Nu9QDytqaMgXsD8
         Ym4MsQcptGfODRJPljb/ItyXESCHSu/K3+W0QNSncYXOhylGHOoPTrLdNR+83O2z3/Al
         ydoRIX5vaHDAAvXqurorSIS2Kg+wA9rQf0A94CTAQQM8ZPV1sqxnocujQSpQw/UzxL4a
         4C1A==
X-Forwarded-Encrypted: i=1; AFNElJ/SBBMBWcYPKUQ+VCGXCXnGi15/xUsCisjEIaukOjcKU0Q4Y3E5zoJSACDIeVVPb5NqfBTKpUjVPFBk7/8nyJlv@vger.kernel.org
X-Gm-Message-State: AOJu0YwatWEJCWTylS/3gU8fKcO984dDKc/pS4PDN7ag0T0t2F/w3nMz
	m9N1uhtvDYHjguPr4nMyVCchotw/RYKK9aI6s7kcBssueoJHXbEe8+43vimJOArz8uIDw1DQuoU
	lTk+9c74Hfw==
X-Received: from dybpk15.prod.google.com ([2002:a05:7301:428f:b0:2f0:f8f7:8376])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4307:b0:304:8114:8d8f
 with SMTP id 5a478bee46e88-3077b3652d7mr1028984eec.31.1780645235209; Fri, 05
 Jun 2026 00:40:35 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:47 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-4-irogers@google.com>
Subject: [PATCH v10 03/19] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use forward declarations and remove unnecessary #includes in
evsel.h. Sort the forward declarations in evsel.h and evlist.h. Move
some PMU code into evsel.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.h | 15 +++++++++------
 tools/perf/util/evsel.c  |  5 +++++
 tools/perf/util/evsel.h  | 25 ++++++++++++-------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e507f5f20ef6..e54761c670b6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,29 +2,32 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
+#include <signal.h>
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/refcount.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
+#include <pthread.h>
+#include <unistd.h>
+
 #include <api/fd/array.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/evlist.h>
+
 #include "affinity.h"
 #include "events_stats.h"
 #include "evsel.h"
 #include "rblist.h"
-#include <pthread.h>
-#include <signal.h>
-#include <unistd.h>
 
-struct pollfd;
-struct thread_map;
 struct perf_cpu_map;
 struct perf_stat_config;
+struct pollfd;
 struct record_opts;
 struct strbuf;
 struct target;
+struct thread_map;
 
 /*
  * State machine of bkw_mmap_state:
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 34c03f47a913..19e48b9260e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -370,6 +370,11 @@ void evsel__set_sample_id(struct evsel *evsel,
 	evsel->core.attr.read_format |= PERF_FORMAT_ID;
 }
 
+bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
+{
+	return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
+}
+
 /**
  * evsel__is_function_event - Return whether given evsel is a function
  * trace event
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8178858d168a..6b28cd754a18 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -2,28 +2,30 @@
 #ifndef __PERF_EVSEL_H
 #define __PERF_EVSEL_H 1
 
-#include <linux/list.h>
 #include <stdbool.h>
-#include <sys/types.h>
+
+#include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <sys/types.h>
+
 #include <internal/evsel.h>
 #include <perf/evsel.h>
+
 #include "symbol_conf.h"
-#include "pmus.h"
-#include "pmu.h"
 
+struct bperf_follower_bpf;
+struct bperf_leader_bpf;
+struct bpf_counter_ops;
 struct bpf_object;
 struct cgroup;
+struct hashmap;
 struct perf_counts;
+struct perf_pmu;
 struct perf_stat_config;
 struct perf_stat_evsel;
-union perf_event;
-struct bpf_counter_ops;
 struct target;
-struct hashmap;
-struct bperf_leader_bpf;
-struct bperf_follower_bpf;
+union perf_event;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
@@ -356,10 +358,6 @@ void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_event_attr
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
-static inline bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
-{
-	return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
-}
 
 int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__enable(struct evsel *evsel);
@@ -478,6 +476,7 @@ static inline bool evsel__is_group_event(struct evsel *evsel)
 	return evsel__is_group_leader(evsel) && evsel->core.nr_members > 1;
 }
 
+bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel);
 bool evsel__is_function_event(struct evsel *evsel);
 
 static inline bool evsel__is_bpf_output(struct evsel *evsel)
-- 
2.54.0.1032.g2f8565e1d1-goog

