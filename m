Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523652036E9
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483306; cv=none; b=KEqbaL/4kQ0/JRUKnZvoPmM5YyIUmbRBikjtmVT7AYM28vBCfLR1DTMgEgs078hDDeGqv+CJ0YGgAxWYXiIxI/hQxMRHmGzOEnUcSGI1eHwEK0ZVsVjML99NpDFsdUy/R7dQbI1Hur+BwM8VP3Gk+UmVbUgRdDKfrbyEbSvJCuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483306; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AsQfIvP+jLxe+k3obGEIpaUvMFLzFBtR39//+qiervHj7GouImyr11Vc1jAEV8YX+m2W9k2zANacJ0Z5B7Kby2XqJVoaX4xA2jyXG4thf/NzOr+KKJ/hHQMkPmYTZhaK9FAvBNkfpAHcBESSzdFH0sJqJKqHua/mc0Ig1BO4axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZYCdfXf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZYCdfXf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30761ab3483so4108523eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483304; x=1782088104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=aZYCdfXfMMwk0/M9ImlwrflpsdA6DX4nxP1BZpSu7y4ZRssrH+pPM7WsklkUe9twvj
         XAvLtlLnR1b7vqsF/FzlLwQHiM//+dVVg7e3EPhfmTyLYT5iCQ47ruKoc1r6ofYQKSf/
         rr+F8ljY4/8zZZqZlH48uvu7ts+/aXhJjEkS9AMyH+uahyNdKDtau5Ii8vaboE7jW5Ug
         SLvHggHkmQ9xHPBuCtWXrOY2aF8tDa/A1ikJU1kGYkHc7kEvhhy853Y51cXGIyK62Lqn
         a30+nqWNvqi1OAHU9tHFhjhjgK1tVvwLQFB+okay+W6d8aFVVqkkHi4alkvuM5h8Lxa0
         +dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483304; x=1782088104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=ZAHD4jOKkD0idZZ4q9A9iy4cLQPyvaBXViKIqtRivarXCD5bHu6BZcAkO2zbLivL8c
         9f59yBLYu11Vh8htgz74SSfJ0AT+aWFrg/NKHWQb8aY6FV1t1HyrvZRCHoX11RrhUmNn
         yW7hYtrc5A37paOjLRO32A34dxKdFPTIGP/3lw2/qq10uRdN3z89V287hseZZUUrA1ew
         tfzgS3PKu4VNEkBa4GdeYzOg4/vNWBlh77E3ejbtBlzDCUptHAahOkAN7cUgyRxRfn3n
         pPNuXtnbWxDTNwjumCiu1IkGC1dsDZGY0I3Q5h8c3WK3kvzuNh9bjtZNOz1Y6AC6bZR5
         k9VA==
X-Forwarded-Encrypted: i=1; AFNElJ9tRSZvbsDS6zrMS8+URsj3d2qs5710CZ6XNbye70+2zoudAveHoDeMMG9DpL7XtwmFCxiLcTqGVX6Tog6oBNZ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FpCHOHRZVKskF7KncpAZHeuHKadmP/nRPRD37CWKHNogge0H
	gaXlSPeuxeUUImFFQcDzVI4ZhDuYL4tgiBh0mj1T6KhUowVVfEt+IsgU0/4rbDFde2Ktrt4oWeL
	VPI/mGKFu6w==
X-Received: from dybsc14.prod.google.com ([2002:a05:7301:4b0e:b0:307:23d9:99c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5415:b0:2f2:5c68:5052
 with SMTP id 5a478bee46e88-3081ff744b8mr6295172eec.13.1781483304206; Sun, 14
 Jun 2026 17:28:24 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:27:55 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-4-irogers@google.com>
Subject: [PATCH v18 03/20] perf evsel/evlist: Avoid unnecessary #includes
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

