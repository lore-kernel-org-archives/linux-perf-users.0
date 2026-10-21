Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622400;
	b=vW3Jw5xYPy5fRrUfFQBITnS6/dyRShRuVyJQ5Gb7kAg9cekgccZ1xwUvSJlTY4w7iRa8
	 a9wb9VFPK6S98z8Xiwq3BQKZJQG5a77Lt0o/SZoaevkrn1m+Iu6g4YNyIVKwq5s7f+8sf
	 wMVs5XW87yoj4R0s6Am6WYpv/SOdSljbmLf8JQHlfn/fbxqWKeq0lVjrLg1HecO45/fRc
	 qZnInHHKlpSYPkR2H4Vy7uZj5Twn7C7DgrF2oaT6AWZsXlwb4vsIMvVDN337HkHtlPTdm
	 HAaDAbflFEV0SA7dukdEk5wge4HmNYiWB+P/fwc1Adpyd3fEMQj6zdSjq5pBEFmL+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AfW2tQ9p//QE4PexE38t14gSeESK4xl5GP2nVAO+gUI=;
	b=ezI7ystTPONHQZIpZ/zj+LIInyyRWVcou24GDARsuyAMsvIp0NBfTzj8G2bgOyUxqYaj
	 bPZVUOx4RuTaVNfLrtNbQFMcOouOOHkRvuA3rHUd+NZ2GTz1pBrOOcRCjHAfT7FzpQFuS
	 jPvytr8HMhdK5ahExfS9CzMlTsFNPB8Ds61HfYEci4CWxmF8mKYxfZlQUdssuEnPWRcPf
	 qDyJq3YlFQW6Z5tIeERBfiy082xfbbiJL9sN+/johpRksyYA2INWuX7HK03iEnpO3Sup+
	 K2cWCLeZ3VM/3PdWVOGfBgl7EDTB/XsdLQKd1f39zHnwnbzzqHVky/Ai3r68k7Aq13Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sjBWIvCA;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59675606A338
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59675606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sjBWIvCA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so10118145ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622399; x=1793227199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfW2tQ9p//QE4PexE38t14gSeESK4xl5GP2nVAO+gUI=;
        b=sjBWIvCAYd3EtrR1Ndmgo/Z7FlyJtbCblFu5jE+1e1EDL2IsWaVe3CBos3YzG61Dam
         vI/gOgymGPlB9lawONczvwAmM+jLzsgf6ZvclqioLONNnBEwzaqWI53LOStRoo0k2OeX
         /+CdM2gNicHSCCNdRomWt/gAjQXT3QR5IZrBbeXBn7LoPs6rEZmXgqqkmAWWswmSSw6F
         AUop5L/tBXpBfsmZCqZH41TqviQwVhlpdqsH80mB1+Ac8PrNTvVYvqWRUCswLNmuaiI/
         hXtG4LJKm1wWd5Xrl4Ot8h/Dx4fy7bmrti0oPA1uIJ1WO3FrFOcDz0gp8FrspgDzX/v8
         WAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622399; x=1793227199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AfW2tQ9p//QE4PexE38t14gSeESK4xl5GP2nVAO+gUI=;
        b=JUB+B7D4Zyahups/h7/1Rxn3c4oJ4GguNucRlTc1g46+peloXlQjHRbfo2mu/1Lu0+
         5/2dwbjglVVPC1MOPO38GD7OAj8nkBi5d6OsBTeF0Gw+XaRKykTPN57xOdyAWIKgKl3/
         pypHBqX1Qg/DhXPUN8PySoBDZjeGGwEpHvL5XH8Xfc6+vpUsdLd9wVmmjObEbsyuDwlF
         QccX50ZlsNuWmJLrW7/3EUOuMpg+kpDSs5SsQ2+hv0/N1MRdKScCQFB/s2AuvPQKGG2/
         9oYyEGYcljgys1OFMT5zP1QRJIO/rcvtX2tSqnjTE46rRJ9dqqldEstp+39Mjof/iftV
         d+1A==
X-Forwarded-Encrypted: i=1; AKwUvBwdUlJ2oCFtAyuagN+i0uqnOtsQHmV2+cqRPt+fMwife43HnEbB6Lmubd8iVEMWsMYDxY4T1gIPg+E+yeYGqc2M@vger.kernel.org
X-Gm-Message-State: AFq9FYKe4eoJEhbxpiadPvFfYUNDpgUqB4QTVQ9rJmfp2a+Lr8g+GUVn
	7WmtCvP17Kb3rFa9kRTeyoCCRpzi58Fjq3OudW07qt/hhR2W11ni7IbtnlXG0NCj5FQtl7MYCCB
	FN2zu1cc/dQ==
X-Received: from plbiw23.prod.google.com ([2002:a17:903:457:b0:2e3:1401:6189])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dad0:b0:2e2:df9c:ff71
 with SMTP id d9443c01a7336-2ea43febc52mr26723295ad.49.1792622398528; Wed, 21
 Oct 2026 15:39:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:39:02 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-15-irogers@google.com>
Subject: [PATCH v7 14/17] perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
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
2.56.0.218.g1ec904b173-goog

