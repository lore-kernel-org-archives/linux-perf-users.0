Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941375;
	b=KmVuPNgWtL8QwniTnH/cZ4aAjQ1uLyzX006Pr4/tVvwEV4Khjlgpw+XPPo8mH6j5SkoS
	 UR3TD7K7aJbI3lkQEEDYEJ9IQ+mNVGZLfuSt1ug9v5iO5fXp1/JhMD1DQxTmI+Um/UOSR
	 MVHmx1A9uJ+o8/hdq/xP9fgJ8e3LaEkiZwg/5eQuTZCzZNnRNB/p81mC5JPUmF2zNT3hZ
	 N7veHhTcPgMucZy+iUtVOkopBjwGqc5fnG5fXmUO0btVS8qMRGVcgmAIQV1Bs6WeLEagh
	 FFLCjWiOGqcW4/4TCrDrk+ciZ/rYzIdFvbgAlxnmYZ7bgFjafMrGm/hOfdcHg6Krfuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jt8Ge1YfesjoyrcwC04dL6qB9pTBfIeSCbHLf5znjY8=;
	b=PAK2QpyEghifSh4EbVTfv6qSytjSURDQuIwRRsFQfD2K9O7Z8oGMFxyOmpC6lkMWuq0u
	 ZxvZXaG/9kBiLpdp+czeeO8E445mS+p5B9Ghg0+X5OyylAEvyKP7QYCq4HePi30HQ9JJe
	 Z0aUobE1Gpr0Hl/MHZd41+IMfUTgvVSq0ObNh9iJLaV+lsAqc7C4MspsPK1KfiAetVi+6
	 5QJ4GvHVUgP6m/H9BTh36yuM+fExisy1baSb29IUPTR8Gi0lCetQ7jnZekO/zReWdlfcW
	 06BmqGepQ5ksrmusmOL1zgt4R+cbC+P+MscAR74NCyxxXO7uhiUCS9AtGW4zCtBjdWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hrN7yDtV;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF787606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF787606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hrN7yDtV
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a3451ea93so185780eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941374; x=1795546174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jt8Ge1YfesjoyrcwC04dL6qB9pTBfIeSCbHLf5znjY8=;
        b=hrN7yDtVLnf+5B91hYtdxX4ogB1CZj8ykCOXG8E+XhHk750aF5w0V/2kJgszavv2UM
         rC1n0ArLCcmFKJ4Ik8i3nMxdIJjCe44d/gf2P2QkkRrzyi2jKb2+mtGY2VtrmIDVld/o
         2vVjTZpCRsLI4o35d03hvTxdc0vZtDwiXzBGTsHfCxUbDXSo1yeXN9v9stYZE046IfUT
         jI6Mg1WaZpykCUaZFiv1XqtM7Uf8VY1qEn7ZXtvMb1KxMKtkKfCin4septnqdGdqE2nQ
         RZIrW81ac+Gp+R/fBkFrmzO4Df90QlwvS/D9fwmGLla/HorraLPJDrgy+Tj70VbUm66E
         DHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941374; x=1795546174;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jt8Ge1YfesjoyrcwC04dL6qB9pTBfIeSCbHLf5znjY8=;
        b=LHy89SkhnfiD2vGOmtv6v9bjSJ1vVt8QgPriNAHXZ/e9Ztvb1w8AR25OmDcTJRINT3
         3rFF/9JRPxPpIkhWIH54pj0id2BKt9HvQuZgYoC0moO8lqBwHEI8eMRC6t+yvYzp9Lqy
         3i49fMj+K7t6zfo7YOdqDGWBxGZSnsf/8/MLKnpWh+xyRO9rkrxG8K3CtjgTaiVouu9r
         aizuslPivKW4ZQQpXGGSF7Ox1SM3N0x3AL0afaIy8Qa0wH4qN7dFenAKBv6iFTyazDET
         RU5hv15zrqkqZvgjYI8rvoRveUYQCmUG/eAo4k8XSs0Q2ldSlcsbi73B70qvAkqMZnHj
         00hg==
X-Forwarded-Encrypted: i=1; AL+hErG4FZtdmGBq3zkofcmfHTPHPGvCpwo6ox/sOqdH4kSBmhyDuMNXWGZMT5GRtme+7pw6C312xRfDfAKertJFcsTj@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dpj+rAXh+GmP3X14/vW7e0uG5KOSW3MZJLHrUHzjVbJ+JY4dQ
	KrEzzfQ/f4fs/G0BC4/5xp2gd59FvQ/LLrHW4jqb6+BuYQsz9DsmE32y9UmisK/7mfuqjFex2rh
	eWtBh4MTTyA==
X-Received: from dybpt11.prod.google.com ([2002:a05:7301:408b:b0:381:1cbb:c2b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:42d0:b0:381:c15:1b6f
 with SMTP id 5a478bee46e88-3827f98c04fmr273545eec.6.1794941373542; Tue, 17
 Nov 2026 10:49:33 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:36 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-16-irogers@google.com>
Subject: [PATCH v14 15/23] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

intel-tpebs has two lifecycle bugs around the background 'perf record'
process and sample reader thread:
1. tpebs_cmd.out is read without tpebs_mtx and closed by both
   perf_session__delete() in __sample_reader() and tpebs_stop() (or
   leaked if perf_session__new() fails).
2. tpebs_stop() reads tpebs_reader_thread after unlocking tpebs_mtx, and
   tpebs_send_record_cmd() drops tpebs_mtx while writing undelimited
   control strings and polling ack_fd, allowing concurrent open/close
   calls to coalesce commands or race to close pipes, join the reader
   thread, and reap tpebs_cmd twice.

Fix (1) by initializing tpebs_cmd.out = -1, passing it to
__sample_reader(), and resetting tpebs_cmd.out = -1 once ownership is
transferred (and on start_command() failure). Fix (2) by preparing
events under tpebs_mtx, reading tpebs_reader_thread under tpebs_mtx,
newline-terminating control commands, serializing open,
tpebs_send_record_cmd(), and teardown via a condition variable and
generation counter, and ignoring late samples while stopping. Add
explicit header includes used by the file.

Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf stat' needs to get retire latency value for a metric.")
Fixes: bded0398ac19 ("perf tpebs: Fix concurrent stop races and PID reuse hazards in tpebs_stop")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 243 +++++++++++++++++++++++++---------
 1 file changed, 184 insertions(+), 59 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7c0b8b15bd10..23d1e8bb678c 100644
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
 
@@ -34,10 +40,17 @@ bool tpebs_recording;
 enum tpebs_mode tpebs_mode;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
-static struct child_process tpebs_cmd;
+static struct child_process tpebs_cmd = {
+	.out = -1,
+};
 static int control_fd[2], ack_fd[2];
 static struct mutex tpebs_mtx;
+static struct cond tpebs_cmd_cond = { .cond = PTHREAD_COND_INITIALIZER };
 static bool tpebs_stopping;
+static bool tpebs_starting;
+static bool tpebs_enabled;
+static bool tpebs_cmd_in_flight;
+static uint64_t tpebs_gen;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -120,10 +133,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
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
@@ -195,8 +213,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct tpebs_retire_lat *t;
 
 	mutex_lock(tpebs_mtx_get());
-	if (tpebs_cmd.pid == 0) {
-		/* Record has terminated. */
+	if (tpebs_stopping || tpebs_cmd.pid == 0) {
+		/* Record is stopping or has terminated. */
 		mutex_unlock(tpebs_mtx_get());
 		return 0;
 	}
@@ -220,13 +238,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
 
@@ -236,8 +254,10 @@ static void *__sample_reader(void *arg __maybe_unused)
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-	if (IS_ERR(session))
+	if (IS_ERR(session)) {
+		close(data.file.fd);
 		return NULL;
+	}
 	perf_session__process_events(session);
 	perf_session__delete(session);
 
@@ -247,35 +267,49 @@ static void *__sample_reader(void *arg __maybe_unused)
 static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 {
 	struct pollfd pollfd = { .events = POLLIN, };
-	int ret, len, retries = 0;
+	bool is_stop = !strcmp(msg, EVLIST_CTL_CMD_STOP_TAG);
+	int ret, len, retries = 0, ctrl_fd, resp_fd;
+	char cmd_buf[EVLIST_CTL_CMD_MAX_LEN];
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
 	 */
 	mutex_unlock(tpebs_mtx_get());
 
-	/* Send perf record command.*/
-	len = strlen(msg);
-	ret = write(control_fd[1], msg, len);
+	/* Send perf record command. */
+	len = scnprintf(cmd_buf, sizeof(cmd_buf), "%s\n", msg);
+	ret = write(ctrl_fd, cmd_buf, len);
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
@@ -284,7 +318,17 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
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
@@ -297,7 +341,17 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
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
@@ -307,7 +361,7 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 		goto out;
 	}
 
-	ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
+	ret = read(resp_fd, ack_buf, sizeof(ack_buf));
 	if (ret > 0)
 		ret = strcmp(ack_buf, EVLIST_CTL_CMD_ACK_TAG);
 	else
@@ -315,6 +369,8 @@ static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 out:
 	/* Re-take lock as expected by caller. */
 	mutex_lock(tpebs_mtx_get());
+	tpebs_cmd_in_flight = false;
+	cond_broadcast(&tpebs_cmd_cond);
 	return ret;
 }
 
@@ -331,12 +387,25 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
 		pid_t actual_pid = tpebs_cmd.pid;
+		bool enabled = tpebs_enabled;
+		pthread_t reader_thread;
 
 		tpebs_stopping = true;
-		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
+		tpebs_starting = false;
+		tpebs_enabled = false;
+		tpebs_gen++;
+		cond_broadcast(&tpebs_cmd_cond);
+		if ((tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG) || !enabled) &&
+		    !tpebs_cmd.finished)
+			kill(actual_pid, SIGTERM);
+		/*
+		 * tpebs_results is empty when stopping; clear pid before
+		 * releasing tpebs_mtx to join the reader thread.
+		 */
 		tpebs_cmd.pid = 0;
+		reader_thread = tpebs_reader_thread;
 		mutex_unlock(tpebs_mtx_get());
-		pthread_join(tpebs_reader_thread, NULL);
+		pthread_join(reader_thread, NULL);
 		mutex_lock(tpebs_mtx_get());
 		if (control_fd[0] >= 0) {
 			close(control_fd[0]);
@@ -464,41 +533,53 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 	return NULL;
 }
 
-/**
- * evsel__tpebs_prepare - create tpebs data structures ready for opening.
- * @evsel: retire_latency evsel, all evsels on its list will be prepared.
- */
-static int evsel__tpebs_prepare(struct evsel *evsel)
+static void tpebs_results__delete(void) __must_hold(tpebs_mtx_get())
+{
+	struct tpebs_retire_lat *t, *tmp;
+
+	list_for_each_entry_safe(t, tmp, &tpebs_results, nd) {
+		list_del_init(&t->nd);
+		tpebs_retire_lat__delete(t);
+	}
+}
+
+static int evsel__tpebs_prepare_one(struct evsel *evsel) __must_hold(tpebs_mtx_get())
 {
-	struct evsel *pos;
 	struct tpebs_retire_lat *tpebs_event;
 
-	mutex_lock(tpebs_mtx_get());
-	tpebs_event = tpebs_retire_lat__find(evsel);
-	if (tpebs_event) {
-		/* evsel, or an identically named one, was already prepared. */
-		mutex_unlock(tpebs_mtx_get());
+	if (tpebs_retire_lat__find(evsel))
 		return 0;
-	}
+
 	tpebs_event = tpebs_retire_lat__new(evsel);
-	if (!tpebs_event) {
-		mutex_unlock(tpebs_mtx_get());
+	if (!tpebs_event)
 		return -ENOMEM;
-	}
+
 	list_add_tail(&tpebs_event->nd, &tpebs_results);
-	mutex_unlock(tpebs_mtx_get());
+	return 0;
+}
+
+/**
+ * evsel__tpebs_prepare - create tpebs data structures ready for opening.
+ * @evsel: retire_latency evsel, all evsels on its list will be prepared.
+ */
+static int evsel__tpebs_prepare(struct evsel *evsel) __must_hold(tpebs_mtx_get())
+{
+	struct evsel *pos;
+	int ret;
+
+	ret = evsel__tpebs_prepare_one(evsel);
+	if (ret)
+		return ret;
 
 	/*
 	 * Eagerly prepare all other evsels on the list to try to ensure that by
 	 * open they are all known.
 	 */
 	evlist__for_each_entry(evsel->evlist, pos) {
-		int ret;
-
 		if (pos == evsel || !pos->retire_lat)
 			continue;
 
-		ret = evsel__tpebs_prepare(pos);
+		ret = evsel__tpebs_prepare_one(pos);
 		if (ret)
 			return ret;
 	}
@@ -515,12 +596,26 @@ int evsel__tpebs_open(struct evsel *evsel)
 	int ret;
 	bool tpebs_empty;
 	bool started_process = false;
+	bool started_thread = false;
+	uint64_t open_gen = 0;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
 		return 0;
 
 	mutex_lock(tpebs_mtx_get());
+	if (tpebs_starting) {
+		uint64_t wait_gen = tpebs_gen;
+
+		while (tpebs_starting && tpebs_gen == wait_gen)
+			cond_wait(&tpebs_cmd_cond, tpebs_mtx_get());
+
+		if (tpebs_gen != wait_gen) {
+			mutex_unlock(tpebs_mtx_get());
+			return -EBUSY;
+		}
+	}
+
 	if (tpebs_stopping) {
 		mutex_unlock(tpebs_mtx_get());
 		return -EBUSY;
@@ -531,25 +626,24 @@ int evsel__tpebs_open(struct evsel *evsel)
 		bool valid;
 
 		t = tpebs_retire_lat__find(evsel);
-		valid = t && t->started;
+		valid = t && t->started && tpebs_enabled;
 		mutex_unlock(tpebs_mtx_get());
 		/* May fail as the event wasn't started. */
 		return valid ? 0 : -EBUSY;
 	}
-	mutex_unlock(tpebs_mtx_get());
 
 	ret = evsel__tpebs_prepare(evsel);
-	if (ret)
+	if (ret) {
+		tpebs_results__delete();
+		mutex_unlock(tpebs_mtx_get());
 		return ret;
-
-	mutex_lock(tpebs_mtx_get());
-	if (tpebs_stopping || tpebs_cmd.pid != 0) {
-		ret = -EBUSY;
-		goto out;
 	}
+
 	tpebs_empty = list_empty(&tpebs_results);
 	if (!tpebs_empty) {
 		started_process = true;
+		tpebs_enabled = false;
+		open_gen = ++tpebs_gen;
 		/*Create control and ack fd for --control*/
 		if (pipe(control_fd) < 0) {
 			pr_err("tpebs: Failed to create control fifo");
@@ -567,28 +661,50 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 
 		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
-				   /*arg=*/NULL)) {
-			kill(tpebs_cmd.pid, SIGTERM);
+				   (void *)(intptr_t)tpebs_cmd.out)) {
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
 		}
+		/* __sample_reader now owns and closes the output fd. */
+		tpebs_cmd.out = -1;
+		started_thread = true;
+		tpebs_starting = true;
 		ret = tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
+		if (!ret) {
+			if (tpebs_gen != open_gen) {
+				ret = -EBUSY;
+			} else {
+				tpebs_enabled = true;
+				if (!tpebs_retire_lat__find(evsel))
+					ret = -EBUSY;
+			}
+		}
 	}
 out:
-	if (ret) {
-		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
-
-		if (t) {
-			list_del_init(&t->nd);
-			tpebs_retire_lat__delete(t);
-		}
-
-		if (started_process) {
-			if (tpebs_cmd.pid > 0) {
-				kill(tpebs_cmd.pid, SIGTERM);
-				finish_command(&tpebs_cmd);
+	if (started_process && tpebs_gen == open_gen) {
+		tpebs_starting = false;
+		if (ret) {
+			pid_t actual_pid = tpebs_cmd.pid;
+
+			tpebs_stopping = true;
+			tpebs_enabled = false;
+			tpebs_gen++;
+			tpebs_results__delete();
+			cond_broadcast(&tpebs_cmd_cond);
+			if (actual_pid > 0) {
+				if (!tpebs_cmd.finished)
+					kill(actual_pid, SIGTERM);
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
@@ -610,6 +726,14 @@ int evsel__tpebs_open(struct evsel *evsel)
 				close(ack_fd[1]);
 				ack_fd[1] = -1;
 			}
+			if (actual_pid > 0) {
+				tpebs_cmd.pid = actual_pid;
+				finish_command(&tpebs_cmd);
+				tpebs_cmd.pid = 0;
+			}
+			tpebs_stopping = false;
+		} else {
+			cond_broadcast(&tpebs_cmd_cond);
 		}
 	}
 	mutex_unlock(tpebs_mtx_get());
@@ -645,6 +769,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 		if (ret)
 			return ret;
 		mutex_lock(tpebs_mtx_get());
+		t = tpebs_retire_lat__find(evsel);
 	}
 	if (t == NULL || t->stats.n == 0) {
 		/* No sample data, use default. */
-- 
2.56.1.703.gf848ed807c-goog

