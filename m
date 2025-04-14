Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D428F528
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652536; cv=none; b=HpFeiy5hf183UOD+Fng+unGbBgHSNddlqBJq7xnWkdpSx+WkzUEbqoBPbSsUqT0sBckyFnh7qMwKFIwyQq6i39rrlVw50V76E7OMgIcCl9NLtfz1Aw2nGOKMaPKukTOtVc5I6QKE6mgkGRuUmq0Kgo/z38rEt/WH/djr7EJ6x9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652536; c=relaxed/simple;
	bh=Ardu5Zto369kK4zW/dNPurCFIiVTURm10s2RGR0ve7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PLoTgz7qARZToUOSx7fS5obrbgD5FLAP5EcgiB4awuo4NxHIKU4cQS/dH4EBbR58ixkt6ma/hnjM3tPwqOUI/gD3fEBVhZDVn/ww3wA1OyeieuiRkdl2K0iStvaswCcdcvIXdQzgLs+BU4lTNp/KfxxDh+yGKcGK2SeHdPz596U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUOdqRMl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUOdqRMl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so33862265ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652533; x=1745257333; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWCJjFZOu/EVf/VdW/8Vm5rWlieUQQLXgc9oCiiDvVY=;
        b=OUOdqRMlMhqtd2V+QMPRXUNGPqR9Ypw/7xAD/fMQJL865ECPLnxv0UQQTNn8ALynfg
         k0yx1L8b7lSgou9D1UbOZMc/7vxloUCAvbb9N4IFBwOK7yvhIeqdxyPV0NOLzX711+V7
         R15DtRmd6mA/TCLV9pSpbudVJkX+T0djLSBvid3SsVt1hIwMHgY4TXQwxqhAVMgnuAgc
         4ymZCMvlqKuIswfj/4NjBHa+/ZyOGfQsVzS/rjDpNqj7quUt46bza8LM5/G7x0prlUxl
         DoJLqksfQ7GMTImqDbflSgzNC8y2YTKQ+ietwnOLmyVkLwWmVVKvAxntk6iewqHwdQKW
         h91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652533; x=1745257333;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWCJjFZOu/EVf/VdW/8Vm5rWlieUQQLXgc9oCiiDvVY=;
        b=arq2fSfxIUYqfUw4vw2oipfuSMPR4AdvgHj6vn096yCXmDqru/dzE17DEUEW5q2bKR
         aS/39GNd+E2NxUORyT879/JScQMYSNepKULyEVFteOPzKd5epfCg94CL3AwwW7rHL5ju
         E3Yw4DUtifCCfR8k42/nFC7lyEWq2R4DHYkJefnW7KVQzqPBnlMywDO/sDb344z7rzEE
         FzbyO/ypWhve0mW3pUfs6vmgtx3JDyt31rruRxrOUdHtzURDq8Ur90Mtb4kesVxSYd4t
         zdNSnjFB96GXgppA7BTyfTq7/o7r9vrIo7JT6mwoyHW0qojytt8wgVFIk/tARgrSCaCF
         6Wug==
X-Forwarded-Encrypted: i=1; AJvYcCWSXO7fSK9h9Wj/1RVwnMX0/u3hYDH33i16+rV7svBbdU/tc09KO8Y0PI2L7b+OFbPgHCWNnYt33ztQPMGb65CU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vZDrfKZ2B/BCo7PFcUcBpRKiH9Mef8uqGDiWFzhuL3K64Sta
	MoxMo0Q09ZSecwKAj1mK1s2chV9meJFO1nn4HaZgsufbDn88Pzsakqw9StSPvyDfG/nnS56mRFx
	ij7tmGA==
X-Google-Smtp-Source: AGHT+IG8dNrboCUfG+ZW8OqTLUhYiuQzZKuXDCNhKV/lf7U+k/W/b7E1OBBuHlvpn6ZP9CZcdt6kK0X9ke97
X-Received: from plhb12.prod.google.com ([2002:a17:903:228c:b0:223:5739:92d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:daca:b0:223:5e6a:57ab
 with SMTP id d9443c01a7336-22bea4efe4dmr194271195ad.39.1744652533627; Mon, 14
 Apr 2025 10:42:13 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:27 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-10-irogers@google.com>
Subject: [PATCH v5 09/16] perf intel-tpebs: Refactor tpebs_results list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
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
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

