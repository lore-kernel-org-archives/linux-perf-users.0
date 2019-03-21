From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/44] perf maps: Purge all maps from the 'names' tree
Date: Thu, 21 Mar 2019 15:51:18 -0300
Message-ID: <20190321185142.11441-21-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Add function __maps__purge_names() to purge all maps from the names
tree.  We need to cleanup the names tree in maps__exit().

Detected with gcc's ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 1e6285699b30 ("perf symbols: Fix slowness due to -ffunction-section")
Link: http://lkml.kernel.org/r/20190316080556.3075-12-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 64bea5eb8bf6..e32628cd20a7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -577,10 +577,25 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
+static void __maps__purge_names(struct maps *maps)
+{
+	struct rb_root *root = &maps->names;
+	struct rb_node *next = rb_first(root);
+
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node_name);
+
+		next = rb_next(&pos->rb_node_name);
+		rb_erase_init(&pos->rb_node_name, root);
+		map__put(pos);
+	}
+}
+
 static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
+	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
-- 
2.20.1
