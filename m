Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622396;
	b=AAWC/cHTJwhcQmj4w0UuefVkVaqz95THoO+5kUNGwzdTS/zlLrRVogbJwyWKyJR3vnBO
	 rA38DV+whO/8mwIMAUVs9z3DJDDSeEoo28nZP5ZC26lyGs8Ny8tfZiycOI5DRM8aBOUOC
	 XzHvFb9TAh3fRdb575xI+4lKmiyCW0EP2nUp+igL17M2llMSQ2Q3jr6bpS2CndAzX0Gee
	 HbRjh7/3NbtouJchJ+KQxMRm+0hnsaNZRvvDreEUMRkjcc0pIjJcEwyJgNoOkhLEDuiB7
	 SrCke4jZQWKFgoE9g9NfJM3iPMZGC1ZkrtC+FlXl9oOq1Zt36S/vlhbPQ+AShgTAQFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
	b=L6NlByKTkMau1fIp9twJsphpX6UC8OPE/v3DXBiyUtcHhE6XemMiJKgNvwd2JSm402RS
	 xGldF1DCsP7GNe8lqx5x2Sdm3/f2G4ilcYWKPQ4pl8rChwx1YeJjmLIk/CEOKgndkRnn4
	 r8wrUcexnFdy0z8BH26qmPCf0FsRWdtsmpudubjvJRs+haNdDp26cI1vr4IN+uN7mkNWJ
	 dpS8auA7x6tp9GgWCJBMZdmI2OXxwFG2vJa3YuBTD2aehMyhMfvwR4OfvmX1shnGUUbSJ
	 ywuvfr6E/pKMa2XrjA4YCUZNXjtYJktXvD11QNpb8j37USImRnP+MLgh61+Qo0UN+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gUIqUiNl;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D0606A32C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gUIqUiNl
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1663fb7e005so1790409c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622395; x=1793227195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
        b=gUIqUiNlsWps7uCKMrspe1bh/dPYiXmYlT334fclxqbvkQ4QLayuIDc6glKaG5rN0w
         0aBEWoQTEBV8nS8u9mqLRlX8J6vdqZzqr1kxjGcA5BgwDa8ARQJKhyMJOLn1+C1AK+A7
         I0TocmeS2VnK+0mVqo6IX+SduNZvHsAcWnvH6nlzguE2BULFO1G0fwjV1KAF5LdCpFGQ
         Qb4nQOFr74ykDLtOiS+oVeDsqbjFNBPct8DcexZlNW/njrnSYI2qcz4etv+zExQgFO0C
         MZxJhhCo1eUlnWE6hBwZ6ZS8c9ANgIY+xgjJRaZ0Ia2SKvLopZebh8pmJ5ETZJ993M83
         w+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622395; x=1793227195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2rrXS1ate7b8OOQCuZc5vd/vkFrx7oPEHSNFj+/YLY=;
        b=LKxBC/qG6Lvb+HM3ZkxP//NGYqEGr+vx3oX5FnBJAVIg+mB5wGrG7EOEgRIPUelerw
         hYzrsKb6uV00lGgi4gxfGoPNf30OBbcAWciT+px+Eg26N/5zof1nxhr6kfEMu34H7u9/
         BXuSfqE74lh5MdTqYAMOSExbWYtj123u/8/sjQ6n/2qHt5H09BzY9aaKMWSmE2jWkliG
         1Rk/zXzcMZ0VAFVAcC/TWyAp1TFsurrWHr+7PCUPjYFVg+Hw95LhFB2+xcmefqi2avq6
         SILu/JTqLdzLvAgI+bs8vcIWexXKIQOUeU0miWhyb2pUzH4MlGFAjcropfSGqtChCgAg
         aMog==
X-Forwarded-Encrypted: i=1; AKwUvBzfY1lJggIDLvYPE7dA1RRtDRnO2ImDdPkcYNUclXN6XusW6F5Ew4dqPIZCKXmxuad3W0gNC7UXcNiptEfygMAV@vger.kernel.org
X-Gm-Message-State: AFq9FYIw+/S6ylw7OPRERqxC7tvCaEk3DsNlkXf5F3lcog8a8MRFC/va
	8BxLfwnWOypvBOA+dQd58m61wb0ZTEMV25++ZGkKnbGKrLsgTg5RSZnpL48MOkk6ZPAPDNqNFmM
	T7hJ44cRBeA==
X-Received: from dlbpt3.prod.google.com ([2002:a05:7022:e803:b0:190:a370:8867])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:465b:b0:14b:cf58:ce15
 with SMTP id a92af1059eb24-190a6eb58e1mr3715874c88.43.1792622394673; Wed, 21
 Oct 2026 15:39:54 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:39:01 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-14-irogers@google.com>
Subject: [PATCH v7 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
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

