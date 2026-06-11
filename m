Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE739D6D4
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217907; cv=none; b=Aw3uUGDpj/vPdqQCkclwRefHZYCFc6fDDl2xehIJmELxoEvVP0IDvxtwPijgtkikPDynH/4rCwClLnY/nlxJD5wZN4M8m107u/vUvQXHth52Ad0FreGy+MzDM5TDz/09eEWaHeEuQR3YvRqdiw3bglm65RWIH560ST1E0MXsOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217907; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+sOtO4rWz4m9cGNWzrKMyo6U/ml2OvttAn1vfHVmnnH11QYwzC0PP1U6ciZGRcKSYOswpEDWbxKOFU5khfKRKoMUTVm6jvPkMWbm8SA5C9TMyf81+ZxzleB0vT/a9ZCYmwMzeGHVy2Gt3yDMGKv5PYHFj6GqRT5axggcQfw/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CceWqu4+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CceWqu4+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so959797eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217905; x=1781822705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=CceWqu4+ckgRx+8Jpp91lP5A3tzkxseeizq+Z/tTO1V9u6X//aPFXyR387wdypu2wk
         8CTTHe8bq+TKmcw/ue0ChlJel/W8EQwp7Cg1alxhdgvBLQu/aZATeKZfuXkSYhqlBvk9
         RZdJ1kVhZpySB+BJAVC9lZ/hxtO5YZrqybKAY4osl1eywERUKFxqRRw3CN2xlDD+R6v/
         /P/7HBVxqZacQlpvH7x7tWT7Jl4+VHmSfYY3G8w96u8jJbuUf7W7eNYMClDJvHklxUBL
         pzodjLFTL8A7moNeUpw8ywXJPtMBasXf/Ln/j5OUs0spCdUavUfyrupxSSKfA1z0qeEB
         609Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217905; x=1781822705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=UU0/YbGDhuWRTFmvbeWYQE3o/ahhQN5GpRLyjFOsVW/7kApK4zItueauPW9ZIWtXca
         9Re8H5eWa0vFMYziN0ni8gozunFNw94mr6IfpbEVibDI6phbIyDZqnFUOu1Y0OjkUlnv
         xEAYqqZxGm+ynxzFniDMJtyFu1Xk4veQZT4AZGM5DI9pAxZsdgnxmedBC9n/kBQA8M0P
         qgqGDItc9xDKmqa3oh2LRuAVC3lmidguBt+tnX7vx2As3yTkEPwoZLdyYa4J5J4ieUHu
         mcMVuL73/VajH0kD+/goRCBw77vwL/KXaJBbyrJHkpQSp5IpSCrZQ+Rzh5cMlv62jWiA
         S2LA==
X-Forwarded-Encrypted: i=1; AFNElJ8uXEU+EOa8iEeaIJeb2kNQQEqAj7ZjpBAuft/+zJzgNXGp/2Zfh34XfOn4lqZV2XgzJYscty21S9hY11r0SH58@vger.kernel.org
X-Gm-Message-State: AOJu0Yybu5WRSv8m9++0whcHQ4pcg7itq943MZAkNjjzsbqnKu70YopX
	UdchIslCj6XHCUYeh7ADSWxCrvtuh1Isd+O5322fhixdeCW1ws7Jc8QFhphSLOz44s/Xmv+DVdB
	8R8oFUCrLZg==
X-Received: from dybqy24.prod.google.com ([2002:a05:7300:d718:b0:2f9:af7:503b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2393:b0:2ed:e16:6b4d
 with SMTP id 5a478bee46e88-308201e6647mr190446eec.35.1781217904520; Thu, 11
 Jun 2026 15:45:04 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:39 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-4-irogers@google.com>
Subject: [PATCH v13 03/19] perf evsel/evlist: Avoid unnecessary #includes
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

