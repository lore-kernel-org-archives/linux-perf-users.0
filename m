Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037303B961E
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562630; cv=none; b=qidLODQ8aPnFLSczedJb+wzIEbROJW7O7c9x9xS+8p4u57uzynJsYqB3fvaYhp/NvhCNGxeQYJAbjfntuZwv77pCoCuTE+55YRrJY2YhJF+aEz2cx8ymFeXy82DfupwmaPxtjjbgeti7VgsnD07xNp62X8HOxponYG9mIRAiO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562630; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSMhAgYO0ltV93jQIUX7ZkKjODiI7sB03Cq0wn4y8LYrW+NfaxmirhpYvIGdidOxHX16mejmbAB157Xpw/kV9hWiTo37HXPtUg6aevq9aKu1DYOJNQxdLvGtrY6NCbbTpAc9mrm+p0gtTmKKDSkZL8UEwALvpLA04RNXB7yJ3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geu7sJ4W; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geu7sJ4W"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307625ee07fso13471348eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562628; x=1782167428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=geu7sJ4WifmBCehVWq6/20QOdbMhs25FHsz+f2g91zUJO9xXR7H/tbec/1FpT/Lt+3
         WgjFooFJdq6ngcsbH7D5Y5qY4450fJYEr0Mw9D+mPUxMU1J26ASKfS5Y2+ak30GCJ+Ii
         EdWrgruvXPFvkO+/TfLpse3VI0KVe/DaomSopTc78lsou2j3WVt+TEJSDhSJXr/4DX0s
         xPgssoOKZegqeK7BnNfroXFS0QNec4FB6FHQJ/jlNNMoFTPf82Ge5y72qECPcZo6JZRI
         ef7iak4Z+WYG7d50N9BOlKYUuTWKH1UjLN35g+tMXTm/jumLZH0G/a+A1xDJGDkZ3LXN
         I/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562628; x=1782167428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=rjExgoEwUdvaPpRfQ4KiQjjUOFOtGyZ5I8GmRhqI+O8cS5VK0BK6QmlqeYdhoFxvsF
         +5Zeu2T4PRD+Cz2iTDmbQ+cEx1GbsyE85b0a+6TKP4jcUdJAoWqO7QfeoWLt7GBLGBnA
         ZsX/CJwL6+ah7nGYNJXb4gBL6czjvkkXo3OvrovEABW3Rgt/Ly603DjJ98BYV/FARWP9
         L+4LU78GbWBdzC2kb35Yq7ViLaSX5CV7AbsdnYKukphXDZb3r4pnFn3YO88UVjMU2Z1f
         7a36iYlwuML7oPyt2EzYVwFDAN+PjRGHxVKfJ9YK/pjHvOv84aCilY10OgBGCf8Ukgmr
         wIpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SpF5WjMzRAlyGZK+CI7LxkZax9T2OdIGFWaNx72gonv1yG0AxkZrnJRYqEI1A1Uy66g5aoaNhMdjCbW4GRRY0@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTK814npmIm+sIDo/5Hjyzwvg6rr0k4mgkbPc4MZUQO5vZg2h
	f9OCIiKjtdZoyewU1ceVd8cd0UO2iwvyLLpjr0bHT/4I1pTmGw5iW9Q3a3TKMhvmeA/FJBoc4xh
	e0FCfxDgzrw==
X-Received: from dyji23.prod.google.com ([2002:a05:7300:7a17:b0:2f6:ff42:df28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2148:b0:2f5:5dd3:1fcf
 with SMTP id 5a478bee46e88-3081ff97b78mr10768829eec.10.1781562627876; Mon, 15
 Jun 2026 15:30:27 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:29:53 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-4-irogers@google.com>
Subject: [PATCH v20 03/21] perf evsel/evlist: Avoid unnecessary #includes
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

