Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A11403B13
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542223; cv=none; b=A2L7A1nItyr84p8kSLu3Lqx/MDi18i6tmvp8l77Ba03NbOu6PDATyIoiLt2chsdeCCzy5ZRa34Q3EZ2+35+YpfO/UDJmBCXuszT4cgVhcp7XMyLksM9O5mBnXsgm+/fcBxbIEE9e/E1McWiu6duNOR4QgCWNfTGtm0h1ikua5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542223; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B/s9hajImL2J5BhoPlB/2fY6ksluOhav9VrdSV8+JX8SvygmBxAlAG+5KtyFDdvHTtbYByhE9Vu+/GPw3fDoa738vYmZUT6PCl6V2OjgcxjFz2nTvUC1C1EuYJe4q+l1bv9XSHOZzkKFuOMsTPO0fmETuvs11Wr2IMQLda9B7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlS5eL4i; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlS5eL4i"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304df51ff3eso7608947eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542221; x=1782147021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=PlS5eL4i5T+HsBHhns/T1GHZmJrhZE+hXJuH6u8YP9EoK0+FWRzc+TNiqYoFkHTOz9
         fuwAmIRwR+0aCQGc8teebwQNerp/2GapMPdmvQvba2woZI2mta15Yk0wtvIjxpuEQnzO
         EcbiEl9Xx62LN184CweDX7ATvA4D6XMyD0giRdlFXFmYkPIylf7mYH6KJ5LJAHJ3tcCM
         X2lKluZmKjul0kSmfioTg0/et+4/LfMnidUILBS1Hm2+qzlaQvViAiqx3Q6Az5Gpop9J
         OGyXhEfRJbJAlzJ+YTXyxrN4bFu++HmGyd5NZF9s8yEb6g6P+p/pk8W7DunAr2+FEhnT
         EV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542221; x=1782147021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=ESL5CASDCt/rWSuLE9nsg5fWuyI5lI8uM1RGL2svBoFIitObu7OHcHePFrP2KylU+I
         pyz0oJJk84dxEUb2dBf49zfBF8j2ayF6wzEh0C4kBFWQPwEdnAPa/Qw4d5mUgz7aya8u
         eB/MraqopDIamDoaEhiYneRLnyXs/Ffv+gNH9DUlLqlZe2YYhii62fPTgM42qKttiNCI
         xuXBn87KZ6tCbKGj/vH1UMew1MYxn0Mm3fpn1+VM8EziJm/U0fCNHgSzZtEFqkYZCw1K
         OcNfLQ4lriYMj5T3aFITEvp2Ej5At4h0Ar+DtxLIK+cTN2s1SDwmHbvN4/TyP1W7yXsL
         vg+g==
X-Forwarded-Encrypted: i=1; AFNElJ+6AsGxVOJSiQRzYk23Do9rPu6VNJUOTq8H1z+jURZ5lV2pRUDOQI2QlK/p62viI+8TxEteitAS+xE8lBCrU7al@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Dkf/iVBihM6C26JUi/K7pofDKEbaMiiH/nO/RnBE/TR7lJR/
	0W1Ztn1vIYOZFNs7hNUTKVmO1ixfCQ3u6z3arSIQDe6fxAuhmHuUAgXPSgC1KnuQyfdyW2yuAFi
	pvGKKjqbQXQ==
X-Received: from dydn14.prod.google.com ([2002:a05:7300:730e:b0:2f9:af7:5041])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f10a:b0:307:91f5:92e2
 with SMTP id 5a478bee46e88-3081ff4b659mr8193908eec.4.1781542220454; Mon, 15
 Jun 2026 09:50:20 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:49:53 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-4-irogers@google.com>
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

