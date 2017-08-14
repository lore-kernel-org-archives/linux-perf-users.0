From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/19] perf stat: Fix saved values rbtree lookup
Date: Mon, 14 Aug 2017 13:27:26 -0300
Message-ID: <20170814162741.6101-5-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The stat shadow saved values rbtree is indexed by a pointer.  Fix the
comparison function:

- We cannot return a pointer delta as an int because that loses bits on
  64bit.

- Doing pointer arithmetic on the struct pointer only works if the
  objects are spaced by the multiple of the object size, which is not
  guaranteed for individual malloc'ed object

Replace it with a proper comparison.

This fixes various problems with values not being found.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170724234015.5165-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 719d6cb86952..a04cf56d3517 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -70,7 +70,11 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 		return a->ctx - b->ctx;
 	if (a->cpu != b->cpu)
 		return a->cpu - b->cpu;
-	return a->evsel - b->evsel;
+	if (a->evsel == b->evsel)
+		return 0;
+	if ((char *)a->evsel < (char *)b->evsel)
+		return -1;
+	return +1;
 }
 
 static struct rb_node *saved_value_new(struct rblist *rblist __maybe_unused,
-- 
2.13.4
