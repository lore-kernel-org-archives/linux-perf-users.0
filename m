Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599676;
	b=ZK5+PZzjyC5JUjRL9M1cM3+crKH5NEwWnv4Eh3EijK5qmR4M//rNXsYcW4jXwVHhwDGc
	 KFTMP2wt7VLSnxbfdDO9gUwuBPzzkqI84SXlhIml6PKzY2mA/JHOm7jRfPOhQ7t/+5wuB
	 LApkg3aIOt0wjbFO9HZ5vNsFezF1T2/ZRhjdlr9OemJlK6RPo4GVdrbzH73PeTSSaglVg
	 tZJ2ioJZH3NIeIf9B8LqYHHZDJwsuYqdFWgfo+71HBkdgFrz54x7ZmHbeyN3fzfFvuCrd
	 FHSpWgrwM60977EmP36nKzWirMg9AUo1fQAHvC2+19994i7Lzbz+TNvKuQ45vfiwuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dal/mb5JtOl+eaoqm0DsiFV/ksKgGWxczXDvLBQHhAg=;
	b=aL9EoL0tmlC3tA7eb6TxH54X3ykSaikxKecpVfivHEGPnaTZz+GB5w+7tc2b9Crjdo3Q
	 BD1Otaa251XYcny8vi/Uwo22fIWYU22bXijZSa0rSz/yf4C3CidCzRESl7FrvGrHf+9Z/
	 7Vf63X8mvC7iIiBrKZkANnRuthZgxrmENPlwmKnGLjtgwZxDNrwGMAi0QTBRR4n04Kpbz
	 RJbNoterWlJe8Df8UzwB6x6nQBxBRcW1TMpeb1RrNtKfcYjh/stliKyhyzBiokpbV/sr3
	 aImBVl+RcKOM2lcGe9NA7HafJ0C4XBlgE5hR2RXuXdzN5mLT8+JOHL3zwwumpXD8kFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="A2n/zUhz";
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCC606F378
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CCC606F378
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A2n/zUhz
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso3846389c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599675; x=1795204475; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dal/mb5JtOl+eaoqm0DsiFV/ksKgGWxczXDvLBQHhAg=;
        b=A2n/zUhzFnlwg3r9BtFgM9kr1e4XFS2hvnDiIWnailyCNfqw+OKU6fVaazloW+babH
         wbsXg14dIa4visfCteNWUQ59H2O4DcrDXrQyPKRh8/6QP0E8MMVw2VXWpuhyWTpfzkeV
         nnaG9QFi8amnAUaNZ7SjEwI9tEvnUEDZw1+E4cr/yB6O8F7ehyrl8ZQ3wkkziYFq5ITR
         iIDMrkRtRfYEZMr7LW3zFHOkvsSWJvBqNYyAGZmzHjDWvcQJlESg3/bDejdOQ4nyM/qY
         Mu/2xGWFM1VmPBPL7C7Lp6gi6DJJi/2CIXK5ObGdonGmDXUo9b/f/R2Cp7e2Onn9CRsg
         EHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599675; x=1795204475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dal/mb5JtOl+eaoqm0DsiFV/ksKgGWxczXDvLBQHhAg=;
        b=hPh2pDdWxnxbl/NMg+3SGzaDvctLYUAT1fEk2vOrWyM6arFtRIJrSKdPGdoZTRCgtH
         Kjhzc4TMZbVEKQyr3R8IatbFegFwV4pTx9kcZkZnmp9hU31YlujExgAFAZKPjYUDC1ug
         niJLAopdEKfRKaZ/w0e7zjuD2glE3HQM05wjIA/DY/NBLnrefwkccU+6kPtsDqprhWd6
         JXsBvgxTckkFv2MWMfLZvb/2g/7FsYMXkHicNy6BYvZYjym2UL5rAARMftGaIWzQTBmp
         GwqhaXVZj81XY+z8haqkwoz1gwouSCBJUo/t2oneP+jeWObo6nfUMZYCaD3ffz1qpxvl
         jeuw==
X-Gm-Message-State: APuU4Z//JTXsNJFFOUc7T4AGpFoYyJXbkGfipkjrl8V+/G+9WUHVrZxc
	QeR0i/uGJqpkYne6Z3AcovnpyLpcnI8uLE8F5Jr2+fHUnef9TTcX91ijf/KHQFzJJrxu2Qrk1OV
	FfA0a3PIWMw==
X-Received: from dlbut5.prod.google.com ([2002:a05:7022:7e05:b0:1b2:450f:bfdf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:258f:b0:184:5f2e:aa52
 with SMTP id a92af1059eb24-1b5030eb156mr3761091c88.16.1794599674327; Fri, 13
 Nov 2026 11:54:34 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:26 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-22-irogers@google.com>
Subject: [PATCH v2 21/30] perf evsel: Generalize metric_id to a set of metric_ids
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When computing a metric the value of each of its events is added to the
expression context using the event's metric_id. When metrics are matched
to events read from a perf.data file, different metrics may refer to the
same recorded event by different names, for example "instructions" and
"cpu_core@INST_RETIRED.ANY@", but an evsel previously stored only a
single metric_id.

Replace evsel::metric_id with a NULL-terminated evsel::metric_ids set of
unique identifier strings. Keep the representation private to evsel.c
behind helpers: evsel__add_metric_id(), evsel__copy_metric_ids(),
evsel__has_metric_id(), evsel__shares_metric_id() and
evsel__for_each_metric_id(), a callback based iterator. Use the iterator
in prepare_metric() to populate the expression parse context with all
metric_ids of each metric event. The metric_ids are freed by
evsel__exit(), so make the __add_event() error path use evsel__put()
rather than freeing the evsel's strings itself.

Remove evsel__metric_id() as returning a single identifier from the set
is error prone. Its uses either iterate over the set, test membership,
or, when finding duplicate events for a metric leader, test whether two
evsels share an identifier. Tool events without an explicit metric-id
keep their tool event name as an implicit identifier, other events
without a metric-id no longer have the identifier "unknown".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        | 172 ++++++++++++++++++++++++++++++---
 tools/perf/util/evsel.h        |  10 +-
 tools/perf/util/metricgroup.c  |  98 ++++++++++++-------
 tools/perf/util/parse-events.c |   8 +-
 tools/perf/util/python.c       |  34 +++++--
 tools/perf/util/stat-shadow.c  |  37 +++++--
 6 files changed, 291 insertions(+), 68 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9d58b9bfa8b6..b08f1cf9de0f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -577,11 +577,8 @@ struct evsel *evsel__clone(struct evsel *orig)
 		if (evsel->filter == NULL)
 			goto out_err;
 	}
-	if (orig->metric_id) {
-		evsel->metric_id = strdup(orig->metric_id);
-		if (evsel->metric_id == NULL)
-			goto out_err;
-	}
+	if (evsel__copy_metric_ids(evsel, orig))
+		goto out_err;
 	evsel->cgrp = cgroup__get(orig->cgrp);
 #ifdef HAVE_LIBTRACEEVENT
 	if (orig->tp_sys) {
@@ -1029,15 +1026,166 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
 	return !strcmp(evsel__name(evsel), name);
 }
 
-const char *evsel__metric_id(const struct evsel *evsel)
+/*
+ * Tool events, such as duration_time, are identified by their tool event name.
+ * Other events without a metric-id have no identifier. The evsel's PMU may not
+ * be set yet, such as during parsing or cloning, so check the attribute's type
+ * rather than using evsel__is_tool().
+ */
+static const char *evsel__implicit_metric_id(const struct evsel *evsel)
 {
-	if (evsel->metric_id)
-		return evsel->metric_id;
+	if (evsel->core.attr.type != PERF_PMU_TYPE_TOOL)
+		return NULL;
 
-	if (evsel__is_tool(evsel))
-		return evsel__tool_pmu_event_name(evsel);
+	return evsel__tool_pmu_event_name(evsel);
+}
 
-	return "unknown";
+/**
+ * evsel__for_each_metric_id - Call @cb for each metric identifier of @evsel.
+ * @evsel: The evsel holding the metric identifiers.
+ * @cb: Callback passed each identifier, a non-zero return stops the iteration.
+ * @data: Passed to @cb.
+ *
+ * Explicit identifiers are visited in the order they were added, followed by
+ * the tool event name for tool events. Tool events without explicit
+ * identifiers have their tool event name as the only identifier.
+ *
+ * Return: 0 or the first non-zero value returned by @cb.
+ */
+int evsel__for_each_metric_id(const struct evsel *evsel,
+			      int (*cb)(const char *metric_id, void *data),
+			      void *data)
+{
+	const char *implicit_id;
+
+	if (!evsel->metric_ids) {
+		implicit_id = evsel__implicit_metric_id(evsel);
+		return implicit_id ? cb(implicit_id, data) : 0;
+	}
+
+	for (size_t i = 0; evsel->metric_ids[i]; i++) {
+		int ret = cb(evsel->metric_ids[i], data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int metric_id_equal_cb(const char *metric_id, void *data)
+{
+	return !strcmp(metric_id, data);
+}
+
+/**
+ * evsel__has_metric_id - Is @metric_id an identifier of @evsel?
+ * @evsel: The evsel holding the metric identifiers.
+ * @metric_id: The identifier to search for, may be NULL.
+ *
+ * Return: true if @metric_id is in the set of metric identifiers of @evsel.
+ */
+bool evsel__has_metric_id(const struct evsel *evsel, const char *metric_id)
+{
+	if (!metric_id)
+		return false;
+
+	return evsel__for_each_metric_id(evsel, metric_id_equal_cb, (void *)metric_id);
+}
+
+static int has_metric_id_cb(const char *metric_id, void *data)
+{
+	const struct evsel *evsel = data;
+
+	return evsel__has_metric_id(evsel, metric_id);
+}
+
+/**
+ * evsel__shares_metric_id - Do two evsels have a metric identifier in common?
+ * @a: The first evsel.
+ * @b: The second evsel.
+ *
+ * Return: true if the intersection of the metric identifier sets of @a and @b
+ * isn't empty.
+ */
+bool evsel__shares_metric_id(const struct evsel *a, const struct evsel *b)
+{
+	return evsel__for_each_metric_id(a, has_metric_id_cb, (void *)b);
+}
+
+/**
+ * evsel__add_metric_id - Add an identifier to the metric identifiers of @evsel.
+ * @evsel: The evsel to add the metric identifier to.
+ * @metric_id: The identifier to add, ignored if NULL or already present.
+ *
+ * The first explicit identifier added to a tool event is followed by the tool
+ * event name so that the tool event name remains an identifier.
+ *
+ * Return: 0 on success or -ENOMEM.
+ */
+int evsel__add_metric_id(struct evsel *evsel, const char *metric_id)
+{
+	const char *implicit_id;
+	char **new_ids;
+	size_t nr = 0;
+
+	if (!metric_id || evsel__has_metric_id(evsel, metric_id))
+		return 0;
+
+	implicit_id = evsel->metric_ids ? NULL : evsel__implicit_metric_id(evsel);
+	while (evsel->metric_ids && evsel->metric_ids[nr])
+		nr++;
+
+	new_ids = realloc(evsel->metric_ids, (nr + 3) * sizeof(*new_ids));
+	if (!new_ids)
+		return -ENOMEM;
+	evsel->metric_ids = new_ids;
+
+	new_ids[nr] = strdup(metric_id);
+	if (!new_ids[nr])
+		goto out_err;
+	new_ids[nr + 1] = NULL;
+	if (implicit_id) {
+		new_ids[nr + 1] = strdup(implicit_id);
+		if (!new_ids[nr + 1])
+			goto out_err;
+		new_ids[nr + 2] = NULL;
+	}
+	return 0;
+out_err:
+	zfree(&new_ids[nr]);
+	if (!nr)
+		zfree(&evsel->metric_ids);
+	return -ENOMEM;
+}
+
+static int add_metric_id_cb(const char *metric_id, void *data)
+{
+	struct evsel *evsel = data;
+
+	return evsel__add_metric_id(evsel, metric_id);
+}
+
+/**
+ * evsel__copy_metric_ids - Add the metric identifiers of @src to @dst.
+ * @dst: The evsel to add the metric identifiers to.
+ * @src: The evsel whose metric identifiers are copied.
+ *
+ * Return: 0 on success or -ENOMEM.
+ */
+int evsel__copy_metric_ids(struct evsel *dst, const struct evsel *src)
+{
+	return evsel__for_each_metric_id(src, add_metric_id_cb, dst);
+}
+
+/**
+ * evsel__free_metric_ids - Free the metric identifiers of @evsel.
+ * @evsel: The evsel whose metric identifiers are freed.
+ */
+static void evsel__free_metric_ids(struct evsel *evsel)
+{
+	for (size_t i = 0; evsel->metric_ids && evsel->metric_ids[i]; i++)
+		zfree(&evsel->metric_ids[i]);
+	zfree(&evsel->metric_ids);
 }
 
 const char *evsel__group_name(struct evsel *evsel)
@@ -2092,7 +2240,7 @@ static void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->filter);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
-	zfree(&evsel->metric_id);
+	evsel__free_metric_ids(evsel);
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
 	evsel->per_pkg_mask = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53f3641b66e1..e776ca60a9a5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -74,7 +74,7 @@ struct evsel {
 		double			scale;
 		const char		*unit;
 		struct cgroup		*cgrp;
-		const char		*metric_id;
+		char			**metric_ids;
 
 		/* The PMU the event is from. Used for missing_features, PMU name, etc. */
 		struct perf_pmu		*pmu;
@@ -336,7 +336,13 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
 int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
 const char *evsel__name(struct evsel *evsel);
 bool evsel__name_is(struct evsel *evsel, const char *name);
-const char *evsel__metric_id(const struct evsel *evsel);
+int evsel__for_each_metric_id(const struct evsel *evsel,
+			      int (*cb)(const char *metric_id, void *data),
+			      void *data);
+bool evsel__has_metric_id(const struct evsel *evsel, const char *metric_id);
+bool evsel__shares_metric_id(const struct evsel *a, const struct evsel *b);
+int evsel__add_metric_id(struct evsel *evsel, const char *metric_id);
+int evsel__copy_metric_ids(struct evsel *dst, const struct evsel *src);
 
 static inline bool evsel__is_retire_lat(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 08679392bf6d..f25709750c3e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -275,12 +275,34 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
 	int i;
 
 	for (i = 0; i < num_events; i++) {
-		if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
+		if (evsel__has_metric_id(metric_events[i], metric_id))
 			return true;
 	}
 	return false;
 }
 
+struct match_metric_id_args {
+	/* The events already matched to IDs of the metric. */
+	struct evsel **metric_events;
+	size_t num_events;
+	/* The metric IDs to match. */
+	struct hashmap *ids;
+	/* The newly matched ID. */
+	const char *matched_id;
+};
+
+static int match_metric_id_cb(const char *metric_id, void *data)
+{
+	struct match_metric_id_args *args = data;
+
+	if (contains_metric_id(args->metric_events, args->num_events, metric_id))
+		return 0;
+	if (!hashmap__find(args->ids, metric_id, NULL))
+		return 0;
+	args->matched_id = metric_id;
+	return 1;
+}
+
 /**
  * setup_metric_events - Find a group of events in metric_evlist that correspond
  *                       to the IDs from a parsed metric expression.
@@ -293,8 +315,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 			       struct evlist *metric_evlist,
 			       struct evsel ***out_metric_events)
 {
+	struct match_metric_id_args args = { .ids = ids, };
 	struct evsel **metric_events;
-	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
 	struct perf_pmus *pmus = perf_env__pmus(evlist__env(metric_evlist) ?: host_env());
@@ -310,9 +332,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		return -ENOMEM;
 
 	matched_events = 0;
+	args.metric_events = metric_events;
 	evlist__for_each_entry(metric_evlist, ev) {
-		struct expr_id_data *val_ptr;
-
 		/* Don't match events for the wrong hybrid PMU. */
 		if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
 		    strcmp(ev->pmu->name, pmu))
@@ -323,21 +344,19 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * events per socket on skylakex. Only the first such
 		 * event is placed in metric_events.
 		 */
-		metric_id = evsel__metric_id(ev);
-		if (contains_metric_id(metric_events, matched_events, metric_id))
-			continue;
 		/*
 		 * Does this event belong to the parse context? For
 		 * combined or shared groups, this metric may not care
 		 * about this event.
 		 */
-		if (hashmap__find(ids, metric_id, &val_ptr)) {
-			pr_debug("Matched metric-id %s to %s\n", metric_id, evsel__name(ev));
+		args.num_events = matched_events;
+		if (evsel__for_each_metric_id(ev, match_metric_id_cb, &args)) {
+			pr_debug("Matched metric-id %s to %s\n",
+				 args.matched_id, evsel__name(ev));
 			metric_events[matched_events++] = ev;
-
-			if (matched_events >= ids_size)
-				break;
 		}
+		if (matched_events >= ids_size)
+			break;
 	}
 	if (matched_events < ids_size) {
 		free(metric_events);
@@ -359,9 +378,8 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * of such events to be the event that appears in
 		 * metric_events.
 		 */
-		metric_id = evsel__metric_id(ev);
 		evlist__for_each_entry_continue(metric_evlist, ev) {
-			if (!strcmp(evsel__metric_id(ev), metric_id))
+			if (evsel__shares_metric_id(ev, metric_events[i]))
 				ev->metric_leader = metric_events[i];
 		}
 	}
@@ -469,13 +487,6 @@ static struct evsel *map_metric_evsel_to_evlist(struct evlist *data_evlist,
 			continue;
 		if (metric_evsel->core.attr.config != data_evsel->core.attr.config)
 			continue;
-		/* Skip if the data event has a metric_id that doesn't match. */
-		if (data_evsel->metric_id &&
-		    strcmp(evsel__metric_id(metric_evsel), evsel__metric_id(data_evsel))) {
-			pr_debug("Skipping matching evsel due to differing metric ids '%s' vs '%s'\n",
-				 evsel__metric_id(metric_evsel), evsel__metric_id(data_evsel));
-			continue;
-		}
 		return data_evsel;
 	}
 	return NULL;
@@ -516,9 +527,8 @@ static int find_matching_metrics_cb(const struct pmu_metric *pm,
 		struct evsel *new_metric_leader;
 
 		if (!data_evsel) {
-			pr_debug("Skipping metric '%s' as evsel '%s' / '%s' is missing\n",
-				pm->metric_name, evsel__name(metric_evsel),
-				evsel__metric_id(metric_evsel));
+			pr_debug("Skipping metric '%s' as evsel '%s' is missing\n",
+				pm->metric_name, evsel__name(metric_evsel));
 			goto out;
 		}
 
@@ -535,8 +545,8 @@ static int find_matching_metrics_cb(const struct pmu_metric *pm,
 		/* Mismatching evsel leaders. */
 		if (data_evsel->metric_leader != new_metric_leader) {
 			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
-				pm->metric_name, evsel__metric_id(metric_evsel),
-				evsel__metric_id(data_evsel));
+				pm->metric_name, evsel__name(metric_evsel),
+				evsel__name(data_evsel));
 			goto out;
 		}
 	}
@@ -552,10 +562,8 @@ static int find_matching_metrics_cb(const struct pmu_metric *pm,
 					    metric_evsel,
 					    /*create=*/false);
 
-		if (data_evsel->metric_id == NULL) {
-			data_evsel->metric_id = metric_evsel->metric_id;
-			metric_evsel->metric_id = NULL;
-		}
+		if (evsel__copy_metric_ids(data_evsel, metric_evsel))
+			goto out;
 
 		if (data_evsel->metric_leader == NULL) {
 			if (metric_evsel->metric_leader == metric_evsel) {
@@ -610,6 +618,17 @@ int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
 					    find_matching_metrics_cb, &args);
 }
 
+static int append_metric_id_cb(const char *metric_id, void *data)
+{
+	struct strbuf *sb = data;
+
+	/*
+	 * Stop after the first, the metric-id of a parsed metric event is its
+	 * first identifier.
+	 */
+	return strbuf_addstr(sb, metric_id) ?: 1;
+}
+
 /*
  * The metric events are parsed with a metric-id holding the identifier used in
  * the metric expression. If the evsel name is just the parsed event, which
@@ -626,16 +645,19 @@ static int set_metric_event_names(struct evlist *perf_evlist, const char *modifi
 	evlist__for_each_entry(perf_evlist, ev) {
 		bool has_slash = false;
 
-		if (!ev->metric_id || !strstr(ev->name, "metric-id="))
+		if (!strstr(ev->name, "metric-id="))
 			continue;
 
 		ret = strbuf_setlen(&sb, 0);
 		if (ret)
 			break;
 
-		ret = strbuf_addstr(&sb, ev->metric_id);
-		if (ret)
+		ret = evsel__for_each_metric_id(ev, append_metric_id_cb, &sb);
+		if (ret < 0)
 			break;
+		if (ret == 0)
+			continue;
+		ret = 0;
 
 		zfree(&ev->name);
 		for (cur = strchr(sb.buf, '@') ; cur; cur = strchr(++cur, '@')) {
@@ -1471,15 +1493,21 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	return ret;
 }
 
+static int pctx_has_metric_id_cb(const char *metric_id, void *data)
+{
+	struct hashmap *ids = data;
+
+	return hashmap__find(ids, metric_id, NULL) ? 1 : 0;
+}
+
 /* How many times will a given evsel be used in a set of metrics? */
 static int count_uses(struct list_head *metric_list, struct evsel *evsel)
 {
-	const char *metric_id = evsel__metric_id(evsel);
 	struct metric *m;
 	int uses = 0;
 
 	list_for_each_entry(m, metric_list, nd) {
-		if (hashmap__find(m->pctx->ids, metric_id, NULL))
+		if (evsel__for_each_metric_id(evsel, pctx_has_metric_id_cb, m->pctx->ids))
 			uses++;
 	}
 	return uses;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a640344afcc8..f50722e68b73 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -332,9 +332,9 @@ __add_event(struct list_head *list, int *idx,
 		int ret = parse_events__decode_metric_id(&sb, metric_id);
 
 		if (!ret)
-			evsel->metric_id = strdup(sb.buf);
+			ret = evsel__add_metric_id(evsel, sb.buf);
 		strbuf_release(&sb);
-		if (!evsel->metric_id)
+		if (ret)
 			goto out_err;
 	}
 
@@ -362,9 +362,7 @@ __add_event(struct list_head *list, int *idx,
 out_err:
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(pmu_cpus);
-	zfree(&evsel->name);
-	zfree(&evsel->metric_id);
-	free(evsel);
+	evsel__put(evsel);
 	return NULL;
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a41372cd6bcb..79a4e9f02cbd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3073,6 +3073,27 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
 	return list;
 }
 
+struct add_metric_id_val_args {
+	struct expr_parse_ctx *pctx;
+	double val;
+	int source_count;
+};
+
+static int add_metric_id_val_cb(const char *metric_id, void *data)
+{
+	struct add_metric_id_val_args *args = data;
+	char *n = strdup(metric_id);
+	int ret;
+
+	if (!n)
+		return -ENOMEM;
+
+	ret = expr__add_id_val_source_count(args->pctx, n, args->val, args->source_count);
+	if (ret)
+		free(n);
+	return ret;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -3080,6 +3101,7 @@ static int prepare_metric(const struct metric_expr *mexp,
 {
 	struct evsel * const *metric_events = mexp->metric_events;
 	struct metric_ref *metric_refs = mexp->metric_refs;
+	struct add_metric_id_val_args args = { .pctx = pctx, };
 
 	for (int i = 0; metric_events[i]; i++) {
 		struct evsel *cur = metric_events[i];
@@ -3127,15 +3149,11 @@ static int prepare_metric(const struct metric_expr *mexp,
 
 		if (ena != run && run != 0)
 			val = val * ena / run;
-		char *n = strdup(evsel__metric_id(cur));
-
-		if (!n)
-			return -ENOMEM;
-		ret = expr__add_id_val_source_count(pctx, n, val, source_count);
-		if (ret) {
-			free(n);
+		args.val = val;
+		args.source_count = source_count;
+		ret = evsel__for_each_metric_id(cur, add_metric_id_val_cb, &args);
+		if (ret)
 			return ret;
-		}
 	}
 
 	for (int i = 0; metric_refs && metric_refs[i].metric_name; i++) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f5ae399bf336..587db3e2a05b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -45,6 +45,29 @@ static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
 	return true;
 }
 
+struct add_metric_id_val_args {
+	struct expr_parse_ctx *pctx;
+	double val;
+	int source_count;
+	int aggr_nr;
+};
+
+static int add_metric_id_val_cb(const char *metric_id, void *data)
+{
+	struct add_metric_id_val_args *args = data;
+	char *n = strdup(metric_id);
+	int ret;
+
+	if (!n)
+		return -ENOMEM;
+
+	ret = expr__add_id_val_source_count_aggr_nr(args->pctx, n, args->val,
+						    args->source_count, args->aggr_nr);
+	if (ret)
+		free(n);
+	return ret;
+}
+
 static int prepare_metric(struct perf_stat_config *config,
 			  const struct metric_expr *mexp,
 			  const struct evsel *evsel,
@@ -53,15 +76,16 @@ static int prepare_metric(struct perf_stat_config *config,
 {
 	struct evsel * const *metric_events = mexp->metric_events;
 	struct metric_ref *metric_refs = mexp->metric_refs;
+	struct add_metric_id_val_args args = { .pctx = pctx, };
 	int i;
 
 	for (i = 0; metric_events[i]; i++) {
 		int source_count = 0, tool_aggr_idx;
 		int aggr_nr = 1;
+		int ret;
 		bool is_tool_time =
 			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
 		struct perf_stat_evsel *ps = metric_events[i]->stats;
-		char *n;
 		double val;
 
 		/*
@@ -114,11 +138,12 @@ static int prepare_metric(struct perf_stat_config *config,
 				aggr_nr = aggr->nr ?: 1;
 			}
 		}
-		n = strdup(evsel__metric_id(metric_events[i]));
-		if (!n)
-			return -ENOMEM;
-
-		expr__add_id_val_source_count_aggr_nr(pctx, n, val, source_count, aggr_nr);
+		args.val = val;
+		args.source_count = source_count;
+		args.aggr_nr = aggr_nr;
+		ret = evsel__for_each_metric_id(metric_events[i], add_metric_id_val_cb, &args);
+		if (ret)
+			return ret;
 	}
 
 	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
-- 
2.56.1.703.gf848ed807c-goog

