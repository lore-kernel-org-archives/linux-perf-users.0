Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831261CD214;
	Sat,  5 Apr 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854528; cv=none; b=fvlrB82q9j6NWwuZrTKNGKZ/ABWJz4tSlj7Yv/OtkZNEbw1gZa1vaJ38z5+qkouyh0hWY5650COLLIkMOusddwZKtTHsepktdz8o1SBFo3FKDqikOze3tTaicA019YmpWYey/HnKa4OO8Pw1QgV0aDQmRbbB0OhBIpJ8rIvFVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854528; c=relaxed/simple;
	bh=tC5zZLuRjOquPQ7CBdWM39ShrTUkUI+qm6YsiAZs2ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqmEYdBTXtP9bdT8kR9FiOKBqYNd9ZdnPKtRKg2mGgu3x2Er0CArp68xYubMk6sknKzKoDz6gX8+tMVDDPOItsSBd/uohrVBTLilkX9Ddkms81wS9EJSEIxliIGRcSE2qMFFkMTNrLJcUcGFZ9lkmkEvnLByhUFGEWcV/RBrWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=kjQVC3F7; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="kjQVC3F7"
Received: from localhost (ip-109-42-179-132.web.vodafone.de [109.42.179.132])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 535C1Rp8022442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 5 Apr 2025 14:01:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743854488; bh=tC5zZLuRjOquPQ7CBdWM39ShrTUkUI+qm6YsiAZs2ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjQVC3F72BRrGPOk5dXsBlR6xxb6rR/zxfLjCP1mG7kcDKTtVBRduBsLG4IzKguvn
	 Mc/A2ePTesrx4Tc7T/2YGfH89iTVI0EZrAnUfyejm93vTQLOvxWQl3Lx//hpTt2WAp
	 +KtyzYLXNVyBskGbBz5M0NATehOGJY8a8dDSBKNw=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dirk Gouders <dirk@gouders.net>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/3] perf bench sched pipe: add -p/--nprocs to run more than 2 workers
Date: Sat,  5 Apr 2025 14:00:06 +0200
Message-ID: <20250405120039.15953-2-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250405120039.15953-1-dirk@gouders.net>
References: <20250402212402.15658-2-dirk@gouders.net>
 <20250405120039.15953-1-dirk@gouders.net>
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

Working with cgroups (-G) still limits the number of cgroups to 2.
The processes with an even index go into the first cgroup specified,
the ones with an odd index go into the second one.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/Documentation/perf-bench.txt |  27 +++-
 tools/perf/bench/sched-pipe.c           | 156 +++++++++++++++---------
 2 files changed, 121 insertions(+), 62 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 8331bd28b10e..8a651f2fe3aa 100644
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
@@ -126,11 +136,24 @@ Specify number of loops.
 
 -G::
 --cgroups=::
-Names of cgroups for sender and receiver, separated by a comma.
+Names of two cgroups separated by a comma.
++
+The worker processes will be added to the cgroups in an alternating
+fashion: processes with an even index go into the first one, those
+with an odd index into the second one.
++
 This is useful to check cgroup context switching overhead.
 Note that perf doesn't create nor delete the cgroups, so users should
-make sure that the cgroups exist and are accessible before use.
+make sure that the cgroups exist and are accessible before use, e.g.
+by
++
+------
+% mkdir /sys/fs/cgroup/{AAA,BBB}
+------
 
+-p::
+--nprocs=::
+Number of processes to use for sending tokens along the pipes.
 
 Example of *pipe*
 ^^^^^^^^^^^^^^^^^
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f..28dd7f3a11b2 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -32,7 +32,8 @@
 #include <pthread.h>
 
 struct thread_data {
-	int			nr;
+	unsigned int		nr;		/* index of this worker */
+	pid_t			pid;
 	int			pipe_read;
 	int			pipe_write;
 	struct epoll_event      epoll_ev;
@@ -42,10 +43,11 @@ struct thread_data {
 };
 
 #define LOOPS_DEFAULT 1000000
-static	int			loops = LOOPS_DEFAULT;
+static	unsigned int		loops = LOOPS_DEFAULT;
 
 /* Use processes by default: */
 static bool			threaded;
+static unsigned int		nr_threads = 2;
 
 static bool			nonblocking;
 static char			*cgrp_names[2];
@@ -86,7 +88,8 @@ static int parse_two_cgroups(const struct option *opt __maybe_unused,
 
 static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
-	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
+	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
@@ -107,15 +110,15 @@ static int enter_cgroup(int nr)
 	struct cgroup *cgrp;
 	pid_t pid;
 
-	if (cgrp_names[nr] == NULL)
+	if (cgrp_names[nr % 2] == NULL)
 		return 0;
 
-	if (cgrps[nr] == NULL) {
-		cgrps[nr] = cgroup__new(cgrp_names[nr], /*do_open=*/true);
-		if (cgrps[nr] == NULL)
+	if (cgrps[nr % 2] == NULL) {
+		cgrps[nr % 2] = cgroup__new(cgrp_names[nr % 2], /*do_open=*/true);
+		if (cgrps[nr % 2] == NULL)
 			goto err;
 	}
-	cgrp = cgrps[nr];
+	cgrp = cgrps[nr % 2];
 
 	if (threaded)
 		pid = syscall(__NR_gettid);
@@ -149,14 +152,14 @@ static int enter_cgroup(int nr)
 
 err:
 	saved_errno = errno;
-	printf("Failed to open cgroup file in %s\n", cgrp_names[nr]);
+	printf("Failed to open cgroup file in %s\n", cgrp_names[nr % 2]);
 
 	if (saved_errno == ENOENT) {
 		char mnt[PATH_MAX];
 
 		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
 			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
-			       mnt, cgrp_names[nr]);
+			       mnt, cgrp_names[nr % 2]);
 	} else if (saved_errno == EACCES && geteuid() > 0) {
 		printf(" Hint: try to run as root\n");
 	}
@@ -166,8 +169,8 @@ static int enter_cgroup(int nr)
 
 static void exit_cgroup(int nr)
 {
-	cgroup__put(cgrps[nr]);
-	free(cgrp_names[nr]);
+	cgroup__put(cgrps[nr % 2]);
+	free(cgrp_names[nr % 2]);
 }
 
 static inline int read_pipe(struct thread_data *td)
@@ -185,81 +188,106 @@ static inline int read_pipe(struct thread_data *td)
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
+	struct thread_data *first_thread = this_thread - this_thread->nr;
 
-	ret = enter_cgroup(td->nr);
+	unsigned int i;
+	int ret, m = 0;
+	int write_fd;
+
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
 
+	/* Find write_fd of right peer in the ring. */
+	if ((this_thread->nr + 1) == nr_threads)
+		write_fd = first_thread->pipe_write;
+	else
+		write_fd = (this_thread + 1)->pipe_write;
+
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
 
+static struct thread_data *create_thread_data(void)
+{
+	struct thread_data *threads;
+	int __maybe_unused flags = 0;
+	int pipe_fds[2];
+	unsigned int i;
+
+	if (nonblocking)
+		flags |= O_NONBLOCK;
+
+	threads = malloc(nr_threads * sizeof(struct thread_data));
+
+	if (!threads) {
+		fprintf(stderr, "Allocation of thread data memory failed.");
+		exit(1);
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		threads[i].nr = i;
+
+		BUG_ON(pipe2(pipe_fds, flags));
+
+		threads[i].pipe_read = pipe_fds[0];
+		threads[i].pipe_write = pipe_fds[1];
+	}
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
-
-	BUG_ON(pipe2(pipe_1, flags));
-	BUG_ON(pipe2(pipe_2, flags));
+	threads = create_thread_data();
 
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
 
@@ -270,18 +298,26 @@ int bench_sched_pipe(int argc, const char **argv)
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
@@ -295,8 +331,8 @@ int bench_sched_pipe(int argc, const char **argv)
 
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

