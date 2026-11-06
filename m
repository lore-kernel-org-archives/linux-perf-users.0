Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948662;
	b=aZqVoe6yTO88P0kyHMZv8SjzuGIc064oyBx6E5ivkaIM+SldBFkjXgZCq2mTdv94oyZg
	 IacleuQHKq9NTPSC5N+DXzHIGoa8JnX1MbrwhIr4SC7jYfXZSSGH3U1o6E7F0HrfB/y+l
	 wRju8NNtZy6kzG6jopEElRRvDi/qA1LSnZKIdUMvhjVhCsDy/kbhuBSIXj5QVy7+7ZIS1
	 jTtgF5i47vMqGaCkkU3Pbmar25zx70fZaf0ieNu3/at3pOFA1oZ8UYOLAgRnDY136+Sl/
	 k+wlsoPImpTddUEGrjvm4/UzXdqL9LVhEFXJQpYWMu9AOKYw9Ji2ohsSQ2cpdllfl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z+dBBCd6DYGy7BcCGRVQtidfxmgPCueCGQfmo0iFs44=;
	b=05Z5VXs7DkRQCcYucQrfuHeCgBcX3MqD1qKs1nzD1sDxpYjnzj6UGWXA+D3Qq1mHt0W+
	 Xs0D0ZTTZNl1+kLFNx1wM88y3jHqQaV0wqf3wKulBR+rkj8XMf9tnr5M5jKfS8MlxXitB
	 gGt+VIG0Lf8YGUrY9zFcDDjVx78Mz9SBR+KDrFNJAK60P/n8l2WNC0Gqg382F4aaH3vuT
	 /ipy+O8nONLWcfFVLH1cwr/4bgJTspEE7XWP/Uqvr0iIBWlrPtw2gRr2eUFzINT/WAOmY
	 JAzcIZgIx3SSvXQOWgsnuPFWpWlJV3r3BH49rWX3q+Cn19Afo4bGiu/WaXNVxG9iDLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xc5v10VY;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67506606A33F
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67506606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xc5v10VY
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36de26cb4b3so438327eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948662; x=1794553462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+dBBCd6DYGy7BcCGRVQtidfxmgPCueCGQfmo0iFs44=;
        b=Xc5v10VYmIqvM/US6yWc7dXcmeFAy6A52fVPTMP0EtaMn8sRfWztQz8dim1zMSDswX
         m1xFeYIenyXp/56C2bQpf0uJFvTCZSPecYpwvhtPZYImmReBP/6iGrWciyNZitarYzKM
         lds0cU17HUiAUlhqkdFcHXeV9TXJZghb4IjfKY4ZzUSz/hqtUqkDMu2AfxS3WmO4K0q6
         RxOueW+D4JT+f2T6UeY+x/jaGdIpe/sU+9+9oe+xyuumBEG3I0O0PpGG2m7gwAq8dBkN
         GwSKuTbCpiOoo4s59HLgl5i9+zQIDZohCIUawkuRE45V0uABAwNmJmA0vRolwe0RUXdZ
         5nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948662; x=1794553462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+dBBCd6DYGy7BcCGRVQtidfxmgPCueCGQfmo0iFs44=;
        b=g47RNTUnUYitsfY6mRLrOrErySqxtwdOS7KkLXZfgwQQQLIT0ucLKOZB5r2y41q6mZ
         ckruBsCOy2JVDPdpx0u2ODOUJYlfYikQ38tG4TsuqwrWKbHwhCggYMIlmePuo1xPNE8U
         wI9AVkjHaUByyCfJpICT8ZLgcGAyMdeu9q8T8Me+8Q8AiIV3Sj/nhZHviHAR1b9VUGBg
         I9+7r9QPGtjVKbe1gGu3PauFEp84CLX256kaUbki00cEKrcmtjcw+sLsGX3VwJVrpUNK
         kXFVu6xXZ1sJTxPfq2/Ocol5dWVnnGY2NbGL3UsAqV0kbWLKSe/ZqtJJEUo4pkw3gXBm
         ZMsg==
X-Forwarded-Encrypted: i=1; AL+hErHGfZWPI5OXV+3zqgizTPlXNTOC0re29dEVMsLBtrwViH+ip5i0veqNZZwGriwR3Im4aYCa4JudQHPrDk6c0kFb@vger.kernel.org
X-Gm-Message-State: APuU4Z+0hm9pVIgt/zVDDXK1vjkV66W5t9NKz2OBsEHqokXzK5/232Pd
	Wdky/XqRCFXsmVOTWTvGlstSboCd/24Pnq1/c7ZCFZKIuwDq43o9cd+6nVowFV58+XkMxb9kkbQ
	ZXw3kB71gBg==
X-Received: from dycc7.prod.google.com ([2002:a05:693c:60c7:b0:36c:9ca8:5abe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:690e:b0:35e:2c6:d46c
 with SMTP id 5a478bee46e88-36f76815707mr1890781eec.10.1793948661317; Thu, 05
 Nov 2026 23:04:21 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:39 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-16-irogers@google.com>
Subject: [PATCH v10 15/20] perf intel-tpebs: Fix race in tpebs_stop() and
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
internally and may leave cmd->pid = -1 on error, and join
tpebs_reader_thread on error in evsel__tpebs_open() if it was already
started.

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
2.56.0.455.g6c5a503b38-goog

