Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B88C1F;
	Sun,  7 Dec 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765097863; cv=none; b=J00WU0NtgnkLaZyTN2/xpmosyDp3IeEoKFvYW7bGNudbRFBFdLRvQmjIVUzifVgbos+LiASjY7QbgjQWBDlih5rxzV0Xjlnxr11L5aR8RoD9CClIFAqAHN7ClJ6d/Z1W9SwI7LL9lQiwmSw61osa7m13A/+YYpZplFN4OBxF9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765097863; c=relaxed/simple;
	bh=K3YITIaGlyo8phix41bcyeykT0MmaRTtW6i/wOehnPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEy+GOs5Y0/dkxU4R3WairoJZj/Kh+UQjk+74cLP5RWN4cZrLDOIK5Z3wXiIim0MVMMOYlB2N3/2N+Ec9eP7mm7D2J5yNmUADBrCrNP1C7H1gMSIH9bX3TJEKBl0wWvAkh8Ki0Y/BUQ4cmuCpCjMONQM7LHYdUGUudQnnA/hYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpjYNeIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpjYNeIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFD4C4CEFB;
	Sun,  7 Dec 2025 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765097862;
	bh=K3YITIaGlyo8phix41bcyeykT0MmaRTtW6i/wOehnPg=;
	h=From:To:Cc:Subject:Date:From;
	b=QpjYNeIcUXWXwgU4vUTgckXwybWXKesi74ue7SZAQDTZ3F7Cu/qXee7dxpDBR11hC
	 uptfrxVfVs+waImvH/zMrWofZKPqQObkLfP2EQIw+cVJbNTureaaGgul4pG83+bBZa
	 bumOYxeqa386oHM92aXY/V9Vkk0bEBkNFMgJzp373JYpPYpkqz2EFIsYnOY+o+9dUF
	 Vwh2s22Tr7CV8XtoRLUnHJytRg4MOF5/zAZsTC9D8zRW0U6BNMR9a1J9mlg6u18DAY
	 gTTmnVV3YbzbZyI0Vi26HxQ30zMUXtZ7n8Ok37z3kruWMzvKOGnou/TjWt0KlFERW8
	 tow+M+oIHM+kA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH] perf bench: Add -t/--threads option to perf bench mem mmap
Date: Sun,  7 Dec 2025 00:57:41 -0800
Message-ID: <20251207085741.1388141-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can measure overhead of mmap_lock and/or per-VMA lock
contention.

  $ perf bench mem mmap -f demand -l 1000 -t 1
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

         2.914503 GB/sec

  $ perf bench mem mmap -f demand -l 1000 -t 2
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

       888.769991 MB/sec

  $ perf bench mem mmap -f demand -l 1000 -t 3
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

       757.658220 MB/sec

  $ perf bench mem mmap -f demand -l 1000 -t 4
  # Running 'mem/mmap' benchmark:
  # function 'demand' (Demand loaded mmap())
  # Copying 1MB bytes ...

       316.410713 MB/sec

Cc: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-bench.txt |  4 ++
 tools/perf/bench/mem-functions.c        | 74 +++++++++++++++++++++----
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 1160224cb718392d..c5913cf59c988421 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -274,6 +274,10 @@ Repeat mmap() invocation this number of times.
 --cycles::
 Use perf's cpu-cycles event instead of gettimeofday syscall.
 
+-t::
+--threads=<NUM>::
+Create multiple threads to call mmap/munmap concurrently.
+
 SUITES FOR 'numa'
 ~~~~~~~~~~~~~~~~~
 *mem*::
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 2908a3a796c932d0..e7e7d0b41fc7720f 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include <linux/time64.h>
 #include <linux/log2.h>
+#include <pthread.h>
 
 #define K 1024
 
@@ -41,6 +42,7 @@ static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 static unsigned int	seed;
+static unsigned int	nr_threads	= 1;
 
 static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
@@ -174,7 +176,7 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
 
 static double timeval2double(struct timeval *ts)
 {
-	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
+	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC / nr_threads;
 }
 
 #define print_bps(x) do {						\
@@ -494,16 +496,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
 	}
 }
 
-static int do_mmap(const struct function *r, struct bench_params *p,
-		  void *src __maybe_unused, void *dst __maybe_unused,
-		  union bench_clock *accum)
+struct mmap_data {
+	pthread_t id;
+	const struct function *func;
+	struct bench_params *params;
+	union bench_clock result;
+	unsigned int seed;
+	int error;
+};
+
+static void *do_mmap_thread(void *arg)
 {
+	struct mmap_data *data = arg;
+	const struct function *r = data->func;
+	struct bench_params *p = data->params;
 	union bench_clock start, end, diff;
 	mmap_op_t fn = r->fn.mmap_op;
 	bool populate = strcmp(r->name, "populate") == 0;
+	void *dst;
 
-	if (p->seed)
-		srand(p->seed);
+	if (data->seed)
+		srand(data->seed);
 
 	for (unsigned int i = 0; i < p->nr_loops; i++) {
 		clock_get(&start);
@@ -514,16 +527,53 @@ static int do_mmap(const struct function *r, struct bench_params *p,
 		fn(dst, p->size, p->page_shift, p->seed);
 		clock_get(&end);
 		diff = clock_diff(&start, &end);
-		clock_accum(accum, &diff);
+		clock_accum(&data->result, &diff);
 
 		bench_munmap(dst, p->size);
 	}
 
-	return 0;
+	return data;
 out:
-	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
-			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
-	return -1;
+	data->error = -ENOMEM;
+	return NULL;
+}
+
+static int do_mmap(const struct function *r, struct bench_params *p,
+		  void *src __maybe_unused, void *dst __maybe_unused,
+		  union bench_clock *accum)
+{
+	struct mmap_data *data;
+	int error = 0;
+
+	data = calloc(nr_threads, sizeof(*data));
+	if (!data) {
+		printf("# Failed to allocate thread resources\n");
+		return -1;
+	}
+
+	for (unsigned int i = 0; i < nr_threads; i++) {
+		data[i].func = r;
+		data[i].params = p;
+		if (p->seed)
+			data[i].seed = p->seed + i;
+
+		if (pthread_create(&data[i].id, NULL, do_mmap_thread, &data[i]) < 0)
+			data[i].error = -errno;
+	}
+
+	for (unsigned int i = 0; i < nr_threads; i++) {
+		pthread_join(data[i].id, NULL);
+
+		clock_accum(accum, &data[i].result);
+		error |= data[i].error;
+	}
+	free(data);
+
+	if (error) {
+		printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+		       p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
+	}
+	return error ? -1 : 0;
 }
 
 static const char * const bench_mem_mmap_usage[] = {
@@ -548,6 +598,8 @@ int bench_mem_mmap(int argc, const char **argv)
 	static const struct option bench_mmap_options[] = {
 		OPT_UINTEGER('r', "randomize", &seed,
 			    "Seed to randomize page access offset."),
+		OPT_UINTEGER('t', "threads", &nr_threads,
+			    "Number of threads to run concurrently (default: 1)."),
 		OPT_PARENT(bench_common_options),
 		OPT_END()
 	};
-- 
2.52.0.223.gf5cc29aaa4-goog

