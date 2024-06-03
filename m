Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132313D244;
	Mon,  3 Jun 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454655; cv=none; b=AU/uNDTA2AUsW6+b7dChua5FKs71FMip/ktJr4jeRi5ATUDrHFXmnoWZ6S/Zk8VmFKiK9pC7Wdf+ejdw6/jxPvwsK2TqeWKJ+xAhQXx5ixH7kaCkH4npSPlyUtdVJEhcKEm7Gtt5xV4gDzZ2gpG4nQIk3bINpPkrsmeb/9RfkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454655; c=relaxed/simple;
	bh=LRfIPWtEHi1TeH+Xj5dcWGvd3NaKK+FQJi7DsB6BcZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwXP5QEX7xTh5eeBgWJg3K/K7KfgK/xUmWrGDlb8q6Yg8GpurumjbSXAHBsx17cIuPD2Ry2R8adIeFI6SciLAEHkvfUAJh7IFHNGWfBW4+Zrd+EBqitDEf5v8vP5cgEXzZ9/mHMcERPoslZd6PY2G7IgYtIbxxloLyXX2NuW/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPiTUc77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPiTUc77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06319C4AF07;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454655;
	bh=LRfIPWtEHi1TeH+Xj5dcWGvd3NaKK+FQJi7DsB6BcZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPiTUc77pd5WmM5jqZaaiChxDeEZ2Tf3CysgdDgVbCKebjN5+bXEYcQs1F0TemGGj
	 Z+UBpM+rvIKRII5JvbYGcKoALZVgKGHQLXzhlVN0erDBIPQNTRSuIqfbjCb7xFQuPE
	 UkpXgcspeTSHJWsfi06pu4pDRAPkqoJY3j89QQ7RXys/VEc0eYY9i/wFLKy1zyxahK
	 OGp90yxjgltln8/ooVSsWoScHE4OEVqSmuIIN1PwhqxkEerLE9cxKTjWM+RCJwVV7U
	 w3wHwa8FUVF8P5PGADRT0mgu3LyO0hdV+QFWAV8ME537VC8wpOH/azVgvMj/U2HEge
	 SQKMZj5fqtEqw==
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
Subject: [PATCH 3/4] perf hist: Add symbol_conf.skip_empty
Date: Mon,  3 Jun 2024 15:44:11 -0700
Message-ID: <20240603224412.1910049-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240603224412.1910049-1-namhyung@kernel.org>
References: <20240603224412.1910049-1-namhyung@kernel.org>
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
2.45.1.288.g0e0cd299f1-goog

