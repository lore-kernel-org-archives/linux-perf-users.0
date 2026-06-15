Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45E3B0AFE
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504206; cv=none; b=pSLkNZPfL6lqQ6grgxXGTxhdbNF1P7GQLKfMyGyDT26VHrG8H6IippmmbzlhsB0CruPxnsokxuxGtlGLTo/87AeOdgpsUCIkXIh3V+x1IrxnxZsNq9vLPnbdC1eATBq+GoMBmySQue3NfjF6slYMSUPapC4eGKm58E9xDg4jFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504206; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKWUvcvnvopoPUzBdxfTnrQI/0SKRg1MFVLRL4I5QSNGy8mztMFiGTFObnL8II5ERJN0sjGVeSTnVFReGYBMJCGCAOpIHS1Xcm7AjX756Wp7b4fYxNh7eDUvtxLXaxAzyxkhif2CYuikpGGbTOJLp4KDTPchfOK7h5EeZhMl7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRBJVzMT; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRBJVzMT"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ed777a96so1974907eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504203; x=1782109003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=QRBJVzMTioOtZR9vZOMmUieFhFmL/iVpcGlBEyg1Vcj/qYhNndL224G9Hkdem3qHh/
         3UZLwLJACaAnkERL/SieG0LJeNArRg/zYURj5LD9TuuOrIrVQySJio61SPBYVqCipBQ8
         LEcD7IV/2fO0VXECBUUgoFVtLa2+F5H5iWlaYhrju2TtoSr6rDWj5pQ1bsCZPH+vftJG
         jkaUubBvz1BphfU/pDEA98RZMvfu/R4/SFSJB0jYM35qa7N3keHK91JZtgy2KppfO0ks
         0qoEJQK4hv6cE/E1/yPObNtyKDOQV7pulIUj/DxuJcBq2/yfJbGYpO1VcXGFKLIDtZkT
         l8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504203; x=1782109003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=nodaQ2QKNmyqgi0Nyy2FUFQdg/HaM9HZZDTtcYXo206A3HbzSLEColKY1fJHgBF2C8
         iCovGRZ1BaZxrjM+z+Q1dPuFfFZVosyTKFC4LGpHEvrwy8Dut7G9WwsgnxBYyn+af53r
         e+Whwm8u/EQSmXeK623yoaYFnrKWiw1FnFbmhbr+ptk4BRL8vjU+ZLCIoZncfAngK25W
         1bnaUKLbzRBkeGZu4QN9S1LeUDQoTSbM4rzmAuzPICa8LurHH6NQxWJvBrfXOI7zD6mR
         USFSO1g1gpBH1E8LccFZANxTUTf0A54orBYLWiBL90eZKgAtD9woGc9F8xP00R4oT3YX
         80xg==
X-Forwarded-Encrypted: i=1; AFNElJ//k1mRd2ZZWqGeDb9q6vYAuCkJmrKH224I2J66PCMaB/JMcVLgQ3YRH9r5N1uAKAS5S7kKI8dW8qDgjW2Q9WUP@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxwWHRgZ8SAGkYOD6p84+oen+ibVv8Ijft8z4bqZsYGdvA5hF
	7Aa8DK/xojVD2H6cKA5rRyT3MsAp/Sx7iYBPCWAHEDtrTjue/HAWcqKHf1l99NvEh4+ztgQw0cV
	fFTA4zttZ9Q==
X-Received: from dybbs28.prod.google.com ([2002:a05:7300:a21c:b0:307:bbdd:4346])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:65c8:b0:30a:e52f:9b99
 with SMTP id 5a478bee46e88-30ae52f9d34mr2329654eec.0.1781504203036; Sun, 14
 Jun 2026 23:16:43 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:13 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-4-irogers@google.com>
Subject: [PATCH v19 03/20] perf evsel/evlist: Avoid unnecessary #includes
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

