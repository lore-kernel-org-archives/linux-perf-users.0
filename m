Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD762161FB
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842033; cv=none; b=SqZgqlijNpzjX+HQiVSBC5LOF7bDrP63hnoCnpwjin6ijufQoFJRJshgZ+ZDuojUzBoDlbURjke82NY5ixD2dtzcacsVpGH/Tg6vDwjmb2Mihq5GzHrCEWResC24wcXwviwP5h8GuDRXonsNj3WrmPqkfc0vOIHIrYtUd9pzN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842033; c=relaxed/simple;
	bh=qcUpsCevuN/4ezMm92doq0Egamb9T9a2FAtuBKLW57I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JwNosmxP5/5p2/VBThaEsJW74RDwWQEChwKqXHV9IYehvt6n9A3FTnbY182ZzgcDTOO/rnnvkyoxWRhwJzj5WSukxaiEp1P/LxSHa9invcE1VPnWUEXhfu2x1eg1rqRuaWYgb/2Vom5DsphGn7lbfAhgCTzQ1jyuLYeqeSXQNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3i39oQM0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3i39oQM0"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so60773237b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842030; x=1731446830; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKL4rNcuhrwPlLoLHBamtHw/kLIkbIZ6raoruCdzEkE=;
        b=3i39oQM0QQhaTZeSVZWrPZkF+RhuTrm51YqWfKnmOXNqDlSbFL2DxSTY3/sK09K6yU
         pSa6TFhI0qXyXDjoOjXgCpwNevGWdH5ZRIp+IRto9y6WV3TcFjRr8J5Jc47CLv82Y9cP
         /CBw8YULldg7qlFxsbRViagCOTacmAlm4QQTyqhdbNhw9Ec5R46rF8qgeDC0MXp1d9JU
         xDL1Rf13qYGPjAaMaV/43doTmZ4irmy8i2TzNRUUEsaLvXpDhIMLQUWxbRBHQvpeQvKF
         2x03FafGEyS7pt6ypaPO7EjgcE9zIED8LpRqkUDrewCwfz3CwiJYh35s9pYTwPvuDqL1
         oMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842030; x=1731446830;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKL4rNcuhrwPlLoLHBamtHw/kLIkbIZ6raoruCdzEkE=;
        b=OVWLgaODOpW7v19cwYgH8CbZ4ZUMRaO9q5saF7fn3c6o4Yz2HMy2+ePbzRZ390VRfV
         A5JbZGEq6JKtPrjZhjgZANasIIdrHxAbDRoa19PNj9GOYyGgDGEnfKaj55S5N4dcv+Ax
         riSUZ+d5b1J2bDxBz7wyTmf9ytoZVmoKVSsejlaFFR+i88I2tqhlmSuIE07+k3v6DCGo
         3WCJziicKcgfY4z31P1LFPBRhaNF8WgGhxmVqx45FAEanSFxoJaV20JCQMfZgX7zucZP
         uHgLmr343ENFDB/UzeYHuYIErI0KJiiQjcm++1DT57PDWKpa6xmyOo7KWmaZ6Y0Jd+Gr
         bCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTsnROv42BMS4fjz8LcC4lpGUUU2qil4X91a7kR8iyd3qfqFAkKeaK9zM3VGZ6HTZusG8OrdNgrAwNMiPUsttf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaaxr4CvqdUcv7APHDpY12PPibej8xCS/0bGjq56k8lDPC5vkt
	iU/433kYei6pGkANcd/7PZZyqx1nmo9R5Ah98ACezav+Lxb99itFUNm3m34EanY7VAFRCneCccH
	zE5VSAg==
X-Google-Smtp-Source: AGHT+IFv1sJKq07men45gPnsWR9dVL6mOnMJVvJj4ob2Bl+KtxZ/0C1pvMFJQl0nS23CEVtHEPUlpZPsXzhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c09:b0:6e7:e493:2db6 with SMTP
 id 00721157ae682-6ea3b951361mr2800337b3.3.1730842030506; Tue, 05 Nov 2024
 13:27:10 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:51 -0800
In-Reply-To: <20241105212652.401943-1-irogers@google.com>
Message-Id: <20241105212652.401943-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105212652.401943-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 5/6] perf evsel: Allow evsel__newtp without libtraceevent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from reading the tracepoint format to reading the id directly
for the evsel config. This avoids the need to initialize
libtraceevent, plugins, etc. It is sufficient for many tracepoint
commands to work like:
$ perf stat -e sched:sched_switch true

To populate evsel->tp_format, do lazy initialization using
libtraceevent in the evsel__tp_format function (the sys and name are
saved in evsel__newtp_idx for this purpose). Reading the id should be
indicative of the format failing to load, but if not an error is
reported in evsel__tp_format. This could happen for a tracepoint with
a format that fails to parse.

As tracepoints can be parsed without libtraceevent with this, remove
the associated #ifdefs in parse-events.c.

By only lazily parsing the tracepoint format information it is hoped
this will help improve the performance of code using tracepoints but
not the format information. It also cuts down on the build and ifdef
logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        | 103 ++++++++++++++++++++++++---------
 tools/perf/util/evsel.h        |  14 ++---
 tools/perf/util/parse-events.c |  16 +----
 3 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a95db7e900d5..56e19e32a852 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -543,54 +543,101 @@ struct evsel *evsel__clone(struct evsel *orig)
 	return NULL;
 }
 
+static int trace_event__id(const char *sys, const char *name)
+{
+	char *tp_dir = get_events_file(sys);
+	char path[PATH_MAX];
+	int id, err;
+
+	if (!tp_dir)
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
+	put_events_file(tp_dir);
+	err = filename__read_int(path, &id);
+	if (err)
+		return err;
+
+	return id;
+}
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-#ifdef HAVE_LIBTRACEEVENT
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
+	struct perf_event_attr attr = {
+		.type	       = PERF_TYPE_TRACEPOINT,
+		.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
+				PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
+	};
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
-	int err = -ENOMEM;
+	int err = -ENOMEM, id = -1;
 
-	if (evsel == NULL) {
+	if (evsel == NULL)
 		goto out_err;
-	} else {
-		struct perf_event_attr attr = {
-			.type	       = PERF_TYPE_TRACEPOINT,
-			.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
-					  PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
-		};
 
-		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
-			goto out_free;
 
-		event_attr_init(&attr);
+	if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
+		goto out_free;
 
-		if (format) {
-			evsel->tp_format = trace_event__tp_format(sys, name);
-			if (IS_ERR(evsel->tp_format)) {
-				err = PTR_ERR(evsel->tp_format);
-				evsel->tp_format = NULL;
-				goto out_free;
-			}
-			attr.config = evsel->tp_format->id;
-		} else {
-			attr.config = (__u64) -1;
-		}
+#ifdef HAVE_LIBTRACEEVENT
+	evsel->tp_sys = strdup(sys);
+	if (!evsel->tp_sys)
+		goto out_free;
 
+	evsel->tp_name = strdup(name);
+	if (!evsel->tp_name)
+		goto out_free;
+#endif
 
-		attr.sample_period = 1;
-		evsel__init(evsel, &attr, idx);
-	}
+	event_attr_init(&attr);
 
+	if (format) {
+		id = trace_event__id(sys, name);
+		if (id < 0) {
+			err = id;
+			goto out_free;
+		}
+	}
+	attr.config = (__u64)id;
+	attr.sample_period = 1;
+	evsel__init(evsel, &attr, idx);
 	return evsel;
 
 out_free:
 	zfree(&evsel->name);
+#ifdef HAVE_LIBTRACEEVENT
+	zfree(&evsel->tp_sys);
+	zfree(&evsel->tp_name);
+#endif
 	free(evsel);
 out_err:
 	return ERR_PTR(err);
 }
+
+#ifdef HAVE_LIBTRACEEVENT
+struct tep_event *evsel__tp_format(struct evsel *evsel)
+{
+	struct tep_event *tp_format = evsel->tp_format;
+
+	if (tp_format)
+		return tp_format;
+
+	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+		return NULL;
+
+	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	if (IS_ERR(tp_format)) {
+		int err = -PTR_ERR(evsel->tp_format);
+
+		pr_err("Error getting tracepoint format '%s' '%s'(%d)\n",
+			evsel__name(evsel), strerror(err), err);
+		return NULL;
+	}
+	evsel->tp_format = tp_format;
+	return evsel->tp_format;
+}
 #endif
 
 const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
@@ -1587,6 +1634,10 @@ void evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
+#ifdef HAVE_LIBTRACEEVENT
+	zfree(&evsel->tp_sys);
+	zfree(&evsel->tp_name);
+#endif
 	zfree(&evsel->filter);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c3e53d320bf5..93b6244ec302 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -59,6 +59,8 @@ struct evsel {
 		char			*group_name;
 		const char		*group_pmu_name;
 #ifdef HAVE_LIBTRACEEVENT
+		char			*tp_sys;
+		char			*tp_name;
 		struct tep_event	*tp_format;
 #endif
 		char			*filter;
@@ -247,25 +249,17 @@ int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
 
 
-#ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
-
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
 	return evsel__newtp_idx(sys, name, 0, true);
 }
 
-static inline struct tep_event *evsel__tp_format(struct evsel *evsel)
-{
-	return evsel->tp_format;
-}
-#endif
-
 #ifdef HAVE_LIBTRACEEVENT
-struct tep_event *event_format__new(const char *sys, const char *name);
+struct tep_event *evsel__tp_format(struct evsel *evsel);
 #endif
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index afeb8d815bbf..7fc1c36ef2a4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -489,7 +489,6 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	return found_supported ? 0 : -EINVAL;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void tracepoint_error(struct parse_events_error *e, int err,
 			     const char *sys, const char *name, int column)
 {
@@ -644,7 +643,6 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 	closedir(events_dir);
 	return ret;
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 size_t default_breakpoint_len(void)
 {
@@ -1066,7 +1064,6 @@ static int config_term_pmu(struct perf_event_attr *attr,
 	return config_term_common(attr, term, err);
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int config_term_tracepoint(struct perf_event_attr *attr,
 				  struct parse_events_term *term,
 				  struct parse_events_error *err)
@@ -1111,7 +1108,6 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 
 	return 0;
 }
-#endif
 
 static int config_attr(struct perf_event_attr *attr,
 		       const struct parse_events_terms *head,
@@ -1303,7 +1299,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-#ifdef HAVE_LIBTRACEEVENT
+
 	if (head_config) {
 		struct perf_event_attr attr;
 
@@ -1318,16 +1314,6 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 	else
 		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config, loc);
-#else
-	(void)parse_state;
-	(void)list;
-	(void)sys;
-	(void)event;
-	(void)head_config;
-	parse_events_error__handle(err, loc->first_column, strdup("unsupported tracepoint"),
-				strdup("libtraceevent is necessary for tracepoint support"));
-	return -1;
-#endif
 }
 
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
-- 
2.47.0.199.ga7371fff76-goog

