Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EE377EB0
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572561; cv=none; b=EHisv8h56uIPH+7xv9oB8PcGURKxPEbOBhPvdkP3x9YLUSDJpf6OCBV7B+2Wo0Bm3k200fGJ3j776T085jRuOOWdEjLsM60lwI25TO+iFDf13yPAU3Ea0vYEpRghYIc80W13mJQvovumS9MV79F5q9o6aRmGH0gMvC1e8Tf9lI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572561; c=relaxed/simple;
	bh=JSfVdaFgVT+16BkkuKzKlIjgGUMwUVUUeSc4uGtnw10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihqRyT8gBXV8uYL4HarDlzXgT3cRsOcW0yN3fKGzzT6cOkA+xYKgN2ktFWvyXCQErr7TSjK/+f1qlgnD3GEbTwTDnUKr9z57MZl+BY6JzhuAv/fnb29Ro9/92D09Lhz5R26N4YNTHvM5gMCM1E9oVefw/VrrFgw8JWq0FFU/TM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNjM4zqV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNjM4zqV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-308004a2c49so458817eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572557; x=1782177357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=cNjM4zqVgr/E3ZmQ6Ju30luwBgzDynysje86Ts6uI0u6WzHCkWj5+h0JeH9GRcfiS/
         FF9gjqm0eNuJBQOCzg2GiGYi5aC7pDRf3f5nmxBbsCMuMygFdJuPmiiIkYbZb+Usz6Vo
         Iga09FOFc235ljlf6reixttWr4SGKVh1ziX1qtYb6YlQCouNeGE8/PaHyJOVM7T1tR0y
         pJ+UTI1/GSwhm47nA1v6Tkfyp44pVf1vAVaR4CXIcomjbj0PBK6HLRBo+n0LZDtJH/Kg
         gQkw2XR9zCKzF6kTi5dB3pvsTf60yx5ouKMQmaKJLENp6tNVXCuXBy5cGoE8lUfEelLG
         GSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572557; x=1782177357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq0ALMVaEZfhSbzg5O+HM/S6tJqN1Cgs4e0hJ55fARY=;
        b=E5aGZ2aIE3EwB9lW7+U13kojsHTuKUr5vGn+VgQr1NkOsJsUvmK1ZKxI27FPVetnBm
         bxq3SERDAdbAnx4uRTmDSFsd2UUIwenkEM7NGQVcPN0banZOqtnD+9RbIxzVH88e5lWf
         6yLBdQIRAY/yLBK4ucN3zPdWNwVW+MtJqz4RvBLexerNmeBvTza/Sj9tGLnOBbqCOp5c
         2+yQ5FYU6NRrUuXHAuRKo66NcYcraBRXOX1vrqrWIkFjOOrFg8WPzlNxdHy/ORdxg6l6
         ELx2csjsp28YMN0Mi8dv95Ab4oxl1lu80FDFdwlLkIGWgAMT7FlXOqetlnKvNReLTNMV
         R4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/2v+Y7qKCIH61O2bvRVcQF0fH1mZMWvx3DEbGQjJZaoy4zcTK0My3VX6hGvmaIOZGsidVHYkPV51CnDt+0lYhn@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDFl0ojbTOvUUdPZjNkDVwOtwPa3J8byrM4vJhFFiKSubUTNg
	82N4IyQ10TsYfasH7V2/kiGaa/PyIHmyHENAmey5Yow+BIj4n20inEzf+W94kMacLnu9ZUiimnE
	LwCAFjAnY0Q==
X-Received: from dyad7.prod.google.com ([2002:a05:693c:8347:b0:304:289b:67db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4785:b0:304:eaa8:11ea
 with SMTP id 5a478bee46e88-30ba5f6c864mr1105158eec.34.1781572556399; Mon, 15
 Jun 2026 18:15:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:25 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-4-irogers@google.com>
Subject: [PATCH v21 03/21] perf evsel/evlist: Avoid unnecessary #includes
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

