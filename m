From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/28] perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
Date: Mon,  5 Mar 2018 11:29:12 -0300
Message-ID: <20180305142932.16921-9-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Because the test is no longer using perf trace but perf record instead.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180301165215.6780-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh}     | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/tests/shell/{trace+probe_libc_inet_pton.sh => record+probe_libc_inet_pton.sh} (100%)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
similarity index 100%
rename from tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
rename to tools/perf/tests/shell/record+probe_libc_inet_pton.sh
-- 
2.14.3
