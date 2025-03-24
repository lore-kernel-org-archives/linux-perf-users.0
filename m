Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D41F3BAE
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855715; cv=none; b=Rl5tN84aPn+5AEkV3gipdMp56GZNHosngMlfHIVGFss7gOB70yVb6D/zx5ZHHKN7g07TEzsPBaihJrAWmYzS1DeJgiBPujWdEkXRze2bRUUMqYKq9G5i+5Sipq+w1RFkop19TvW60n/G1m/stNjFHzepw8XdlI6B1DFxt0RMYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855715; c=relaxed/simple;
	bh=NOwsl0wEuL5koR3NXHep7k7Xz0LqWmUdBTPVtZ/ePi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NnXr8Tfqg0z70vzX0oc0pwimPaQIE5O3xPDDZzaYfxxfgW5cUjT2Ik7eAs2sMnG/k7B83q5mQqJuKB0r7EML3wRn7fRpzGf7nQ8W5mHYAZ2IA5DsKt5kAt7EmlFujoalPYEiHvTOwQ4Qvr/HoW6wEV/HylDF32ic9Eyia0DZ0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7VTGG4b; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7VTGG4b"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso74880115ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855713; x=1743460513; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG9Nmmv36pxRcjjEqaCPf9FJZsaOcmEhpQ4zx8j/rkI=;
        b=Q7VTGG4bNM1ImOXBVkZvdFX4F4gUmNDX1777FSNDRaAdKHshQSnEf/Y+4RgwgcqWi6
         i1xy4LEvaMzYQjOn9YMzZb4VRySx4FmnT5CsOop7z3AhFZEOrhRyY4N9wFRoRT+boi2D
         Q+uuliqDoFQQstXCY7pQGPb+mFmKTvxq9r3aAgq/Smci6+gwmmzkKeLrMoO99x4w8erk
         702yFgJA6vCSGTGWVj3s6PIxUesqaAR2EQty//kZuzUdCShwX6cURcUUHM3pR4wMby3D
         fLfDPbIpBkbOBLMoH/khBp6xMcn5rLkzc+uT64x1RbTGs/yCvM0ddzrf/D0uV/h9Ma/d
         OWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855713; x=1743460513;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xG9Nmmv36pxRcjjEqaCPf9FJZsaOcmEhpQ4zx8j/rkI=;
        b=I6WKS08mUSE6nSZnApXP1DV4tji+iKq/kOZYYMBxIXmrLV4NI+z5LHb+fVLTU+Q/OT
         yHatmTl6btnyCSoRD6OKZS92gKU4uYAY+/fvlrtYDp8UbLLeYMI7UZwVVdu6gBrKLoRC
         cA0U1o/fzz0ZDXabL/gJvh/xMvZe1N51vyb1tcsqtkNBiXo1TxIOR63grkLl0TZ9rUch
         FgLA6AgKLQH8MxusJVb+NtrtRlkj2QFLeacFdWCV18c4js4ACc6KdoeB1HVsTY/dFH81
         ySRMNhplN0gqtA2V9nm07Z1HEUdsRGxWIdVHz3pst26LMEBRVFvNrmfAdY4LYMZNvI3l
         /ccA==
X-Forwarded-Encrypted: i=1; AJvYcCW7tHdv9TnKISOV61yeM7yemxb9EIW7GA8tNzMq5nSmkilgx5KaWG9vO2RLtAeSNJ9w3PgYIa8m3ai38NgGkMdP@vger.kernel.org
X-Gm-Message-State: AOJu0Yypry410qQORy9aO2yCAFeve4BGIen/6omsACMIkEl6HFSy8qrc
	1XCC+nS0WomPX3cSNWcrDPNqHOkPscdL872N1k79VAJJwndFOyXcHS8IJPDlGREG6TlYdIRXxXZ
	5nmnplg==
X-Google-Smtp-Source: AGHT+IEF9FZXzvHy0V0vOJKqofApvJzXbXsG6N9/WfJN4q/K2ePlAkMljkL6PeMHdQ9rJKW/Yt82ONv5kZRR
X-Received: from pffk14.prod.google.com ([2002:aa7:88ce:0:b0:730:8e17:ed13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce82:b0:223:525b:2a7
 with SMTP id d9443c01a7336-22780d7c73bmr200774775ad.15.1742855712732; Mon, 24
 Mar 2025 15:35:12 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:46 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-9-irogers@google.com>
Subject: [PATCH v1 08/14] perf intel-tpebs: Refactor tpebs_results list
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
 tools/perf/util/intel-tpebs.c | 147 ++++++++++++++++++++--------------
 tools/perf/util/intel-tpebs.h |   4 +-
 5 files changed, 90 insertions(+), 66 deletions(-)

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
index 9116cdc6981e..500c472f7059 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -34,10 +34,10 @@ static struct child_process tpebs_cmd;
 
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
@@ -48,6 +48,8 @@ struct tpebs_retire_lat {
 	bool started;
 };
 
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
+
 static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
@@ -84,7 +86,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 
 	list_for_each_entry(t, &tpebs_results, nd) {
 		record_argv[i++] = "-e";
-		record_argv[i++] = t->name;
+		record_argv[i++] = t->event;
 	}
 	record_argv[i++] = NULL;
 	assert(i == 10 + 2 * tpebs_event_size || i == 8 + 2 * tpebs_event_size);
@@ -107,27 +109,20 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
@@ -182,50 +177,93 @@ static int tpebs_stop(void)
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
-	if (!name)
-		return NULL;
+	if (!*name)
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
+	assert(!strncmp(evsel->name, "tpebs_event_", 12));
+	errno = 0;
+	num = strtoull(evsel->name + 12, NULL, 16);
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
@@ -362,8 +400,12 @@ int evsel__tpebs_open(struct evsel *evsel)
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
 
@@ -413,34 +455,19 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
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
index 88d70bb37971..6ff92f5de9b4 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -11,7 +11,7 @@ struct evsel;
 
 extern bool tpebs_recording;
 int evsel__tpebs_open(struct evsel *evsel);
-void tpebs_delete(void);
+void evsel__tpebs_close(struct evsel *evsel);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #else
@@ -21,7 +21,7 @@ static inline int evsel__tpebs_open(struct evsel *evsel __maybe_unused)
 	return 0;
 }
 
-static inline void tpebs_delete(void) {};
+static inline void evsel__tpebs_close(struct evsel *evsed __maybe_unused) {};
 
 static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
 				int cpu_map_idx  __maybe_unused,
-- 
2.49.0.395.g12beb8f557-goog

