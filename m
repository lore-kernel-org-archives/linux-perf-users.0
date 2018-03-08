From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/54] perf record: Remove progname from struct record
Date: Thu,  8 Mar 2018 16:50:18 -0300
Message-ID: <20180308195029.14991-44-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It's no longer used.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 31d4d70e2f6a..b81494587120 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -71,7 +71,6 @@ struct record {
 	struct auxtrace_record	*itr;
 	struct perf_evlist	*evlist;
 	struct perf_session	*session;
-	const char		*progname;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -861,8 +860,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 
-	rec->progname = argv[0];
-
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
-- 
2.14.3
