Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286C1F4282;
	Wed,  2 Apr 2025 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629853; cv=none; b=VROuYveHGb+3yNIb6PrOWJ97gU8y+1VIcrjqvyc5SxABQATBPjUYITiKsElZPaFxTk1QuMBKEgqV5Wo56j8Pz++xV8ewfJh4OJceGCxJDvZ2oOfVLkF5JbrVAM/veXhR8hODm6KCoTth0CsOXt0Z0RWEmh5wTGTEuvH+NlqTZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629853; c=relaxed/simple;
	bh=fJ5TqShwUQ6IugRAtIpS4YeDiS7gskEmIXAXiTFahNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+V4TxrAWjyjqKX8ESogztbpo9l9S0KHOogSbeHsECQQT0Q/m6G2T1pmnOrYkBRUQNecl2sWmNZsI3qT4hJuDl82OdEUQz3Ve3mupKNdm25F+SMslIjV1FGr/GlAedLsRJmjL5tFjKHb5NpKksmkR9ynqHPF3zpw6VJyh3rL7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=tzUXNfrq; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="tzUXNfrq"
Received: from localhost (ip-109-42-179-236.web.vodafone.de [109.42.179.236])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 532LP6Vx030779
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 2 Apr 2025 23:25:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1743629107; bh=fJ5TqShwUQ6IugRAtIpS4YeDiS7gskEmIXAXiTFahNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tzUXNfrq01jfWT586TdsvyIZSUX9z2HruBuqtWKWmU20juMY4R79v87FXhM+XfcwC
	 kCatDuz3fdiVXeDHxOME7q73xq73j9Wo9QCZgomjOqr3kt1WHe8CU2UShofo8Q4soy
	 BUQT+dBL3th+gotpKw+KvUPouFtiKWHZMqGAhL8U=
From: Dirk Gouders <dirk@gouders.net>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Dirk Gouders <dirk@gouders.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf bench sched pipe: add complete graph simulation
Date: Wed,  2 Apr 2025 23:15:27 +0200
Message-ID: <20250402212402.15658-3-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250402212402.15658-2-dirk@gouders.net>
References: <20250402212402.15658-2-dirk@gouders.net>
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

Different workers could be interesting, because they seem to realize
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
 tools/perf/Documentation/perf-bench.txt |  5 ++
 tools/perf/bench/sched-pipe.c           | 62 +++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 5c8dc99e1c57..c1f479de9ded 100644
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
index 89a54d33eee0..553e5ead254f 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -12,7 +12,8 @@
 #include <subcmd/parse-options.h>
 #include <api/fs/fs.h>
 #include "bench.h"
-#include "util/cgroup.h"
+#include <util/cgroup.h>
+#include <util/string2.h>
 
 #include <unistd.h>
 #include <stdio.h>
@@ -51,6 +52,7 @@ static bool			threaded;
 static unsigned int		nr_threads = 2;
 
 static bool			nonblocking;
+static bool			Kn_mode;	/* Toggle for ring mode -> complete graph mode */
 static char			**cgrp_names;
 static struct cgroup		**cgrps;
 
@@ -91,6 +93,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
 	OPT_UINTEGER('p', "nprocs",	&nr_threads,    "Number of processes"),
 	OPT_UINTEGER('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_BOOLEAN('K', "Kn",		&Kn_mode,	"Send tokens in a complete graph instead of a ring."),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
 		     "Put sender and receivers in given cgroups",
@@ -189,11 +192,55 @@ static inline int read_pipe(struct thread_data *td)
 	return ret;
 }
 
+/*
+ * Worker thread for processes forming a complete graph,
+ * sending tokens one to each other.
+ */
+static void *worker_thread_kn(void *__tdata)
+{
+	struct thread_data *this_thread = __tdata;
+	struct thread_data *threads_all = this_thread->td;
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
+				ret = write(threads_all[t].pipe_write, &m, sizeof(int));
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
 	struct thread_data *threads_all = this_thread->td;
@@ -229,6 +276,9 @@ static void *worker_thread(void *__tdata)
 	return NULL;
 }
 
+/* Ring mode is the default. */
+void * (*worker_thread)(void *) = worker_thread_ring;
+
 static int create_pipes(struct thread_data *tdata)
 {
 	int __maybe_unused flags = 0;
@@ -288,6 +338,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
+	if (Kn_mode)
+		worker_thread = worker_thread_kn;
+
 	threads = create_thread_data();
 
 	cgrp_names = calloc(nr_threads, sizeof(char *));
@@ -343,8 +396,9 @@ int bench_sched_pipe(int argc, const char **argv)
 
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

