Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2A57F74C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171919; cv=none; b=gEIKQL5mIdbwL7wZshV14NIkR5phkLbPBeWuHCrOuxHjxt82voemZuvQzyZcV9KyAUPKPEkrRIX+nNKsvQQ1LiUWVzVTWDVl/JGStsUyaFomyyFDZ1Vwbr7UzML1vhZQB3sCJq/kXmm7zc2AeTvUADBxzmvl3tgS4fI6HqIqn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171919; c=relaxed/simple;
	bh=JhUWynhIEZWiLWjQpGn0ld49QveimZB7k1DTXPYl0Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Htp8CAlPO2/hxkzqwfWC9QsVYHhZQo9IOmKqLUt5LfyZp9ZoRypdBLtkRdFprdEdfWDTw3+d6QI7MlPSiWFGg77VBXrY4znE1Ph0xMd2u8e1YGj4pfXxEQWRvZ6zjg6HH1ksZ1vcos97fW5vWoOaz78GTsT0k66O3qqSP0TT1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bM+GR5ev; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bM+GR5ev"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3592749a017so158980eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171916; x=1792776716; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60QbVpuGydrNDKWPP4KASVAU2WPfOezgWPH2lNk+OJs=;
        b=bM+GR5evEZz3tqNuD16raf556Ej9PZCMQXdSP9KV0G9Q3ktwuEMSlG/OIW187GzgSa
         r3U8VZ/qPYsZfBcC7sSACo/94qiuS6D7e6RhjMOetRE1KOVTRnhHA7/H5UKykfkQ0Evn
         PNUbFfIast20V1QcAvc6r0XcE5vwJTNC9kcV5amgOB+MJO6BzCJzq4tyD8lKmW/w1R0W
         NdQytY3dESRNJvxRjYLI+VLNtYM35xHCTr/pW18Rfek8M6TZSqCL9lOKliTxLDe9c/9S
         +u+D1w/jPDt6WjYdn8PDvwdQSSY+Ae3kJO0WsA16Ns5CogcaV20T2IhYJz8kJaNOBz6F
         TA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171916; x=1792776716;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60QbVpuGydrNDKWPP4KASVAU2WPfOezgWPH2lNk+OJs=;
        b=ebsVoUjoNMPqnzo6TfQcdQj1se+znPJxJRYPjf0hkKTOipifus4nzxv54N/6n06Ijs
         m7H0tSF5gWhZvpq+TAOaSUXMpvW9Itd4anlWNc/0B8gwQxGfxdASDAZv6CfFvh1SSdmi
         2Q2frumfGlxo986Esqex5aKe4bkO5mFamCT+9Bgl0aeIoYYQ7aonqXZVLTGij69sWePZ
         04ILllv86UpUkOkBLMJI5pe7NcUNQiJtaVwKb9XrvDHtD4QpZzXl1dvenrrGYkpUXNm3
         n20HLj5F2wMjFaw9tRh+FIVGNBHIhTVY4B6Ms3UU4YoI8RbD37MYM00pWe2sJwtCMXK7
         YNrw==
X-Forwarded-Encrypted: i=1; AKwUvByyZJf9TF18Himg5NU6kBY7szdcSFzBzkSSrIB5RX0swZ2+ZZujy1WifEIGnWK3UaJ5ELks1o1rGWx262faY+Va@vger.kernel.org
X-Gm-Message-State: AFq9FYIdER2XC9zdd2ofXKHLKNKn8zL+r3O/f+MR17UhF+yPJIbuPgjJ
	1qiF6wgbzkCOWSnuMOdF1IZRMI4ldaBVZCqnyYfB6w96lfb6q6q1dlT+N1yzJwpPVtuLCZydnEa
	HXWsoIBKrqw==
X-Received: from dyz21.prod.google.com ([2002:a05:693c:4095:b0:351:4806:4ae4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fc09:b0:357:ee3a:267a
 with SMTP id 5a478bee46e88-3619ed152d7mr486641eec.2.1792171915593; Fri, 16
 Oct 2026 10:31:55 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:31:03 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-15-irogers@google.com>
Subject: [PATCH v3 14/17] perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Replace tpebs_mtx_get() and its pthread_once() initialization helper
tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
control_fd and ack_fd.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 75 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index b81831f5e5a4..57e08476a13d 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -36,11 +36,11 @@
 
 bool tpebs_recording;
 enum tpebs_mode tpebs_mode;
+static DEFINE_MUTEX(tpebs_mtx);
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
-static int control_fd[2], ack_fd[2];
-static struct mutex tpebs_mtx;
+static int control_fd[2] = { -1, -1 }, ack_fd[2] = { -1, -1 };
 static bool tpebs_stopping;
 
 struct tpebs_retire_lat {
@@ -57,23 +57,8 @@ struct tpebs_retire_lat {
 	bool started;
 };
 
-static void tpebs_init(void)
-{
-	mutex_init(&tpebs_mtx);
-	control_fd[0] = control_fd[1] = -1;
-	ack_fd[0] = ack_fd[1] = -1;
-}
-
-static struct mutex *tpebs_mtx_get(void)
-{
-	static pthread_once_t tpebs_once = PTHREAD_ONCE_INIT;
-
-	pthread_once(&tpebs_once, tpebs_init);
-	return &tpebs_mtx;
-}
-
 static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
-	__must_hold(tpebs_mtx_get());
+	__must_hold(&tpebs_mtx);
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 {
@@ -200,19 +185,19 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 {
 	struct tpebs_retire_lat *t;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	if (tpebs_cmd.pid == 0) {
 		/* Record has terminated. */
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return 0;
 	}
 	t = tpebs_retire_lat__find(sample->evsel);
 	if (!t) {
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return -EINVAL;
 	}
 	if (should_ignore_sample(sample, t)) {
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return 0;
 	}
 	/*
@@ -222,7 +207,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 */
 	t->last = sample->weight3;
 	update_stats(&t->stats, sample->weight3);
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 	return 0;
 }
 
@@ -252,7 +237,7 @@ static void *__sample_reader(void *arg)
 	return NULL;
 }
 
-static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
+static int tpebs_send_record_cmd(const char *msg) __must_hold(&tpebs_mtx)
 {
 	struct pollfd pollfd = { .events = POLLIN, };
 	int ret, len, retries = 0;
@@ -266,7 +251,7 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 	 * Let go of the lock while sending/receiving as blocking can starve the
 	 * sample reading thread.
 	 */
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	/* Send perf record command.*/
 	len = strlen(msg);
@@ -322,14 +307,14 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 		pr_err("tpebs: perf record control ack failed\n");
 out:
 	/* Re-take lock as expected by caller. */
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	return ret;
 }
 
 /*
  * tpebs_stop - stop the sample data read thread and the perf record process.
  */
-static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
+static int tpebs_stop(void) __must_hold(&tpebs_mtx)
 {
 	int ret = 0;
 
@@ -345,9 +330,9 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
 		tpebs_cmd.pid = 0;
 		reader_thread = tpebs_reader_thread;
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		pthread_join(reader_thread, NULL);
-		mutex_lock(tpebs_mtx_get());
+		mutex_lock(&tpebs_mtx);
 		if (control_fd[0] >= 0) {
 			close(control_fd[0]);
 			control_fd[0] = -1;
@@ -483,20 +468,20 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
 	struct evsel *pos;
 	struct tpebs_retire_lat *tpebs_event;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	tpebs_event = tpebs_retire_lat__find(evsel);
 	if (tpebs_event) {
 		/* evsel, or an identically named one, was already prepared. */
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
 	if (!tpebs_event) {
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return -ENOMEM;
 	}
 	list_add_tail(&tpebs_event->nd, &tpebs_results);
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	/*
 	 * Eagerly prepare all other evsels on the list to try to ensure that by
@@ -530,9 +515,9 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (!tpebs_recording)
 		return 0;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	if (tpebs_stopping) {
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		return -EBUSY;
 	}
 	/* Only start the events once. */
@@ -542,17 +527,17 @@ int evsel__tpebs_open(struct evsel *evsel)
 
 		t = tpebs_retire_lat__find(evsel);
 		valid = t && t->started;
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		/* May fail as the event wasn't started. */
 		return valid ? 0 : -EBUSY;
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	ret = evsel__tpebs_prepare(evsel);
 	if (ret)
 		return ret;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	if (tpebs_stopping || tpebs_cmd.pid != 0) {
 		ret = -EBUSY;
 		goto out;
@@ -624,7 +609,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			}
 		}
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 	return ret;
 }
 
@@ -644,7 +629,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	t = tpebs_retire_lat__find(evsel);
 	/*
 	 * If reading the first tpebs result, send a ping to the record
@@ -653,10 +638,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	 */
 	if (t && &t->nd == tpebs_results.next) {
 		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_PING_TAG);
-		mutex_unlock(tpebs_mtx_get());
+		mutex_unlock(&tpebs_mtx);
 		if (ret)
 			return ret;
-		mutex_lock(tpebs_mtx_get());
+		mutex_lock(&tpebs_mtx);
 	}
 	if (t == NULL || t->stats.n == 0) {
 		/* No sample data, use default. */
@@ -695,7 +680,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			break;
 		}
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	if (old_count) {
 		count->val = old_count->val + val;
@@ -720,7 +705,7 @@ void evsel__tpebs_close(struct evsel *evsel)
 {
 	struct tpebs_retire_lat *t;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	t = tpebs_retire_lat__find(evsel);
 	if (t) {
 		list_del_init(&t->nd);
@@ -729,5 +714,5 @@ void evsel__tpebs_close(struct evsel *evsel)
 		if (list_empty(&tpebs_results))
 			tpebs_stop();
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 }
-- 
2.56.0.212.g129ede20d9-goog

