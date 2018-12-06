From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/75] perf map: Remove extra indirection from map__find()
Date: Thu,  6 Dec 2018 18:24:51 -0300
Message-ID: <20181206212602.20474-5-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Eric Saint-Etienne <eric.saintetienne@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Eric Saint-Etienne <eric.saint.etienne@oracle.com>

A double pointer is used in map__find() where a single pointer is enough
because the function doesn't affect the rbtree and the rbtree is locked.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Eric Saint-Etienne <eric.saintetienne@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 781eed8e3265..a0d58b4d9c32 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -873,19 +873,18 @@ void maps__remove(struct maps *maps, struct map *map)
 
 struct map *maps__find(struct maps *maps, u64 ip)
 {
-	struct rb_node **p, *parent = NULL;
+	struct rb_node *p;
 	struct map *m;
 
 	down_read(&maps->lock);
 
-	p = &maps->entries.rb_node;
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node);
+	p = maps->entries.rb_node;
+	while (p != NULL) {
+		m = rb_entry(p, struct map, rb_node);
 		if (ip < m->start)
-			p = &(*p)->rb_left;
+			p = p->rb_left;
 		else if (ip >= m->end)
-			p = &(*p)->rb_right;
+			p = p->rb_right;
 		else
 			goto out;
 	}
-- 
2.19.2
