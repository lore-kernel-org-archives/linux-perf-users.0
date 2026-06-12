Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70903D34B3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302364; cv=none; b=bgcPcSC7Ug8dfzSKHXAFrbzKyFzxSP76hN8DFDUAXK46BgAXAwQzBrwOh57T1WLUKanDzAM9sL8Akg7osZsIzGEBRCTrI7LpPlRq/eAkGS0KwoLJL+B8MnZ/+E61KtbQjMA24g7HSVyIFXHKxLJbLDr8aADzew0/U47N1McJ+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302364; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g99GqzbYMGYWaMXbQ4qDr3D2YvpmbIgsju2vGimYGV+b2g8/IFPIFpz22hI9vE0pJHgaogFLZWc9SFebPq2wZGo6tbvKWdwHMbrBD5Htn7SwmfUh5yt9duP4geI2M+sqx9WtTYpUjUs31IqpVqJ/DiO9brDeHhng0VG1Z79bexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Df22yw4i; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Df22yw4i"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30761ab3483so1158473eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302362; x=1781907162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=Df22yw4iNmS7iMaH81E+3XHxwzA6/vtnYdoRFRkF+PysEG4oPfOXaPXg1TcZ+VHMcn
         tJDLIXB+Eh5hvqV0HKQ5Zmqy/xWF0VrWyuDxazVqPNhw/jManNvx204+92Jl8kF6Wl2s
         tKH399H8ksyVpAdDOyAfFPjmUb3+/00GNKo2kuLFuxIUvaVbPKMGZrrfeajfx/E0XAaO
         x4IMlzCy3xaQmHk6nk02IjXYIzynSyVAITSxa0Prs0RbdHZKqMcoFmX2AkX+ha7PTP0B
         z7ODPOhBovXiPWoYgWy1hHuy3ZazUeZrCCY5aZlZgUN++j7zxSRqRtJfWPOgnvXdoa5Y
         CB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302362; x=1781907162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=mSG7QDhCAthuAyhDSOBKu7eURd3do7/1iyLdYa4BqITd4J1PapE6J5UqDNZOqyoSL0
         jRIii+/SQgEIOuL5C1DYM2G+VkEoGD3lI7Ml/QJEo/sTLkME0m+kB4F430aEc5ugH7zz
         hF0xcuAG9uiw/Xe7EjAsAL8a2JI7lQT1namBWCBljz5VGXBb+JvOxbRTOD3VIU17LLUg
         SeRnJe10kzb9hwXbpgNIOadDzsPbCZPT0ELptS6YxGF8jdIsSFgYo1As0ajK34z05qaM
         IwIkSAENiMZ+LRbz0yBkEOXscJbbCkNQEJCuIs7qbMfXPbhk2ZbFd8iu92gmmiylRpzo
         2O9g==
X-Forwarded-Encrypted: i=1; AFNElJ/g6DeNKx093aL04GVAnuN5mjO0kRTzmk2X2BtrVeivyncnYi3Klq1JO0lE7wSCaEm984lSvFH8ThCcNeb1RPBT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67s000Jk9tEi2ooGr6mli326NqDdiSk6jxr4Pwn7iNRj0fgbI
	umtxAdbMlEEx/wtFC4MxfNDikKJfUhVpOeoBdFOmX2roeJF7o/h6n+DkYcovo+1xTddNpgr4qLK
	+1F1ntLk/QQ==
X-Received: from dybnb29.prod.google.com ([2002:a05:7300:cc9d:b0:304:d272:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:324d:b0:2ea:b7a9:580d
 with SMTP id 5a478bee46e88-3081ff73b7dmr3148646eec.9.1781302361714; Fri, 12
 Jun 2026 15:12:41 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:11:55 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-4-irogers@google.com>
Subject: [PATCH v15 03/19] perf evsel/evlist: Avoid unnecessary #includes
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

