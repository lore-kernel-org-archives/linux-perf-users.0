Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A537FF67
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334676; cv=none; b=a1gY0FCKNyOpKL8ZyhRyWttn7MkE0dlY8OGsbEl6gi1jFy/q0qJGoTMewXcwdTK79H1dAMD2oVM0038YDGPN7OAApcuJutCHHIDwkX3CbkFZcFPHTQXf4b17qvHrb2hdeIz0emxdQboxMon65zyB3dJqAoKvTZGPpEk/tjKcUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334676; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s2v7XWI9+88foHEiAjbIgQM7+CHibgQK48aKNfCXX/8i2LuYeOI7Ik3ZPEVphgFLxCX2jXtgfTlehLiRuapuWIocAiy15fnoSmGFY2sZsb3MrvvwhS1sPwc3VQJO8acC8DY4YjkI6PS9X76QAGCFDhM/tDYTkgb4GCJpbtBLB2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqbAwbEN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqbAwbEN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137fe4a3640so2673603c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334672; x=1781939472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=VqbAwbENBduds9zbGgZcNXOzwOHH9E1Aq47GYAuEZ/jPvNjBKbPho/65vvXzq20oEB
         vY7X1tXobt/UVRrQHJxH4dVNepGGVjz1aPXrDHJkK7UA1jyCuJRlOhZPIsdwgsbmoNTC
         L5ktd2agjUruND81aa8+fxHIxAjACXHTIxTIH7hB+tT7S9TPY1L80e9p2PR7rWJ73t1o
         xJp+C/ckMfaxaQnA/WdTshR3XKIn9SX+AUsGvI96Qy2gpJbP1rf1sNgHw9Za3Xg1JoCl
         TpO95I7XQxNADNzyOYnz5wkkAO0QsM7whg7tn4FlBSNWllAIFl99KNo3KqWCZIQMbVIX
         2SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334672; x=1781939472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=oHymdlLRNyfNjxWT3SY2+bZgwywH1Aji1my9d3Ro3W5klnp/uW8p1FwDHiQftCVLYG
         4C9GP4CDYNiWtPXQTHEDKSII65cNAOc1GcUc+6/otM6M5hwTOb3MD38HP3jhIXk9VvQN
         V63UkVmfG7m7IzdT7RdrrneJ6weGqz8XEqR7m0gFA7gPqL1IKgjAmSGt/YpGmrhNFYYh
         Avy63n/v3u4jazDkWWGOfGCxpbsT0BKSrCYRxVFrPy/IXarZ4vcAj68z4Zqe3eQNqqJh
         Chof18rat75U8yd1H9rv+PZU4q97rPs/NZMMOm7CC4Ipm4RHDHSXYXX72oM4Be6gqppr
         Oo0A==
X-Forwarded-Encrypted: i=1; AFNElJ+2telK6cWzL2BRL2mCb9Dl2i6LiFfH5KMsavNSIqi7QeWluOvWO6lm89HbX16YlODJx1hFzbgAUIxqgBqxvM9Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Px7HBjAOyLtA73ixg5eR4DSul8UvtRa/D6zkDgIFvZ+lgLRu
	gZoB2qzyXzyzTdewqgViwt86ZT/z3m0U4AivOCxGA0w6At1wkgzcURw1HHxZtoeA20nmDp8rymm
	GxRXgHQTHFA==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:138:7a2:6b03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f11:b0:137:fc71:664e
 with SMTP id a92af1059eb24-1384baee6b5mr1365302c88.4.1781334672004; Sat, 13
 Jun 2026 00:11:12 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:43 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-4-irogers@google.com>
Subject: [PATCH v17 03/20] perf evsel/evlist: Avoid unnecessary #includes
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
2.54.0.1136.gdb2ca164c4-goog

