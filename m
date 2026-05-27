Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54542189F;
	Wed, 27 May 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889409; cv=none; b=foFUwJg1zHPjvkQrxMd9r1mzmVL1h5bigdnAFIcZVVn7K9xHATqhJuGIZNuuJtoVX+q50hJVcD8Luu/tRYfX3TsxwJ7p1m8H5TEhvtgaTyXdxpuhR6SDe0yIJyJvygQPdn5HYy+vOijDwx5t5ovggyuZ5DRPu09xFwThfqV/p30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889409; c=relaxed/simple;
	bh=/SYBOpXwA3JUorT0XmzfFqTpZf8EbTeitIVCpglX37Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OPSLGA26vZ5K4tMgY6a2dXDilWeWDphvqmE7ZBcLK1kpTbXXI8G1zAz9ZeiMQmcVPHUSIrwSGFiaBzAqtF50gnZ09jB30/msZmAJZ60rKODnc60zAukIeP7TRyZlGVn08GLYe9GDT11C/sxZV0VPKpdJChmr9N69E+b8nd6NtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K0FiAONN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K0FiAONN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=3CjuvZLddchMM73n5OQ7RqkFRKjnZF9ch2/4sDAS2Ms=; b=K0FiAONNkyjTVF1G2LHqA4dCiG
	WL4DBvWkBVppyK7tnhpEhYEYl+kS3pxC35Xw+BTRpHNi16pI1lMKTUo4rTEMZQeSPBz+OIeHt7v33
	PJX6WNfpzNnYPsNAeJmlaUDPgzxW9mZSJlNPoxM0aq1aeqaYmpkKg1QeXeyHtnJ2Xnh09rrcDYB4y
	1f6HlraXF8XXytBx3pqnqKFtdIpLa7zkQa+pOuMA+akr0UFDiq3jwFYomlawm5aTiPiQK8cCLGj2y
	io9eTsdTgHXxafCzMv76t23sg9fh72BLtuMEmd5VeqNRyXYyGXr3J1eTjb7Mkid9E1zrXB4erN1Af
	Wojfpveg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEXP-003CbU-39;
	Wed, 27 May 2026 13:43:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 May 2026 06:42:59 -0700
Subject: [PATCH v3] perf bench: add --write-size option to sched pipe
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
X-B4-Tracking: v=1; b=H4sIAOL0FmoC/3XN0QrCIBiG4VuR/zhDXc6xo+4jYqj73exgE11Sj
 N17uE6K6PCDl+dbIWH0mKAlK0TMPvl5gpZUBwJ21NOA1PfQEhBM1ExySQNG1xmc7NgFH5AajQK
 tUsqeDBwIhIjOP3bxcn3vdDc3tEthSjH6tMzxuV9mXrr/euaU08pK0zBpNFfNuUfj9XSc4wCFz
 +IDEPwXEJRTJZipnVOOOf0FbNv2Ai17EvsCAQAA
X-Change-ID: 20260515-perf_bench_pipe-bae2ec777c4b
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7984; i=leitao@debian.org;
 h=from:subject:message-id; bh=/SYBOpXwA3JUorT0XmzfFqTpZf8EbTeitIVCpglX37Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvTsqTvp0j8oh/oqVWeBqpEBWfvz8gh1P/721
 d6KfgpC5deJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb07AAKCRA1o5Of/Hh3
 bXwCD/9ObLAAW8avnFGjEBUVtG7NLmOPMk/U0N4PeIYWQP1KVy9BTukBs8ZNnW/6Xg8+fonEGX3
 ib4UzGHf6qCTt9aw14PJkjolfrhUmC2iICQqWQl2oxgbkwz/1XUFtVeek0W9mxu3WmTNMWVj3c9
 +lnav+u4GUkjVb9k19kgQyYtyC8xokvMnSREXz6vpCySWHxz840R2/je9UG63TxYgHloy0/ZHjs
 IPVTRhTNP+vsAu4MvDOxaI7JxtEMeW6ji3wr1uHmoHFR0lRu+Ej0H8lQwWaesrcHni1xyaUAHf7
 TgmFm5Gb8dgwToWKxVeFSJRnN5jQeuaYNrlu8VMNeZgplZOCEkK6YsPF1jtcsMhfG8F2gyunbnk
 A7So8PNDtLdS0mqThGHFyg5qaN8grqukSRjkUVzn27IUIQp39e19rGgr2LvDzQVlwNmcCiigCcm
 h3niPMADKC8SoG3Wp16CJhb71Q1OQB/17G2xyeIYQNC93gyB7wy6iwG9oWyshTuq/6uccInqpJp
 rMnlMSvRC7DVuZMf3ry82cXGDsho8vOEEeShNjjws5e1QQrmD3b7oxOcXy7DQ2gkDe/V61CLw9V
 UQzlc9DJC5L0upbd+ncV0v1QExNAADN+1RvwLErF7WgsKNiDWvDXSPr4Jj91JKbmbZUWuRlj8If
 xRbmyeaIC21ceog==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
exercises only the pipe-buffer merge path and keeps allocation entirely
out of the picture. That makes the bench a useful scheduler / context-
switch latency probe but unable to surface anything from the pipe
page-allocation hot path.

Add a -s/--write-size option that sets the bytes written and read per
ping-pong iteration. The buffer is allocated for each side via
struct thread_data and replaces the on-stack int previously used. The
default remains sizeof(int) so existing invocations are unchanged.

With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
through alloc_page() (or the bulk pre-alloc, if the relevant patch is
applied), which is what we want when measuring pipe locking and page
allocation work.

The bench is a ping-pong: both sides call write() before read(), so a
single write_size payload must fit entirely in the pipe buffer or both
sides deadlock waiting for the other to drain. Resize the pipe via
F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
and error out cleanly when the request exceeds
/proc/sys/fs/pipe-max-size.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
This patch has been valuable for testing and verifying the pipe
enhancements currently under discussion at
https://lore.kernel.org/all/20260515-fix_pipe-v1-0-b14c840c7555@debian.org/
---
Changes in v3:
- Loop on short read()/write() in the worker via new
  pipe_xread()/pipe_xwrite() helpers, instead of asserting that the
  full payload is always transferred in one call (suggested by
  Namhyung).
- Link to v2: https://patch.msgid.link/20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org

Changes in v2:
- Reject --write-size == 0 to avoid a zero-byte ping-pong that spins
  (blocking mode) or hangs on epoll_wait (non-blocking mode).
- Validate --write-size <= INT_MAX and drop the (int) casts in the
  read/write BUG_ON and fcntl(F_SETPIPE_SZ) checks, so the comparisons
  are unambiguous regardless of the requested size.
- Fix "acommodate" typo in the pipe-resize comment.
- Link to v1: https://patch.msgid.link/20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/bench/sched-pipe.c | 102 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 13 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f..7a14abc36047 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <assert.h>
 #include <sys/epoll.h>
 #include <sys/time.h>
@@ -39,6 +40,7 @@ struct thread_data {
 	int			epoll_fd;
 	bool			cgroup_failed;
 	pthread_t		pthread;
+	char			*buf;
 };
 
 #define LOOPS_DEFAULT 1000000
@@ -48,6 +50,7 @@ static	int			loops = LOOPS_DEFAULT;
 static bool			threaded;
 
 static bool			nonblocking;
+static unsigned int		write_size = sizeof(int);
 static char			*cgrp_names[2];
 static struct cgroup		*cgrps[2];
 
@@ -88,6 +91,8 @@ static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
+	OPT_UINTEGER('s', "write-size", &write_size,
+		     "Bytes per ping-pong write (default 4-bytes). Use larger values to exercise the pipe page-allocation path."),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
 		     parse_two_cgroups),
@@ -170,25 +175,57 @@ static void exit_cgroup(int nr)
 	free(cgrp_names[nr]);
 }
 
+/*
+ * Loop on short read()/write(): the kernel may return fewer bytes than
+ * requested, and in non-blocking mode the writer can transiently hit
+ * EWOULDBLOCK while the peer is still draining a full pipe (capacity is
+ * sized to write_size).
+ */
+static inline int write_pipe(struct thread_data *td)
+{
+	unsigned int done = 0;
+	int ret;
+
+	while (done < write_size) {
+		ret = write(td->pipe_write, td->buf + done, write_size - done);
+		if (ret < 0) {
+			if (nonblocking && errno == EWOULDBLOCK)
+				continue;
+			return ret;
+		}
+		done += ret;
+	}
+	return done;
+}
+
 static inline int read_pipe(struct thread_data *td)
 {
-	int ret, m;
-retry:
-	if (nonblocking) {
-		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
-		if (ret < 0)
+	unsigned int done = 0;
+	int ret;
+
+	while (done < write_size) {
+		if (nonblocking) {
+			ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
+			if (ret < 0)
+				return ret;
+		}
+		ret = read(td->pipe_read, td->buf + done, write_size - done);
+		if (ret < 0) {
+			if (nonblocking && errno == EWOULDBLOCK)
+				continue;
+			return ret;
+		}
+		if (ret == 0)
 			return ret;
+		done += ret;
 	}
-	ret = read(td->pipe_read, &m, sizeof(int));
-	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
-		goto retry;
-	return ret;
+	return done;
 }
 
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
-	int i, ret, m = 0;
+	int i, ret;
 
 	ret = enter_cgroup(td->nr);
 	if (ret < 0) {
@@ -204,15 +241,38 @@ static void *worker_thread(void *__tdata)
 	}
 
 	for (i = 0; i < loops; i++) {
-		ret = write(td->pipe_write, &m, sizeof(int));
-		BUG_ON(ret != sizeof(int));
+		ret = write_pipe(td);
+		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
 		ret = read_pipe(td);
-		BUG_ON(ret != sizeof(int));
+		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
 	}
 
 	return NULL;
 }
 
+/*
+ * On a custom write_size, resize the pipes so a single payload fits.
+ */
+static int resize_pipes(int wfd1, int wfd2)
+{
+	int r1, r2;
+
+	if (write_size <= sizeof(int))
+		return 0;
+
+	r1 = fcntl(wfd1, F_SETPIPE_SZ, write_size);
+	r2 = fcntl(wfd2, F_SETPIPE_SZ, write_size);
+	if (r1 < 0 || r2 < 0 ||
+	    (unsigned int)r1 < write_size ||
+	    (unsigned int)r2 < write_size) {
+		fprintf(stderr,
+			"--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
+			write_size);
+		return -1;
+	}
+	return 0;
+}
+
 int bench_sched_pipe(int argc, const char **argv)
 {
 	struct thread_data threads[2] = {};
@@ -233,12 +293,25 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
+	if (write_size == 0 || write_size > INT_MAX) {
+		fprintf(stderr, "--write-size must be in 1..%d\n", INT_MAX);
+		return -1;
+	}
+
 	if (nonblocking)
 		flags |= O_NONBLOCK;
 
 	BUG_ON(pipe2(pipe_1, flags));
 	BUG_ON(pipe2(pipe_2, flags));
 
+	if (resize_pipes(pipe_1[1], pipe_2[1]) < 0)
+		return -1;
+
+	for (t = 0; t < nr_threads; t++) {
+		threads[t].buf = calloc(1, write_size);
+		BUG_ON(!threads[t].buf);
+	}
+
 	gettimeofday(&start, NULL);
 
 	for (t = 0; t < nr_threads; t++) {
@@ -287,6 +360,9 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	for (t = 0; t < nr_threads; t++)
+		free(threads[t].buf);
+
 	exit_cgroup(0);
 	exit_cgroup(1);
 

---
base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
change-id: 20260515-perf_bench_pipe-bae2ec777c4b

Best regards,
--  
Breno Leitao <leitao@debian.org>

