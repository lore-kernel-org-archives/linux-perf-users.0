Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAF40DFC4
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686925; cv=none; b=B0DQHRmAJdaJZjW7xewYd0KZD0h0y28lFc2hjgerHKhiNeFhf43KnHpQdhs1LSVSLgafzIotcV8jFJj9Eo6OGJQ2AIN66ZW+W4bQsprFDLmlWbbKZzkasiMt+j66Q4O6cCD8K3cLBRxVWSjBoAtrSff68vX5iRMHjot8tudKoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686925; c=relaxed/simple;
	bh=ZD8nySNmfII//eX2G0gtlpqpA5fO9vJF8ULOOxAor5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVpwFgsLBnTFX8wDq3GvzGTjRDkFUq9uR/hha4Abfev6JABwew3QcZxp/XiPg9UeGmVw5jQcdEQL4PhkJBw8roA/CLYgeN09m0Mw0W4cy/7Ql2s8kG47kBfyLVxWhqfIwHE+eyoGMIw6vufyE97yxfid5YlXx4K9Ew8QVlkxjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVo4wREk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVo4wREk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso2217921eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686916; x=1781291716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqXzvj0HL75GGH0vSM8SpyCIJBlgpw+ijia5w1nscwA=;
        b=uVo4wREkSRJcIg2n8mDwhDUKtY6EFgIFPiTHgKHJOESCg5x2vlyCY7f17KL25g2wRT
         dL9bZLCl6M0qTUf5XElykgSKEi3TdPCbt1UYRVa+WmNZsB+LBF0rVQcs4SWX7HUK0qS4
         kTaeWePv2CCojjIbySoGQjoSPF6w6QCPU3TzMnFE8s3NZ8O3ElC64n/vMYRgQF9xldFi
         vzpg0vrahl3G/EMxw84g3Z0NrnkY7tS/kii/YQ6fxnmHiKq/fVy9PtAQSaGsUjAwLYkP
         +rcaMvc0/kuKTsGKkYx8AhFpbgfp4jipDj1eY40UW/MAuodMo5UDOvCSgFUrk2uQXPQG
         xNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686916; x=1781291716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqXzvj0HL75GGH0vSM8SpyCIJBlgpw+ijia5w1nscwA=;
        b=JpaOdQ5HPB43ICe3RiUGDwJWwqbGvTHOtRBjivO5EXnuoTgpgVs5uwAo+gwGaj2Tow
         msAj+IZmV9y9LL6JTp2i2M24jHrpvLpgKggEE2PHBNx0a0YrbbsnqUZTXAP2PhNQCEXH
         gwdpRLrdBtQcjDgFKodTyJw4cEoyinl03+1VAp3a5tV4jBQcjJmtT0AL3q3Lk7U0a9Ew
         K7raMKXPoumr0EACbvlJHjFcjUS4MvKf2A4OVm66ZTQ9nXz01ndNJ9s29AgHPWRqgWgV
         QcVsJJRwjAYao8hnuC+nNApHvPCXuJxX+dS9RmJ8GiCdP8t4a1zhebHXUBfeH30Ne24r
         2Ktw==
X-Forwarded-Encrypted: i=1; AFNElJ8M6y4m/PHfOT0oP7eFxS++H1UOQqDdgGBOQdRYAx1KYECR+8PEtcybDjjvAthi0/si0Xdpu3pNuqO5/7yuBDuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOk0qTGr+y8YRA2aJNOxeoTFQ0RMHeqpr7x+PRYMw7KNIaxCVR
	2thVMlMGBFobMKQuU5l7/xXwMhYWcEr/P82yOei6nGzfZOfLiAOE++QC39FA5+GDYfhDv37GHd/
	+Y4md+Ym/IA==
X-Received: from dyaa27.prod.google.com ([2002:a05:693c:40db:b0:304:ee01:7777])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d517:b0:304:de94:1c2c
 with SMTP id 5a478bee46e88-3077b866467mr2881457eec.34.1780686915906; Fri, 05
 Jun 2026 12:15:15 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:44 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-4-irogers@google.com>
Subject: [PATCH v11 03/19] perf evsel/evlist: Avoid unnecessary #includes
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

