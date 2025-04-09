Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D31E51FC
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179071; cv=none; b=e/Xq4CB51OsSx+2x0gEmwCQxeBArhh9O7WH1qHeNiB4GFw+y4JMUqq3vXB5ivHsl4/7u3xPHVxvSAYOmmoyYkwJnCf0NNALpfj/cEKAt+33TVHVUKfolhxNp3lElZ6vqnP28TUBvSbfGHNxGIUbthhBWJqKmbK8mE/e94vohIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179071; c=relaxed/simple;
	bh=x712Sf+REbTmULA7rLtp2gm66BCVWDC8OsSNLy0MlXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bjuEYjApksV6Rew2HkTw51c1CZMicpIv08EO0qOPjPxsjVr2umizfUPZ0txE4+Y/2zhO+0pKgN0fAtv+nEd6uIMxuctvNyY8adn6lMacOYLzRyinyUcBX0BN2oqaYSU9ETnlgalNYdcv+RaNu0vGJQkp3ddeSG6rn91/J+1JLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtsSN2OX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtsSN2OX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a96112fso96904945ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179069; x=1744783869; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1svmlgZ1hdj/s5BLTsbiEJmcy0BtMBOLnzcKMtls/k=;
        b=KtsSN2OX7GExEAeAYR5RBdI09WSXUdyd9jMrfBXEO5NzyhKi6CI1rhqO2oc7lzO9Ix
         G10VA9tCD5yQnE6Q6QaZl1nJzo13MQ36oUpOcxLd8RyFCDuKy/XZKgKleJ+WqylNme5b
         3mmr8iU9Yk3qcQIb1Rv2UxkiV7TahUzF9X1CRmR3AEWIBgJklgo/BWxlELLXIvCSEdJs
         3LCfhjPA6QPxzPdxNt7PfW5rsG1sleEQ45BHGlHt1ZMrHyrTyJUEyNoe6dIeJ7KsB0p8
         qTdD6VzlnSH2CugkjDksMxieSNTBkTqSOu31T8i9jwerIxBz3OhOS8fbmSLR9E+L34Kf
         NvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179069; x=1744783869;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1svmlgZ1hdj/s5BLTsbiEJmcy0BtMBOLnzcKMtls/k=;
        b=BWOckNTNVVZdMWeDi/QL09MsL/+kLdSu1fyoS/pKCJvV8STsKPiOAQZUYwhoMuk80A
         uFQt9eI7sZf8Urh/FpAJ70OXgcj3BvmsM6unlw53dherWU4MadXsTgktVMBWheIUr2uS
         11zwEo3m7NV+f8Cm+OQIOL/UuOQDgyFYhGWyRRf/9hDqEGr9TTpeiRzKdIZ97wkoNnif
         KP7hoYu6X79AmG/PF5TfY8HzOaPmWnmIbCzeERDy19l+jUe99KO1da5Moszud3DFab8O
         KeBNe3bIt/xKEjtnxculT0rMtNWauoK029qRgc0Pse+u09OJhNwFu7l1pbxSkbx5GILB
         nafw==
X-Forwarded-Encrypted: i=1; AJvYcCWw3fs/UUpvxe2L1QW+XaNIsbL0b44p5AKNWA85p3O4WHZGhnlT7WkoMSGXeGa5O/AI6Ivlgi3G1JbZuBu426+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2nv0rW2tZsCxs2CURgjKOEi8l3PR0KygOCVhUMYZEkR/KRGs
	OCuPtH9n1rOq8Q1/sUtNt1Udl8Xq+n2hcIUjbAPZsyBepvW+g5CThKO4re3xCN6prdbwSxrFSu1
	qrTp18A==
X-Google-Smtp-Source: AGHT+IFF5rSsLbQXg74UiA+QXkKwvMWAdG0+WZXaU5j0Dn35HdDSRmPwA+yJWVbuHYTSNqVsLoSGr+B7RzDC
X-Received: from pltg4.prod.google.com ([2002:a17:902:6b44:b0:223:37b7:2388])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f04:b0:223:5379:5e4e
 with SMTP id d9443c01a7336-22ac3f2dd7amr24757125ad.10.1744179069189; Tue, 08
 Apr 2025 23:11:09 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:36 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-10-irogers@google.com>
Subject: [PATCH v4 09/16] perf intel-tpebs: Refactor tpebs_results list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evsel names and metric-ids are used for matching but this can be
problematic, for example, multiple occurrences of the same retirement
latency event become a single event for the record. Change the name of
the record events so they are unique and reflect the evsel of the
retirement latency event that opens them (the retirement latency
event's evsel address is embedded within them). This allows an evsel
based close to close the event when the retirement latency event is
closed. This is important as perf stat has an evlist and the session
listen to the record events has an evlist, knowing which event should
remove the tpebs_retire_lat can't be tied to an evlist list as there
is more than 1, so closing which evlist should cause the tpebs to
stop? Using the evsel and the last one out doing the tpebs_stop is
cleaner.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |   2 -
 tools/perf/util/evlist.c      |   1 -
 tools/perf/util/evsel.c       |   2 +-
 tools/perf/util/intel-tpebs.c | 150 +++++++++++++++++++++-------------
 tools/perf/util/intel-tpebs.h |   2 +-
 5 files changed, 93 insertions(+), 64 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68ea7589c143..80e491bd775b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -681,8 +681,6 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
 
-	tpebs_delete();
-
 	return COUNTER_FATAL;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1a04141aed0..0a21da4f990f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -183,7 +183,6 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
-	tpebs_delete();
 	evlist__free_stats(evlist);
 	evlist__munmap(evlist);
 	evlist__close(evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 121283f2f382..554252ed1aab 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2759,7 +2759,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 void evsel__close(struct evsel *evsel)
 {
 	if (evsel__is_retire_lat(evsel))
-		tpebs_delete();
+		evsel__tpebs_close(evsel);
 	perf_evsel__close(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
 }
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index e42f3ec39a64..a723687e67f6 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -35,10 +35,10 @@ static struct child_process tpebs_cmd;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
-	/* Event name */
-	char *name;
-	/* Event name with the TPEBS modifier R */
-	const char *tpebs_name;
+	/** @evsel: The evsel that opened the retire_lat event. */
+	struct evsel *evsel;
+	/** @event: Event passed to perf record. */
+	char *event;
 	/* Count of retire_latency values found in sample data */
 	size_t count;
 	/* Sum of all the retire_latency values in sample data */
@@ -49,6 +49,8 @@ struct tpebs_retire_lat {
 	bool started;
 };
 
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
+
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
@@ -85,7 +87,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 
 	list_for_each_entry(t, &tpebs_results, nd) {
 		record_argv[i++] = "-e";
-		record_argv[i++] = t->name;
+		record_argv[i++] = t->event;
 	}
 	record_argv[i++] = NULL;
 	assert(i == 10 + 2 * tpebs_event_size || i == 8 + 2 * tpebs_event_size);
@@ -108,27 +110,20 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				struct evsel *evsel,
 				struct machine *machine __maybe_unused)
 {
-	int ret = 0;
-	const char *evname;
 	struct tpebs_retire_lat *t;
 
-	evname = evsel__name(evsel);
-
+	t = tpebs_retire_lat__find(evsel);
+	if (!t)
+		return -EINVAL;
 	/*
 	 * Need to handle per core results? We are assuming average retire
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
-	list_for_each_entry(t, &tpebs_results, nd) {
-		if (!strcmp(evname, t->name)) {
-			t->count += 1;
-			t->sum += sample->retire_lat;
-			t->val = (double) t->sum / t->count;
-			break;
-		}
-	}
-
-	return ret;
+	t->count += 1;
+	t->sum += sample->retire_lat;
+	t->val = (double) t->sum / t->count;
+	return 0;
 }
 
 static int process_feature_event(struct perf_session *session,
@@ -183,50 +178,98 @@ static int tpebs_stop(void)
 	return ret;
 }
 
-static char *evsel__tpebs_name(struct evsel *evsel)
+/**
+ * evsel__tpebs_event() - Create string event encoding to pass to `perf record`.
+ */
+static int evsel__tpebs_event(struct evsel *evsel, char **event)
 {
 	char *name, *modifier;
+	int ret;
 
 	name = strdup(evsel->name);
 	if (!name)
-		return NULL;
+		return -ENOMEM;
 
 	modifier = strrchr(name, 'R');
 	if (!modifier) {
-		pr_err("Tpebs event missing modifier '%s'\n", name);
-		free(name);
-		return NULL;
+		ret = -EINVAL;
+		goto out;
 	}
-
 	*modifier = 'p';
-	return name;
+	modifier = strchr(name, ':');
+	if (!modifier)
+		modifier = strrchr(name, '/');
+	if (!modifier) {
+		ret = -EINVAL;
+		goto out;
+	}
+	*modifier = '\0';
+	if (asprintf(event, "%s/name=tpebs_event_%p/%s", name, evsel, modifier + 1) > 0)
+		ret = 0;
+	else
+		ret = -ENOMEM;
+out:
+	if (ret)
+		pr_err("Tpebs event modifier broken '%s'\n", evsel->name);
+	free(name);
+	return ret;
 }
 
 static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
 {
 	struct tpebs_retire_lat *result = zalloc(sizeof(*result));
+	int ret;
 
 	if (!result)
 		return NULL;
 
-	result->tpebs_name = evsel->name;
-	result->name = evsel__tpebs_name(evsel);
-	if (!result->name) {
+	ret = evsel__tpebs_event(evsel, &result->event);
+	if (ret) {
 		free(result);
 		return NULL;
 	}
+	result->evsel = evsel;
 	list_add_tail(&result->nd, &tpebs_results);
 	return result;
 }
 
+static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
+{
+	zfree(&r->event);
+	free(r);
+}
+
 static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 {
 	struct tpebs_retire_lat *t;
+	uint64_t num;
+	const char *evsel_name;
 
+	/*
+	 * Evsels will match for evlist with the retirement latency event. The
+	 * name with "tpebs_event_" prefix will be present on events being read
+	 * from `perf record`.
+	 */
+	if (evsel__is_retire_lat(evsel)) {
+		list_for_each_entry(t, &tpebs_results, nd) {
+			if (t->evsel == evsel)
+				return t;
+		}
+		return NULL;
+	}
+	evsel_name = strstr(evsel->name, "tpebs_event_");
+	if (!evsel_name) {
+		/* Unexpected that the perf record should have other events. */
+		return NULL;
+	}
+	errno = 0;
+	num = strtoull(evsel_name + 12, NULL, 16);
+	if (errno) {
+		pr_err("Bad evsel for tpebs find '%s'\n", evsel->name);
+		return NULL;
+	}
 	list_for_each_entry(t, &tpebs_results, nd) {
-		if (t->tpebs_name == evsel->name ||
-		    !strcmp(t->tpebs_name, evsel->name) ||
-		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id)))
+		if ((uint64_t)t->evsel == num)
 			return t;
 	}
 	return NULL;
@@ -363,8 +406,12 @@ int evsel__tpebs_open(struct evsel *evsel)
 		close(ack_fd[0]);
 		close(ack_fd[1]);
 	}
-	if (ret)
-		tpebs_delete();
+	if (ret) {
+		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+
+		list_del_init(&t->nd);
+		tpebs_retire_lat__delete(t);
+	}
 	return ret;
 }
 
@@ -414,34 +461,19 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
-static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
-{
-	zfree(&r->name);
-	free(r);
-}
-
-
-/*
- * tpebs_delete - delete tpebs related data and stop the created thread and
- * process by calling tpebs_stop().
- *
- * This function is called from evlist_delete() and also from builtin-stat
- * stat_handle_error(). If tpebs_start() is called from places other then perf
- * stat, need to ensure tpebs_delete() is also called to safely free mem and
- * close the data read thread and the forked perf record process.
+/**
+ * evsel__tpebs_close() - delete tpebs related data. If the last event, stop the
+ * created thread and process by calling tpebs_stop().
  *
- * This function is also called in evsel__close() to be symmetric with
- * tpebs_start() being called in evsel__open(). We will update this call site
- * when move tpebs_start() to evlist level.
+ * This function is called in evsel__close() to be symmetric with
+ * evsel__tpebs_open() being called in evsel__open().
  */
-void tpebs_delete(void)
+void evsel__tpebs_close(struct evsel *evsel)
 {
-	struct tpebs_retire_lat *r, *rtmp;
+	struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
 
-	tpebs_stop();
+	tpebs_retire_lat__delete(t);
 
-	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
-		list_del_init(&r->nd);
-		tpebs_retire_lat__delete(r);
-	}
+	if (list_empty(&tpebs_results))
+		tpebs_stop();
 }
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index cc98203719c8..5c671181ec60 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -11,7 +11,7 @@ struct evsel;
 extern bool tpebs_recording;
 
 int evsel__tpebs_open(struct evsel *evsel);
-void tpebs_delete(void);
+void evsel__tpebs_close(struct evsel *evsel);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #endif /* __INTEL_TPEBS_H */
-- 
2.49.0.504.g3bcea36a83-goog

