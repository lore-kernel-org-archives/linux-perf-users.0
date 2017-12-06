From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/36] perf stat: Add rbtree node_delete op
Date: Wed,  6 Dec 2017 11:40:55 -0300
Message-ID: <20171206144115.15097-17-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbdLFOmb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:42:31 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jin Yao <yao.jin@linux.intel.com>

In current stat-shadow.c, the rbtree deleting is ignored.

The patch adds the implementation to node_delete method of rblist.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512125856-22056-5-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 855e35cbb1dc..57ec22513971 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -87,6 +87,16 @@ static struct rb_node *saved_value_new(struct rblist *rblist __maybe_unused,
 	return &nd->rb_node;
 }
 
+static void saved_value_delete(struct rblist *rblist __maybe_unused,
+			       struct rb_node *rb_node)
+{
+	struct saved_value *v;
+
+	BUG_ON(!rb_node);
+	v = container_of(rb_node, struct saved_value, rb_node);
+	free(v);
+}
+
 static struct saved_value *saved_value_lookup(struct perf_evsel *evsel,
 					      int cpu,
 					      bool create)
@@ -114,7 +124,7 @@ void perf_stat__init_shadow_stats(void)
 	rblist__init(&runtime_saved_values);
 	runtime_saved_values.node_cmp = saved_value_cmp;
 	runtime_saved_values.node_new = saved_value_new;
-	/* No delete for now */
+	runtime_saved_values.node_delete = saved_value_delete;
 }
 
 static int evsel_context(struct perf_evsel *evsel)
-- 
2.13.6
