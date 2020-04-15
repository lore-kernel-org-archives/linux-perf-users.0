From: Ian Rogers <irogers@google.com>
Subject: [PATCH v5 0/3] perf synthetic events
Date: Tue, 14 Apr 2020 22:40:47 -0700
Message-ID: <20200415054050.31645-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Add a multi-threaded version of the internals synthesize benchmark. It
attempts to compute a time per event synthesized, but as it is reading
/proc there are issues:
 - permissions if not run as root
 - "random" nature of /proc
 
By default the benchmark is disabled but can be enabled with a
flag. It has been useful in gauging the value of multi-threaded
improvements not included here as their value appears minimal.

The patch set includes 2 patches that improve synthesis performance
and updates the benchmark numbers:
https://lore.kernel.org/lkml/20200411064248.247530-1-irogers@google.com/

v4 added a missing test file
v3 improved documenation, return values and added testing to the io framework
   following feedback from namhyung@kernel.org.
v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/

Ian Rogers (3):
  perf bench: add a multi-threaded synthesize benchmark
  tools api: add a lightweight buffered reading api
  perf synthetic events: Remove use of sscanf from /proc reading

 tools/lib/api/io.h                 | 112 +++++++++++
 tools/perf/bench/synthesize.c      | 211 +++++++++++++++++---
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/api-io.c          | 304 +++++++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c    |   4 +
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/synthetic-events.c | 157 ++++++++++-----
 7 files changed, 713 insertions(+), 77 deletions(-)
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/tests/api-io.c

-- 
2.26.0.110.g2183baf09c-goog
