From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/8] perf xyarray: Fix wrong processing when closing evsel fd
Date: Thu, 19 Oct 2017 14:45:14 -0300
Message-ID: <20171019174515.7407-8-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In current xyarray code, xyarray__max_x() returns max_y, and xyarray__max_y()
returns max_x.

It's confusing and for code logic it looks not correct.

Error happens when closing evsel fd. Let's see this scenario:

1. Allocate an fd (pseudo-code)

  perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
  {
	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
  }

  xyarray__new(int xlen, int ylen, size_t entry_size)
  {
	size_t row_size = ylen * entry_size;
	struct xyarray *xy = zalloc(sizeof(*xy) + xlen * row_size);

	xy->entry_size = entry_size;
	xy->row_size   = row_size;
	xy->entries    = xlen * ylen;
	xy->max_x      = xlen;
	xy->max_y      = ylen;
	......
  }

So max_x is ncpus, max_y is nthreads and row_size = nthreads * 4.

2. Use perf syscall and get the fd

  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
		     struct thread_map *threads)
  {
	for (cpu = 0; cpu < cpus->nr; cpu++) {

		for (thread = 0; thread < nthreads; thread++) {
			int fd, group_fd;

			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
						 group_fd, flags);

			FD(evsel, cpu, thread) = fd;
	}
  }

  static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
  {
	return &xy->contents[x * xy->row_size + y * xy->entry_size];
  }

These codes don't have issues. The issue happens in the closing of fd.

3. Close fd.

  void perf_evsel__close_fd(struct perf_evsel *evsel)
  {
	int cpu, thread;

	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
			close(FD(evsel, cpu, thread));
			FD(evsel, cpu, thread) = -1;
		}
  }

  Since xyarray__max_x() returns max_y (nthreads) and xyarry__max_y()
  returns max_x (ncpus), so above code is actually to be:

        for (cpu = 0; cpu < nthreads; cpu++)
                for (thread = 0; thread < ncpus; ++thread) {
                        close(FD(evsel, cpu, thread));
                        FD(evsel, cpu, thread) = -1;
                }

  It's not correct!

This change is introduced by "475fb533fb7d" ("perf evsel: Fix buffer overflow
while freeing events")

This fix is to let xyarray__max_x() return max_x (ncpus) and
let xyarry__max_y() return max_y (nthreads)

Committer note:

This was also fixed by Ravi Bangoria, who provided the same patch,
noticing the problem with 'perf record':

<quote Ravi>
I see 'perf record -p <pid>' crashes with following log:

   *** Error in `./perf': free(): invalid next size (normal): 0x000000000298b340 ***
   ======= Backtrace: =========
   /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f7fd85c87e5]
   /lib/x86_64-linux-gnu/libc.so.6(+0x8037a)[0x7f7fd85d137a]
   /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f7fd85d553c]
   ./perf(perf_evsel__close+0xb4)[0x4b7614]
   ./perf(perf_evlist__delete+0x100)[0x4ab180]
   ./perf(cmd_record+0x1d9)[0x43a5a9]
   ./perf[0x49aa2f]
   ./perf(main+0x631)[0x427841]
   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f7fd8571830]
   ./perf(_start+0x29)[0x427a59]
</>

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Fixes: d74be4767367 ("perf xyarray: Save max_x, max_y")
Link: http://lkml.kernel.org/r/1508339478-26674-1-git-send-email-yao.jin@linux.intel.com
Link: http://lkml.kernel.org/r/1508327446-15302-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/xyarray.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/xyarray.h b/tools/perf/util/xyarray.h
index 4ba726c90870..54af60462130 100644
--- a/tools/perf/util/xyarray.h
+++ b/tools/perf/util/xyarray.h
@@ -23,12 +23,12 @@ static inline void *xyarray__entry(struct xyarray *xy, int x, int y)
 
 static inline int xyarray__max_y(struct xyarray *xy)
 {
-	return xy->max_x;
+	return xy->max_y;
 }
 
 static inline int xyarray__max_x(struct xyarray *xy)
 {
-	return xy->max_y;
+	return xy->max_x;
 }
 
 #endif /* _PERF_XYARRAY_H_ */
-- 
2.13.6
