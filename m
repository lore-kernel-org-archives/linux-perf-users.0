From: Ian Rogers <irogers@google.com>
Subject: [PATCH 0/5] Benchmark and improve event synthesis performance
Date: Wed,  1 Apr 2020 16:39:40 -0700
Message-ID: <20200401233945.133550-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org


Event synthesis is performance critical in common tasks using perf. For
example, when perf record starts in system wide mode the /proc file
system is scanned with events synthesized for each process and all
executable mmaps. With large machines and lots of processes, we have seen
O(seconds) of wall clock time while synthesis is occurring.

This patch set adds a benchmark for synthesis performance in a new
benchmark collection called 'internals'. The benchmark uses the
machine__synthesize_threads function, single threaded on the perf process
with a 'tool' that just drops the events, to measure how long synthesis
takes.

By profiling this benchmark 2 performance bottlenecks were identified,
hugetlbfs_mountpoint and stdio. The impact of theses changes are:

Before:
Average synthesis took: 167.616800 usec
Average data synthesis took: 208.655600 usec

After hugetlbfs_mountpoint scalability fix:
Average synthesis took: 120.195100 usec
Average data synthesis took: 156.582300 usec

After removal of stdio in /proc/pid/maps code:
Average synthesis took: 67.189100 usec
Average data synthesis took: 102.451600 usec

Time was measured on an Intel Xeon 6154 compiling with Debian gcc 9.2.1.

Two patches in the set were sent to LKML previously but are included
here for context around the benchmark performance impact:
https://lore.kernel.org/lkml/20200327172914.28603-1-irogers@google.com/T/#u
https://lore.kernel.org/lkml/20200328014221.168130-1-irogers@google.com/T/#u

A future area of improvement could be to add the perf top
num-thread-synthesize option more widely to other perf commands, and
also to benchmark its effectiveness.

Ian Rogers (4):
  perf bench: add event synthesis benchmark
  perf synthetic-events: save 4kb from 2 stack frames
  tools api: add a lightweight buffered reading api
  perf synthetic events: Remove use of sscanf from /proc reading

Stephane Eranian (1):
  tools api fs: make xxx__mountpoint() more scalable

 tools/lib/api/fs/fs.c              |  17 +++
 tools/lib/api/fs/fs.h              |  12 ++
 tools/lib/api/io.h                 | 103 +++++++++++++++++
 tools/perf/bench/Build             |   2 +-
 tools/perf/bench/bench.h           |   2 +-
 tools/perf/bench/synthesize.c      | 101 ++++++++++++++++
 tools/perf/builtin-bench.c         |   6 +
 tools/perf/util/synthetic-events.c | 177 +++++++++++++++++++----------
 8 files changed, 355 insertions(+), 65 deletions(-)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/bench/synthesize.c

-- 
2.26.0.rc2.310.g2932bb562d-goog
