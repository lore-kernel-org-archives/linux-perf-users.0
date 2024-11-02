Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400D16B38B
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532187; cv=none; b=VkHwDyQ1e4a9ZDky+h2CF5kw5A9C2CDMUOg2+GNwsI6u/LxE4IUjomRDml/WoLqMUFr2crZyyRkinnq19SBSfduxd30whFvPa5M2dpkcr/kOdKrC1LVeguA2NGgWsFECCuqXmtPZpztUW36lDDoN6I59wUdmlTzcWcxX9+6lCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532187; c=relaxed/simple;
	bh=7Y4sqAJ8H8/wv4YeVklOCJ++26LwgmHe6Sf8bb4jcEk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mf/Qt5RC/gf9H3YiY1xPPANmXeYYU9X0jEozmdwh1PEqucd5jf3rXBY5yrhg5EHsyVJJ2joQ0HN3bA3PkbbWxEd6f5MbOrwNIynztIkto/tMpeM1cYOTbIhOBdnNEBSehdOrSz9PTkE/e/M64RTGcGU14D4hH9HaLVbVPJnVVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLYy886e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLYy886e"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf48435fso5194607276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532185; x=1731136985; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+XLGbF4z6yhLVHsw4IRHpaH32znecDF7ITzpGw3GKA=;
        b=fLYy886eBSRsaT4u1AXGrkbsIu/fGcccLbaymt3bOKD6vmqwGxdgGLaOmDDnE4Gwsa
         hnGQfzxIH0VoETFwJO373bphZsO487qv1aGQKsVoVvY1K0sPf6PKFYhWDQBovNVUqyXn
         81j4XlGCY7F4MvGkbhSHnbWaaoYcWgKqtgyIgMggulPPWoznERvO24Aga07AwDDzxHMW
         Iv14v7JekOO0BK9sVbj5pp/h4mD6WC0u73LhwJHJ/8MfhGEoLPFsUKMAVYh3NgacEaZl
         HrsxSYDYSYBoTBx9yR76KrEeTqxOeoeDkQ96I97Z8LtUsZNRIite0kbydDXWtTCrlksP
         Jgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532185; x=1731136985;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+XLGbF4z6yhLVHsw4IRHpaH32znecDF7ITzpGw3GKA=;
        b=dGLK21jkpPD+s8BcyWMUUpYGyFEvVGIGR0fwLsoPMCXVGIdH3/o+3R1VPxn3zhkz9B
         Fo7ZnFNAo2njotBTZHbSsH7D4Xc+/+9OVy1xKSeThvJZZ5EFjLBTdmAmrK1WwDA0aWC3
         4rGWm0+PS7GUL0Oqe+3hbhdiV+Tiv104LC2zZOv6OEMhayVsgf/wHSwChYIefHWubM9J
         LlK4OtJKzK+OCUCwtPEvbJ4eM7Lz2ZA4BoiKWPWCdlfFsu39VaN97ldg3PqaTzpJ3T15
         ZoTlD3wY2fzUQxkU6GwFH+Nd60fQByMBiaRL7VwF5Fu2mO9h651Km5wLV6NtFwFy5hfw
         aKEw==
X-Forwarded-Encrypted: i=1; AJvYcCWsW3/uFl+N9+GRLK6rD2jBT6CCSIVgjqHorvd1tzL1QdnEcD89OodK6mZTQLb5n7DT6ozJwSQhU5jTTJUCjrfN@vger.kernel.org
X-Gm-Message-State: AOJu0YwazG+KYN+L7dJZmF0e2EQjyarZWMRdXyxb3riBHX3yBD8lkFUW
	v+lthGWwuXnANUFNYDwxIGgESDbIbVQitqyfNSbAaiL1GIyDP6/kb7re6YtMWPXsLCUej1JPSpF
	5/VgkZA==
X-Google-Smtp-Source: AGHT+IGuUK4GzkjzC09ZcIJQLIZNDEngjbi2hiidCenaPPeInpbbt1xIcKWP/YxzU3HebhVS+gUfEYonSlgz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a25:83c7:0:b0:e20:2502:be14 with SMTP id
 3f1490d57ef6-e330356f9camr3227276.7.1730532185049; Sat, 02 Nov 2024 00:23:05
 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:47 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 5/6] perf evsel: Allow evsel__newtp without libtraceevent
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
saved in evsel__newtp_idx for this purpose). As tracepoints can be
parsed without libtraceevent with this, remove the associated #ifdefs
in parse-events.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        | 93 ++++++++++++++++++++++++----------
 tools/perf/util/evsel.h        | 14 ++---
 tools/perf/util/parse-events.c | 16 +-----
 3 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a95db7e900d5..f98e60803b98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -543,54 +543,91 @@ struct evsel *evsel__clone(struct evsel *orig)
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
+	if (evsel->tp_format)
+		return evsel->tp_format;
+
+	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+		return NULL;
+
+	evsel->tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	return evsel->tp_format;
+}
 #endif
 
 const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
@@ -1587,6 +1624,10 @@ void evsel__exit(struct evsel *evsel)
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

