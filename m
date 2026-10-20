Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514245;
	b=uzxTGZit3u1VxWCENU3GGxZ9Nel6hL1O2tKFfncTeRGH0tmvOuPpCtX4/fhY7jfSSF4+
	 Wc1lXGJ6FKwLZqPLePdRzyFvS2yJjWdbEMyZ5f9AV7qCWO8ImH3Dz4r/DMApMGocodWBK
	 dUTOlYqsHy0LJ8P6pi1a9oIETOqOd22Y1c/oHIK8eLByb51mFqa6d3kQ7Q1GOHm5XuYAr
	 lypYOTIwXwMOepu4Vl68fqpWOKD7EkUxhT242yt/EZB6QdD+eL63rOBXqMvth391q2r6G
	 MApzlSSIm99FVaQHnOie5B2JPZ7pZy94yCTf762g9NoTLqb1Ac2gCy3GXMWUpo3usQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AHBhTJ6DgmiFrC9tIjIEIYR/ZRkbpnES5KahAOZYnik=;
	b=1UAgKc1vyLb5tXkwgDIj7papEeR0PM4CrUbbfKY4FeD0/LSiZ77mGhTBxkbB6XtapGjE
	 C9nyg8EeUReGoNGAZMDtMIFOiIczH+N06dS/xxOYOF5YU+coatkcRWWYJbq42I9R0zCib
	 fG7VTeK8CtN63hmN+hX7g1LWaTcuLz/Ulk0S8xc+zgoBbbA81u4qgTL5L1orhuv2jZg0f
	 FC6KcVMzBf2AsZmSPZY9MVxsGpmKOmbBlG4GXGPE0JMBFJHdjajxn0Gf/FV0PaTIb1aKw
	 0LEyVT0rzzw8j5ODml2CDoMK/159ynOBTvnFXPqhmUmb2GWbSGz3J2o53h4g2YE/Law==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XLmbAYoI;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C960A5BC3
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2C960A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XLmbAYoI
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso5710956c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514245; x=1793119045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHBhTJ6DgmiFrC9tIjIEIYR/ZRkbpnES5KahAOZYnik=;
        b=XLmbAYoIyKbsJZy8bkXdv6p0cBFR/1+NfGNd/tBLiSNGSB4a5A6YPJjDBvNDPLXQA0
         hyjJsBZsIosTLaPzW9g87hMsQu6wq6PGHygrsgqzu7Qz2y0W+e/x0D6yqx12Z7kCc04/
         xfPihOZ2zJN3bJdyLqiBVgnzy4zKgp6lfe6OT3epGDWTRtbrvWTavzduy+z9M2fQsTY6
         INnZUIdmLhKWLy0+l03Owsf1qRCVTykc81Q4foVB7uYVJvYCildMev/5cbREu/W7PHQc
         HfQ9+sKEhkyTkj4rXtvyiaIMN3GUpBV4+H8j+2YJQJOz24GpPjb+r4UluK1KCJXRbTqk
         PPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514245; x=1793119045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHBhTJ6DgmiFrC9tIjIEIYR/ZRkbpnES5KahAOZYnik=;
        b=OTxEe2d/FRfID7u1DiUhaSt/5MJCJIbYi4U6+VP72gzakmwuDI696F8XWuc+jnXzGP
         dC/JozRDrIcWC4ZLxNMx6yYWja7dG3hkUpGegcw5mRQ4c7/XAnyrKV9zcUvZm26JrxXP
         rGxPaBIUYpHsdXVTPwhF14RnFpG73A4JIGcwmZPe8rZ+MtWYpMJ31hPb3yhcC9vwhWf8
         k2wTydoQEeCsAO37fclEyc49O3aXJ095aGj3fkyiGLBTflwKjmyb2tyZxnSEq26L5c1k
         ViZsic0Zo3DR2MMS29Myku+3a9AOlJrgC1Kf6YaJl4Vcn8O5TDoD3UoH7deVqGcKxzt4
         1t6g==
X-Forwarded-Encrypted: i=1; AKwUvBxaFApR92oYURh0G+xujJ5GhdwTANylC0QjKJ/7gXZMxwRdRtYbAlVFONZy4+dxV+JbkvmUPClr/EQNBMdWRDIV@vger.kernel.org
X-Gm-Message-State: AFq9FYKczVyF4j1t0PbGv+wQCk3bkManC9kCVchlJ8wKWcaUV/6pyAu2
	cc7jjSDTZx7Ut1dbZQdLn3vr+8MrB/oTM86RWqZNWR+nlM5mqm0M27XacSjolEJ3pwCwiIlLqRP
	zxJOu7OOk9w==
X-Received: from dlbvg7.prod.google.com ([2002:a05:7022:7f07:b0:15f:bc5b:ddbb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2906:b0:141:4a06:ad6f
 with SMTP id a92af1059eb24-1851238b5f2mr16989219c88.8.1792514242659; Tue, 20
 Oct 2026 09:37:22 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:36 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-14-irogers@google.com>
Subject: [PATCH v5 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
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
2.56.0.212.g129ede20d9-goog

