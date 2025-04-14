Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D928291173
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652541; cv=none; b=fCIBmG/7R0tjLMFuasqlPnS+WvR6suBH/fCxmZpL8r7sBt+2GLFup2ih2NZnzMIto95RCem7YmU5w9wbncw4+sfa5lxxzU9l4Y2M4Jr/dQ0YVhQsapHTG2DWs14/2nhyisAgMenxR1xCkviEvHpk98HZv2j791/m2o0x5XwL7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652541; c=relaxed/simple;
	bh=/n1D0aH+aEk2XO0eFvDbfFi5XFTjuCJOPuFxCOifGAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RtySG3mpuGK023VmNE8Dmobuic1sWLkEk7FGIoyuOjaNijcdt4iJ4dqMFZQUhIB0Xi1R1O0cUTshOwpTVMHHzTcdx6myCsVvl7tbORXcx1lBD38pTC/E9e95b/WJB+F7m6W6yW6Kej3NaE9OGbbuozXEDkxeQbL+Th5tzVlxYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULy+HraF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULy+HraF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3011bee1751so3954387a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652539; x=1745257339; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+v5/q5rPSGglKhge482QHSxn0kDSG2APb/UlulErBlA=;
        b=ULy+HraFSkD5UVJGh+bh5B0pQLqhFipAK8AoRi5GPmux/XvvAyYc/AIdIhvTciYMAw
         atEpul5SSAX37sYlrK3MfB489q5ujrzx2g9gU5hT2+/EQoaFpZNZRFi+mo93yViPNwy5
         TyLuhuueyFXfBtRPtM4yedxDF6fAMg2lnuUv18YNveeVmukqAhlHuExyLvZRgvs6Xoc5
         JbJu3haHHJUuFeotNB6WnnxbLuaBWncFz5dsTRwNNIaWwHiF0/JvistGhQ3Ntw11xqMH
         F9M1Dwp8x0PBiNLSPSt+YPK2xgrImKF9QdkaOuu5W1j7EnNDfloUHKVEn1g+wNqIRfR9
         ZdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652539; x=1745257339;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v5/q5rPSGglKhge482QHSxn0kDSG2APb/UlulErBlA=;
        b=bvPAzn1f6sVX0KFiLA/WTKHZF4J3vAEEmvxwzLBnn0bMJzhaZqbWNCt5+tE3jFwcyv
         3RxRaHi37y5xYpy8dd3Yvk5UtGNCITaf+DtUCeteDWoXR3CdIOvHS6TyNYlaSKrcD6D/
         4vzTAcGBrwwvbIkBpNw2TebEqTtNJYD8zNp5eJJ/L32a64yj8BJrOHbcZDXx+ruSZZt2
         hvCr+AVCQkhpByIg4u+gyqZmwU5BAeh5s1dBqoNSiLqkf/dXYdqwQ7R3HtV2Zgh1h/Kw
         nzFua5xiltZ51KWkurbuu0aSIeMkdW1hXC6dsuFRJrkgu7MQXMbiqZzwuNiZ4Wz2li/b
         1oZA==
X-Forwarded-Encrypted: i=1; AJvYcCUkKWZ6/25mT06T6DbdQS3NSFpufp0xoZi+0cafUHoPqqO0wwWbomLxNrxu1Gn/HH5vwCS/l0rQQJzGXStkJMxi@vger.kernel.org
X-Gm-Message-State: AOJu0YwccSCbCgexm+5K+oj0zhyD0+NzvqL9Kn3kBJ0iWyICLNS8dMb0
	3klxiZdg6DZ4p/GgNAEfiDMeP5yqDDG2dTZ8IPvLaaRPU2c6l0RAshis6cNFTUL8eH0L4JcSb1x
	6oxfQWg==
X-Google-Smtp-Source: AGHT+IG427R/lno3K5WSfhSr/PrtGfyC0AAoSR1CaVNs9fF0cIKkbSGqaJd7SnL4Vyi1rOuK9Kt95u+JIiee
X-Received: from pjbsz5.prod.google.com ([2002:a17:90b:2d45:b0:2f5:63a:4513])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264c:b0:2f9:9ddd:689b
 with SMTP id 98e67ed59e1d1-308236728a0mr17494499a91.22.1744652539466; Mon, 14
 Apr 2025 10:42:19 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:30 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-13-irogers@google.com>
Subject: [PATCH v5 12/16] perf intel-tpebs: Don't close record on read
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
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c       |   2 +
 tools/perf/util/intel-tpebs.c | 200 +++++++++++++++++++++-------------
 2 files changed, 129 insertions(+), 73 deletions(-)

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
index aa6bcdf2bf6c..a9446e7a1c5c 100644
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
@@ -352,13 +437,15 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -367,12 +454,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 
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
@@ -385,7 +467,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
-		ret = evsel__tpebs_start_perf_record(evsel, control_fd, ack_fd);
+		ret = evsel__tpebs_start_perf_record(evsel);
 		if (ret)
 			goto out;
 
@@ -397,53 +479,16 @@ int evsel__tpebs_open(struct evsel *evsel)
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
 
@@ -452,6 +497,7 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	struct perf_counts_values *count, *old_count = NULL;
 	struct tpebs_retire_lat *t;
 	uint64_t val;
+	int ret;
 
 	/* Only set retire_latency value to the first CPU and thread. */
 	if (cpu_map_idx != 0 || thread != 0)
@@ -462,14 +508,20 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 
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
 
@@ -498,10 +550,12 @@ void evsel__tpebs_close(struct evsel *evsel)
 
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
2.49.0.604.gff1f9ca942-goog

