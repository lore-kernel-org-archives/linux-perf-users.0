Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C6185B54;
	Wed,  6 Nov 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904532; cv=none; b=KjEPlGS0SS/o+ZjThA64AGoN7jIu4kbzUV120qqWT/OOX8FON+HacUtLiYo0vRZSQZ3DHwAHlh/sMCjmiu/owJKeytEYBnrEBklILK/x3yjss8COWh9/hI/11RBiA2tYZ1hVquf4dPRsNRh49YXox96nRu4YrHCD6Cit2v7ZR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904532; c=relaxed/simple;
	bh=aty/ZaSqARoN/QRgWrgxM4RpQKSflE4BEFdxyhUhlds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDpunIVokl3jcf1gdbGvKSAfVcdKvuFhTyNzwo6i4/ZKsNsmA/q1m5NFi9XiFmLxoGHRylY48Njb96R7WfV3XeeuSTybuVzXV/fCPp6TLD94ln9bBYyFV27syrC8UWOnE6q3lhIcJXmwOdCaZTbrphvkJDdDCSECBZOO/hh6FDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GorRMs+y; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GorRMs+y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=6SvmYEZdzoMAUatd+D7feCFhkSBOgxRXB4Df+5G9/D0=; b=GorRMs+y48eTiOmH
	4H5EeVeRPG9SSlJSvkTgfwAbBE0fO4CVOmiEAR9WsdJQo4Kp9RzT1lXZqDvgpR9ke2UHzEY0u3u3e
	tpUSZgxJHM2EqfEkydL8XLl7NGehMoerggUDGP549ncN8oLCow9xssQIK6B57p4dp4Haq+zKhuZDW
	Gf9asNaTyVm7/p9CJaMvYRva0YYOUnr9ILyUyAj7HEZKjCEpvb/dePA2fGKwm6/M0jZcneIL+oi8r
	AshOyQlyXkjDtNGbvbecDeoMOpOzWDF6zIBi5y0SK0tdobRB/B3hTP2y/q2T+W6ddb6ncfCksbpSI
	9SEYs77zf26J4ihsvw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t8hKe-00FoNf-0r;
	Wed, 06 Nov 2024 14:48:28 +0000
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
Subject: [PATCH v2] perf: event: Remove deadcode
Date: Wed,  6 Nov 2024 14:48:26 +0000
Message-ID: <20241106144826.91728-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ZyscLqAzo9Z7Zg02@google.com>
References: <ZyscLqAzo9Z7Zg02@google.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
---
v2
  Rebase on perf-tools-next 29bf07bc9ad2e

 tools/perf/util/evlist.c            | 18 ------------------
 tools/perf/util/evlist.h            |  2 --
 tools/perf/util/trace-event-parse.c |  6 ------
 tools/perf/util/trace-event.h       |  3 ---
 4 files changed, 29 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 37d0fc01c180..f0dd174e2deb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -320,19 +320,6 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 }
 #endif
 
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
@@ -1157,11 +1144,6 @@ int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
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
index cd80a470a4ba..adddb1db1ad2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -132,7 +132,6 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	__evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(array))
 
 int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
-int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
 int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
@@ -140,7 +139,6 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
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

