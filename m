Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041691DB148;
	Thu,  3 Jul 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507386; cv=none; b=DebzXCrtq8oZ35pQGv69R5xI83a6vN9Rte+3ft1YCVoINdYYP9XWDWPKys7npSxDAw2tTB/+gvwryRz3QxCDjxbNgJSwPZtarwdfeOzlHxvCo+oHerprAQ/f9LiDYRsWx7rQk3p0gzcsWIihQTCCnjdt8j07S4aPlMROq2vl7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507386; c=relaxed/simple;
	bh=brjZ66S2Sv5ZaBEezsenPWufMzSYuey2BvMpjs1HNps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omJea0FF5wdtNsqJ6jsKJyVFyh+JC1aS6TnBh24CFVpXpmVt9+ob3iGHrybExllwKFem7tulbQg6XX/h2BF3Q9gRh81moCZsGQ2qhFvy7+BqWrTYgXxvKvJvn7h4WDMx5MDdDH0nmpGwyHn7Ad0XFkdlDnUVnuFHZfRw+kivkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDxvh7WA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDxvh7WA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC2C4CEED;
	Thu,  3 Jul 2025 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507385;
	bh=brjZ66S2Sv5ZaBEezsenPWufMzSYuey2BvMpjs1HNps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDxvh7WAxh2dVh/HvhUQuAui4ShsIpFsKiHoo8GgHGUYl1zSNZKGTvuhSTEclunXi
	 rfwTe91yr0e9OryeGlMUtYFU2kbxGvzbOHnRKaOYbntW6mNgUHwNIipzi+T5QEhZEt
	 Qrod+OmJ9SYMq7fV8S0BxiSaYcSvPYgsQRAqnZ+Rw3Eo3X6mcdeTRL656eeqOqw2+5
	 Vsb+Trrpa1xSqAlDjT4kr64FY0yxU0l8lhguMXyfZvtD6Xb4W9TYnezdIthmnMZW6c
	 e+u1SBQnBqUxsNIH1s7M8W8Yg3sxjQB7vhpICHXsWjXzvH1m4u0dhJdFpURy4ToBYu
	 owLslqbvF0FgQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 5/8] perf sched: Fix memory leaks for evsel->priv in timehist
Date: Wed,  2 Jul 2025 18:49:39 -0700
Message-ID: <20250703014942.1369397-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It uses evsel->priv to save per-cpu timing information.  It should be
freed when the evsel is released.

Add the priv destructor for evsel same as thread to handle that.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 12 ++++++++++++
 tools/perf/util/evsel.c    | 11 +++++++++++
 tools/perf/util/evsel.h    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 83b5a85a91b7ffbd..a6eb0462dd5be20f 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2020,6 +2020,16 @@ static u64 evsel__get_time(struct evsel *evsel, u32 cpu)
 	return r->last_time[cpu];
 }
 
+static void timehist__evsel_priv_destructor(void *priv)
+{
+	struct evsel_runtime *r = priv;
+
+	if (r) {
+		free(r->last_time);
+		free(r);
+	}
+}
+
 static int comm_width = 30;
 
 static char *timehist_get_commstr(struct thread *thread)
@@ -3314,6 +3324,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	setup_pager();
 
+	evsel__set_priv_destructor(timehist__evsel_priv_destructor);
+
 	/* prefer sched_waking if it is captured */
 	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
 		handlers[1].handler = timehist_sched_wakeup_ignore;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c50c3960487feee..3896a04d90af71f3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1657,6 +1657,15 @@ static void evsel__free_config_terms(struct evsel *evsel)
 	free_config_terms(&evsel->config_terms);
 }
 
+static void (*evsel__priv_destructor)(void *priv);
+
+void evsel__set_priv_destructor(void (*destructor)(void *priv))
+{
+	assert(evsel__priv_destructor == NULL);
+
+	evsel__priv_destructor = destructor;
+}
+
 void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
@@ -1687,6 +1696,8 @@ void evsel__exit(struct evsel *evsel)
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
+	if (evsel__priv_destructor)
+		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
 	if (evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME ||
 	    evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6dbc9690e0c9258c..b84ee274602d7d2b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -280,6 +280,8 @@ void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void evsel__exit(struct evsel *evsel);
 void evsel__delete(struct evsel *evsel);
 
+void evsel__set_priv_destructor(void (*destructor)(void *priv));
+
 struct callchain_param;
 
 void evsel__config(struct evsel *evsel, struct record_opts *opts,
-- 
2.50.0.727.gbf7dc18ff4-goog

