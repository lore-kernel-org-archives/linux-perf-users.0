Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C3224880
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060225; cv=none; b=Bo48xT+PjyAOvhxSnYuD1E1QUgGMoPozBJKQRhCXHjqsqYNpqanniUX2NNzNDNRHzmTLnNRkA7vZMfisvLwNwtaYDXdfr19FIzF0iC/lc0aEmnt36i2FYrpg3hep/7sfHRxM2la5BYtDtIzsWsIUBF0FpAaUrtX4XJdYdUqxe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060225; c=relaxed/simple;
	bh=ifUhHpvB3YWjewd+FCiG+bnPL8N1hMQyEOj1ALhK2zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CseN5vkCepF5CD9K30b4ScJbvi9aKfJQnxkb+aRbM/wM0Xh8UVKOOLMzeJA/WFCbA+3PGoJorpwZ9hpfJYLchL0Qmb+eI7afpiHsmFggDG0aDYp7RgwV24l+jpw+6Y3JlfBsJ2o1mEt99x7YyBt5PDwm6m8Fdn807Ur4iX4OMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJEtIFHR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJEtIFHR"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242f3fd213so35968195ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060223; x=1744665023; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=oJEtIFHR/xWIcSH92yqkomCZDa2rgp+wMrkl8lHCHmog0tHNDkS/so7rAHfLyxgl4Q
         SCKk67wnPj/Xn2ZoJ3uMOIfLhrJV0W0zkYbQBMrv73wJdgO6vHlKui43kqA6D1jWeEYD
         2yVHXEVCDdDCg4tqP4TWEiZmwBZz+J1LopEEcK6e2Zzb+Q05RCcIm9d9KX1wilib28ZC
         2lXGGPArTzT8iOE6r/DshzWIeq9jYdpXfGhU++qYVfjGlOeTNPo/1aw4Ip8pk6jF/0Xv
         tXwwkeIdJHUBKCeX2RL+pqNsLiN4RX6UeXbe6+dNwKsW7c00hhhbfCrXkA4nOJzazLzC
         s3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060223; x=1744665023;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kljzr7zwrGyBJiGR5feDDMzqEBYffKkoUZPkiCSQTN4=;
        b=OMBYfLvj0QhDs/AfHwQk3j0tZim6z3HktViAs+bOiaMdyHFb+/tKLVAJH+PJ9P7l40
         Fp3WWaxgkha6T/NgITK4Sp3lTs2q6HBs/EKb4NXEevGnmF2vFz9aOwzwTNcZFwKPGE8V
         5LkehqqjHMOkGjLNythjQJ195/aGXteXBe1Vl7/QLeFArcw4/Dvib0f9zOuF+PdOHUSF
         aQnMZlNQyuBsgXFlO1EYmtlu2ZYeQxCk8BGXNBHr4T2pSq0+WOLwNlW1V+xkR01WQJyJ
         lmRCciwAL9kAwCtUfS1UdSgl8u0GYAmyO2c0XXDe3MhZuiOmFiqVNZk3wbiFy2Io1UEW
         nJkA==
X-Forwarded-Encrypted: i=1; AJvYcCWSFIaDjgTL+ZxNin+syiHYl8COttJyA3CDn4ZAdFW0PFX8HTUI/ZcPgYWPHNSEQ2QBFSPOQt4qxLW+cdmo4myo@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8CZIWG6kDZZvV13ScQcwwnFjZgUTUAMLLbk3bn0mULNbpp3k
	AaoVvzgg0/M8FF+IcPvCgLZtxvtVBd7AfFya/lDXde+EAvzvdOIlGKjFelGxbCsgsXnSvOp6Ebl
	O5dz1MQ==
X-Google-Smtp-Source: AGHT+IEM3/2+3p4g2+IjgFL6miLEqz06Qs4xo+S+z4grR7818G19GtbHRP8lOTbPqoj/HNDYBnreHi+4zdDE
X-Received: from plcc1.prod.google.com ([2002:a17:902:c1c1:b0:220:c4f0:4f1e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:223:88af:2c30
 with SMTP id d9443c01a7336-22a8a0583d6mr184935005ad.16.1744060223017; Mon, 07
 Apr 2025 14:10:23 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:23 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-3-irogers@google.com>
Subject: [PATCH v3 02/16] perf intel-tpebs: Simplify tpebs_cmd
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

No need to dynamically allocate when there is 1. tpebs_pid duplicates
tpebs_cmd.pid, so remove. Use 0 as the uninitialized value (PID == 0
is reserved for the kernel) rather than -1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 55 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 3503da28a12f..74b43faab986 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -28,11 +28,10 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static pid_t tpebs_pid = -1;
 static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
-static struct child_process *tpebs_cmd;
+static struct child_process tpebs_cmd;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -83,16 +82,6 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int prepare_run_command(const char **argv)
-{
-	tpebs_cmd = zalloc(sizeof(struct child_process));
-	if (!tpebs_cmd)
-		return -ENOMEM;
-	tpebs_cmd->argv = argv;
-	tpebs_cmd->out = -1;
-	return 0;
-}
-
 static int start_perf_record(int control_fd[], int ack_fd[],
 				const char *cpumap_buf)
 {
@@ -110,10 +99,10 @@ static int start_perf_record(int control_fd[], int ack_fd[],
 	if (ret)
 		goto out;
 
-	ret = prepare_run_command(record_argv);
-	if (ret)
-		goto out;
-	ret = start_command(tpebs_cmd);
+	assert(tpebs_cmd.pid == 0);
+	tpebs_cmd.argv = record_argv;
+	tpebs_cmd.out = -1;
+	ret = start_command(&tpebs_cmd);
 out:
 	free(record_argv);
 	return ret;
@@ -156,14 +145,13 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static void *__sample_reader(void *arg)
+static void *__sample_reader(void *arg __maybe_unused)
 {
-	struct child_process *child = arg;
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = child->out,
+		.file.fd = tpebs_cmd.out,
 	};
 	struct perf_tool tool;
 
@@ -189,12 +177,12 @@ static int tpebs_stop(void)
 	int ret = 0;
 
 	/* Like tpebs_start, we should only run tpebs_end once. */
-	if (tpebs_pid != -1) {
-		kill(tpebs_cmd->pid, SIGTERM);
-		tpebs_pid = -1;
+	if (tpebs_cmd.pid != 0) {
+		kill(tpebs_cmd.pid, SIGTERM);
 		pthread_join(tpebs_reader_thread, NULL);
-		close(tpebs_cmd->out);
-		ret = finish_command(tpebs_cmd);
+		close(tpebs_cmd.out);
+		ret = finish_command(&tpebs_cmd);
+		tpebs_cmd.pid = 0;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
@@ -219,7 +207,7 @@ int tpebs_start(struct evlist *evsel_list)
 	 * We should only run tpebs_start when tpebs_recording is enabled.
 	 * And we should only run it once with all the required events.
 	 */
-	if (tpebs_pid != -1 || !tpebs_recording)
+	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
 	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
@@ -284,10 +272,11 @@ int tpebs_start(struct evlist *evsel_list)
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
-		tpebs_pid = tpebs_cmd->pid;
-		if (pthread_create(&tpebs_reader_thread, NULL, __sample_reader, tpebs_cmd)) {
-			kill(tpebs_cmd->pid, SIGTERM);
-			close(tpebs_cmd->out);
+
+		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
+				   /*arg=*/NULL)) {
+			kill(tpebs_cmd.pid, SIGTERM);
+			close(tpebs_cmd.out);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
@@ -416,18 +405,10 @@ void tpebs_delete(void)
 {
 	struct tpebs_retire_lat *r, *rtmp;
 
-	if (tpebs_pid == -1)
-		return;
-
 	tpebs_stop();
 
 	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
 		list_del_init(&r->nd);
 		tpebs_retire_lat__delete(r);
 	}
-
-	if (tpebs_cmd) {
-		free(tpebs_cmd);
-		tpebs_cmd = NULL;
-	}
 }
-- 
2.49.0.504.g3bcea36a83-goog

