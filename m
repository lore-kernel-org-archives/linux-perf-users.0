Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700152;
	b=C5vR4LjF1BOCh8XkHjR6yK6rcETN/LMOlJ3W/PW8/xTvdJ79JpmgoVqHG03jmmAGRz+o
	 Ymcc/Lzvz5+BIrScX3zJq7H4lqI1mqwtBW9nKZNQ3R8ADxEE4Nmp+1FBddFoHyKwmWubY
	 ezALWizo0JpYOHmvwPU9fvKlcT14J9Bg6mEzkCIwH2UrKBXitdxouyiP11QTiQtObbfZT
	 nQJfMz1N3sWrcVJhT5eUxXup+66cQ7wK++y24HH+sphPwK0JP647ohs+56FJESo873//Z
	 To4sHj0+xdHa62+qvjwpEl6S93eiZP1daOMnN050Zfwm/jmcqmgEjQd/zgOfIqV++Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+PvHupV3LdkjeIjfKKzL+b+1QpW53jwZ/f1wz3405lQ=;
	b=PApV4wn1P3RDX66IrLXQ3O3gT/uFRnqdJVwrPEkFrkkJMn1YTt1UJI/uQWqwaxl40xca
	 pat5pro3uCjEe/hWc5lTZY9TjldPTw9qodWoBi/wCDiw+J+ZLuznQdcrdeZsYgTa8qX/t
	 I96azer0y8ao4gcNpqfPaMCvYG3rZpZynoDREX588cdir/Xt7iL3htmG2h63yGtCqGS1Y
	 hrFbzLie1Yel7svqKNMUTXJadJsg49r05lM/K5UGMAesxqFNLPI5Nj3HDQKg5h8XF8746
	 TGkCgDjfBDeJ+afZC1EblUtws/IELfSjoji6ccKpqNipInjIy/TnJIA6YkEreSugg1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IT1ZFevN;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611360A5BC3
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D611360A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IT1ZFevN
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c902e0da2so1526634eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700151; x=1793304951; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PvHupV3LdkjeIjfKKzL+b+1QpW53jwZ/f1wz3405lQ=;
        b=IT1ZFevN5aCyRr+5OVW2r0TwYDoqpvE9JGPZ4YaB4ejsemzg4VobYGf/qVE918zOPy
         nvjD0fiU40SM/fCV48lyplJyq92Oxb+X3PDv8qhyJn8FTDaGzYk0+TONl7DP2eBfompL
         ENqmCBJHYYn7WN7bCkx7LMSgK6E6TMBS8nnkT0F4uNW6jLuwoGIo4H2Ke8Oc9FPUjHSG
         zj7KK2EQOBxlvK6O6wKvFghv6bL/qWWy56cADszmoW/o52i1tdMQCpzsVHVpbzvSf31t
         JTMsmir5RrtpziyZlb9ZzQq0+9LsiQJmt5R3tAgsPrcUa5Yhomxq6Hd4xTg+Jm2niGsh
         ZGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700151; x=1793304951;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PvHupV3LdkjeIjfKKzL+b+1QpW53jwZ/f1wz3405lQ=;
        b=cdCSEZ+FQVy8rrkczlgd6sDRlYGaOB/Tp7kZWtWfp7IGSJUivyZP6tetkOUGfnpoNC
         zYknqRx+kFh16BxlPaIVNcqrAFIJQhdEwSr2CaRO/t9IfTEGJL/E1gYhaMg2jFZ4GBVN
         alCf1fmPduEjg2PiAMrM7jMaJ/IIftkEYdfu3cJurGLKdSvjJ73sc3wdyCgxcRdKRLdO
         WYRLMevAq2t/Zqc9h4sXy1d6UOcgfFNhbHLhBDSTxG9e5zEGGnDNrZd9tupxOJY1u/nn
         QroUB7eAf143j82LcEmnfb+sNAEimhyCDG2IudOJAqOXj73AnhanNF4G/8TXt4FctRbM
         XXmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLknE5BnI+ZB5blE5ucJYvszw1P4j+czBwzUH3vBBhZq2GvJ6phpntDQ/83E/QZEM9ZUcnmjXLVyjfLrVvqbDE@vger.kernel.org
X-Gm-Message-State: AFq9FYJeNPmGfvTy3njD34uzNnotjWEytlv65eOgLd6S2DwHP+Te+Ckm
	KF2WCuv+q9QvzEOmfp05PnXyiKVkt+JjMmMe+mmyaIYjSBeLu7JftES5qbiFzS5xsYKF4BciDyG
	RK0NX8PzuQQ==
X-Received: from dlboz1.prod.google.com ([2002:a05:7022:1301:b0:164:47f8:a96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f0d:b0:15c:a04c:cd4f
 with SMTP id a92af1059eb24-195904b1191mr464491c88.0.1792700150451; Thu, 22
 Oct 2026 13:15:50 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:49 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-17-irogers@google.com>
Subject: [PATCH v8 16/19] perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Replace tpebs_mtx_get() and its pthread_once() initialization helper
tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
control_fd and ack_fd.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 79 ++++++++++++++---------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 47c939fc2058..1812917bfb85 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -38,11 +38,11 @@
 
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
@@ -59,23 +59,8 @@ struct tpebs_retire_lat {
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
@@ -205,19 +190,19 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
@@ -227,7 +212,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 */
 	t->last = sample->weight3;
 	update_stats(&t->stats, sample->weight3);
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 	return 0;
 }
 
@@ -257,7 +242,7 @@ static void *__sample_reader(void *arg)
 	return NULL;
 }
 
-static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
+static int tpebs_send_record_cmd(const char *msg) __must_hold(&tpebs_mtx)
 {
 	struct pollfd pollfd = { .events = POLLIN, };
 	int ret, len, retries = 0;
@@ -271,7 +256,7 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 	 * Let go of the lock while sending/receiving as blocking can starve the
 	 * sample reading thread.
 	 */
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	/* Send perf record command.*/
 	len = strlen(msg);
@@ -327,14 +312,14 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
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
 
@@ -355,9 +340,9 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 		 */
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
@@ -493,20 +478,20 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
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
@@ -541,9 +526,9 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -553,17 +538,17 @@ int evsel__tpebs_open(struct evsel *evsel)
 
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
@@ -618,9 +603,9 @@ int evsel__tpebs_open(struct evsel *evsel)
 				if (started_thread) {
 					pthread_t reader_thread = tpebs_reader_thread;
 
-					mutex_unlock(tpebs_mtx_get());
+					mutex_unlock(&tpebs_mtx);
 					pthread_join(reader_thread, NULL);
-					mutex_lock(tpebs_mtx_get());
+					mutex_lock(&tpebs_mtx);
 				}
 				tpebs_cmd.pid = actual_pid;
 				finish_command(&tpebs_cmd);
@@ -649,7 +634,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			}
 		}
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 	return ret;
 }
 
@@ -669,7 +654,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	t = tpebs_retire_lat__find(evsel);
 	/*
 	 * If reading the first tpebs result, send a ping to the record
@@ -678,10 +663,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -720,7 +705,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			break;
 		}
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 
 	if (old_count) {
 		count->val = old_count->val + val;
@@ -745,7 +730,7 @@ void evsel__tpebs_close(struct evsel *evsel)
 {
 	struct tpebs_retire_lat *t;
 
-	mutex_lock(tpebs_mtx_get());
+	mutex_lock(&tpebs_mtx);
 	t = tpebs_retire_lat__find(evsel);
 	if (t) {
 		list_del_init(&t->nd);
@@ -754,5 +739,5 @@ void evsel__tpebs_close(struct evsel *evsel)
 		if (list_empty(&tpebs_results))
 			tpebs_stop();
 	}
-	mutex_unlock(tpebs_mtx_get());
+	mutex_unlock(&tpebs_mtx);
 }
-- 
2.56.0.307.g5fe7bd680c-goog

