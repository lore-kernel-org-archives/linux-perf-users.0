Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0231F4C8B;
	Wed,  2 Apr 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629856; cv=none; b=Xnsx4A6w96lfhDNGAS5BKzYkZkJ1E3p6DKgjRzp6WS8UDXulTjkKIxzYfjWgaNjNr7cX+ZKDjc9tVASBis9O6z7r7gdPEEIq8mbuatq+ci402MeHZI97rmTPMfGTIwdP9RjIERbb5pr/Cz/OH7espNmof3G6X7WZ+GIHtRk/16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629856; c=relaxed/simple;
	bh=MTCvIyCFkt1ZD21YOEh+cRwWjkmrYfLmaqh3tH2V79o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1+np9NCzhzOi4HHmYBLGDV6FSPgqvSbEafJGNMyjgvpK+UKOr/CBUt7glsGtPdFV1o2q6PMCTdvxHYTz6nK1hYvz0NJu82zyP4If4pKGH2B7D0EgRAso6fE3zIGqqROXVEdNt5Wr59rQYrn9ePWejhbMqut9TNIDhrFZ1rav8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=YVPNn/Ew; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="YVPNn/Ew"
Received: from localhost (ip-109-42-179-236.web.vodafone.de [109.42.179.236])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 532LOmnX030757
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 2 Apr 2025 23:24:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743629089; bh=MTCvIyCFkt1ZD21YOEh+cRwWjkmrYfLmaqh3tH2V79o=;
	h=From:To:Cc:Subject:Date;
	b=YVPNn/Ew1rG+/9VZhvku7uYbJxYlAb5mPU7q0ei0HZRISi7ixTSZELj0X2/IR8MZi
	 K0U/cgMlxvO7948C9tSDK3r5KIHGq955Rs62W+reESSYGa1sxEEGeJJYDMw6mWgxTx
	 CtRndyqnCvgXGw/SY+2rROqYupgj2Q0TGa1c/eo8=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Dirk Gouders <dirk@gouders.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf bench sched pipe: add -p/--nprocs to run more than 2 workers
Date: Wed,  2 Apr 2025 23:15:26 +0200
Message-ID: <20250402212402.15658-2-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Partly, sched-pipe.c looks as if it was designed to run more than two
workers, but that possibility is still missing.

Introduce a new option -p/--nprocs to specify the number of
processes/threads to run the worker function.
The worker function remains to simulate a ring structure, analogous
to lmbench.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/Documentation/perf-bench.txt |  13 ++
 tools/perf/bench/sched-pipe.c           | 152 ++++++++++++++++--------
 2 files changed, 113 insertions(+), 52 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 8331bd28b10e..5c8dc99e1c57 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -118,6 +118,16 @@ options (20 sender and receiver processes per group)
 Suite for pipe() system call.
 Based on pipe-test-1m.c by Ingo Molnar.
 
+Create a number of processes (default is 2) and a pipe for each of
+them.  Then, send tokens using the pipe ends for a specified number of
+loops (default 1,000,000).
+
+By default, theses Processes send tokens of length 4 (an int) by
+simulating a ring structure which means each process has two peers.
+It sends the tokens to one of its peers and receives them from its other
+peer (in case of 2 processes those peers are identical and just the other
+process).
+
 Options of *pipe*
 ^^^^^^^^^^^^^^^^^
 -l::
@@ -131,6 +141,9 @@ This is useful to check cgroup context switching overhead.
 Note that perf doesn't create nor delete the cgroups, so users should
 make sure that the cgroups exist and are accessible before use.
 
+-p::
+--nprocs=::
+Number of processes to use for sending tokens along the pipes.
 
 Example of *pipe*
 ^^^^^^^^^^^^^^^^^
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f..89a54d33eee0 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -32,7 +32,9 @@
 #include <pthread.h>
 
 struct thread_data {
-	int			nr;
+	unsigned int		nr;		/* index of this worker */
+	struct thread_data	*td;		/* The data for all workers (including us).*/
+	pid_t			pid;
 	int			pipe_read;
 	int			pipe_write;
 	struct epoll_event      epoll_ev;
@@ -42,14 +44,15 @@ struct thread_data {
 };
 
 #define LOOPS_DEFAULT 1000000
-static	int			loops = LOOPS_DEFAULT;
+static	unsigned int		loops = LOOPS_DEFAULT;
 
 /* Use processes by default: */
 static bool			threaded;
+static unsigned int		nr_threads = 2;
 
 static bool			nonblocking;
-static char			*cgrp_names[2];
-static struct cgroup		*cgrps[2];
+static char			**cgrp_names;
+static struct cgroup		**cgrps;
 
 static int parse_two_cgroups(const struct option *opt __maybe_unused,
 			     const char *str, int unset __maybe_unused)
@@ -86,7 +89,8 @@ static int parse_two_cgroups(const struct option *opt __maybe_unused,
 
 static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
-	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
+	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
@@ -185,81 +189,117 @@ static inline int read_pipe(struct thread_data *td)
 	return ret;
 }
 
+/*
+ * Worker thread for nodes forming a ring, receiving tokens from the left
+ * neighbor and sending them to the right one.
+ */
 static void *worker_thread(void *__tdata)
 {
-	struct thread_data *td = __tdata;
-	int i, ret, m = 0;
+	struct thread_data *this_thread = __tdata;
+	struct thread_data *threads_all = this_thread->td;
+
+	unsigned int right;
+	unsigned int i;
+	int ret, m = 0;
+	int write_fd;
 
-	ret = enter_cgroup(td->nr);
+	ret = enter_cgroup(this_thread->nr);
 	if (ret < 0) {
-		td->cgroup_failed = true;
+		this_thread->cgroup_failed = true;
 		return NULL;
 	}
 
 	if (nonblocking) {
-		td->epoll_ev.events = EPOLLIN;
-		td->epoll_fd = epoll_create(1);
-		BUG_ON(td->epoll_fd < 0);
-		BUG_ON(epoll_ctl(td->epoll_fd, EPOLL_CTL_ADD, td->pipe_read, &td->epoll_ev) < 0);
+		this_thread->epoll_ev.events = EPOLLIN;
+		this_thread->epoll_fd = epoll_create(1);
+		BUG_ON(this_thread->epoll_fd < 0);
+		BUG_ON(epoll_ctl(this_thread->epoll_fd, EPOLL_CTL_ADD, this_thread->pipe_read, &this_thread->epoll_ev) < 0);
 	}
 
+	right = (this_thread->nr + 1) % nr_threads;
+	write_fd = threads_all[right].pipe_write;
+
 	for (i = 0; i < loops; i++) {
-		ret = write(td->pipe_write, &m, sizeof(int));
+		ret = write(write_fd, &m, sizeof(int));
 		BUG_ON(ret != sizeof(int));
-		ret = read_pipe(td);
+		ret = read_pipe(this_thread);
 		BUG_ON(ret != sizeof(int));
 	}
 
 	return NULL;
 }
 
+static int create_pipes(struct thread_data *tdata)
+{
+	int __maybe_unused flags = 0;
+	int pipe_fds[2];
+	unsigned int i;
+
+	if (nonblocking)
+		flags |= O_NONBLOCK;
+
+	for (i = 0; i < nr_threads; i++) {
+		BUG_ON(pipe2(pipe_fds, flags));
+
+		tdata[i].pipe_read = pipe_fds[0];
+		tdata[i].pipe_write = pipe_fds[1];
+	}
+	return 0;
+}
+
+static struct thread_data *create_thread_data(void)
+{
+	unsigned int i;
+	struct thread_data *threads;
+
+	threads = malloc(nr_threads * sizeof(struct thread_data));
+
+	if (!threads) {
+		fprintf(stderr, "Allocation of thread data memory failed.");
+		exit(1);
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		threads[i].td = threads;
+		threads[i].nr = i;
+	}
+
+	create_pipes(threads);
+
+	return threads;
+}
+
 int bench_sched_pipe(int argc, const char **argv)
 {
-	struct thread_data threads[2] = {};
+	struct thread_data *threads;
 	struct thread_data *td;
-	int pipe_1[2], pipe_2[2];
+
 	struct timeval start, stop, diff;
 	unsigned long long result_usec = 0;
-	int nr_threads = 2;
-	int t;
+	unsigned int t;
 
 	/*
 	 * why does "ret" exist?
 	 * discarding returned value of read(), write()
 	 * causes error in building environment for perf
 	 */
-	int __maybe_unused ret, wait_stat, flags = 0;
-	pid_t pid, retpid __maybe_unused;
+	int __maybe_unused ret, wait_stat;
+	pid_t retpid __maybe_unused;
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
-	if (nonblocking)
-		flags |= O_NONBLOCK;
+	threads = create_thread_data();
 
-	BUG_ON(pipe2(pipe_1, flags));
-	BUG_ON(pipe2(pipe_2, flags));
+	cgrp_names = calloc(nr_threads, sizeof(char *));
+	cgrps = calloc(nr_threads, sizeof(struct cgroup *));
 
 	gettimeofday(&start, NULL);
 
-	for (t = 0; t < nr_threads; t++) {
-		td = threads + t;
-
-		td->nr = t;
-
-		if (t == 0) {
-			td->pipe_read = pipe_1[0];
-			td->pipe_write = pipe_2[1];
-		} else {
-			td->pipe_write = pipe_1[1];
-			td->pipe_read = pipe_2[0];
-		}
-	}
-
 	if (threaded) {
 		for (t = 0; t < nr_threads; t++) {
 			td = threads + t;
 
-			ret = pthread_create(&td->pthread, NULL, worker_thread, td);
+			ret = pthread_create(&td->pthread, NULL, worker_thread, threads + t);
 			BUG_ON(ret);
 		}
 
@@ -270,18 +310,26 @@ int bench_sched_pipe(int argc, const char **argv)
 			BUG_ON(ret);
 		}
 	} else {
-		pid = fork();
-		assert(pid >= 0);
-
-		if (!pid) {
-			worker_thread(threads + 0);
-			exit(0);
-		} else {
-			worker_thread(threads + 1);
+		/*
+		 * Start at '1', because the parent eventually also becomes a
+		 * worker.
+		 */
+		for (t = 1; t < nr_threads; t++) {
+			threads[t].pid = fork();
+			assert(threads[t].pid >= 0);
+
+			if (!threads[t].pid) {
+				worker_thread(threads + t);
+				exit(0);
+			}
 		}
 
-		retpid = waitpid(pid, &wait_stat, 0);
-		assert((retpid == pid) && WIFEXITED(wait_stat));
+		worker_thread(threads);
+
+		for (t = 1; t < nr_threads; t++) {
+			retpid = waitpid(threads[t].pid, &wait_stat, 0);
+			assert((retpid == threads[t].pid) && WIFEXITED(wait_stat));
+		}
 	}
 
 	gettimeofday(&stop, NULL);
@@ -295,8 +343,8 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# Executed %d pipe operations between two %s\n\n",
-			loops, threaded ? "threads" : "processes");
+		printf("# Executed %d pipe operations between %u %s\n\n", loops,
+		       nr_threads, threaded ? "threads" : "processes");
 
 		result_usec = diff.tv_sec * USEC_PER_SEC;
 		result_usec += diff.tv_usec;
-- 
2.45.3

