Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95706A31;
	Sun,  3 Nov 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643803; cv=none; b=qDiJSvQEXla0htoe4G5FHeizS/2Z70HIuIBTwE6/ScdbJp1/9WWDFraSsGA+WcPR31NcUdWBABxLCRjPtG88VC8Q9zaW/NvEuOXy1hYrue5xod6mVyWMoa1t3q1CMRq+VqLU9/Ae3C2qSBV9dHh79BqWHnnGPFi0r7UBM+A9EDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643803; c=relaxed/simple;
	bh=qCUegWLwOEXdLg8GCnSpNF+Vl81XP8CX0+zmrIgJhKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+fyAaBlpFWq/lj6+2klpf4cDOuqdbC0iFOQGaeeP87hVGEs+PObv8d/BmyI1KuOOwDFhWNTc0bB9cDISwxDPoEiJo7TLyNn3vjq+SOpKpeaSfhjeGrQ5xQ/8O/sCujOXnEVE5/qZpyZG2Oju/1pKh65Sd5h8i0ku6LaboG6xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GP5K9YSc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GP5K9YSc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Uucxvjcd8BIf1N4VBFnidFDJIxQKOg5thMov+0neKrk=; b=GP5K9YScUwy3G2wn
	tUCqzo28M7oBsQbD/5ATq2pB+nzpW1Kma6Vidx9HTqyAsl/ej5CHHM3n2RbtrETcZdCk3RJP7jOMn
	8vAxCsp/FfDHt1J/f/T9YUNn8P/KyyTg7TAVF9IeqBIinDE8I9D0m2ENbxOGYLHoT5zj3DkV5hEUJ
	Jq2iP91E1vlkZ7GfgRraEfm4Yzka2v/1d7USTsjPeSd3Mh/la6608sR1BulPqSL6PRrvPr5dgDvze
	S2cJBTLuETnEwsp1lQhpviRdvSClVUiM8yFwz9rJM3mlk/mWOmWnfCz7dVBx8pq7Ymg2S09mbnMqq
	sqqB/7Uyi7tRzroBuQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7bVO-00FAuD-2y;
	Sun, 03 Nov 2024 14:23:02 +0000
From: linux@treblig.org
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf: event: Remove deadcode
Date: Sun,  3 Nov 2024 14:23:01 +0000
Message-ID: <20241103142302.230370-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

event_format__print() last use was removed by 2017's
commit 894f3f1732cb ("perf script: Use event_format__fprintf()")

evlist__find_tracepoint_by_id() last use was removed by 2012's
commit e60fc847cefa ("perf evlist: Remove some unused methods")

evlist__set_tp_filter_pid() last use was removed by 2017's
commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/evlist.c            | 18 ------------------
 tools/perf/util/evlist.h            |  2 --
 tools/perf/util/trace-event-parse.c |  6 ------
 tools/perf/util/trace-event.h       |  3 ---
 4 files changed, 29 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f14b7e6ff1dc..4b992a3f2985 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -362,19 +362,6 @@ __weak int arch_evlist__add_default_attrs(struct evlist *evlist,
 	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
 }
 
-struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type   == PERF_TYPE_TRACEPOINT &&
-		    (int)evsel->core.attr.config == id)
-			return evsel;
-	}
-
-	return NULL;
-}
-
 struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name)
 {
 	struct evsel *evsel;
@@ -1199,11 +1186,6 @@ int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
 	return ret;
 }
 
-int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
-{
-	return evlist__set_tp_filter_pids(evlist, 1, &pid);
-}
-
 int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
 {
 	char *filter = asprintf__tp_filter_pids(npids, pids);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bcc1c6984bb5..ff73908e2178 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -144,7 +144,6 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	__evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(array))
 
 int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
-int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
 int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
@@ -152,7 +151,6 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
 int evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
-struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name);
 
 int evlist__add_pollfd(struct evlist *evlist, int fd);
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index f0332bd3a501..d97830cdbd7e 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -116,12 +116,6 @@ void event_format__fprintf(struct tep_event *event,
 	trace_seq_destroy(&s);
 }
 
-void event_format__print(struct tep_event *event,
-			 int cpu, void *data, int size)
-{
-	return event_format__fprintf(event, cpu, data, size, stdout);
-}
-
 /*
  * prev_state is of size long, which is 32 bits on 32 bit architectures.
  * As it needs to have the same bits for both 32 bit and 64 bit architectures
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..0e5133f1b910 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -42,9 +42,6 @@ struct tep_event *trace_event__tp_format_id(int id);
 void event_format__fprintf(struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
-void event_format__print(struct tep_event *event,
-			 int cpu, void *data, int size);
-
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
 int parse_event_file(struct tep_handle *pevent,
 		     char *buf, unsigned long size, char *sys);
-- 
2.47.0

