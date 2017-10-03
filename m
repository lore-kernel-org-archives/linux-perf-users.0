From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/8] perf tools: Lock to protect comm_str rb tree
Date: Tue,  3 Oct 2017 09:55:37 -0300
Message-ID: <20171003125540.331-6-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Add comm_str_lock to protect comm_str rb tree.

The lock is only needed for multithreaded code, so using mutex wrappers
provided by perf tool.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1506696477-146932-3-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7bc981b6bf29..756a9c14efbb 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/refcount.h>
+#include "rwsem.h"
 
 struct comm_str {
 	char *str;
@@ -14,6 +15,7 @@ struct comm_str {
 
 /* Should perhaps be moved to struct machine */
 static struct rb_root comm_str_root;
+static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
 
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
@@ -25,7 +27,9 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 static void comm_str__put(struct comm_str *cs)
 {
 	if (cs && refcount_dec_and_test(&cs->refcnt)) {
+		down_write(&comm_str_lock);
 		rb_erase(&cs->rb_node, &comm_str_root);
+		up_write(&comm_str_lock);
 		zfree(&cs->str);
 		free(cs);
 	}
@@ -50,7 +54,8 @@ static struct comm_str *comm_str__alloc(const char *str)
 	return cs;
 }
 
-static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
+static
+struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -81,6 +86,17 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
 	return new;
 }
 
+static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
+{
+	struct comm_str *cs;
+
+	down_write(&comm_str_lock);
+	cs = __comm_str__findnew(str, root);
+	up_write(&comm_str_lock);
+
+	return cs;
+}
+
 struct comm *comm__new(const char *str, u64 timestamp, bool exec)
 {
 	struct comm *comm = zalloc(sizeof(*comm));
-- 
2.13.6
