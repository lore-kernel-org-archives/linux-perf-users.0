Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09235481FD1
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198303; cv=none; b=OkCvOQXz/RTq9q+cgadTp2hYZFHNdtrVZnahpd5gkWjr7sfAejsX6/QU05nJbt69ngo7b5FUZnz9ECnRn2Jnuy+YFixW6RmCKhtlzmkslQHycm4mU2+XQkMzNithq0MelIyjnU4xYFyUd6vo/e/nSckCrvJfXwQpVXMLiB/SYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198303; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3EYvLrMY0C9TESXh1mPdGVrnIKsm9Pm5yeuDEZMuMrooULgC5aq3FEXZPdq5YoCCNPvM/ds4/+eCGSjPRGirLnZ4KCy+Pc3USPBq6eiejAY2vCWhI6f8OwmAYEOhYV6PdzI89mKLscw9D4jks//LrnaFj93u1Osnr/Q9dZmf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aODAzUsI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aODAzUsI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-308004a2c49so89818eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198297; x=1781803097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=aODAzUsIMXoxDKnuOSmc3qpZnkXEXaFCplWpRa6PwWVSHl2alz1WRLm8t4creXC4Fj
         XYdKur8x6PBAW6adWN2Sr+M9EbKNxkCILs5fjRjNaRa1I25tX8at0BsuYc5dFARfczua
         TfUhUSSJ0Iu7Thxnl0+NL/rkTzydkNgK/tDPpM/CF94CKzHbrv5K1ghGLiY2QCZVuOx1
         WFOiej+8w+f3AzqWOyOEKpK9ppbvIRzRrYkO0nK8F8C7403ol5ughgYz2Vh0cXNvVTgK
         AIBsykHmIm2YX1n6lmS+jGX+U86KaZrFI2nQRmw8qQvIpGMBeVv9fyhOqhyTcvtmj3OF
         jP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198297; x=1781803097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=rWzQeXtxtUhjG31mEBqkWS4rk5y9NtK8ISzbu2hphic6pTBT9CWJh7R358jVAwh3JA
         vcSUuoWSi1YwRQhfBcFOK8szl1wqLW5Jtfm6Iri/KeyWvOcM2bscsLDV8LDX+vkH7nkm
         jqpTNvdZaRA4jC8IZmVePxV264H4jj1AMlZStQyU3AINirxD13Vzgba+0U004SmKRIJh
         ubjqy/Ck2b6HDvj+NcpWXxmSuVg2LPcyTV7AW8j9XMpjKZMg0agO3nyNsE81GhgE8HNF
         h3flLeYJKrfDO1cmeHk/tqsw5VBUMpW1T0yvaiPJ1RYA9ceTqShP5O76/0vLA1DxAM0g
         1RBA==
X-Forwarded-Encrypted: i=1; AFNElJ8KNoyIRROPIpYVf+Cbmv+VdMyhp0z1nS0wOK6pUgZOu5TJr/ZHwr2GhpE1xXRWlI7z7xJoC5TDuYRndsrdX2gF@vger.kernel.org
X-Gm-Message-State: AOJu0YxEr/ZQMn2CXodU/9YMajMxnfpYotk99Fg2Gh0ZHegKVXeBWxNX
	Ece8wkCsiGytSeKOxFLr+pjArTZ5hDikDaPgM408mFHMCJBJ23mD9HAvieltrZt9FQ/c9yIpmZU
	J/CB80dJ48Q==
X-Received: from dyvp27.prod.google.com ([2002:a05:693c:885b:b0:303:3f37:eaf5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a146:b0:2ed:e12:3773
 with SMTP id 5a478bee46e88-30804cdf536mr2919358eec.35.1781198296578; Thu, 11
 Jun 2026 10:18:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:40 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-4-irogers@google.com>
Subject: [PATCH v12 03/19] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
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

