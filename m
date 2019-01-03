From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/29] perf c2c: Change the default coalesce setup
Date: Thu,  3 Jan 2019 09:45:56 -0300
Message-ID: <20190103124609.29672-17-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Joe Mario <jmario@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Joe suggested to have the coalesce default set just to 'iaddr', because
it's easier to read on the default 'perf c2c report' output.

By removing the "pid" field from the default -c/--coalesce option, the
'perf c2c' report will group all the relevant PIDs under the instruction
address ('iaddr') bucket. User can always run "-c pid,iaddr" for a more
fine grained output on particular PIDs.

Suggested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181228101820.28010-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f3aa9d02a5ab..964f3f5ef420 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -68,7 +68,7 @@ struct c2c_hist_entry {
 	struct hist_entry	he;
 };
 
-static char const *coalesce_default = "pid,iaddr";
+static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
 	struct perf_tool	tool;
-- 
2.19.2
