Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90717379C49;
	Thu, 21 May 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380176; cv=none; b=QSMYneSQBAl38mkcEsvUCDGgwXfewL+iQsOJrvwuTwSHrwvtW8PQlQW5NqVqUDIz6R2hvpOxHgp1sMyuQYz5Bt9yr1U18IFdNAD16BvSvseseO0sNPQAlgppMQ4IlDH0qK5vROT1Gqcg5wC2G+7nAggEh5yqXVEQhCB+BNenoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380176; c=relaxed/simple;
	bh=h1STcp0V/4Swp9okpNxX5m6mXG3IH5u518En9NVZYjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P682HJdau23unTuFQR7p0EpwzFccosmlS4T+0VT8zbkMMVPoHRI5gq8Kv0INmCa1TFffU6aS565VSRoM3K8Ayz80d8wqGhNGoJ5QCA1uQVPFWiPfJUcNJKJZVyHiTSiYWMcg+bsJ1i4pBZA7Fmx9+Zs0+KLJAg0VZ+k+Zbha6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=t7kwLlRY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="t7kwLlRY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=c2KSnlZfvNvIK/8DF8+f3WK12BTgpI7JujkuE2tGtL8=; b=t7kwLlRYkAUlSQLsyI0KAcJTGt
	F5MIDB61n7ID161jhn+yBdhzu1GkLHrFHDJXnaIkgw/UdJTwBgTXGA4g7ACJjGcoElOfci9+dBPUB
	KZ7UqVzxWwNAFw1gM8rgGuNp29GoBYkOjm86nA2UROwL7yArg8zXTRI7nDJ456SIXvI1fa2GXg2Pm
	X6yoHKluKO+Ik8xSRNBbv7YE3TQk6KxSjlJg55+h/cvenfpB/TanyW3POP8je0no8HYl8Mpkr4VX9
	T1EG3akcjS00zgqUNy3oLT5lQ8caWO30XEZsoT8KgTqOigx1RW76X9Wr0CMoS26ndYGHU1bmw5wlm
	BS7zHhXA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ63x-0040XW-1Z;
	Thu, 21 May 2026 16:15:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 21 May 2026 09:15:37 -0700
Subject: [PATCH v2] perf bench: add --write-size option to sched pipe
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
X-B4-Tracking: v=1; b=H4sIAKgvD2oC/3XNQQqDMBCF4auEWZti0qYRV96jiGTiqNNFDImVF
 vHuRbvu8sHP9zbIlJgy1GKDRCtnngPUQhcC/OTCSJJ7qAXoUt9Lo4yMlIYOKfipixxJoiNN3lr
 rbwiFgJho4PcpPtrfzi98kl8O5igmzsucPuflqo7uv74qqeTVG6xKg07ZqukJ2YXLnEZo933/A
 qa7NbHBAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6547; i=leitao@debian.org;
 h=from:subject:message-id; bh=h1STcp0V/4Swp9okpNxX5m6mXG3IH5u518En9NVZYjA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDy+5lki0gk6aHINcwNe+Jlcy912TQCTlQCxKT
 NFD3DpRFFiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag8vuQAKCRA1o5Of/Hh3
 bSsCEACJLzye2qhmbpZOCb/3LC3QY3SPX3Evq0Kzr4rcCp3o1g2hPC6fBllIUgQOOIMmc2a6GbB
 zp6LKJme7ja2wFU5D8uKOtTgte3B7SltYnVzsM6O+i5Hg5XmognFwYjEmGXIQfKbN60IM47FgEu
 MSBCdgz+KOhtv3P8iD6s1I0JXdhnJsxVK4eCw9wvEKbrJ67xgBLB2E7YT1nREyVVbxlEtkuKQgr
 hexY98Fc/GOaNrrHyyFfih/iqSZ/a7h9KdQzeJrvWBCVLo33jTt/wBMjQPRxpe61YbGt20I+j8l
 DdhcPFAvZEKxl2XGlu6ZDBGlPj3uLtiWjN1LvGpSqnVPDBrUZ20k71I5T8s+wuIzCjY1kTxG0s8
 vtUb02msslbfJY9v8wHGN+X8H+aMKswBPqY8g1uYBkuYVa2cyBw9soCb4/5dWah3qoC+l0DeQro
 cW4HSPj4DKYzp9e03YystWAO6IJayfFg2o3YcFl6iO7T7Ie1ZOKBC4BaShtruHBOMCyjwMWGuU0
 SnkKJ42IPNKq6h0TnTSx6O5Sa9bXCTvWXlH7sHcIFXpa/g4A5Xqet/sAij3UAD17TNsuHG2HFMU
 q57IE1wP2DLEYJVt4jhUxxdSkC3vR+O6Hj7lPEJvUM8WJF/YYeij7W46LC24B63lDK4G0ZlFR0H
 a4aJ2mvEqfli02g==
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
 tools/perf/bench/sched-pipe.c | 47 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f0..216d3121d438d 100644
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
@@ -172,14 +177,14 @@ static void exit_cgroup(int nr)
 
 static inline int read_pipe(struct thread_data *td)
 {
-	int ret, m;
+	int ret;
 retry:
 	if (nonblocking) {
 		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
 		if (ret < 0)
 			return ret;
 	}
-	ret = read(td->pipe_read, &m, sizeof(int));
+	ret = read(td->pipe_read, td->buf, write_size);
 	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
 		goto retry;
 	return ret;
@@ -188,7 +193,7 @@ static inline int read_pipe(struct thread_data *td)
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
-	int i, ret, m = 0;
+	int i, ret;
 
 	ret = enter_cgroup(td->nr);
 	if (ret < 0) {
@@ -204,10 +209,10 @@ static void *worker_thread(void *__tdata)
 	}
 
 	for (i = 0; i < loops; i++) {
-		ret = write(td->pipe_write, &m, sizeof(int));
-		BUG_ON(ret != sizeof(int));
+		ret = write(td->pipe_write, td->buf, write_size);
+		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
 		ret = read_pipe(td);
-		BUG_ON(ret != sizeof(int));
+		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
 	}
 
 	return NULL;
@@ -233,12 +238,39 @@ int bench_sched_pipe(int argc, const char **argv)
 
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
 
+	/*
+	 * On a custom write_size, resize the pipes so a single payload fits.
+	 */
+	if (write_size > sizeof(int)) {
+		int r1 = fcntl(pipe_1[1], F_SETPIPE_SZ, write_size);
+		int r2 = fcntl(pipe_2[1], F_SETPIPE_SZ, write_size);
+
+		if (r1 < 0 || r2 < 0 ||
+		    (unsigned int)r1 < write_size ||
+		    (unsigned int)r2 < write_size) {
+			fprintf(stderr,
+				"--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
+				write_size);
+			return -1;
+		}
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		threads[t].buf = calloc(1, write_size);
+		BUG_ON(!threads[t].buf);
+	}
+
 	gettimeofday(&start, NULL);
 
 	for (t = 0; t < nr_threads; t++) {
@@ -287,6 +319,9 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	for (t = 0; t < nr_threads; t++)
+		free(threads[t].buf);
+
 	exit_cgroup(0);
 	exit_cgroup(1);
 

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-perf_bench_pipe-bae2ec777c4b

Best regards,
--  
Breno Leitao <leitao@debian.org>

