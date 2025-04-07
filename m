Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67E255E26
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060245; cv=none; b=Jjl6sPI4lJojhtMfyVdYmtwC0IzTzo74yJI2jjvvsfGtMRuBkEaEYGKkc9MqoMf4u2XH4wV11l2pnm7ocuB2lABxjD9sjxq6MFkJB+RKTgvtMngUfLNVyD9vGAnk/bHF15b3dYiSi92GDa2t0UJSOwhZ+5NSsvLArBggYP9wP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060245; c=relaxed/simple;
	bh=rq1T4nW3ptF3rW6w1vwJRYhMU8sLO7lL7UaD2qb6LQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Vkc1iu4M/Wvviu4r3O3CyJ+bwPICQEY0gzsO+EGNRlFl6tWss56/gkLuGjgYJDtirh089l7cUafg4QgS5kxU3ZRC+di9FQp2jxNBtp/0Z7g+g8hgiAqABINIfX8qCla5JE+QVC8e+C1PJuCwtnj2hJotuAXVtr2dmII9FRiMS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRBSk2h5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRBSk2h5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22651aca434so45779975ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060243; x=1744665043; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJnQ6O5jw867vwmHrVw3vRVHN/Cs2sIpYKycpB+54Lg=;
        b=BRBSk2h5r20DMxtP0Lr2/T6YwzCDdShhGmDgyKxv++oiAqJPrDwup3Sgky/INEt1eW
         mdd6lCszoA9mF37LxTDpp7EZLs/OMSGbnh5ItNgyY+RUgKMwx9bMjjno9uluBP7GMUcC
         bn8cPQuta0XzHWOEgDUUO3J9dsTBoporB+tYLgDWGH7LlVhYg8w/RB2D9nYOLKYLy0p5
         bRCkAsrWGij6W90S8CunwhTF6DU2yjMuqs4L0lDUvHNzJ7WO4/boqiXELWJx5MqZDnFs
         QDEFXdRx1ymK8pAyOFNkmw7w7/pcU2gTwIoa+DMbaFy5Ao1IeSMbvbzhgjJ0MZKW780D
         ui5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060243; x=1744665043;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJnQ6O5jw867vwmHrVw3vRVHN/Cs2sIpYKycpB+54Lg=;
        b=EQrXtwMt6acn/FxUpLQRGtF7cZuk8Ub29lNN4n03XeMA7wochlDvfDKp+H/t7trJll
         x9pAWGbcFKzY8QqSGrYX8RjJg2lQ83+wPHWOgadG+ZhFHtntrq4a55jyARf2n99EYXxz
         ZYdBA7UJYBSAlL4VFW3m2laBd7bhNvao0ZjifJpafszXz7mAYlA1lEVLxX2FFTCEnLuF
         F78FDLHnoZ5HdJ9YgADIKZCZwXBCI5rJeYLMkNdzZVEjh07v4WpGLMedzOX6cA6mvKWt
         8E/RJVup71PnJnVQCBficYQEvfMQ4yzsLzqia483FKZyUu7ispJ2C7XQbqxvKojX/81K
         WvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiO1JjCNgJhCz5tNy0dEeCDmeY5voHhpfT6ws8paVTEwfcIjOeMrIkyx3JXFb9LN29gMUL1OkuIu2qS7hTrzHz@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdoJAxo2j4fwEiM2E2VaIa+c3vksyNTedStgCCeZCDwFTVIHk
	QKIbExFgP3R+tnZICree7xamUMpAWJfZyhhKIdubvgSzOtb2KwlmonVI0XLdTFoW7hWV72eTS5L
	7wqCxJA==
X-Google-Smtp-Source: AGHT+IF7wpA5PTmDJWkY01tJDs4bCuELZ2QAFndIAgA6tC6ZVYoDHGmaTRvHKZX40caPWaNJLBkaMZ9nn5ne
X-Received: from plbjf14.prod.google.com ([2002:a17:903:268e:b0:227:e4a6:fc21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e805:b0:223:4bd6:3863
 with SMTP id d9443c01a7336-22a8a85a489mr177565295ad.10.1744060243436; Mon, 07
 Apr 2025 14:10:43 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:33 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-13-irogers@google.com>
Subject: [PATCH v3 12/16] perf intel-tpebs: Don't close record on read
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

Factor sending record control fd code into its own function. Rather
than killing the record process send it a ping when reading. Timeouts
were witnessed if done too frequently, so only ping for the first
tpebs events. Don't kill the record command send it a stop command. As
close isn't reliably called also close on evsel__exit. Add extra
checks on the record being terminated to avoid warnings. Adjust the
locking as needed and incorporate extra -Wthread-safety checks. Check
to do six 500ms poll timeouts when sending commands, rather than the
larger 3000ms, to allow the record process terminating to be better
witnessed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       |   2 +
 tools/perf/util/intel-tpebs.c | 205 +++++++++++++++++++++-------------
 2 files changed, 132 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1d343f51225b..661a07cbdb25 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1656,6 +1656,8 @@ void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
+	if (evsel__is_retire_lat(evsel))
+		evsel__tpebs_close(evsel);
 	bpf_counter__destroy(evsel);
 	perf_bpf_filter__destroy(evsel);
 	evsel__free_counts(evsel);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index c5ccdbc42dc6..a9446e7a1c5c 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -33,6 +33,7 @@ bool tpebs_recording;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
+static int control_fd[2], ack_fd[2];
 static struct mutex tpebs_mtx;
 
 struct tpebs_retire_lat {
@@ -51,8 +52,6 @@ struct tpebs_retire_lat {
 	bool started;
 };
 
-static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
-
 static void tpebs_mtx_init(void)
 {
 	mutex_init(&tpebs_mtx);
@@ -66,7 +65,10 @@ static struct mutex *tpebs_mtx_get(void)
 	return &tpebs_mtx;
 }
 
-static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
+static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
+	EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get());
+
+static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 {
 	const char **record_argv;
 	int tpebs_event_size = 0, i = 0, ret;
@@ -74,15 +76,13 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	char cpumap_buf[50];
 	struct tpebs_retire_lat *t;
 
-	mutex_lock(tpebs_mtx_get());
 	list_for_each_entry(t, &tpebs_results, nd)
 		tpebs_event_size++;
 
 	record_argv = malloc((10 + 2 * tpebs_event_size) * sizeof(*record_argv));
-	if (!record_argv) {
-		mutex_unlock(tpebs_mtx_get());
+	if (!record_argv)
 		return -ENOMEM;
-	}
+
 	record_argv[i++] = "perf";
 	record_argv[i++] = "record";
 	record_argv[i++] = "-W";
@@ -118,7 +118,6 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
 
-	mutex_unlock(tpebs_mtx_get());
 	return ret;
 }
 
@@ -131,6 +130,11 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct tpebs_retire_lat *t;
 
 	mutex_lock(tpebs_mtx_get());
+	if (tpebs_cmd.pid == 0) {
+		/* Record has terminated. */
+		mutex_unlock(tpebs_mtx_get());
+		return 0;
+	}
 	t = tpebs_retire_lat__find(evsel);
 	if (!t) {
 		mutex_unlock(tpebs_mtx_get());
@@ -180,17 +184,98 @@ static void *__sample_reader(void *arg __maybe_unused)
 	return NULL;
 }
 
+static int tpebs_send_record_cmd(const char *msg) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
+{
+	struct pollfd pollfd = { .events = POLLIN, };
+	int ret, len, retries = 0;
+	char ack_buf[8];
+
+	/* Check if the command exited before the send, done with the lock held. */
+	if (tpebs_cmd.pid == 0)
+		return 0;
+
+	/*
+	 * Let go of the lock while sending/receiving as blocking can starve the
+	 * sample reading thread.
+	 */
+	mutex_unlock(tpebs_mtx_get());
+
+	/* Send perf record command.*/
+	len = strlen(msg);
+	ret = write(control_fd[1], msg, len);
+	if (ret != len) {
+		pr_err("perf record control write control message '%s' failed\n", msg);
+		ret = -EPIPE;
+		goto out;
+	}
+
+	if (!strcmp(msg, EVLIST_CTL_CMD_STOP_TAG)) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Wait for an ack. */
+	pollfd.fd = ack_fd[0];
+
+	/*
+	 * We need this poll to ensure the ack_fd PIPE will not hang
+	 * when perf record failed for any reason. The timeout value
+	 * 3000ms is an empirical selection.
+	 */
+again:
+	if (!poll(&pollfd, 1, 500)) {
+		if (check_if_command_finished(&tpebs_cmd)) {
+			ret = 0;
+			goto out;
+		}
+
+		if (retries++ < 6)
+			goto again;
+		pr_err("tpebs failed: perf record ack timeout for '%s'\n", msg);
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (!(pollfd.revents & POLLIN)) {
+		if (check_if_command_finished(&tpebs_cmd)) {
+			ret = 0;
+			goto out;
+		}
+
+		pr_err("tpebs failed: did not received an ack for '%s'\n", msg);
+		ret = -EPIPE;
+		goto out;
+	}
+
+	ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
+	if (ret > 0)
+		ret = strcmp(ack_buf, EVLIST_CTL_CMD_ACK_TAG);
+	else
+		pr_err("tpebs: perf record control ack failed\n");
+out:
+	/* Re-take lock as expected by caller. */
+	mutex_lock(tpebs_mtx_get());
+	return ret;
+}
+
 /*
  * tpebs_stop - stop the sample data read thread and the perf record process.
  */
-static int tpebs_stop(void)
+static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
 {
 	int ret = 0;
 
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
-		kill(tpebs_cmd.pid, SIGTERM);
+		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
+		tpebs_cmd.pid = 0;
+		mutex_unlock(tpebs_mtx_get());
 		pthread_join(tpebs_reader_thread, NULL);
+		mutex_lock(tpebs_mtx_get());
+		close(control_fd[0]);
+		close(control_fd[1]);
+		close(ack_fd[0]);
+		close(ack_fd[1]);
 		close(tpebs_cmd.out);
 		ret = finish_command(&tpebs_cmd);
 		tpebs_cmd.pid = 0;
@@ -313,9 +398,10 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
 		return 0;
 	}
 	tpebs_event = tpebs_retire_lat__new(evsel);
-	if (!tpebs_event)
+	if (!tpebs_event) {
+		mutex_unlock(tpebs_mtx_get());
 		return -ENOMEM;
-
+	}
 	list_add_tail(&tpebs_event->nd, &tpebs_results);
 	mutex_unlock(tpebs_mtx_get());
 
@@ -351,13 +437,15 @@ int evsel__tpebs_open(struct evsel *evsel)
 		return 0;
 	/* Only start the events once. */
 	if (tpebs_cmd.pid != 0) {
-		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
+		struct tpebs_retire_lat *t;
+		bool valid;
 
-		if (!t || !t->started) {
-			/* Fail, as the event wasn't started. */
-			return -EBUSY;
-		}
-		return 0;
+		mutex_lock(tpebs_mtx_get());
+		t = tpebs_retire_lat__find(evsel);
+		valid = t && t->started;
+		mutex_unlock(tpebs_mtx_get());
+		/* May fail as the event wasn't started. */
+		return valid ? 0 : -EBUSY;
 	}
 
 	ret = evsel__tpebs_prepare(evsel);
@@ -366,12 +454,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 
 	mutex_lock(tpebs_mtx_get());
 	tpebs_empty = list_empty(&tpebs_results);
-	mutex_unlock(tpebs_mtx_get());
 	if (!tpebs_empty) {
-		struct pollfd pollfd = { .events = POLLIN, };
-		int control_fd[2], ack_fd[2], len;
-		char ack_buf[8];
-
 		/*Create control and ack fd for --control*/
 		if (pipe(control_fd) < 0) {
 			pr_err("tpebs: Failed to create control fifo");
@@ -384,7 +467,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
-		ret = evsel__tpebs_start_perf_record(evsel, control_fd, ack_fd);
+		ret = evsel__tpebs_start_perf_record(evsel);
 		if (ret)
 			goto out;
 
@@ -396,53 +479,16 @@ int evsel__tpebs_open(struct evsel *evsel)
 			ret = -1;
 			goto out;
 		}
-		/* Wait for perf record initialization.*/
-		len = strlen(EVLIST_CTL_CMD_ENABLE_TAG);
-		ret = write(control_fd[1], EVLIST_CTL_CMD_ENABLE_TAG, len);
-		if (ret != len) {
-			pr_err("perf record control write control message failed\n");
-			goto out;
-		}
-
-		/* wait for an ack */
-		pollfd.fd = ack_fd[0];
-
-		/*
-		 * We need this poll to ensure the ack_fd PIPE will not hang
-		 * when perf record failed for any reason. The timeout value
-		 * 3000ms is an empirical selection.
-		 */
-		if (!poll(&pollfd, 1, 3000)) {
-			pr_err("tpebs failed: perf record ack timeout\n");
-			ret = -1;
-			goto out;
-		}
-
-		if (!(pollfd.revents & POLLIN)) {
-			pr_err("tpebs failed: did not received an ack\n");
-			ret = -1;
-			goto out;
-		}
-
-		ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
-		if (ret > 0)
-			ret = strcmp(ack_buf, EVLIST_CTL_CMD_ACK_TAG);
-		else {
-			pr_err("tpebs: perf record control ack failed\n");
-			goto out;
-		}
-out:
-		close(control_fd[0]);
-		close(control_fd[1]);
-		close(ack_fd[0]);
-		close(ack_fd[1]);
+		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
 	}
+out:
 	if (ret) {
 		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
 
 		list_del_init(&t->nd);
 		tpebs_retire_lat__delete(t);
 	}
+	mutex_unlock(tpebs_mtx_get());
 	return ret;
 }
 
@@ -451,6 +497,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	struct perf_counts_values *count, *old_count = NULL;
 	struct tpebs_retire_lat *t;
 	uint64_t val;
+	int ret;
 
 	/* Only set retire_latency value to the first CPU and thread. */
 	if (cpu_map_idx != 0 || thread != 0)
@@ -461,14 +508,20 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	/*
-	 * Need to stop the forked record to ensure get sampled data from the
-	 * PIPE to process and get non-zero retire_lat value for hybrid.
-	 */
-	tpebs_stop();
-
 	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
+	/*
+	 * If reading the first tpebs result, send a ping to the record
+	 * process. Allow the sample reader a chance to read by releasing and
+	 * reacquiring the lock.
+	 */
+	if (&t->nd == tpebs_results.next) {
+		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_PING_TAG);
+		mutex_unlock(tpebs_mtx_get());
+		if (ret)
+			return ret;
+		mutex_lock(tpebs_mtx_get());
+	}
 	val = rint(t->val);
 	mutex_unlock(tpebs_mtx_get());
 
@@ -497,10 +550,12 @@ void evsel__tpebs_close(struct evsel *evsel)
 
 	mutex_lock(tpebs_mtx_get());
 	t = tpebs_retire_lat__find(evsel);
-	list_del_init(&t->nd);
-	tpebs_retire_lat__delete(t);
-	mutex_unlock(tpebs_mtx_get());
+	if (t) {
+		list_del_init(&t->nd);
+		tpebs_retire_lat__delete(t);
 
-	if (list_empty(&tpebs_results))
-		tpebs_stop();
+		if (list_empty(&tpebs_results))
+			tpebs_stop();
+	}
+	mutex_unlock(tpebs_mtx_get());
 }
-- 
2.49.0.504.g3bcea36a83-goog

