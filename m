From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/44] perf map: Remove map from 'names' tree in __maps__remove()
Date: Thu, 21 Mar 2019 15:51:17 -0300
Message-ID: <20190321185142.11441-20-acme@kernel.org>
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

There are two trees for each map inserted by maps__insert(), so remove
it from the 'names' tree in __maps__remove().

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
Link: http://lkml.kernel.org/r/20190316080556.3075-11-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..64bea5eb8bf6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -917,6 +917,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
+
+	rb_erase_init(&map->rb_node_name, &maps->names);
+	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
-- 
2.20.1
