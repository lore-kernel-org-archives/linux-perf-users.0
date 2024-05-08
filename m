Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30540841;
	Wed,  8 May 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209284; cv=none; b=aSm8zUwqQhzEzPcyfnQKZgdFKEeqDTdMi4wwe76I1MDz0CWkVqsKqz/ZHrw88Cl9WtgJtjEhSolRDeyXayYIbowSOvIuZWDUaGA3zTqdEi7H40oyG/Y2jA61PppqtimDOhXpHcuUHk3SQpm5Y4G2W0a06638VA3TZe0bf87OznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209284; c=relaxed/simple;
	bh=fN4ufz3Y1kRTbivEXYzNImgKWuIAekp2n+qBPkJublU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD3d9egPytXDyLKkYmtKRmEQZLv+1T7I1YiYeikpn3bF6HBlUv21NI0BQc44SonRGHgn2U6E6nOH2kbpoVgpOQnl2FG8aZYve5aqZ7b5AxkbYI0FTpdZ6XAR57SBhAYwfDB0qaiuoRLrmvYKNvBXTzHd8P6cqDJU6DYLRd9hRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=M1h1yV7k; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="M1h1yV7k"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 268CE14C2DC;
	Thu,  9 May 2024 01:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715209275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V9r1VV+2F+sgHWeR0/4ne1F1lK/DMZyCeDq+XDAAW8=;
	b=M1h1yV7kGlEgfIbqvk0CI/TUmBLFwcYV/jH9ebaScX19gAdJt4EuzI0oeKPGszszKz0A6h
	s/W9Njlbh1w7xM/JrxcmBz23i+T7/LFdl30WSsqs2zerGQ7XPm/ysbRoF2C54AXrbnAfwz
	qRIojnvywVEKkda8gTZie7Oyf9uslHtHotMt+ce6z+4bKKJWZmL3rhRKWspNchFlDPB/eJ
	R0F5PSmBLkHYxTDqdqCQB4lGpLAczfGuzGK/0vtj1HwESqNFoNIisFiuYZo2lI7MHh9kkH
	DimcYk7Noi0RxETi+DJBfRGi1mVIkvEVMzOycVVTV5CtGA+VIpODtWA+39YkYQ==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 574e4e52;
	Wed, 8 May 2024 23:01:02 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Thu, 09 May 2024 08:00:46 +0900
Subject: [PATCH v3 2/3] perf parse-events: Add new 'fake_tp' parameter for
 tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-perf_digit-v3-2-9036bf7898da@codewreck.org>
References: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
In-Reply-To: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9031;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=fN4ufz3Y1kRTbivEXYzNImgKWuIAekp2n+qBPkJublU=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPAQu7zwiqRAMUcEG82dGi90nqEPyKRnVLZN0e
 rU763m/nOCJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjwELgAKCRCrTpvsapjm
 cJlaEACdOkVrLKcq6E+3YRBXNHZgu7IU7KGc/FdGGIycrr1xWOpBRGn1kVl1ki9e32mhRXcqZq/
 y5bEaSJRFBf1ROBcck1slOY4QvwTVe/zZJaVb/X9aEyp5IwYPetIy0I2lEoJ4P2SHXkRHtp7Pb0
 Gy+IB2n7H6+VgdgXz2PwUpbVH8k5F66ATCSgnGNUGaXAqqKdfuuxfixuSymhooX+beXTCxEyX2V
 OtnJWoPOJ6miRjTDXRqMOEfPqjUZ5KqCvUWEetfFjzk0pCGORn+9TZiUTisnwrFbsA3HJbrxTQ/
 aqYhJwtNLrhCtyd6y8Ls8AfY6PQJ6Impdr4mWFjXFHppP1iLaC5pWKD2s82h1aqrKB033xd7AX6
 F8YMG08cfSpXU7D1ubkz4BU8xwFUce2ZgejYu3UJCrqe6wcag36atsFrF4RK4aDJWQIlWjXso85
 71c9sgcI6fCOTJTqj3mhKQypgpzLNNDFAt6yaB3X1jHk4ls9avI+5QDFeenmkt5v7zHmvgmq822
 L8N8kJwsfkuT2DpJPV3HduQrxMICubcqJTt+ggxo3fFfahEs/IoiWn4gM3fh+gEfoJ2LOagcFwc
 6F/JABnh2bSjjh8f8faku2p6ElgM8NLqGQYlgFExbL7baeBiZO2METedv7MujlAnZDI7uqM+7qm
 iuZNy9Hdmb+ISWQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next commit will allow tracepoints starting with digits, but most
systems do not have any available by default so tests should skip the
actual "check if it exists in /sys/kernel/debug/tracing" step.

In order to do that, add a new boolean flag specifying if we should
actually "format" the probe or not.

Originally-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c |  6 ++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  |  9 ++++++---
 tools/perf/util/parse-events.h  |  6 ++++--
 8 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 993e482f094c..c3b77570bb57 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2493,7 +2493,8 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, e->name, &err);
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/NULL,
+			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
@@ -2521,7 +2522,8 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     &perf_pmu__fake, /*warn_if_reordered=*/true);
+			     &perf_pmu__fake, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
 			 str, ret);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f39aadacd7a6..ff3e7bc0a77f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -842,7 +842,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		*cur = '/';
 
 	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, fake_pmu,
-			     /*warn_if_reordered=*/true);
+			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..3a719edafc7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -298,7 +298,8 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 #ifdef HAVE_LIBTRACEEVENT
 struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 {
-	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
+	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0,
+					       /*format=*/true);
 
 	if (IS_ERR(evsel))
 		return evsel;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..4f818ab6b662 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -452,7 +452,7 @@ struct evsel *evsel__clone(struct evsel *orig)
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -469,14 +469,20 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
-		evsel->tp_format = trace_event__tp_format(sys, name);
-		if (IS_ERR(evsel->tp_format)) {
-			err = PTR_ERR(evsel->tp_format);
-			goto out_free;
+		event_attr_init(&attr);
+
+		if (format) {
+			evsel->tp_format = trace_event__tp_format(sys, name);
+			if (IS_ERR(evsel->tp_format)) {
+				err = PTR_ERR(evsel->tp_format);
+				goto out_free;
+			}
+			attr.config = evsel->tp_format->id;
+		} else {
+			attr.config = (__u64) -1;
 		}
 
-		event_attr_init(&attr);
-		attr.config = evsel->tp_format->id;
+
 		attr.sample_period = 1;
 		evsel__init(evsel, &attr, idx);
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..375a38e15cd9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -234,14 +234,14 @@ void free_config_terms(struct list_head *config_terms);
 
 
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
-	return evsel__newtp_idx(sys, name, 0);
+	return evsel__newtp_idx(sys, name, 0, true);
 }
 #endif
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9be406524617..69f6a46402c3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1502,7 +1502,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false);
+			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e6a2a80b02df..30f958069076 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -550,7 +550,8 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++,
+					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
@@ -2135,7 +2136,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered)
+		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2143,6 +2144,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		.error	  = err,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.fake_tp  = fake_tp,
 		.pmu_filter = pmu_filter,
 		.match_legacy_cache_terms = true,
 	};
@@ -2352,7 +2354,8 @@ int parse_events_option(const struct option *opt, const char *str,
 
 	parse_events_error__init(&err);
 	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
+			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/false);
 
 	if (ret) {
 		parse_events_error__print(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c06984bd3af8..f2baa69fff98 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -32,14 +32,14 @@ int parse_events_option_new_evlist(const struct option *opt, const char *str, in
 __attribute__((nonnull(1, 2, 4)))
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *error, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered);
+		   bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
 	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/NULL,
-			      /*warn_if_reordered=*/true);
+			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -152,6 +152,8 @@ struct parse_events_state {
 	int			   stoken;
 	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
+	/* Skip actual tracepoint processing for testing. */
+	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */

-- 
2.44.0

