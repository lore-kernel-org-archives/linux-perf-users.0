Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514247;
	b=GWCH2oRrybtpW/25fAaxSzplNbTAEEJzSZlLidsbgEoo5j4i1rvRHyUJAza+V1t3EZvg
	 sT5BBD801gjTk5J4SJX+d9NDoMuXOB9zRmnbIwlDwCLybVJCEW+X1ZvB1UUI/KQBCf22j
	 YEYy6AKd2T002ZjdRst7szt+bm5qZYZzZoid/bvOmIgLl6AclakzpqEdtkp9Sd/07kza3
	 BfO7zwpBKtITii5ac+5txLJ0byOLZIYwY7QUyy/8Wz1MdgE5jgyQc6rgWAyy2+NFSSDWm
	 eFWEHzd1tGDT4joN+aD8ER59z/loudmq1LKQOlomF83zE1tHzRPR48MwoUT0/Q/0wBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dre+hbOKTxf3B5Sh6dXNmqRCROVNAmt0s7WlUHXOWM8=;
	b=vHgKyuOISP23vOKOy1u+vbP4Fy+4E9q4cTT3KlxDbY4LrRpnuRe7a6cB2QrISen+8YlN
	 3XzY5od3/HQcjE8aaEy7bbzNZcuwr0XdTcpDGlRoGRR3fKXEbfV6KRKmBxtWPG4870bYX
	 yAc70byE1JXZw0boVmvDfrvMOD/lFNsPAet8yyQTqlyXVa0R8pyMVniZ/IobYrZIgIUiZ
	 vbRK2OLI5Eanl+oLQJ8P3pbflyR5tEWKVMmtFWgogvnoZc/V/L7stNKOmcrYXMQnnIAaU
	 vRnR4iY8QBOiyyA52gh1dLEisAcagK6A302QtdIBQn54UfoLiSZzdpkYnnCbeZumCgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iInrtfJs;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CD60A5BCC
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D8CD60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iInrtfJs
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so13461848c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514246; x=1793119046; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dre+hbOKTxf3B5Sh6dXNmqRCROVNAmt0s7WlUHXOWM8=;
        b=iInrtfJsW0vSempJ4N6CuVfIumEp2qzaY/FNGe15UV+0IRhOZkp5by8zWvmhMb96Ah
         HE7GKtBr7UA7/AA4BPSt509Y1UkdA95lIcheMkK3FsfWGff1Bblp6tPTjMBE02xSyEe+
         CXNZG1atyjzaiQAc7pt7JUJWiUzmdeXgpZMXhAy0q/7v/fQDv3jaQp2Zcqv2aOcnJSvM
         BFs1o+2rb+09SR8b2M39cPBnGulNgOzTDpAB32RPInlBU+zQM815EkpvVLQHZbNTa9P7
         0cELQhshIo4zQTE8YF3CYKCpGq5kOAKrdqk5B532eMMguXJ/61L28ytLaPujBDVDRaam
         kamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514246; x=1793119046;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dre+hbOKTxf3B5Sh6dXNmqRCROVNAmt0s7WlUHXOWM8=;
        b=mfHYbKwShhnjS9KJq1eah1mJPvN9uFL3lzvViSJ7JYUhWTRA4omZ2rP8NSA06tUU3v
         A96GQZ8H4bOyMiDFh89AB7ZV6P4aCE94Pi5zSvmQQ8WLxwxMep/6CEV4X0C7NE48ZJ6X
         rDBgcvbJCfkGuUViKUvxhdC1EGFNYFL+TG/UqFUCCC4rPAy+6xI0QvYY4HhUZYB3bVmu
         pQcXnR+P3+KLZ/+qlDL6zCyhFduPdnDM34XVXGk/uYpYuJD+/FW6tU4uRxwtyaNO9si3
         nu35Ancs4tWZJ3Qjvgi9A/6Jn3hkOLpDWFecpHLBWRFTJg+sd7FvHcofFB5L43GJ/VNf
         seHg==
X-Forwarded-Encrypted: i=1; AKwUvByXVQBN27ABwd4mcCOU/snNQMtLOwvsX6Oykb961U8Moxs+4fdkQOXAwq78R/ovO5LW2Xm3RdnEHYEfOCniQlOk@vger.kernel.org
X-Gm-Message-State: AFq9FYIOunBsG6coQ1coi/3boveZUzQtcDQYMqx/gAmccFAGJ1iTJWl0
	CSUuz6oR2wAkYLM6brWFpNg8bdRDN9tKHT1feM46cW8U4PURjDUyenOtVN+TQMkYxhcY9dkyw1m
	NJdk9bPM/1A==
X-Received: from dlbur7-n1.prod.google.com ([2002:a05:7022:ea47:10b0:185:5973:326c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea50:b0:184:ad2a:d1fd
 with SMTP id a92af1059eb24-1851434f3a6mr15396560c88.37.1792514245276; Tue, 20
 Oct 2026 09:37:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:37 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-15-irogers@google.com>
Subject: [PATCH v5 14/17] perf intel-tpebs: Use DEFINE_MUTEX for tpebs_mtx
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
2.56.0.212.g129ede20d9-goog

