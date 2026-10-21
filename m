Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602729;
	b=yN2qWLJMS92ptBu+XB3o9dxGDsAKiCs6IOEMffko2U0LY/nsBBbfzWyfSrZUzWkn3v9V
	 t7tAd6BI8PMd87enYBsUH4rQE50CSrHPAiPeRtJbUAJuWc+1TOSy6qhUqE+HacWlC/b3I
	 IaymVU8ukVr4A18L7oxVSeMhSLnqDfVYui9oGhEKf1ptI8ZrdYaqsoJsAL5nNkWHVracp
	 Uofb5z7d5y7h7LE5YrTzGXcfGs4KVXNxiR1qrWvGlUTXCC1J/v8N5OikRBvcQ8PVI6NI6
	 zDLIs1P426o+6IlFxV4snJwG3NdvdASvf+j1Mx7qD5woPWpYJywaqCBY2bw87bY5/YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
	b=2Mb2hTaRwE0dZ0zlGxv7QbWt6G58pkyvDAGreJG0oXWJTYcBO7hw58tJYx6H0g7DcV8e
	 EQ317E00FK/g5m+jbUKDkzzov5wglcdtuebPIEWJ0kV5XBYVC+gK2C9AHSoflPxlWANVw
	 sjKx3LipagrUvUOd02za5c5cNSq3QMK8Rok76JtZR7RMWg2HkbPYyvrTWN369YQiFMS8V
	 7BPKPqYE87elmwEMsqQKDTD2AzJwHk64g3HGqgUX82Ou514czR5tGNCzsrMQC6J6uQ1Ku
	 MT7sd5FCReQAsBeLVvHsr6FTiEH05gvuVVKyirEWCCtnL631PwtcCmowz10ta/GhypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CbbHbcMQ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD64606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CbbHbcMQ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so2222278eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602728; x=1793207528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
        b=CbbHbcMQiZ+byJpSKHMsv41LI+BX1TPk5IL23P3fEgoK9+wgAxZDil/k8dLkwYd4PY
         05RK+qAD11vMoG9GFnZB+97IK9QdM7tFGWONKWkRiEmR1ogJ60X21QlcWfGokt5SBy0Z
         YQP0vw3K7kcfJS5F7myg4eluhhVo2E+f5s+onwOJH6yyCOft3T9A/fgaQYphvkreCDeF
         E/ahRH1Yrpw9DUA1WbrXyZbX3jW5KflfLTJAEvAU2Wc99Jb0Ub+zOl90nMY/UxlfXnuD
         HVz7fXn6h2lRm43PXRIx/8R2PiwQBDu/8Sr1ujy9NlHr2tNaguhDBSKhEgYJhBI3Jrgr
         jiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602728; x=1793207528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
        b=Mc1kgg6kDTeUfQHAjyCss4ngaRR5c+yQf1apuEewqavszzfTtxNsPBK2RVdvw6ZtES
         kniOyp9t06uoysNpzw2xS5kc9f5NzS7C9FsZOAydSniTKJV/DP3bjgKnX+jvEx4tOciI
         O9F9ouF1L8GBLT/YHpXnKYtxl/Fw8L4waSYTCa6AXmHG3sgcUtUL784l9+Yjiul+nTSH
         gL3M9ez2ejYXamVcLhO9G8V1nQqmF3iffaqSH7k5/xI52a7XNfPdMu4AWPGy9HoeQBo7
         PTUi9jEFIwbgREEE+4lmLwVFdTXHg1fP7fKQMQUkGOklqCxD9ZbeQZPfPVI95FrHn477
         uRqA==
X-Forwarded-Encrypted: i=1; AKwUvBxIPJfPDbPPkhEyCj2T71kozf8FZx84kpKl9n1J0jf2RQizwYJZwZPY/23p+iCYBEla0Q8UywtPDX5GfgVzTTzC@vger.kernel.org
X-Gm-Message-State: AFq9FYJi7iV8D2Vg0uVVfJs5r4AuEUnuZU2IbZleHQAUiZsBIApuhRPX
	YVwYPRwdao9YOC/lNBLn4eH8JLvSC5FXcnVSUnTTlyjBe2Srk/t76WAW+xmUwDpfD9dzZuzQgz3
	ZQ1Mze6RzXw==
X-Received: from dydr17.prod.google.com ([2002:a05:7300:50f1:b0:366:5b79:cc98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:32cd:b0:35d:e0da:ad2d
 with SMTP id 5a478bee46e88-3674cf378ddmr4074485eec.17.1792602727439; Wed, 21
 Oct 2026 10:12:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:39 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-14-irogers@google.com>
Subject: [PATCH v6 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In tpebs_stop(), read tpebs_reader_thread into a local variable before
releasing tpebs_mtx to call pthread_join().

Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it as
the thread argument and setting tpebs_cmd.out = -1 in
evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
by perf_session__delete(). Also reset tpebs_cmd.pid = 0 and tpebs_cmd.out = -1 and return early if
start_command() fails in evsel__tpebs_start_perf_record(), as
start_command() closes the pipe internally and may leave cmd->pid = -1
on error, and join tpebs_reader_thread on error in evsel__tpebs_open()
if it was already started.

Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
<unistd.h> explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7c0b8b15bd10..47c939fc2058 100644
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
 
@@ -120,10 +126,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
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
@@ -220,13 +231,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
 
@@ -236,8 +247,10 @@ static void *__sample_reader(void *arg __maybe_unused)
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-	if (IS_ERR(session))
+	if (IS_ERR(session)) {
+		close(data.file.fd);
 		return NULL;
+	}
 	perf_session__process_events(session);
 	perf_session__delete(session);
 
@@ -331,12 +344,19 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 	/* Like tpebs_start, we should only run tpebs_end once. */
 	if (tpebs_cmd.pid != 0) {
 		pid_t actual_pid = tpebs_cmd.pid;
+		pthread_t reader_thread;
 
 		tpebs_stopping = true;
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
@@ -515,6 +535,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	int ret;
 	bool tpebs_empty;
 	bool started_process = false;
+	bool started_thread = false;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -567,12 +588,15 @@ int evsel__tpebs_open(struct evsel *evsel)
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
 	}
 out:
@@ -586,9 +610,22 @@ int evsel__tpebs_open(struct evsel *evsel)
 
 		if (started_process) {
 			if (tpebs_cmd.pid > 0) {
-				kill(tpebs_cmd.pid, SIGTERM);
+				pid_t actual_pid = tpebs_cmd.pid;
+
+				tpebs_stopping = true;
+				kill(actual_pid, SIGTERM);
+				tpebs_cmd.pid = 0;
+				if (started_thread) {
+					pthread_t reader_thread = tpebs_reader_thread;
+
+					mutex_unlock(tpebs_mtx_get());
+					pthread_join(reader_thread, NULL);
+					mutex_lock(tpebs_mtx_get());
+				}
+				tpebs_cmd.pid = actual_pid;
 				finish_command(&tpebs_cmd);
 				tpebs_cmd.pid = 0;
+				tpebs_stopping = false;
 			}
 			if (tpebs_cmd.out >= 0) {
 				close(tpebs_cmd.out);
-- 
2.56.0.218.g1ec904b173-goog

