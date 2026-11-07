Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026500;
	b=pwRp0qzcTgxWJaOR3DSNQnKYDV0HfRxMkqr4FqXoP/QBE1lhTEHYTsGS2meOd8YAbqby
	 M+cDCRV6zbak1RaPuM7RCWfeF4oq64srqIDqCHFbEwMUXnCqGetJaRaqTyZrblauNW3Hg
	 yAzKL8SVpHO8B2qH8GgM/NNDbMq+J3j1Q8eJobBOpAhWuKd/+NNPKpvOiQKko93hvMZsI
	 5UJNAJAttp1fKRnDDexLaftJRd65+9ZuZiU28fmE/eZhNho+jlhbEDqIdivGLykf2VqI9
	 JiyZYZZ2gLZs+VKqAhRHZOz4MtqO4DFMTFGcbsntfiEz2DS3cjah5VMGlk6nmvNOuZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s4C6VSkUsKcA/XReA8X+gTc8wqynE+fYe31cERcc+sQ=;
	b=i7XO33R7o6ZI/OvVrIhECyqy0/qm/1ifJ8OH4cj3QipK5P3iZJS4jzfCnHISXQzd26bF
	 YSfr+46y+2y5waOysDmytLpLjPdkkjUNSFihytiHYPUvJJgTuxlFDxQ+u676hFXt8qrDD
	 xcC/rgBm5wly0IZBef5eJnP+z9cLmgQiBZFFoY+CI4TfRAGECykKSUU9wbEdeznuZCmbJ
	 YFdSmD6ydaEOHIon4aV86fp3OjZPELbDZ1lsXUdXfvBh+nMAO09z4m0GnohSnKSyQNYG4
	 qDzuGSj19Nj53euNH55PC+GWcSvurvvDmkhZKrKXTV2Eif1LaFC+Brknmms1JV89BRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A69ORkJC;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29394606D830
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29394606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A69ORkJC
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-351788121cfso3372604eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026499; x=1794631299; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4C6VSkUsKcA/XReA8X+gTc8wqynE+fYe31cERcc+sQ=;
        b=A69ORkJCe6CbrLHHfeeQknq9QsRDcXHJAHgi9Xiu7P/1sPvT/MT8Tf+94pv0JyQYIS
         c/SMD3iwQzWGLi12RmroqEv1/1jqzSh8qnxHDnhubDVw+KhDFXnX54IpkuGXP7tSuX1S
         +lRGVyyuhJfHqScuxqAVbYxyaWkIQec/pm6v0IGOmyKG29BMSk27abjNYgL0Clpsh8lK
         bPi3lXshSVydfZ6mAAXNONXz0wJ8Sd2TLZFvfqeiDSBhOquxZAzCttxNhmHfcVBB5s//
         N95embPvw08Q2st8J8FHqeixIyyRf8+NFZsWAt00Mm+79/6tKT07OftU6ojUUyKBgIZF
         ehdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026499; x=1794631299;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4C6VSkUsKcA/XReA8X+gTc8wqynE+fYe31cERcc+sQ=;
        b=FEJv2xNs2NQR8JNRDEdlhJuuSrhJLB5/w7J19dJUcpvc7V4WTv+uU6+ir3jba/C9S4
         hRlfEVAuq7i4iMkVzstZ0b7gn6KAleyCsWX3pi1Eq6scwnFPI20zBKiYzLw50aqnfUSF
         owWdlhGGyDkB/AKfy6r8YRqCkj6q/llGv2lRofKUPJTwNn1XOZwPBzc09WztgdcOn5jq
         uIEk3oj2LuLbFf3vo2zHlG0OuGCUusY1OY+lEumpNZM9mIGc4+v7b3TT2YDR7GANrkrT
         lPnjY+gAkmTmJb0aq9EFtWtxDKvW6OoxKA1D+w1faqFwJJmZuUryd8lFE3kMhASuQrsT
         4fbw==
X-Forwarded-Encrypted: i=1; AL+hErHCp+OjtPzW8EgyVKkAYhiKM7uHQZvhPhSV1zBM6BbXOn7NqE5bdtGp8hNlFmRqlsLOxNslQUpdkaVXCM8mZy2f@vger.kernel.org
X-Gm-Message-State: APuU4Z+Jh0o+HnaV3r3zwLfgvmKT/pB/t+qRC502sjMoJhDc0tiOGszo
	bYQ5rnXQdGuLEv+vPxLrVj7/rmdjtxeK7wY88tpS4vv47tZ/Sdwsr1OZ9CQkVAd1wOpCIbB1TkC
	FLbXK60+G3Q==
X-Received: from dycmb1-n1.prod.google.com ([2002:a05:693c:20c1:10b0:35f:390d:248a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6096:b0:36a:1d6a:596b
 with SMTP id 5a478bee46e88-36f77200d2dmr7725330eec.29.1794026499136; Fri, 06
 Nov 2026 20:41:39 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:56 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-16-irogers@google.com>
Subject: [PATCH v11 15/20] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In tpebs_stop(), read tpebs_reader_thread into a local variable before
releasing tpebs_mtx to call pthread_join().

Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it
as the thread argument and setting tpebs_cmd.out = -1 in
evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
by perf_session__delete(). Also reset tpebs_cmd.pid = 0 and
tpebs_cmd.out = -1 and return early if start_command() fails in
evsel__tpebs_start_perf_record(), as start_command() closes the pipe
internally and may leave cmd->pid = -1 on error.

Serialize tpebs_send_record_cmd() with teardown via tpebs_cmd_in_flight
and tpebs_cmd_cond, check check_if_command_finished(&tpebs_cmd) under
tpebs_mtx only when not stopping, and guard evsel__tpebs_open() against
a concurrent tpebs_stop() with a generation counter (tpebs_gen) and
tpebs_stopping across closing the fds and finish_command().

Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
<unistd.h> explicitly.

Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf stat' needs to get retire latency value for a metric.")
Fixes: bded0398ac19 ("perf tpebs: Fix concurrent stop races and PID reuse hazards in tpebs_stop")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 121 +++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7c0b8b15bd10..4b7464cfa0eb 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -27,6 +27,12 @@
 #include <errno.h>
 #include <poll.h>
 #include <math.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 
 #define PERF_DATA		"-"
 
@@ -37,7 +43,10 @@ static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
 static int control_fd[2], ack_fd[2];
 static struct mutex tpebs_mtx;
+static struct cond tpebs_cmd_cond = { .cond = PTHREAD_COND_INITIALIZER };
 static bool tpebs_stopping;
+static bool tpebs_cmd_in_flight;
+static uint64_t tpebs_gen;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -120,10 +129,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
 	zfree(&tpebs_cmd.argv);
+	if (ret) {
+		tpebs_cmd.pid = 0;
+		tpebs_cmd.out = -1;
+		return ret;
+	}
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
 
-	return ret;
+	return 0;
 }
 
 static bool is_child_pid(pid_t parent, pid_t child)
@@ -220,13 +234,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static void *__sample_reader(void *arg __maybe_unused)
+static void *__sample_reader(void *arg)
 {
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = tpebs_cmd.out,
+		.file.fd = (int)(intptr_t)arg,
 	};
 	struct perf_tool tool;
 
@@ -236,8 +250,10 @@ static void *__sample_reader(void *arg __maybe_unused)
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-	if (IS_ERR(session))
+	if (IS_ERR(session)) {
+		close(data.file.fd);
 		return NULL;
+	}
 	perf_session__process_events(session);
 	perf_session__delete(session);
 
@@ -247,13 +263,26 @@ static void *__sample_reader(void *arg __maybe_unused)
 static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 {
 	struct pollfd pollfd = { .events = POLLIN, };
-	int ret, len, retries = 0;
+	bool is_stop = !strcmp(msg, EVLIST_CTL_CMD_STOP_TAG);
+	int ret, len, retries = 0, ctrl_fd, resp_fd;
 	char ack_buf[8];
 
+	while (tpebs_cmd_in_flight) {
+		if (!is_stop && tpebs_stopping)
+			return -EBUSY;
+		cond_wait(&tpebs_cmd_cond, tpebs_mtx_get());
+	}
+	if (!is_stop && tpebs_stopping)
+		return -EBUSY;
+
 	/* Check if the command exited before the send, done with the lock held. */
 	if (tpebs_cmd.pid == 0)
 		return 0;
 
+	ctrl_fd = control_fd[1];
+	resp_fd = ack_fd[0];
+	tpebs_cmd_in_flight = true;
+
 	/*
 	 * Let go of the lock while sending/receiving as blocking can starve the
 	 * sample reading thread.
@@ -262,20 +291,20 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 
 	/* Send perf record command.*/
 	len = strlen(msg);
-	ret = write(control_fd[1], msg, len);
+	ret = write(ctrl_fd, msg, len);
 	if (ret != len) {
 		pr_err("perf record control write control message '%s' failed\n", msg);
 		ret = -EPIPE;
 		goto out;
 	}
 
-	if (!strcmp(msg, EVLIST_CTL_CMD_STOP_TAG)) {
+	if (is_stop) {
 		ret = 0;
 		goto out;
 	}
 
 	/* Wait for an ack. */
-	pollfd.fd = ack_fd[0];
+	pollfd.fd = resp_fd;
 
 	/*
 	 * We need this poll to ensure the ack_fd PIPE will not hang
@@ -284,7 +313,17 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 	 */
 again:
 	if (!poll(&pollfd, 1, 500)) {
-		if (check_if_command_finished(&tpebs_cmd)) {
+		bool stopping, finished;
+
+		mutex_lock(tpebs_mtx_get());
+		stopping = tpebs_stopping;
+		finished = !stopping && check_if_command_finished(&tpebs_cmd);
+		mutex_unlock(tpebs_mtx_get());
+		if (stopping) {
+			ret = -EBUSY;
+			goto out;
+		}
+		if (finished) {
 			ret = 0;
 			goto out;
 		}
@@ -297,7 +336,17 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 	}
 
 	if (!(pollfd.revents & POLLIN)) {
-		if (check_if_command_finished(&tpebs_cmd)) {
+		bool stopping, finished;
+
+		mutex_lock(tpebs_mtx_get());
+		stopping = tpebs_stopping;
+		finished = !stopping && check_if_command_finished(&tpebs_cmd);
+		mutex_unlock(tpebs_mtx_get());
+		if (stopping) {
+			ret = -EBUSY;
+			goto out;
+		}
+		if (finished) {
 			ret = 0;
 			goto out;
 		}
@@ -307,7 +356,7 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 		goto out;
 	}
 
-	ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
+	ret = read(resp_fd, ack_buf, sizeof(ack_buf));
 	if (ret > 0)
 		ret = strcmp(ack_buf, EVLIST_CTL_CMD_ACK_TAG);
 	else
@@ -315,6 +364,8 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 out:
 	/* Re-take lock as expected by caller. */
 	mutex_lock(tpebs_mtx_get());
+	tpebs_cmd_in_flight = false;
+	cond_broadcast(&tpebs_cmd_cond);
 	return ret;
 }
 
@@ -331,12 +382,21 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
 		pid_t actual_pid = tpebs_cmd.pid;
+		pthread_t reader_thread;
 
 		tpebs_stopping = true;
+		tpebs_gen++;
+		cond_broadcast(&tpebs_cmd_cond);
 		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
+		/*
+		 * tpebs_results is empty when stopping; clear pid so
+		 * process_sample_event() ignores any late samples while
+		 * draining the pipe.
+		 */
 		tpebs_cmd.pid = 0;
+		reader_thread = tpebs_reader_thread;
 		mutex_unlock(tpebs_mtx_get());
-		pthread_join(tpebs_reader_thread, NULL);
+		pthread_join(reader_thread, NULL);
 		mutex_lock(tpebs_mtx_get());
 		if (control_fd[0] >= 0) {
 			close(control_fd[0]);
@@ -515,6 +575,8 @@ int evsel__tpebs_open(struct evsel *evsel)
 	int ret;
 	bool tpebs_empty;
 	bool started_process = false;
+	bool started_thread = false;
+	uint64_t open_gen = 0;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -550,6 +612,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	tpebs_empty = list_empty(&tpebs_results);
 	if (!tpebs_empty) {
 		started_process = true;
+		open_gen = ++tpebs_gen;
 		/*Create control and ack fd for --control*/
 		if (pipe(control_fd) < 0) {
 			pr_err("tpebs: Failed to create control fifo");
@@ -567,13 +630,18 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 
 		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
-				   /*arg=*/NULL)) {
+				   (void *)(intptr_t)tpebs_cmd.out)) {
 			kill(tpebs_cmd.pid, SIGTERM);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
 		}
+		/* __sample_reader now owns and closes the output fd. */
+		tpebs_cmd.out = -1;
+		started_thread = true;
 		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
+		if (!ret && tpebs_gen != open_gen)
+			ret = -EBUSY;
 	}
 out:
 	if (ret) {
@@ -584,11 +652,24 @@ int evsel__tpebs_open(struct evsel *evsel)
 			tpebs_retire_lat__delete(t);
 		}
 
-		if (started_process) {
-			if (tpebs_cmd.pid > 0) {
-				kill(tpebs_cmd.pid, SIGTERM);
-				finish_command(&tpebs_cmd);
+		if (started_process && tpebs_gen == open_gen) {
+			pid_t actual_pid = tpebs_cmd.pid;
+
+			tpebs_stopping = true;
+			tpebs_gen++;
+			cond_broadcast(&tpebs_cmd_cond);
+			if (actual_pid > 0) {
+				kill(actual_pid, SIGTERM);
+				while (tpebs_cmd_in_flight)
+					cond_wait(&tpebs_cmd_cond, tpebs_mtx_get());
 				tpebs_cmd.pid = 0;
+				if (started_thread) {
+					pthread_t reader_thread = tpebs_reader_thread;
+
+					mutex_unlock(tpebs_mtx_get());
+					pthread_join(reader_thread, NULL);
+					mutex_lock(tpebs_mtx_get());
+				}
 			}
 			if (tpebs_cmd.out >= 0) {
 				close(tpebs_cmd.out);
@@ -610,6 +691,12 @@ int evsel__tpebs_open(struct evsel *evsel)
 				close(ack_fd[1]);
 				ack_fd[1] = -1;
 			}
+			if (actual_pid > 0) {
+				tpebs_cmd.pid = actual_pid;
+				finish_command(&tpebs_cmd);
+				tpebs_cmd.pid = 0;
+			}
+			tpebs_stopping = false;
 		}
 	}
 	mutex_unlock(tpebs_mtx_get());
-- 
2.56.0.455.g6c5a503b38-goog

