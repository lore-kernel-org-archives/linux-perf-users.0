Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244363;
	b=Y/SKe1ebiqnFjXhe0uwYvHkpREvoQEsZ2m5hE8+nzfYox/9F54g1eV/5HH2mWfzQbJR8
	 82+kPZCC3EUeo3BYw3ImApgSuB9+b7rIBmaFhtwEeE2xdt3upLGKo6+d/3rA5WtJtV1NM
	 j7lelit3b4LwV6Ivim3FvjasZydSXHBJWIrD2HnVp7etsPorslzzZ97aAiyrurPlSCiCk
	 RTSeOu2sJX0J+0n5GTDb2+cNtB5DhfqKfckGbvVWLnqnAq8yNCEDNf5b0OHqDP25Nq2mH
	 IyegLgG66ojY4cHt9HFAi6ekiFo6giJ+82GoVKTRefkAv17jetI8zfvvzgS/exA3Smw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d95iHTNdtf/y8c1gOlDmpA5GClWqrzVm2GjHbOzts1E=;
	b=YpiykO3iD8+38qL3XEkX/0ScyIVclZFdC5o/Z+AjOulZ1CUwtvEAT8HJYvmeb/LrJhBP
	 eZ6hrdq/OuQ3eS2UpF3E1jid81LYw4HZx1L038N+rQJN/mzc+wr+b4np8kRHAKFRu7XXs
	 VIkUQhfCHE51l+FERifMnNgo5CW4LHHeCg9bjJ4LeYJWT+iFz+D1Qbr9lwdjLd7cVsyXW
	 Vy+JCN3RIXkvFO4rLMulWkAm1VDhAkY+0ny69wUXCjnF9CQDtMXLDIsfVdRROR4Iu9Lan
	 PfPCQ8sGssFfKsRjjN0MuKLQCufmJoGzEkgOtLmFbnX/5OSkboVs8qExcy0j0iZ7zag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F4P3DI88;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB51606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB51606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F4P3DI88
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4ba0e4ca606so1157451fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244362; x=1795849162; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d95iHTNdtf/y8c1gOlDmpA5GClWqrzVm2GjHbOzts1E=;
        b=F4P3DI8899shPOvrCS8jIAml7OLHECSct3jhKXphaDBrr3ZXq2Kn76chC8h2CeMhWG
         HiF6cqXd7GjAwaK9uGUxEgwDW9FQ/SbGMDt6Cc1SCRnlESb6qxLY3BnZyZrDvAdVz4AU
         qfXKTwHQ2IFGXvbRg0thXR9XQsSOC8CrlpRYZt0CufmvZlVkacXV5tp5tETOm0HdKKoQ
         vlNAMngxrj9poXFwRmoM1fPYofpjI8pTsJ4z/ehgEjZv86nkbK2o3dTatRPGQbg4ZktG
         ltkNDSYH2+87eWOz5V/xDlmvxOazCw6dnsHMN/2ZGJf/rm8YYPc7tnVbP/fKH7hG9ja0
         AD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244362; x=1795849162;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d95iHTNdtf/y8c1gOlDmpA5GClWqrzVm2GjHbOzts1E=;
        b=PQ+xOQv6QtldIRQk/afBoesyBWFjeeWvaVkxws0N2V95qqrLZWqkDknpiW/sX7Huhg
         XFK4PD14fjKEE6o8wfS6s32p6trvI42BsyaBDbRISNd4ATAuvgB6stXbz1k3MK3OyZLs
         WAOSExPX/Snuvz3ohrcLy/RvqauDYhSBlgCzBc5O4d3UvTWK1CrxY5MkNGO2aRhmuwXW
         2ub5CcxusOrh1i14nqb3fQ2K3jCebIvNLAomrkidAeauOtHDbAzafM6XE4XwXsSrbuVz
         d9K0rXea6TZZkdPdCtLO1vLBPb8y6LMUweyJVnPBJWaKAwTTJgdJLiCGEb/kVNaVmswP
         j9Fw==
X-Forwarded-Encrypted: i=1; AL+hErH6gmUPwLdWuT6MysIyQLO+dTZMpD33a8bBbdZEJkOHV3XRn2Tk+rdvKgNnw9okJYvQy75MymO3rmllAsZVQ9a5@vger.kernel.org
X-Gm-Message-State: APuU4Z9+etyGhp7FFC6hPwm46awPtk8I2zEUtN6LfItMJbHKFtNnxhcd
	Vr3Xk6pFHEVZnocQokx36GmZ+H+IADVaK3imoNDWxuEIwfULpfRpP/kQBq8v8sPaY88QO/8i1Q2
	e4+3QzZ9/rw==
X-Received: from ioi20-n1.prod.google.com ([2002:a05:6602:c654:10b0:9c7:66cc:b115])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:f13:b0:567:f784:f939
 with SMTP id 5614622812f47-57a0bb54177mr5310815b6e.51.1795244361845; Fri, 20
 Nov 2026 22:59:21 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:04 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-16-irogers@google.com>
Subject: [PATCH v15 15/23] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.750.gf70dc682cf-goog

