From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/32] perf evlist: Remove trailing semicolon
Date: Wed, 17 Jan 2018 13:11:52 -0300
Message-ID: <20180117161222.15611-3-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Luis de Bethencourt <luisbg@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Luis de Bethencourt <luisbg@kernel.org>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180111155020.9782-1-luisbg@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0a5e09c4071..120efd85f2c8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1760,7 +1760,7 @@ void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
 	switch (old_state) {
 	case BKW_MMAP_NOTREADY: {
 		if (state != BKW_MMAP_RUNNING)
-			goto state_err;;
+			goto state_err;
 		break;
 	}
 	case BKW_MMAP_RUNNING: {
-- 
2.14.3
