Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF651DED42;
	Sat,  5 Apr 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854529; cv=none; b=e1KdmymnPvSErKcXwu1ZHPR+suAzitegHsgCpvA/pgTVz7UDak+EHyoCcNdkr/w7lBTI+hnW3ZinPSDR+UaHuTWRBmemq+UzHAdncp7mVIt+pafP2iFzkfJLeb0RrYY4e8INxKDkNudPBWLmaWW/qJms7iSAoYHku0zcw4GFJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854529; c=relaxed/simple;
	bh=q36thpo4qph9HO2471J3L8SDoZKI0EjIb7JRIbOTa3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWUY+ywjbnIO5zYLzqtsYv1a0FbvX2JxvlB42iCt6W8t+Y4t5Lxj3na872B+FxQGqtBFZTns3Bt9U4zyb2o4iobla5bgn+u1V9eiIPRxqkw61o7E9byOGQbjFhGGgEt75QmsmTka98A8eg+/W19Yk3ZwvsH/drtUpPO7329uR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=n7ppOQfa; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="n7ppOQfa"
Received: from localhost (ip-109-42-179-132.web.vodafone.de [109.42.179.132])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 535C1aJL022451
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 5 Apr 2025 14:01:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743854497; bh=q36thpo4qph9HO2471J3L8SDoZKI0EjIb7JRIbOTa3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7ppOQfak5bGpMjs/1zK4iVTEX/jOaofVz2g90pNjwA1Scsev06mtdKaGLTZ+ES6Z
	 PJF8N4f+10A5xOibeagSo1QvTP1LcA07viZrnVxXj8LIOil9RmNmMD+agcQZNUrdmZ
	 Ln9mGRE5MK4MOOjHIFtq9EOPvdtXC0tKJikaHyXw=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dirk Gouders <dirk@gouders.net>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/3] perf bench sched pipe: add complete graph simulation
Date: Sat,  5 Apr 2025 14:00:07 +0200
Message-ID: <20250405120039.15953-3-dirk@gouders.net>
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

Currently, we have only one worker function: the simulation of a ring
for token traversal.

Add another worker to simulate a complete graph (Kn) for token
traversal.  A new option -K/--Kn can be used to use the new worker.

Those different workers could be interesting, because they produce
workload varieties noticeable by perf-report(1), for example:

(booted with mitigations=off, 6 processes)

Ring simulation:

Samples: 92K of event 'cycles:P', Event count (approx.): 18690208287
Overhead  Command     Shared Object         Symbol
  13.16%  sched-pipe  [kernel.kallsyms]     [k] timerqueue_add
   7.10%  sched-pipe  [kernel.kallsyms]     [k] read_hpet
   3.36%  sched-pipe  [kernel.kallsyms]     [k] _copy_from_iter
   3.23%  sched-pipe  [kernel.kallsyms]     [k] _copy_to_iter
   2.64%  sched-pipe  [kernel.kallsyms]     [k] vfs_write
   2.55%  sched-pipe  [kernel.kallsyms]     [k] vfs_read

Kn simulation:

Samples: 163K of event 'cycles:P', Event count (approx.): 100366721164
Overhead  Command     Shared Object         Symbol
   5.11%  sched-pipe  [kernel.kallsyms]     [k] _copy_from_iter
   4.90%  sched-pipe  [kernel.kallsyms]     [k] queued_spin_lock_slowpath
   3.99%  sched-pipe  [kernel.kallsyms]     [k] _copy_to_iter
   3.35%  sched-pipe  [kernel.kallsyms]     [k] timerqueue_add
   2.80%  sched-pipe  [kernel.kallsyms]     [k] check_preemption_disabled
   2.56%  sched-pipe  [kernel.kallsyms]     [k] vfs_write
   2.40%  sched-pipe  [kernel.kallsyms]     [k] vfs_read

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/Documentation/perf-bench.txt |  5 +++
 tools/perf/bench/sched-pipe.c           | 60 +++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 8a651f2fe3aa..6f7df3d47821 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -130,6 +130,11 @@ process).
 
 Options of *pipe*
 ^^^^^^^^^^^^^^^^^
+-K::
+--Kn::
+Simulate a complete graph instead of a ring for sending tokens.
+Each process sends and receives tokens to/from every other process.
+
 -l::
 --loop=::
 Specify number of loops.
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 28dd7f3a11b2..3c76e8249a9b 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -50,6 +50,8 @@ static bool			threaded;
 static unsigned int		nr_threads = 2;
 
 static bool			nonblocking;
+static bool			Kn_mode;	/* Toggle for ring mode -> complete graph mode */
+
 static char			*cgrp_names[2];
 static struct cgroup		*cgrps[2];
 
@@ -90,6 +92,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
 	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
 	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_BOOLEAN('K', "Kn",		&Kn_mode,	"Send tokens in a complete graph instead of a ring."),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
@@ -188,11 +191,55 @@ static inline int read_pipe(struct thread_data *td)
 	return ret;
 }
 
+/*
+ * Worker thread for processes forming a complete graph,
+ * sending tokens one to each other.
+ */
+static void *worker_thread_kn(void *__tdata)
+{
+	struct thread_data *this_thread = __tdata;
+	struct thread_data *all_threads = this_thread - this_thread->nr;
+
+	int ret, m = 0;
+	unsigned int i;
+	unsigned int t;
+
+	ret = enter_cgroup(this_thread->nr);
+	if (ret < 0) {
+		this_thread->cgroup_failed = true;
+		return NULL;
+	}
+
+	if (nonblocking) {
+		this_thread->epoll_ev.events = EPOLLIN;
+		this_thread->epoll_fd = epoll_create(1);
+		BUG_ON(this_thread->epoll_fd < 0);
+		BUG_ON(epoll_ctl(this_thread->epoll_fd, EPOLL_CTL_ADD, this_thread->pipe_read, &this_thread->epoll_ev) < 0);
+	}
+
+	for (i = 0; i < loops; i++) {
+		/* First: feed all other workers. */
+		for (t = 0; t < nr_threads; t++)
+			if (t != this_thread->nr) {
+				ret = write(all_threads[t].pipe_write, &m, sizeof(int));
+				BUG_ON(ret != sizeof(int));
+			}
+
+		/* Read a token from all other workers. */
+		for (t = 1; t < nr_threads; t++) {
+			ret = read_pipe(this_thread);
+			BUG_ON(ret != sizeof(int));
+		}
+	}
+
+	return NULL;
+}
+
 /*
  * Worker thread for nodes forming a ring, receiving tokens from the left
  * neighbor and sending them to the right one.
  */
-static void *worker_thread(void *__tdata)
+static void *worker_thread_ring(void *__tdata)
 {
 	struct thread_data *this_thread = __tdata;
 	struct thread_data *first_thread = this_thread - this_thread->nr;
@@ -231,6 +278,9 @@ static void *worker_thread(void *__tdata)
 	return NULL;
 }
 
+/* Ring mode is the default. */
+void * (*worker_thread)(void *) = worker_thread_ring;
+
 static struct thread_data *create_thread_data(void)
 {
 	struct thread_data *threads;
@@ -279,6 +329,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
+	if (Kn_mode)
+		worker_thread = worker_thread_kn;
+
 	threads = create_thread_data();
 
 	gettimeofday(&start, NULL);
@@ -331,8 +384,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# Executed %d pipe operations between %u %s\n\n", loops,
-		       nr_threads, threaded ? "threads" : "processes");
+		printf("# Executed %d pipe operations (%s) between %u %s\n\n", loops,
+		       Kn_mode ? "Kn" : "ring", nr_threads,
+		       threaded ? "threads" : "processes");
 
 		result_usec = diff.tv_sec * USEC_PER_SEC;
 		result_usec += diff.tv_usec;
-- 
2.45.3

