Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400B37BE9C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287815; cv=none; b=LJ08mE51Vz943VuiSAl9pppMUw2pBefnEuyMmcn3Mt6DEZs4X93d4I0ljXFPmVfKVW2jDjz+a9BXgbwg7IoEeSzdGe8TtAoW8JUTbMErBMxVJoCoBeFVov5lsSAsIE6wwIop28j95hH+gby9lNjCm1QR+SvRGg9XAPYk7GLm3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287815; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jjq3Eojpp0Uoy8jcgreMfId/fUPB9mdGdmJhx085cXOfmRbmmpK7tmBQcl5W3OEvEcTyaz9SFcA276zsCIvYk1oPeIx+qvcU34haet7wksbh7FOBOB0stJaMydsAgPv6p3Ketk2gdQvqM+ULSzjYZVmqnGM1DtpGigiKpk+O0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrMd1T07; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrMd1T07"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so2615749eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287811; x=1781892611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=NrMd1T077smHTdhOzZJ3mXY9iAX4O8bMONWblO3Nrp/97iRirmu4PeXHmt06/Y71XF
         SnBCmlqtqqnL0VO2yj0TBUOKTsL8fCHN0WsbdTpQhSpLwK2APvzwGza/M+dLxP00oLGj
         3zsr8T0FkgeiVS6nu5M7EyTzOS+voH+Bt9PBhD2LEjoYjLkhg0xXa6Bn/dZWEY/tBamo
         RiZrUrXCpy0j7s/tbllxpfnzHYjn3VkI/2WrIggEGrkcG3VA/ruMP6VaCxf05p1T/NH3
         azOaISgcYeNffThud8pk5Lr/fuw9G7lF7jsk+J9BbCCZVbGIk7ZzrZIlzq8d6HI3LHln
         4Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287811; x=1781892611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=QjdtQ5SVV2DiY024UZfF0f0PjcMh6sNGDTlqh/F7E6ampnJnEBOCwGI9rgquwmCeHY
         dSIRVYE7JoVp3JYpUqp5wGoOQHwQzv0bHNtUERkx+IVtBLzcKtooTykHbbBLCZblipdW
         gQzVHu+6tl4q7CEVQbEkDVgvcp4njcUdVV0evzcTDRwvgu8zlybbYEbibuHpV1gualR2
         5/7w/KpGBHuONDsP34iQ7jjnnB8ml6buuYsowdI1MYpz1wpFkAD8HUICHSQ8YqC/L6u2
         JEwv6YWIFGtwPGpOqXIQLZipf1YeMSUBjLcnK3zh2ey/R5VPmnC3vroDQXT75ANEsAcf
         uNJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tryq5P3qIBsl56TuhUwfelxZp+l90cEj9G9V2HeTogq3SQqfSGXKKY1xVSu9FbmyTD7DTPkVvUM8TTRTIcoWT@vger.kernel.org
X-Gm-Message-State: AOJu0YwktyGx0h8qZ+XQdK+yBRcFbQYmDULrO8og9fL7gYKW3ymblEEu
	KtzSZTI/ZILn+Fy3vDTCYDV3WW6+fB7bwct5SMv60xUP/4MXe2B26BD6ln8MyFZ7PMPIR//Ih9p
	5nM55CLynNg==
X-Received: from dykg10.prod.google.com ([2002:a05:7300:578a:b0:303:9bd4:479a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1344:b0:304:e7c9:b528
 with SMTP id 5a478bee46e88-308200d33aemr2127893eec.30.1781287810738; Fri, 12
 Jun 2026 11:10:10 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:40 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-4-irogers@google.com>
Subject: [PATCH v14 03/19] perf evsel/evlist: Avoid unnecessary #includes
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

