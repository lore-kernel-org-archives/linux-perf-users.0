Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700149;
	b=I/eLVIeKwKCBooNSbZyiE1QTAZ8IKU0sg6ADFfGcwVGp+fa/H63ikyzovEF16/fHkG+F
	 ZeF7C8xsg/hytYMCAWpUC5KkRAhZuZpgfzTng2FJEjrr2SyLGz3UGg0gi+GJOPLEX/WKI
	 uZEGpG5Djhpf81tzBSOz4fwfYS+mWilnNJzFHNlcs+myeqOxa/N3RwOzuEOQbxG26GOQH
	 QQ22gg+JgfJ0oT2Vj9PIALQC6aDJRce8o57D24C1oLNu6trSmaBsnVDl1BN7B3l8+r0rL
	 qtptpkOeakz0iGXDtSxpGuaovnk4bNLO/ZgLap7axHq5k6Tfy2Hi1O8i7oQv9ProEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2xDkyVwKOR14cu0DSimvn78NCfE/+WZV/F/W5kCR4EI=;
	b=qThpimlMGasRORFFJerMpwrJyp0ekMmvDl7z6b/3Aek+3MoN6KjoYoBRzfexAtfI8kas
	 Ggs6VPumOMPyTxU2AJOzjdvsheFe8Ysf8v3Rq1jThV8ThxE/7OdtXhRLGmH4jCzmTJItH
	 zQFA51PkgaPu8R71sgl/DQCmKryVGxwC4k/cWqbXCdBqmKyenF4aw0DeAGA8VfSFKiJ31
	 5a6BkH8+5JJ75aw8A5ENQVchykkKwC+qvgXnqjbOUU1NVJCIax0qDdaf8h1fJSKKUKw1L
	 m8r5E2qvlhEp8NNSUXBAZgvzcp6MXXSOe4VqbxvjAzXp2NLeZMXqw8+1jPnb6PdEQMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VyXX0gr+;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484860A2607
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7484860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VyXX0gr+
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso254687eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700149; x=1793304949; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xDkyVwKOR14cu0DSimvn78NCfE/+WZV/F/W5kCR4EI=;
        b=VyXX0gr+sBaRxXxNGuq3Dw8uX+XUgA3b99aidyguVrUZRT1nlUyIa66CtHvMwdwUHw
         +7d3v9FW70+nJlCf3w5k/tGSPkLMxh7REBSHxzu5btEKBfB5N8yaiCWDbpjyLZ+4cJSC
         L3Xhzs4/94+2/DpXqnO7ssjDdcdbpb8+G9qN8ilm6QoUh0k3lST2SNOMLpCqqhuLZCEa
         6WHLzFB9m24Vg6S7FLaUhY3m9nOMJfF5RYfC2j0Vw+T8gRb/r/M1bhSC+ar1IayqlQkL
         jH2kgOPR2ioFvLLwzAOL+GjCEDojGf9raPiZD4aeQL6QWjM6REYRJ3MVMqivc1ZwXgle
         iqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700149; x=1793304949;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xDkyVwKOR14cu0DSimvn78NCfE/+WZV/F/W5kCR4EI=;
        b=vz6pNTzs1THfQPk9ACokcpHqWKojIsst/mPEmTGeQxyAFv3ZSzbQlJU2E4BXnJWsa/
         YgxSxFTyEnO5kBOnHvoMZtCExjTWDG3XYTyRsvOcWgtwGlNwS1pzSL1XEaPaio4s/SPe
         k2hbPN3mTM61/1P+GPBPuD1nv458IS2x4qYzcOwRvc/weC7K6GRaJ2oi4oSXgwttuQCG
         K2j1sCTu6gE2CedmBB8rmh4DIgtUqnihUPy/F1r5Clv1/1EA2GFXSKuKKICYulczyN6i
         IFbzsPuWpPDrmAJmLsUkxrxmEvYDNYMY+xgPq/0HPZ86a5jck2pr0ZXEhwNezgwTsJ2X
         zwuA==
X-Forwarded-Encrypted: i=1; AKwUvByk6208O7XqJNhNbiOuek8jk08Ym1FVJ5wklekf9Owfhy9oASi2s3tZGVyTrvBUQAvD6Q69K3arQgAbIpk6NrBK@vger.kernel.org
X-Gm-Message-State: AFq9FYIp+JMpW8O1XxgYA9zWDoa/Pv90KMMkC6njO72tUFR0Et8iHO5d
	pA6a5+yKZxHDGNLXcNDAvxpCRxUM9+FSlcutJ35WSkg9Z26OvFNmj8jlstahU0XUjg2BXzmMsJl
	csKjdDu0YYA==
X-Received: from dleb17-n2.prod.google.com ([2002:a05:701b:4251:20b0:15e:225e:ae03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4559:10b0:15b:7f7a:730d
 with SMTP id a92af1059eb24-195c77a8177mr315037c88.28.1792700148205; Thu, 22
 Oct 2026 13:15:48 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:48 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-16-irogers@google.com>
Subject: [PATCH v8 15/19] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.307.g5fe7bd680c-goog

