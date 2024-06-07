Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEB154429;
	Fri,  7 Jun 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792161; cv=none; b=lVyuN7ycOEBGhoZ/2Qc/9pBIuC2w+EM8LIfWAXIUyFU7GM/6PJSOnXmnan4F9Daq3oMNQE/CgPNot8ZEsh4CvCUGAGpuGM+I2By+RLrFVcnTw5DiKsDKHGdtfrzAlkr9ECNWFZA79lk3b+ErC92bX16Q1FMOsW637DXJw37D2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792161; c=relaxed/simple;
	bh=flcmlgF7FOvJbK8GX4v+2Pmn4oZIQjxIgvZ7GXLJMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfdghj0PSgU1kO3a5bWHjSsnuQzwQUVuAmjwmLi8zbW0ICkqpGc9YdspuujeWz06ACr9WtkVDpPx9WumZdu4eOlxO41WwH27N6rHgKwKrbij1O46MYLSLJpoyzgv+wbjuO5JULQ8updQf+B5YTFyxSlKuYurcIYk1YGgd5SldYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLinowvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLinowvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A9BC32782;
	Fri,  7 Jun 2024 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792161;
	bh=flcmlgF7FOvJbK8GX4v+2Pmn4oZIQjxIgvZ7GXLJMlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLinowvCaCCM9oPsHnspwGifQ7WLIYR+TwOrKGxOsnaZWYrsEb0yU7/xH0mJhoWNA
	 5SB9lwlKfBPB6zjFBJC6RdIP14DPRi2lqxzvVeSkaOtzTKjhoMLO7ZRbxTrd5jxGdT
	 65Ayz0U1M4iQ0vRJMk3nNXtrgQ4+be9ac4h+ruymlMCLimpG2bL0pQ7sr1PMgSKStw
	 GUJ5/noapnpTHPhVVfo4WNMbT7nXz/obmoMp/kWerldma0YS8KlBdBaP95gDiDYy90
	 huPxwPjRPEpUwycTSDIcBe9lAY6SHz/vxuKdYPr/45WCuYJCozKWyEig7uCzKu4j/n
	 g3oRIzmcbfD1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/4] perf hist: Add symbol_conf.skip_empty
Date: Fri,  7 Jun 2024 13:29:17 -0700
Message-ID: <20240607202918.2357459-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607202918.2357459-1-namhyung@kernel.org>
References: <20240607202918.2357459-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the skip_empty flag to symbol_conf and set the value from the report
command to preserve the existing behavior.  This makes the code simpler
and will be needed other code which is hard to add a new argument.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c  |  4 ++--
 tools/perf/builtin-report.c    | 12 ++++++------
 tools/perf/ui/stdio/hist.c     |  5 ++---
 tools/perf/util/events_stats.h |  3 +--
 tools/perf/util/hist.c         |  6 +++---
 tools/perf/util/hist.h         |  3 +--
 tools/perf/util/session.c      |  5 ++---
 tools/perf/util/session.h      |  3 +--
 tools/perf/util/symbol_conf.h  |  3 ++-
 9 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 50d2fb222d48..b10b7f005658 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -571,8 +571,8 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		goto out;
 
 	if (dump_trace) {
-		perf_session__fprintf_nr_events(session, stdout, false);
-		evlist__fprintf_nr_events(session->evlist, stdout, false);
+		perf_session__fprintf_nr_events(session, stdout);
+		evlist__fprintf_nr_events(session->evlist, stdout);
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 69618fb0110b..9718770facb5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -810,8 +810,8 @@ static int stats_print(struct report *rep)
 {
 	struct perf_session *session = rep->session;
 
-	perf_session__fprintf_nr_events(session, stdout, rep->skip_empty);
-	evlist__fprintf_nr_events(session->evlist, stdout, rep->skip_empty);
+	perf_session__fprintf_nr_events(session, stdout);
+	evlist__fprintf_nr_events(session->evlist, stdout);
 	return 0;
 }
 
@@ -1089,10 +1089,8 @@ static int __cmd_report(struct report *rep)
 			perf_session__fprintf_dsos(session, stdout);
 
 		if (dump_trace) {
-			perf_session__fprintf_nr_events(session, stdout,
-							rep->skip_empty);
-			evlist__fprintf_nr_events(session->evlist, stdout,
-						  rep->skip_empty);
+			perf_session__fprintf_nr_events(session, stdout);
+			evlist__fprintf_nr_events(session->evlist, stdout);
 			return 0;
 		}
 	}
@@ -1562,6 +1560,8 @@ int cmd_report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	symbol_conf.skip_empty = report.skip_empty;
+
 repeat:
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index b849caace398..9372e8904d22 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -897,8 +897,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 	return ret;
 }
 
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
-			     bool skip_empty)
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
 {
 	int i;
 	size_t ret = 0;
@@ -910,7 +909,7 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
 		name = perf_event__name(i);
 		if (!strcmp(name, "UNKNOWN"))
 			continue;
-		if (skip_empty && !stats->nr_events[i])
+		if (symbol_conf.skip_empty && !stats->nr_events[i])
 			continue;
 
 		if (i && total) {
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 8fecc9fbaecc..f43e5b1a366a 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -52,7 +52,6 @@ struct hists_stats {
 
 void events_stats__inc(struct events_stats *stats, u32 type);
 
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
-			     bool skip_empty);
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
 
 #endif /* __PERF_EVENTS_STATS_ */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 2e9e193179dd..f028f113c4fd 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2706,8 +2706,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 	}
 }
 
-size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
-				 bool skip_empty)
+size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 {
 	struct evsel *pos;
 	size_t ret = 0;
@@ -2715,7 +2714,8 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		if (skip_empty && !hists->stats.nr_samples && !hists->stats.nr_lost_samples)
+		if (symbol_conf.skip_empty && !hists->stats.nr_samples &&
+		    !hists->stats.nr_lost_samples)
 			continue;
 
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8fb3bdd29188..5273f5c37050 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -375,8 +375,7 @@ void hists__inc_nr_lost_samples(struct hists *hists, u32 lost);
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
 		      bool ignore_callchains);
-size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
-				 bool skip_empty);
+size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp);
 
 void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a10343b9dcd4..0ec92d47373c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2696,8 +2696,7 @@ size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp
 	return machines__fprintf_dsos_buildid(&session->machines, fp, skip, parm);
 }
 
-size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
-				       bool skip_empty)
+size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
 {
 	size_t ret;
 	const char *msg = "";
@@ -2707,7 +2706,7 @@ size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
 
 	ret = fprintf(fp, "\nAggregated stats:%s\n", msg);
 
-	ret += events_stats__fprintf(&session->evlist->stats, fp, skip_empty);
+	ret += events_stats__fprintf(&session->evlist->stats, fp);
 	return ret;
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 3b0256e977a6..4c29dc86956f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -130,8 +130,7 @@ size_t perf_session__fprintf_dsos(struct perf_session *session, FILE *fp);
 size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp,
 					  bool (fn)(struct dso *dso, int parm), int parm);
 
-size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
-				       bool skip_empty);
+size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp);
 
 void perf_session__dump_kmaps(struct perf_session *session);
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index c114bbceef40..657cfa5af43c 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -46,7 +46,8 @@ struct symbol_conf {
 			lazy_load_kernel_maps,
 			keep_exited_threads,
 			annotate_data_member,
-			annotate_data_sample;
+			annotate_data_sample,
+			skip_empty;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.45.2.505.gda0bf45e8d-goog

