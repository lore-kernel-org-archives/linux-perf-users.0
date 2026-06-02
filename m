Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25973806C9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422101; cv=none; b=kEcBy7o4Ea2jTlBw+tquLQ15QA+Q6mUCn160ZN2LW4YbwWKqF3rAfcfci9rtkEhgchk32TbsxQ/hYSC3/G94yFIE49ZkgCF6kV6PBYh388GG/obRA5nsrC+goP0/a/8knjV8Z4DEMIMKo7CwD4TfTlAaTYXcwGjIjFatGI89zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422101; c=relaxed/simple;
	bh=erqZ3YI6CEZ5hspp+wvMpUBiA5Aa5RqpQQrKjQaP0k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evw2gF0BAMeFHOEwEZuhFcfKgAVmisaE+sDXi3yZ8hAZXD6pvoOojPvyeEqTSnhHWxPMCnAwWVjIzacPZ2dxeb9SDgQAGxN64gViGI2O5heBZouAuTVIxJvbNxkUpsQ0JohsKfyESkS/E3OhtR+50rcK27WjUX3Sbn1omLEcuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubeLwhl3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubeLwhl3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dbe27199so376860c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422099; x=1781026899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=onXlnB2ZQ1GPIBaPdwRSwTOIJYhcXH8fhqKzxRdltT4=;
        b=ubeLwhl3bogEdB2CYVByzvHeurGJwMY41xVCGNSyf2bf/4pkUURCAFSIMw+cpGkRRi
         ajycHxmoaxmKgLfY4UJeDxrUuZYsdl0V+3oNZv85f00BCFJV/tm0OAfe7CwSudCJRh9h
         CvFhUBuuOtSf40NTdSz6iMpOpFFBQU83q8xfydB15HXpKCUT7KggsbBuESYbErGkhllE
         WTl4HJrCrMbnhUFx9aliP1XaSNH0yVHBEi92ADRcfta91u3v/w2uOVUgMKUEXvRQQtes
         9woBmu+y1Ow7dCn5i2VWLohANEZP2dsK11oGhLN5Qp92pxHSe5UlFoA75TP0pGI4oKb9
         Auug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422099; x=1781026899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onXlnB2ZQ1GPIBaPdwRSwTOIJYhcXH8fhqKzxRdltT4=;
        b=mAr2IgZjpGoYMfyZWaGndCjLjRIGNvuLHmNFVzuGJkuHgIcjkZB0uETrDpmlqqxBLN
         QUOMmho51xvyHyw2cFpI2utABCd9Z28l6R3v0duPaMW++8Y7zYJYi8n/noKJEfmcF1O6
         XU+RAt2j96ZeNsB1v+Y6Tfz6MM2P3SZ6DaA/F4Hv9TgHOGwU4qhpY9qRo5AvWWo1Kcow
         bPOk0Rh3G2axDipWjro6v7nCjaU5M0KvqwonYgVxwl4PiRe3fqYwzPuq3PzF80zvLm8v
         sHRDrO5MEwEqb2iDcoaBcHAa1nrloMR6Wnd0EvvvhauFGtz6cQJ5VyzVM+7SsUQVF+1m
         6bsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/87YX0AmvK+SMWVDS8JmLb1WSeXew8sKV5aOTUzR6bB1VoFK1b8HW/OkPQTo2crxfthD2VmTzy1AEiUiOlDNU@vger.kernel.org
X-Gm-Message-State: AOJu0YySHbXPaFIgLjQrWdnrgPA2mLuVnvvaup2wbTkaBbjmfqF3GMNN
	tzIw/8ds+QN0QS6J9LoDhh+b7jL6IlZyg2fziqQ8nLwsClIFJiJoqqk3NOTTVbZT35teFdNTiCK
	zdRA9RJGEbw==
X-Received: from dlbrp10.prod.google.com ([2002:a05:7022:160a:b0:137:e7d3:1490])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:208:b0:130:5ec9:7ad0
 with SMTP id a92af1059eb24-137d42c4145mr7990519c88.41.1780422098768; Tue, 02
 Jun 2026 10:41:38 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:12 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-2-irogers@google.com>
Subject: [PATCH v8 01/18] perf tpebs: Fix concurrent stop races and PID reuse
 hazards in tpebs_stop
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Parallel verbose test execution can trigger a race condition in tpebs_stop
if called concurrently or when PID reuse occurs, causing finish_command()
to block or reap the wrong process.

Introduce a `tpebs_stopping` flag inside intel-tpebs.c to prevent
redundant stop execution paths, and safely restore the `cmd.pid`
temporarily only during `finish_command()` to ensure it is properly reaped,
while preventing other threads from referencing it.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 92 ++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index ed8cfe2ba2fa..bc3b79bfa01a 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -37,6 +37,7 @@ static pthread_t tpebs_reader_thread;
 static struct child_process tpebs_cmd;
 static int control_fd[2], ack_fd[2];
 static struct mutex tpebs_mtx;
+static bool tpebs_stopping;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -52,16 +53,18 @@ struct tpebs_retire_lat {
 	bool started;
 };
 
-static void tpebs_mtx_init(void)
+static void tpebs_init(void)
 {
 	mutex_init(&tpebs_mtx);
+	control_fd[0] = control_fd[1] = -1;
+	ack_fd[0] = ack_fd[1] = -1;
 }
 
 static struct mutex *tpebs_mtx_get(void)
 {
-	static pthread_once_t tpebs_mtx_once = PTHREAD_ONCE_INIT;
+	static pthread_once_t tpebs_once = PTHREAD_ONCE_INIT;
 
-	pthread_once(&tpebs_mtx_once, tpebs_mtx_init);
+	pthread_once(&tpebs_once, tpebs_init);
 	return &tpebs_mtx;
 }
 
@@ -111,6 +114,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 	/* Note, no workload given so system wide is implied. */
 
 	assert(tpebs_cmd.pid == 0);
+	memset(&tpebs_cmd, 0, sizeof(tpebs_cmd));
 	tpebs_cmd.argv = record_argv;
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
@@ -320,20 +324,43 @@ static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
 {
 	int ret = 0;
 
+	if (tpebs_stopping)
+		return 0;
+
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
+		pid_t actual_pid = tpebs_cmd.pid;
+
+		tpebs_stopping = true;
 		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
 		tpebs_cmd.pid = 0;
 		mutex_unlock(tpebs_mtx_get());
 		pthread_join(tpebs_reader_thread, NULL);
 		mutex_lock(tpebs_mtx_get());
-		close(control_fd[0]);
-		close(control_fd[1]);
-		close(ack_fd[0]);
-		close(ack_fd[1]);
-		close(tpebs_cmd.out);
+		if (control_fd[0] >= 0) {
+			close(control_fd[0]);
+			control_fd[0] = -1;
+		}
+		if (control_fd[1] >= 0) {
+			close(control_fd[1]);
+			control_fd[1] = -1;
+		}
+		if (ack_fd[0] >= 0) {
+			close(ack_fd[0]);
+			ack_fd[0] = -1;
+		}
+		if (ack_fd[1] >= 0) {
+			close(ack_fd[1]);
+			ack_fd[1] = -1;
+		}
+		if (tpebs_cmd.out >= 0) {
+			close(tpebs_cmd.out);
+			tpebs_cmd.out = -1;
+		}
+		tpebs_cmd.pid = actual_pid;
 		ret = finish_command(&tpebs_cmd);
 		tpebs_cmd.pid = 0;
+		tpebs_stopping = false;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
@@ -486,30 +513,42 @@ int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret;
 	bool tpebs_empty;
+	bool started_process = false;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
 		return 0;
+
+	mutex_lock(tpebs_mtx_get());
+	if (tpebs_stopping) {
+		mutex_unlock(tpebs_mtx_get());
+		return -EBUSY;
+	}
 	/* Only start the events once. */
 	if (tpebs_cmd.pid != 0) {
 		struct tpebs_retire_lat *t;
 		bool valid;
 
-		mutex_lock(tpebs_mtx_get());
 		t = tpebs_retire_lat__find(evsel);
 		valid = t && t->started;
 		mutex_unlock(tpebs_mtx_get());
 		/* May fail as the event wasn't started. */
 		return valid ? 0 : -EBUSY;
 	}
+	mutex_unlock(tpebs_mtx_get());
 
 	ret = evsel__tpebs_prepare(evsel);
 	if (ret)
 		return ret;
 
 	mutex_lock(tpebs_mtx_get());
+	if (tpebs_stopping || tpebs_cmd.pid != 0) {
+		ret = -EBUSY;
+		goto out;
+	}
 	tpebs_empty = list_empty(&tpebs_results);
 	if (!tpebs_empty) {
+		started_process = true;
 		/*Create control and ack fd for --control*/
 		if (pipe(control_fd) < 0) {
 			pr_err("tpebs: Failed to create control fifo");
@@ -529,7 +568,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
 				   /*arg=*/NULL)) {
 			kill(tpebs_cmd.pid, SIGTERM);
-			close(tpebs_cmd.out);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
@@ -540,8 +578,38 @@ int evsel__tpebs_open(struct evsel *evsel)
 	if (ret) {
 		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
 
-		list_del_init(&t->nd);
-		tpebs_retire_lat__delete(t);
+		if (t) {
+			list_del_init(&t->nd);
+			tpebs_retire_lat__delete(t);
+		}
+
+		if (started_process) {
+			if (tpebs_cmd.pid > 0) {
+				kill(tpebs_cmd.pid, SIGTERM);
+				finish_command(&tpebs_cmd);
+				tpebs_cmd.pid = 0;
+			}
+			if (tpebs_cmd.out >= 0) {
+				close(tpebs_cmd.out);
+				tpebs_cmd.out = -1;
+			}
+			if (control_fd[0] >= 0) {
+				close(control_fd[0]);
+				control_fd[0] = -1;
+			}
+			if (control_fd[1] >= 0) {
+				close(control_fd[1]);
+				control_fd[1] = -1;
+			}
+			if (ack_fd[0] >= 0) {
+				close(ack_fd[0]);
+				ack_fd[0] = -1;
+			}
+			if (ack_fd[1] >= 0) {
+				close(ack_fd[1]);
+				ack_fd[1] = -1;
+			}
+		}
 	}
 	mutex_unlock(tpebs_mtx_get());
 	return ret;
-- 
2.54.0.1013.g208068f2d8-goog

