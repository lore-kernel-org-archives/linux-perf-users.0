Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34FC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64D861248
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbhJGRAd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhJGRAX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE37C061762
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:58:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso8703070ybj.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a2RIMIv6DgwF5i0y2na8+/dr5/0zLMFuOoqLC1Vn+es=;
        b=LptvEsiqwME8onOvpEP3zr1MdTd9MAiNmslc+FAx4M01oUnU35AjWn3D1gczWGKSJx
         2+/YlguTFrXxPBB/uRbzpbv72bnsBRo+iWT2VhoDLA0LrZrRcgaQjEC2X161+8xhjtI+
         a6eqqFZFM+CT8ueH2H7oL3RMveOHfDhSlXMzqAW7o63j+WjIOYiiYNUVz6CCinmn9N4p
         PFSpAgj0bdWvHrdMKd07tz6xt1YltHFXkX9dHKIv1Uj3nhlxksnrfnPqv2fYUNasUK2y
         sO9zsNl1SodjtEc7o8CULWR04zCjPz73QPW33EDBKS7qTVsAyJr95Us0qIiQ6YoGz0cJ
         s5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a2RIMIv6DgwF5i0y2na8+/dr5/0zLMFuOoqLC1Vn+es=;
        b=jQPg+lAKqkrRxX+K7DoNTbbPrWGbbcO9uNLrNQvNrLUv9uGF/f+13DpnI1aDF7Vmsl
         fnBZWeyI4dRkoY8N49WaS5j/5jJ0zuC79S8wu/zS4oKPDqWoHfiJgcl96jLeoVxymrY3
         vGqkjPO47QPGuJEPTczM5T17qZ/y7IFMJTC/DQ8cGNOovaUYgOxDn4HsFUuE8XF7p3Hz
         FviW4dvLlSwviKOQF64zNCGoveFsWKT0wpM0vLbcXmCjU8wCmGYUG17wcSAz2s0QEM/B
         vD7sgk25H27MIpFScmR0NYi0dj5kmJsplZR1hs8Dr9sMTn4nFlb+FCx/WXihibrH8cR4
         M8FQ==
X-Gm-Message-State: AOAM5304ug0GF0r1C1PC9XZZDMPTxIkvf+OZL+YmTudz0eCsb7d3ana0
        2et83xOiZuTPMA526NyuOeZjYP2CyCs9
X-Google-Smtp-Source: ABdhPJyfYmIiHG1lBTPkyDnR3G0gls+OOyS7ePDNQFdtJhUytPYLSTP5x7cdjakKOTaFTo9YQyIa6tzCLX0a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:afcd:: with SMTP id
 d13mr6175230ybj.504.1633625888010; Thu, 07 Oct 2021 09:58:08 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:42 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-17-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 16/21] perf metric: Encode and use metric-id as qualifier
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For a metric like IPC a group of events like {instructions,cycles}:W
would be formed. If the events names were changed in parsing then the
metric expression parser would fail to find them. This change makes the
event encoding be something like {instructions/metric-id=instructions/,
cycles/metric-id=cycles/} and then uses the evsel's stable metric-id
value to locate the events. This fixes the case that an event is
restricted to user because of the paranoia setting:

    $ echo 2 > /proc/sys/kernel/perf_event_paranoid
    $ perf stat -M IPC /bin/true
     Performance counter stats for '/bin/true':

               150,298      inst_retired.any:u        #      0.77 IPC
               187,095      cpu_clk_unhalted.thread:u

           0.002042731 seconds time elapsed

           0.000000000 seconds user
           0.002377000 seconds sys

Adding the metric-id as a qualifier has a complication in that
qualifiers will become embedded in qualifiers. For example, msr/tsc/
could become msr/tsc,metric-id=msr/tsc// which will fail parse-events.
To solve this problem the metric is encoded and decoded for the
metric-id with !<num> standing in for an encoded value. Previously !
wasn't parsed. With this msr/tsc/ becomese msr/tsc,metric-id=msr!3tsc!3/

The metric expression parser is changed so that @ isn't changed to /,
instead this is done when the ID is encoded for parse events.

metricgroup__add_metric_non_group and metricgroup__add_metric_weak_group
need to inject the metric-id qualifier, so to avoid repetition they are
merged into a single metricgroup__build_event_string with error codes
more rigorously checked.

stat-shadow's prepare_metric uses the metric-id to match the metricgroup
code.

As "metric-id=..." is added to all events, it is adding during testing
with the fake PMU. This complicates pmu_str_check code as
PE_PMU_EVENT_FAKE won't match as part of a configuration. The testing
fake PMU case is fixed so that if a known qualifier with an ! is parsed
then it isn't reported as a fake PMU. This is sufficient to pass all
testing but it and the original mechanism are somewhat brittle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c        |   4 +-
 tools/perf/tests/pmu-events.c  |  13 +-
 tools/perf/util/expr.l         |   6 +-
 tools/perf/util/metricgroup.c  | 263 ++++++++++++++++++++++++++-------
 tools/perf/util/parse-events.l |  17 ++-
 tools/perf/util/stat-shadow.c  |  20 +--
 6 files changed, 242 insertions(+), 81 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 718c13e5a0f4..077783223ce0 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -129,9 +129,9 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
 					NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3@",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3@",
 						    (void **)&val_ptr));
 
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 71b08c296410..50b1299fe643 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -761,6 +761,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 {
 	struct evlist *evlist;
 	int ret;
+	char *dup, *cur;
 
 	/* Numbers are always valid. */
 	if (is_number(id))
@@ -769,7 +770,17 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
-	ret = __parse_events(evlist, id, error, fake_pmu);
+
+	dup = strdup(id);
+	if (!dup)
+		return -ENOMEM;
+
+	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
+		*cur = '/';
+
+	ret = __parse_events(evlist, dup, error, fake_pmu);
+	free(dup);
+
 	evlist__delete(evlist);
 	return ret;
 }
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 702fdf6456ca..bd20f33418ba 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -41,11 +41,9 @@ static char *normalize(char *str, int runtime)
 	char *dst = str;
 
 	while (*str) {
-		if (*str == '@')
-			*dst++ = '/';
-		else if (*str == '\\')
+		if (*str == '\\')
 			*dst++ = *++str;
-		 else if (*str == '?') {
+		else if (*str == '?') {
 			char *paramval;
 			int i = 0;
 			int size = asprintf(&paramval, "%d", runtime);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b48836d7c080..9c16a956fd2c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -212,13 +212,13 @@ static void metric__free(struct metric *m)
 	free(m);
 }
 
-static bool contains_event(struct evsel **metric_events, int num_events,
-			const char *event_name)
+static bool contains_metric_id(struct evsel **metric_events, int num_events,
+			       const char *metric_id)
 {
 	int i;
 
 	for (i = 0; i < num_events; i++) {
-		if (!strcmp(metric_events[i]->name, event_name))
+		if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
 			return true;
 	}
 	return false;
@@ -259,6 +259,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 {
 	struct evsel *ev, *current_leader = NULL;
 	struct expr_id_data *val_ptr;
+	const char *metric_id;
 	int i = 0, matched_events = 0, events_to_match;
 	int idnum = (int)hashmap__size(pctx->ids);
 
@@ -300,10 +301,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 * different sibling groups aren't both added to
 			 * metric_events.
 			 */
-			if (contains_event(metric_events, matched_events, ev->name))
+			metric_id = evsel__metric_id(ev);
+			if (contains_metric_id(metric_events, matched_events, metric_id))
 				continue;
 			/* Does this event belong to the parse context? */
-			if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
+			if (hashmap__find(pctx->ids, metric_id, (void **)&val_ptr))
 				metric_events[matched_events++] = ev;
 
 			if (matched_events == events_to_match)
@@ -347,6 +349,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		 * for each pmu. Set the metric leader of such events to be the
 		 * event that appears in metric_events.
 		 */
+		metric_id = evsel__metric_id(ev);
 		evlist__for_each_entry_continue(perf_evlist, ev) {
 			/*
 			 * If events are grouped then the search can terminate
@@ -356,7 +359,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    ev->core.leader != metric_events[i]->core.leader &&
 			    evsel_same_pmu_or_none(evsel__leader(ev), evsel__leader(metric_events[i])))
 				break;
-			if (!strcmp(metric_events[i]->name, ev->name)) {
+			if (!strcmp(evsel__metric_id(metric_events[i]), metric_id)) {
 				set_bit(ev->core.idx, evlist_used);
 				ev->metric_leader = metric_events[i];
 			}
@@ -724,50 +727,191 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
-static void metricgroup__add_metric_weak_group(struct strbuf *events,
-					       struct expr_parse_ctx *ctx)
+static const char *code_characters = ",-=@";
+
+static int encode_metric_id(struct strbuf *sb, const char *x)
+{
+	char *c;
+	int ret = 0;
+
+	for (; *x; x++) {
+		c = strchr(code_characters, *x);
+		if (c) {
+			ret = strbuf_addch(sb, '!');
+			if (ret)
+				break;
+
+			ret = strbuf_addch(sb, '0' + (c - code_characters));
+			if (ret)
+				break;
+		} else {
+			ret = strbuf_addch(sb, *x);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
+static int decode_metric_id(struct strbuf *sb, const char *x)
+{
+	const char *orig = x;
+	size_t i;
+	char c;
+	int ret;
+
+	for (; *x; x++) {
+		c = *x;
+		if (*x == '!') {
+			x++;
+			i = *x - '0';
+			if (i > strlen(code_characters)) {
+				pr_err("Bad metric-id encoding in: '%s'", orig);
+				return -1;
+			}
+			c = code_characters[i];
+		}
+		ret = strbuf_addch(sb, c);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int decode_all_metric_ids(struct evlist *perf_evlist)
+{
+	struct evsel *ev;
+	struct strbuf sb = STRBUF_INIT;
+	char *cur;
+	int ret = 0;
+
+	evlist__for_each_entry(perf_evlist, ev) {
+		if (!ev->metric_id)
+			continue;
+
+		ret = strbuf_setlen(&sb, 0);
+		if (ret)
+			break;
+
+		ret = decode_metric_id(&sb, ev->metric_id);
+		if (ret)
+			break;
+
+		free((char *)ev->metric_id);
+		ev->metric_id = strdup(sb.buf);
+		if (!ev->metric_id) {
+			ret = -ENOMEM;
+			break;
+		}
+		/*
+		 * If the name is just the parsed event, use the metric-id to
+		 * give a more friendly display version.
+		 */
+		if (strstr(ev->name, "metric-id=")) {
+			free(ev->name);
+			for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@'))
+				*cur = '/';
+
+			ev->name = strdup(sb.buf);
+			if (!ev->name) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
+	}
+	strbuf_release(&sb);
+	return ret;
+}
+
+static int metricgroup__build_event_string(struct strbuf *events,
+					   const struct expr_parse_ctx *ctx,
+					   bool has_constraint)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
 	bool no_group = true, has_duration = false;
+	int ret = 0;
+
+#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		pr_debug("found event %s\n", (const char *)cur->key);
+		const char *sep, *rsep, *id = cur->key;
+
+		pr_debug("found event %s\n", id);
 		/*
 		 * Duration time maps to a software event and can make
 		 * groups not count. Always use it outside a
 		 * group.
 		 */
-		if (!strcmp(cur->key, "duration_time")) {
+		if (!strcmp(id, "duration_time")) {
 			has_duration = true;
 			continue;
 		}
-		strbuf_addf(events, "%s%s",
-			no_group ? "{" : ",",
-			(const char *)cur->key);
-		no_group = false;
-	}
-	if (!no_group) {
-		strbuf_addf(events, "}:W");
-		if (has_duration)
-			strbuf_addf(events, ",duration_time");
-	} else if (has_duration)
-		strbuf_addf(events, "duration_time");
-}
-
-static void metricgroup__add_metric_non_group(struct strbuf *events,
-					      struct expr_parse_ctx *ctx)
-{
-	struct hashmap_entry *cur;
-	size_t bkt;
-	bool first = true;
+		/* Separate events with commas and open the group if necessary. */
+		if (no_group) {
+			if (!has_constraint) {
+				ret = strbuf_addch(events, '{');
+				RETURN_IF_NON_ZERO(ret);
+			}
 
-	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		if (!first)
-			strbuf_addf(events, ",");
-		strbuf_addf(events, "%s", (const char *)cur->key);
-		first = false;
+			no_group = false;
+		} else {
+			ret = strbuf_addch(events, ',');
+			RETURN_IF_NON_ZERO(ret);
+		}
+		/*
+		 * Encode the ID as an event string. Add a qualifier for
+		 * metric_id that is the original name except with characters
+		 * that parse-events can't parse replaced. For example,
+		 * 'msr@tsc@' gets added as msr/tsc,metric-id=msr!3tsc!3/
+		 */
+		sep = strchr(id, '@');
+		if (sep != NULL) {
+			ret = strbuf_add(events, id, sep - id);
+			RETURN_IF_NON_ZERO(ret);
+			ret = strbuf_addch(events, '/');
+			RETURN_IF_NON_ZERO(ret);
+			rsep = strrchr(sep, '@');
+			ret = strbuf_add(events, sep + 1, rsep - sep - 1);
+			RETURN_IF_NON_ZERO(ret);
+			ret = strbuf_addstr(events, ",metric-id=");
+			RETURN_IF_NON_ZERO(ret);
+			sep = rsep;
+		} else {
+			sep = strchr(id, ':');
+			if (sep != NULL) {
+				ret = strbuf_add(events, id, sep - id);
+				RETURN_IF_NON_ZERO(ret);
+			} else {
+				ret = strbuf_addstr(events, id);
+				RETURN_IF_NON_ZERO(ret);
+			}
+			ret = strbuf_addstr(events, "/metric-id=");
+			RETURN_IF_NON_ZERO(ret);
+		}
+		ret = encode_metric_id(events, id);
+		RETURN_IF_NON_ZERO(ret);
+		ret = strbuf_addstr(events, "/");
+		RETURN_IF_NON_ZERO(ret);
+
+		if (sep != NULL) {
+			ret = strbuf_addstr(events, sep + 1);
+			RETURN_IF_NON_ZERO(ret);
+		}
 	}
+	if (has_duration) {
+		if (no_group) {
+			/* Strange case of a metric of just duration_time. */
+			ret = strbuf_addf(events, "duration_time");
+		} else if (!has_constraint)
+			ret = strbuf_addf(events, "}:W,duration_time");
+		else
+			ret = strbuf_addf(events, ",duration_time");
+	} else if (!no_group && !has_constraint)
+		ret = strbuf_addf(events, "}:W");
+
+	return ret;
+#undef RETURN_IF_NON_ZERO
 }
 
 int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
@@ -1134,16 +1278,17 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
 	list_sort(NULL,  &list, metric_list_cmp);
 
 	list_for_each_entry(m, &list, nd) {
-		if (events->len > 0)
-			strbuf_addf(events, ",");
-
-		if (m->has_constraint) {
-			metricgroup__add_metric_non_group(events,
-							  m->pctx);
-		} else {
-			metricgroup__add_metric_weak_group(events,
-							   m->pctx);
+		if (events->len > 0) {
+			ret = strbuf_addf(events, ",");
+			if (ret)
+				break;
 		}
+
+		ret = metricgroup__build_event_string(events,
+						m->pctx,
+						m->has_constraint);
+		if (ret)
+			break;
 	}
 
 out:
@@ -1180,30 +1325,40 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					const struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
-	int ret = -EINVAL;
+	int ret, count = 0;
 
 	nlist = strdup(list);
 	if (!nlist)
 		return -ENOMEM;
 	llist = nlist;
 
-	strbuf_init(events, 100);
-	strbuf_addf(events, "%s", "");
+	ret = strbuf_init(events, 100);
+	if (ret)
+		return ret;
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
 					      metric_list, map);
-		if (ret == -EINVAL) {
-			fprintf(stderr, "Cannot find metric or group `%s'\n",
-					p);
+		if (ret == -EINVAL)
+			fprintf(stderr, "Cannot find metric or group `%s'\n", p);
+
+		if (ret)
 			break;
-		}
+
+		count++;
 	}
 	free(nlist);
 
-	if (!ret)
+	if (!ret) {
+		/*
+		 * Warn about nmi_watchdog if any parsed metrics had the
+		 * NO_NMI_WATCHDOG constraint.
+		 */
 		metricgroup___watchdog_constraint_hint(NULL, true);
-
+		/* No metrics. */
+		if (count == 0)
+			return -EINVAL;
+	}
 	return ret;
 }
 
@@ -1243,6 +1398,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
 	}
+	ret = decode_all_metric_ids(perf_evlist);
+	if (ret)
+		goto out;
+
 	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index b1e29b97d261..4efe9872c667 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -138,18 +138,23 @@ static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_stat
 
 	yylval->str = strdup(text);
 
-	if (parse_state->fake_pmu)
-		return PE_PMU_EVENT_FAKE;
-
+	/*
+	 * If we're not testing then parse check determines the PMU event type
+	 * which if it isn't a PMU returns PE_NAME. When testing the result of
+	 * parse check can't be trusted so we return PE_PMU_EVENT_FAKE unless
+	 * an '!' is present in which case the text can't be a PMU name.
+	 */
 	switch (perf_pmu__parse_check(text)) {
 		case PMU_EVENT_SYMBOL_PREFIX:
 			return PE_PMU_EVENT_PRE;
 		case PMU_EVENT_SYMBOL_SUFFIX:
 			return PE_PMU_EVENT_SUF;
 		case PMU_EVENT_SYMBOL:
-			return PE_KERNEL_PMU_EVENT;
+			return parse_state->fake_pmu
+				? PE_PMU_EVENT_FAKE : PE_KERNEL_PMU_EVENT;
 		default:
-			return PE_NAME;
+			return parse_state->fake_pmu && !strchr(text,'!')
+				? PE_PMU_EVENT_FAKE : PE_NAME;
 	}
 }
 
@@ -204,7 +209,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 20f1b9d0f272..69f3cf3b4a44 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -821,7 +821,7 @@ static int prepare_metric(struct evsel **metric_events,
 			  struct runtime_stat *st)
 {
 	double scale;
-	char *n, *pn;
+	char *n;
 	int i, j, ret;
 
 	for (i = 0; metric_events[i]; i++) {
@@ -844,23 +844,11 @@ static int prepare_metric(struct evsel **metric_events,
 			if (v->metric_other)
 				metric_total = v->metric_total;
 		}
-
-		n = strdup(metric_events[i]->name);
+		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
 			return -ENOMEM;
-		/*
-		 * This display code with --no-merge adds [cpu] postfixes.
-		 * These are not supported by the parser. Remove everything
-		 * after the space.
-		 */
-		pn = strchr(n, ' ');
-		if (pn)
-			*pn = 0;
-
-		if (metric_total)
-			expr__add_id_val(pctx, n, metric_total);
-		else
-			expr__add_id_val(pctx, n, avg_stats(stats)*scale);
+
+		expr__add_id_val(pctx, n, metric_total ? : avg_stats(stats) * scale);
 	}
 
 	for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
-- 
2.33.0.882.g93a45727a2-goog

