Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DC3093AE
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191522; cv=none; b=jDpTHyKHL/XL8tWooFjvEbQPYy0K56Q+x8f1Yn/6WO7qYYZEVJCvU24Aqah8V2xkRRBY1qgXJJI7shzSOkRgRl3ut7Gz1SsUmgRs48ykmjKBklD22ulf4E94E7eEL07cAoeB7DhdZkGBoVcfT1zZ3z/wOMx3HxlJeCRwlq+U9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191522; c=relaxed/simple;
	bh=w5eNqcWn2O0y6EMKp9jCIupHTttD6lDBxXRkCF1rGCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kVxXIxFNoEDlb1dMklmUVv9GwSWWuxOyYFdzfxg/Rxl2kLqtDQzwzKLhRvLF5wZm1x0ZaHJLHlv+/qNP0O85wpeVljjP+RrdO8k2rLsRfRm2BHvQ9v4kB1L4aWjvcfw1Q94GMpXxGQORUi3VganDYnut8LAHP4YxwmCLCzHdWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrNQHEIN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrNQHEIN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso1584712a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191520; x=1752796320; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoNwchClBb7Gcfk0e4XraPQtQcpY/XFOcoy596WayHU=;
        b=DrNQHEINvvWLzrTNTaKRt6nKM5tm5AgbaTlpNQcsKKiwoBz60SbcXYj/ZNlZdsDtnP
         swEgFJduysgZh/i8CFMwiTgXMgpq2GdQIQISdta6HLv0eyyqEPG7YtptoPNvPopvQG3T
         b80vTR3PNRrq1dHH836p5RCLV4qKH/J+sqp3Vu3MBxw82+3IiSoFiw7fWFmvCLVgrtzb
         SVMIDztd5chlDnR5xD2nVr2RqnZELwZUvtglhFPQFjhun+vDR5w+S3RHRtNqqWseXRj9
         3hTne3xCyZ8zwklSW1yA9hidwuN1L1bcH8vZwzzcWNGra3y6GCd9l2E+v8iCmgi6bVUk
         yLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191520; x=1752796320;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoNwchClBb7Gcfk0e4XraPQtQcpY/XFOcoy596WayHU=;
        b=Wr8RbH3ovMoCI9/fBTTQ0f1z77pE/Ewp7UBG42cZQuRfFBLKFjY8kCSuWUtWJemliu
         aEqMmtyWuX94tgyXUn+3kMM8ABcPK2/0ZS5lU9iyBzQcTLrtUP9rLr+bxlAVBJ7yvwZ6
         A6E2dGAKpZHuoYjd1ojGXG1pe854ND396863uPDvRGApDAiJ12KiG4FKa7WW6v/ns7c5
         4PUsj9q4XLBExj7ZLrgMAlrEcc3OkoBkJGZ+pYN0AzQk82zP6F8GV4fmQ6WmN0Oiok0U
         TCT42o3jnC7TEKb/r0ElyFLvKUiFRIDqn8+T2toqWbD6OP/zo4vrzGQ/zsntVRrBXmoo
         kn5w==
X-Forwarded-Encrypted: i=1; AJvYcCXgA5z7eD6hHIM8YlTGfsztk1CVg4xLBuLvC+7FRpCw+1o41VaKrxnJ+rKMGnoDsfxqPPwanYtAbO1YfKO9Ytur@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcYCmKeeWQuDxp1WhspugKwppPlUHhR9gR0NAIWar6OQ6chDL
	Z3C5mDRrsh6wMJ4QK6UmWO2nwSAqPilJDRojrIyYF6TmmUSyv6S3mnFsETHHY2i1sHSmGnZaQP+
	QN9V0vdzHfA==
X-Google-Smtp-Source: AGHT+IG0B8YFEZA8V8LiUmGV5dCe3b/biwYNthB5zqBtruQZhOYLikGG3vCBQ54sznM4CvSliMGF+JWuyPHh
X-Received: from pjbta6.prod.google.com ([2002:a17:90b:4ec6:b0:31c:2fe4:33b7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d84:b0:312:db8:dbdd
 with SMTP id 98e67ed59e1d1-31c4f54963amr582991a91.28.1752191519728; Thu, 10
 Jul 2025 16:51:59 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:18 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-6-irogers@google.com>
Subject: [PATCH v2 05/13] perf metricgroup: Factor out for-each function and
 move out printing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor metricgroup__for_each_metric into its own function handling
regular and sys metrics. Make the metric adding and printing code use
it, move the printing code into print-events files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c  | 241 ++++-----------------------------
 tools/perf/util/metricgroup.h  |   3 +-
 tools/perf/util/print-events.c | 133 ++++++++++++++++++
 tools/perf/util/print-events.h |   2 +
 4 files changed, 165 insertions(+), 214 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 43d35f956a33..ddd5c362d183 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -384,107 +384,6 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
 	       match_metric_or_groups(pm->metric_name, metric_or_groups);
 }
 
-/** struct mep - RB-tree node for building printing information. */
-struct mep {
-	/** nd - RB-tree element. */
-	struct rb_node nd;
-	/** @metric_group: Owned metric group name, separated others with ';'. */
-	char *metric_group;
-	const char *metric_name;
-	const char *metric_desc;
-	const char *metric_long_desc;
-	const char *metric_expr;
-	const char *metric_threshold;
-	const char *metric_unit;
-	const char *pmu_name;
-};
-
-static int mep_cmp(struct rb_node *rb_node, const void *entry)
-{
-	struct mep *a = container_of(rb_node, struct mep, nd);
-	struct mep *b = (struct mep *)entry;
-	int ret;
-
-	ret = strcmp(a->metric_group, b->metric_group);
-	if (ret)
-		return ret;
-
-	return strcmp(a->metric_name, b->metric_name);
-}
-
-static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const void *entry)
-{
-	struct mep *me = malloc(sizeof(struct mep));
-
-	if (!me)
-		return NULL;
-
-	memcpy(me, entry, sizeof(struct mep));
-	return &me->nd;
-}
-
-static void mep_delete(struct rblist *rl __maybe_unused,
-		       struct rb_node *nd)
-{
-	struct mep *me = container_of(nd, struct mep, nd);
-
-	zfree(&me->metric_group);
-	free(me);
-}
-
-static struct mep *mep_lookup(struct rblist *groups, const char *metric_group,
-			      const char *metric_name)
-{
-	struct rb_node *nd;
-	struct mep me = {
-		.metric_group = strdup(metric_group),
-		.metric_name = metric_name,
-	};
-	nd = rblist__find(groups, &me);
-	if (nd) {
-		free(me.metric_group);
-		return container_of(nd, struct mep, nd);
-	}
-	rblist__add_node(groups, &me);
-	nd = rblist__find(groups, &me);
-	if (nd)
-		return container_of(nd, struct mep, nd);
-	return NULL;
-}
-
-static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
-					struct rblist *groups)
-{
-	const char *g;
-	char *omg, *mg;
-
-	mg = strdup(pm->metric_group ?: pm->metric_name);
-	if (!mg)
-		return -ENOMEM;
-	omg = mg;
-	while ((g = strsep(&mg, ";")) != NULL) {
-		struct mep *me;
-
-		g = skip_spaces(g);
-		if (strlen(g))
-			me = mep_lookup(groups, g, pm->metric_name);
-		else
-			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
-
-		if (me) {
-			me->metric_desc = pm->desc;
-			me->metric_long_desc = pm->long_desc;
-			me->metric_expr = pm->metric_expr;
-			me->metric_threshold = pm->metric_threshold;
-			me->metric_unit = pm->unit;
-			me->pmu_name = pm->pmu;
-		}
-	}
-	free(omg);
-
-	return 0;
-}
-
 struct metricgroup_iter_data {
 	pmu_metric_iter_fn fn;
 	void *data;
@@ -510,54 +409,22 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 	return 0;
 }
 
-static int metricgroup__add_to_mep_groups_callback(const struct pmu_metric *pm,
-					const struct pmu_metrics_table *table __maybe_unused,
-					void *vdata)
+int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+				 void *data)
 {
-	struct rblist *groups = vdata;
-
-	return metricgroup__add_to_mep_groups(pm, groups);
-}
-
-void metricgroup__print(const struct print_callbacks *print_cb, void *print_state)
-{
-	struct rblist groups;
-	const struct pmu_metrics_table *table;
-	struct rb_node *node, *next;
+	struct metricgroup_iter_data sys_data = {
+		.fn = fn,
+		.data = data,
+	};
 
-	rblist__init(&groups);
-	groups.node_new = mep_new;
-	groups.node_cmp = mep_cmp;
-	groups.node_delete = mep_delete;
-	table = pmu_metrics_table__find();
 	if (table) {
-		pmu_metrics_table__for_each_metric(table,
-						 metricgroup__add_to_mep_groups_callback,
-						 &groups);
-	}
-	{
-		struct metricgroup_iter_data data = {
-			.fn = metricgroup__add_to_mep_groups_callback,
-			.data = &groups,
-		};
-		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
-	}
+		int ret = pmu_metrics_table__for_each_metric(table, fn, data);
 
-	for (node = rb_first_cached(&groups.entries); node; node = next) {
-		struct mep *me = container_of(node, struct mep, nd);
-
-		print_cb->print_metric(print_state,
-				me->metric_group,
-				me->metric_name,
-				me->metric_desc,
-				me->metric_long_desc,
-				me->metric_expr,
-				me->metric_threshold,
-				me->metric_unit,
-				me->pmu_name);
-		next = rb_next(node);
-		rblist__remove_node(&groups, node);
+		if (ret)
+			return ret;
 	}
+
+	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
 }
 
 static const char *code_characters = ",-=@";
@@ -1090,29 +957,6 @@ static int add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
-					const struct pmu_metrics_table *table __maybe_unused,
-					void *data)
-{
-	struct metricgroup_add_iter_data *d = data;
-	int ret;
-
-	if (!match_pm_metric_or_groups(pm, d->pmu, d->metric_name))
-		return 0;
-
-	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
-			 d->metric_no_threshold, d->user_requested_cpu_list,
-			 d->system_wide, d->root_metric, d->visited, d->table);
-	if (ret)
-		goto out;
-
-	*(d->has_match) = true;
-
-out:
-	*(d->ret) = ret;
-	return ret;
-}
-
 /**
  * metric_list_cmp - list_sort comparator that sorts metrics with more events to
  *                   the front. tool events are excluded from the count.
@@ -1216,55 +1060,26 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 {
 	LIST_HEAD(list);
 	int ret;
-	bool has_match = false;
-
-	{
-		struct metricgroup__add_metric_data data = {
-			.list = &list,
-			.pmu = pmu,
-			.metric_name = metric_name,
-			.modifier = modifier,
-			.metric_no_group = metric_no_group,
-			.metric_no_threshold = metric_no_threshold,
-			.user_requested_cpu_list = user_requested_cpu_list,
-			.system_wide = system_wide,
-			.has_match = false,
-		};
-		/*
-		 * Iterate over all metrics seeing if metric matches either the
-		 * name or group. When it does add the metric to the list.
-		 */
-		ret = pmu_metrics_table__for_each_metric(table, metricgroup__add_metric_callback,
-						       &data);
-		if (ret)
-			goto out;
+	struct metricgroup__add_metric_data data = {
+		.list = &list,
+		.pmu = pmu,
+		.metric_name = metric_name,
+		.modifier = modifier,
+		.metric_no_group = metric_no_group,
+		.metric_no_threshold = metric_no_threshold,
+		.user_requested_cpu_list = user_requested_cpu_list,
+		.system_wide = system_wide,
+		.has_match = false,
+	};
 
-		has_match = data.has_match;
-	}
-	{
-		struct metricgroup_iter_data data = {
-			.fn = metricgroup__add_metric_sys_event_iter,
-			.data = (void *) &(struct metricgroup_add_iter_data) {
-				.metric_list = &list,
-				.pmu = pmu,
-				.metric_name = metric_name,
-				.modifier = modifier,
-				.metric_no_group = metric_no_group,
-				.user_requested_cpu_list = user_requested_cpu_list,
-				.system_wide = system_wide,
-				.has_match = &has_match,
-				.ret = &ret,
-				.table = table,
-			},
-		};
-
-		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
-	}
-	/* End of pmu events. */
-	if (!has_match)
+	/*
+	 * Iterate over all metrics seeing if metric matches either the
+	 * name or group. When it does add the metric to the list.
+	 */
+	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
+	if (!ret && !data.has_match)
 		ret = -EINVAL;
 
-out:
 	/*
 	 * add to metric_list so that they can be released
 	 * even if it's failed
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index a04ac1afa6cc..1c07295931c1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -84,7 +84,8 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const char *str,
 				   struct rblist *metric_events);
 
-void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
+int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+				 void *data);
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 83aaf7cda635..e233bacaa641 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -381,6 +381,139 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 	strlist__delete(evt_name_list);
 }
 
+/** struct mep - RB-tree node for building printing information. */
+struct mep {
+	/** nd - RB-tree element. */
+	struct rb_node nd;
+	/** @metric_group: Owned metric group name, separated others with ';'. */
+	char *metric_group;
+	const char *metric_name;
+	const char *metric_desc;
+	const char *metric_long_desc;
+	const char *metric_expr;
+	const char *metric_threshold;
+	const char *metric_unit;
+	const char *pmu_name;
+};
+
+static int mep_cmp(struct rb_node *rb_node, const void *entry)
+{
+	struct mep *a = container_of(rb_node, struct mep, nd);
+	struct mep *b = (struct mep *)entry;
+	int ret;
+
+	ret = strcmp(a->metric_group, b->metric_group);
+	if (ret)
+		return ret;
+
+	return strcmp(a->metric_name, b->metric_name);
+}
+
+static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const void *entry)
+{
+	struct mep *me = malloc(sizeof(struct mep));
+
+	if (!me)
+		return NULL;
+
+	memcpy(me, entry, sizeof(struct mep));
+	return &me->nd;
+}
+
+static void mep_delete(struct rblist *rl __maybe_unused,
+		       struct rb_node *nd)
+{
+	struct mep *me = container_of(nd, struct mep, nd);
+
+	zfree(&me->metric_group);
+	free(me);
+}
+
+static struct mep *mep_lookup(struct rblist *groups, const char *metric_group,
+			      const char *metric_name)
+{
+	struct rb_node *nd;
+	struct mep me = {
+		.metric_group = strdup(metric_group),
+		.metric_name = metric_name,
+	};
+	nd = rblist__find(groups, &me);
+	if (nd) {
+		free(me.metric_group);
+		return container_of(nd, struct mep, nd);
+	}
+	rblist__add_node(groups, &me);
+	nd = rblist__find(groups, &me);
+	if (nd)
+		return container_of(nd, struct mep, nd);
+	return NULL;
+}
+
+static int metricgroup__add_to_mep_groups_callback(const struct pmu_metric *pm,
+					const struct pmu_metrics_table *table __maybe_unused,
+					void *vdata)
+{
+	struct rblist *groups = vdata;
+	const char *g;
+	char *omg, *mg;
+
+	mg = strdup(pm->metric_group ?: pm->metric_name);
+	if (!mg)
+		return -ENOMEM;
+	omg = mg;
+	while ((g = strsep(&mg, ";")) != NULL) {
+		struct mep *me;
+
+		g = skip_spaces(g);
+		if (strlen(g))
+			me = mep_lookup(groups, g, pm->metric_name);
+		else
+			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
+
+		if (me) {
+			me->metric_desc = pm->desc;
+			me->metric_long_desc = pm->long_desc;
+			me->metric_expr = pm->metric_expr;
+			me->metric_threshold = pm->metric_threshold;
+			me->metric_unit = pm->unit;
+			me->pmu_name = pm->pmu;
+		}
+	}
+	free(omg);
+
+	return 0;
+}
+
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state)
+{
+	struct rblist groups;
+	struct rb_node *node, *next;
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+
+	rblist__init(&groups);
+	groups.node_new = mep_new;
+	groups.node_cmp = mep_cmp;
+	groups.node_delete = mep_delete;
+
+	metricgroup__for_each_metric(table, metricgroup__add_to_mep_groups_callback, &groups);
+
+	for (node = rb_first_cached(&groups.entries); node; node = next) {
+		struct mep *me = container_of(node, struct mep, nd);
+
+		print_cb->print_metric(print_state,
+				me->metric_group,
+				me->metric_name,
+				me->metric_desc,
+				me->metric_long_desc,
+				me->metric_expr,
+				me->metric_threshold,
+				me->metric_unit,
+				me->pmu_name);
+		next = rb_next(node);
+		rblist__remove_node(&groups, node);
+	}
+}
+
 /*
  * Print the help text for the event symbols:
  */
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 8f19c2bea64a..48682e2d166d 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -37,7 +37,9 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
+
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
+void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
 #endif /* __PERF_PRINT_EVENTS_H */
-- 
2.50.0.727.gbf7dc18ff4-goog

