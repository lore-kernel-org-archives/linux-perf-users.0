From: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Subject: [PATCH v3 0/2] perf inject jit: Add namespaces support
Date: Thu,  5 Nov 2020 03:48:31 +0200
Message-ID: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
List-Id: linux-perf-users.vger.kernel.org

This version removes some redundant "else"s.

Changlog:
v2 -> v3
* Remove 2 redundant "else"s.

v1 -> v2
* Add 'in_pidns' and use PID & TID from jitdump entries for
  non-containerized processes.

Thanks,

Yonatan Goldschmidt (2):
  perf tools: Add 'in_pidns' to nsinfo struct
  perf inject jit: Add namespaces support

 tools/perf/builtin-inject.c  |  4 +-
 tools/perf/util/jit.h        |  2 +-
 tools/perf/util/jitdump.c    | 84 ++++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.c | 23 +++++++++-
 tools/perf/util/namespaces.h |  3 ++
 5 files changed, 92 insertions(+), 24 deletions(-)

-- 
2.25.0
