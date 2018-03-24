From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/44] perf annotate: Defer searching for comma in raw line till it is needed
Date: Sat, 24 Mar 2018 17:02:10 -0300
Message-ID: <20180324200211.21326-44-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That strchr() in jump__scnprintf() needs to be nuked somehow, as it,
IIRC is already done in jump__parse() and if needed at scnprintf() time,
should be stashed in the struct filled in parse() time.

For now jus defer it to just before where it is used.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j0t5hagnphoz9xw07bh3ha3g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5fa270b24eea..f730e0cf8a26 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -350,7 +350,7 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	const char *c = strchr(ops->raw, ',');
+	const char *c;
 
 	if (!ops->target.addr || ops->target.offset < 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
@@ -358,6 +358,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 	if (ops->target.outside && ops->target.sym != NULL)
 		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
+	c = strchr(ops->raw, ',');
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
-- 
2.14.3
