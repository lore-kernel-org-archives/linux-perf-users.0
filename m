Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583E207646
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622145; cv=none; b=nk8oSxMa51BheuHKYBprfqNHVzOINNezzFbAwpcbmx+OPYKrCDqMhxP//5V4nnGiV/YrBVkztGkkIo95fSdXQ2651zIj8MHD4scmvmhVo4M/LloEdMEp0T8e8Bw2+QKq/t1WCYnQ2tfp8jUd4LtF3iWjH/srb6+NlUPQMsM7W6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622145; c=relaxed/simple;
	bh=8d5ZbXGg+CS4F+PUcskdXxWDod5xL4EBuLpzbLfOx2g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o8Cl6tISpaswBkfg8ff1v6ggUHiMrio5Ckg692VXHsZbZUrA1rl6BKW7Rj+VaIC49OarE0/Xmwud3dKm7sO+EWIg54Pu5cF00Ua7GdlQfKvncdP9NTtyjca563lNLAOxO3kfrP6rTIZwkGcnUtO45sRfvwGK1DdbIrbxZCVCRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xm6t5Jnc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xm6t5Jnc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5740c858beso913251276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622142; x=1737226942; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KHdCQrYjK76avUgYltveC+FrWILCxlnZWg9B+pOdgg=;
        b=xm6t5Jnc8z07IkWuoACHilm+9iy9uTDmGklcZ7iQ4EPXImvwdzsgK78STXJ+hu4Hfl
         uR8fH2vr8XZ5zcDafats0Qyju+O+EewayUMpy7XIc+J4pAR0YJ/1Pvc4l0HRCWQJ3kUm
         gjLN5oSFiM2TgE7rr/42pGqUHJxBt07KlWIArSzyqKMWNGc3WpczCNRVx/VQ8zHDLFUq
         w+/ViovAAu5I/UZeozmqAzgGwgwyqnnKJg7aSW0u9NghsLWcsFtoJhknAs1WIboQJDaT
         Y2rHGLiIDXIpPGoCIm0DLukGcnP8YR6a9l9iuP+voC1SRHnLJtX/vX1YLtmV2SZPnpuF
         2xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622142; x=1737226942;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KHdCQrYjK76avUgYltveC+FrWILCxlnZWg9B+pOdgg=;
        b=NMZNOhKzq+z6bqliaeH23Nlt4fE4rMSwuI0amF4K7MFyZWFgeCAowjy+cjLPZsmXp2
         oGT31NWtmafMIi9JnmZHimrAeGlhWTf12G2t06lWvVeIR16qqibxg6dUUswNbwQ/bR3O
         2gKrbskHBeWLT6YFa92yo3FUFrlRqEzMZkL0odqUpOWua90/Ktk0UMHXi0+SqCZxUPVR
         FWcSuwZGZV5m8e9PqVuIEo99p4uPZV/1tfnWPHSiLRYUSLxO1TbPjgfJvJeJPEuPgDif
         69UHkB84JTJsEs7hyNzKSE33SZ5c/w8o7xikBC8Pf9sytuzsF6JMz8soWe+qCuetqJXz
         JNrg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGH6KufSArR2YczMYXZaNlOrIl3rHAjYXVk+wjkXxoitzd/92b19ODhM/ymWB82GgUiD0Rxmm19wE2GEnE6f2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GKIqXnpEunSiX108/v43e6BVL70MQ9HJYojGHkz/IlmZQIUH
	rD7ZgtAxQzCcLU98P6NoFOR0b3qbvsJNLQ1HdO3tUUDQKcI0c3/736xagOJScZaDhAoVMSJVTHU
	ZgtVESg==
X-Google-Smtp-Source: AGHT+IFPtElgJRccVOWvDP8xI+8WJBxpOJzmwpiRcDdRn2q0TflIymCwYwyTqswzTFZ7olVJ5MONMO9wG84S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a05:690c:6b84:b0:6dd:fda3:6568 with SMTP
 id 00721157ae682-6f5312dcab5mr420237b3.3.1736622142666; Sat, 11 Jan 2025
 11:02:22 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:43 -0800
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
Message-Id: <20250111190143.1029906-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 10/10] perf thread_map: Remove uid options
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now the target doesn't have a uid, it is handled through BPF filters,
remove the uid options to thread_map creation. Tidy up the functions
used in tests to avoid passing unused arguments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c             |  4 +--
 tools/perf/tests/keep-tracking.c           |  2 +-
 tools/perf/tests/mmap-basic.c              |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/tests/perf-time-to-tsc.c        |  2 +-
 tools/perf/tests/switch-tracking.c         |  2 +-
 tools/perf/tests/thread-map.c              |  2 +-
 tools/perf/util/evlist.c                   |  2 +-
 tools/perf/util/python.c                   | 10 +++----
 tools/perf/util/thread_map.c               | 32 ++--------------------
 tools/perf/util/thread_map.h               |  6 ++--
 12 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 2148024b4f4a..ae3b98bb42cf 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -62,7 +62,7 @@ static int attach__current_disabled(struct evlist *evlist)
 
 	pr_debug("attaching to current thread as disabled\n");
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
 		return -1;
@@ -88,7 +88,7 @@ static int attach__current_enabled(struct evlist *evlist)
 
 	pr_debug("attaching to current thread as enabled\n");
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("failed to call thread_map__new\n");
 		return -1;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 5a3b2bed07f3..eafb49eb0b56 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -78,7 +78,7 @@ static int test__keep_tracking(struct test_suite *test __maybe_unused, int subte
 	int found, err = -1;
 	const char *comm;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	CHECK_NOT_NULL__(threads);
 
 	cpus = perf_cpu_map__new_online_cpus();
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 012c8ae439fd..cf2ca28aa0f7 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -46,7 +46,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	char sbuf[STRERR_BUFSIZE];
 	struct mmap *md;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (threads == NULL) {
 		pr_debug("thread_map__new\n");
 		return -1;
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index fb114118c876..3644d6f52c07 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -28,7 +28,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
 	cpu_set_t cpu_set;
-	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new_by_tid(getpid());
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 131b62271bfa..b54cbe5f1808 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -20,7 +20,7 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
 	int err = TEST_FAIL, fd;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
-	struct perf_thread_map *threads = thread_map__new(-1, getpid(), UINT_MAX);
+	struct perf_thread_map *threads = thread_map__new_by_tid(getpid());
 	char sbuf[STRERR_BUFSIZE];
 	char errbuf[BUFSIZ];
 
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index bbe2ddeb9b74..c2a6b451d7ff 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -90,7 +90,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 	struct mmap *md;
 
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	CHECK_NOT_NULL__(threads);
 
 	cpus = perf_cpu_map__new_online_cpus();
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 576f82a15015..0691c272537c 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -345,7 +345,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	const char *comm;
 	int err = -1;
 
-	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	threads = thread_map__new_by_tid(getpid());
 	if (!threads) {
 		pr_debug("thread_map__new failed!\n");
 		goto out_err;
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 1fe521466bf4..54209592168d 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -115,7 +115,7 @@ static int test__thread_map_remove(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_VAL("failed to allocate map string",
 			asprintf(&str, "%d,%d", getpid(), getppid()) >= 0);
 
-	threads = thread_map__new_str(str, NULL, 0, false);
+	threads = thread_map__new_str(str, /*tid=*/NULL, /*all_threads=*/false);
 	free(str);
 
 	TEST_ASSERT_VAL("failed to allocate thread_map",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1fd91b5e8777..f686c9f5054d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1006,7 +1006,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b4bc57859f73..2488f6f4a3f7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -566,14 +566,14 @@ struct pyrf_thread_map {
 static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
 				 PyObject *args, PyObject *kwargs)
 {
-	static char *kwlist[] = { "pid", "tid", "uid", NULL };
-	int pid = -1, tid = -1, uid = UINT_MAX;
+	static char *kwlist[] = { "pid", "tid", NULL };
+	int pid = -1, tid = -1;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|iii",
-					 kwlist, &pid, &tid, &uid))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ii",
+					 kwlist, &pid, &tid))
 		return -1;
 
-	pthreads->threads = thread_map__new(pid, tid, uid);
+	pthreads->threads = thread_map__new(pid, tid);
 	if (pthreads->threads == NULL)
 		return -1;
 	return 0;
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index b5f12390c355..ca193c1374ed 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -72,7 +72,7 @@ struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
 	return threads;
 }
 
-static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
+static struct perf_thread_map *thread_map__new_all_cpus(void)
 {
 	DIR *proc;
 	int max_threads = 32, items, i;
@@ -98,15 +98,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 		if (*end) /* only interested in proper numerical dirents */
 			continue;
 
-		snprintf(path, sizeof(path), "/proc/%s", dirent->d_name);
-
-		if (uid != UINT_MAX) {
-			struct stat st;
-
-			if (stat(path, &st) != 0 || st.st_uid != uid)
-				continue;
-		}
-
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
 		if (items <= 0) {
@@ -157,24 +148,11 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	goto out_closedir;
 }
 
-struct perf_thread_map *thread_map__new_all_cpus(void)
-{
-	return __thread_map__new_all_cpus(UINT_MAX);
-}
-
-struct perf_thread_map *thread_map__new_by_uid(uid_t uid)
-{
-	return __thread_map__new_all_cpus(uid);
-}
-
-struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid)
 {
 	if (pid != -1)
 		return thread_map__new_by_pid(pid);
 
-	if (tid == -1 && uid != UINT_MAX)
-		return thread_map__new_by_uid(uid);
-
 	return thread_map__new_by_tid(tid);
 }
 
@@ -289,15 +267,11 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 	goto out;
 }
 
-struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid,
-				       uid_t uid, bool all_threads)
+struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid, bool all_threads)
 {
 	if (pid)
 		return thread_map__new_by_pid_str(pid);
 
-	if (!tid && uid != UINT_MAX)
-		return thread_map__new_by_uid(uid);
-
 	if (all_threads)
 		return thread_map__new_all_cpus();
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 00ec05fc1656..fc16d87f32fb 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -11,13 +11,11 @@ struct perf_record_thread_map;
 struct perf_thread_map *thread_map__new_dummy(void);
 struct perf_thread_map *thread_map__new_by_pid(pid_t pid);
 struct perf_thread_map *thread_map__new_by_tid(pid_t tid);
-struct perf_thread_map *thread_map__new_by_uid(uid_t uid);
-struct perf_thread_map *thread_map__new_all_cpus(void);
-struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
+struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid);
 struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event);
 
 struct perf_thread_map *thread_map__new_str(const char *pid,
-		const char *tid, uid_t uid, bool all_threads);
+		const char *tid, bool all_threads);
 
 struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
-- 
2.47.1.613.gc27f4b7a9f-goog

