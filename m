Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E99498E3D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189127; cv=none; b=d010Hm4j5U2dTHv/6rk+/WpVAsUAtCvrkJXymaQq9o0jyG9AaGxSG+dMjo8P3kCkXQKzt+7oC31+p4e/82hXId6xdkJMKnsFCYup+JMU9Mb7HFvQAFVTL/+XO+Cp1nh/KJkEFU+E73YbYJDu634vCeL0Gh+jS2hyHpf+vF0h/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189127; c=relaxed/simple;
	bh=cnVP24sPxVf7DLFdNE+8GJtq/I4mfxr/kMD9Davd+UA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tm9znFhwdXsZWWPFghHOxx4Ne31Lf0+7XHtHMaNcpaB7tw6wbkDR3iViAuXP3KDkcK9ha4l2yIFj5PSehgrxXa68eoOKFapzLYAa/mSzI7uiqc+ZnMwk/J6SZAbsj8xADGVobi0WoPrWv5CzAk+dxHa+LuVVkVyaHq1SuMDD15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUk+khOb; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUk+khOb"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-151ba226e1bso611082c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189125; x=1792793925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQPYsB3WYXp4pgTL9HnXVVqxTUDv+FCAWpR0WURZtvs=;
        b=oUk+khObVxAVbyzJmMYYDwqJl4x3U7GBjXImn8fQU5qDrcGleJYmEUZJqh2CHLPv4D
         mz82dj6lyP6GTUVVQXy94jcnQgkNPhRrZcxh2+kH2vM5el1soCty9NXff/t+CixpCxUv
         tUyKrYGTGXdNZJ5qpFwoCuA8zlNVppuua/nKZlrgE3U7TwVqs85QOecqIWk5wNqVVezS
         UDHU42r4wV3RBS/GM7U6j7CTRf781v+ws0RAggwSe1c/AdPJEdVJ89N0h5McXf5SxUPn
         b/ZGA2KA6G0XF+mEpXwuBT0fewWNTR2qLyxp4+nkBEzJBWeM3ciO1nUDY0h5DyysbIR4
         A/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189125; x=1792793925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQPYsB3WYXp4pgTL9HnXVVqxTUDv+FCAWpR0WURZtvs=;
        b=ByDpTIJondego+Tg/Hohy7cRyf2ENpTv4AaTiKQ9rczwReXGZV5xL/n9Y2P33ZYR3j
         OcrMeyguvL0F98Assb+AHMAQfTvbNDmrGn/buxUtv39+BjryRSaTY0hNKUIQxK7vaDSR
         ZZOwLqo+veIvNI/hop2yUy8FFjQpP25etTTFmDWciskOZSrmu7jUbixQ0W9MZWB5HACj
         1cbWC3qbTSPimS4kEcKBrhNykRH5qh8tKpm9jj/BbNigUQ26lalN5o5JErPZMCcN3igX
         Z9eWTPFefB3l77vD3Nm2TyAko5lW99900LTVhr78RKVUovkkm/xUOZjqEBukeYDJxjkW
         LJeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIRc0u3j2ecGA5fndzPuTZEueBrv4AyoT6ZWG2zR+xPOJK7k+H72sQAwO7IasDf832W0kOKFJS+vG9N9+Va49/@vger.kernel.org
X-Gm-Message-State: AFq9FYJquZR60wckfE4Qeh6jqWvQWk4Hoj+HTl5Tole1iWSyVb/fmwph
	ScsS/+CuCkDQKPfSOGvrKJ8pwXzj184XhjAg+HB4ZvSntPoJ74it29iyj/HuZTWYX+XxvRj7jQc
	llgOm7tsvLA==
X-Received: from dyaf25-n1.prod.google.com ([2002:a05:693c:8399:10b0:355:e5a8:715f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2610:b0:143:3da5:cada
 with SMTP id a92af1059eb24-185152b6b6bmr1469301c88.37.1792189124811; Fri, 16
 Oct 2026 15:18:44 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:56 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-14-irogers@google.com>
Subject: [PATCH v4 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
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
by perf_session__delete(). Also reset tpebs_cmd.out = -1 if
start_command() fails in evsel__tpebs_start_perf_record(), as
start_command() closes the pipe internally on error without resetting
cmd->out, and join tpebs_reader_thread on error in evsel__tpebs_open()
if it was already started.

Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
<unistd.h> explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 46 ++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7c0b8b15bd10..5954811a94df 100644
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
 
@@ -119,6 +125,8 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 	tpebs_cmd.argv = record_argv;
 	tpebs_cmd.out = -1;
 	ret = start_command(&tpebs_cmd);
+	if (ret)
+		tpebs_cmd.out = -1;
 	zfree(&tpebs_cmd.argv);
 	list_for_each_entry(t, &tpebs_results, nd)
 		t->started = true;
@@ -220,13 +228,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
 
@@ -236,8 +244,10 @@ static void *__sample_reader(void *arg __maybe_unused)
 	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
-	if (IS_ERR(session))
+	if (IS_ERR(session)) {
+		close(data.file.fd);
 		return NULL;
+	}
 	perf_session__process_events(session);
 	perf_session__delete(session);
 
@@ -331,12 +341,19 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
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
@@ -515,6 +532,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 	int ret;
 	bool tpebs_empty;
 	bool started_process = false;
+	bool started_thread = false;
 
 	/* We should only run tpebs_start when tpebs_recording is enabled. */
 	if (!tpebs_recording)
@@ -567,12 +585,15 @@ int evsel__tpebs_open(struct evsel *evsel)
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
@@ -586,9 +607,22 @@ int evsel__tpebs_open(struct evsel *evsel)
 
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
2.56.0.212.g129ede20d9-goog

